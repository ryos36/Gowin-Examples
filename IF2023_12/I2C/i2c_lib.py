#compile
from polyphony import testbench
from polyphony import rule
from polyphony import module
from polyphony.typing import bit, bit8, bit16
from polyphony.io import Port
from polyphony import is_worker_running
from polyphony.timing import clksleep, wait_value, clkfence

Z=0b1
OE=0b0
WRITE_BIT0=0b0
READ_BIT0=0b1
SCL_HIGH=0b1
SCL_LOW=0b0
SLAVE_SCL_FORCE_LOW=0b0

ACK=0b0
NACK=0b1

CHECK_SLAVE_BUSY=False
WAIT_ACK_TIME_OUT_N=16

@module
class i2c_lib:
    def __init__(self):
        self.scl_o  = Port(bit, 'out')
        self.scl_i  = Port(bit, 'in')
        self.scl_t  = Port(bit, 'out')
        self.sda_o  = Port(bit, 'out')
        self.sda_i  = Port(bit, 'in')
        self.sda_t  = Port(bit, 'out')

    def init_bus(self):
        self.scl_o.wr(0b1)
        self.scl_t.wr(OE)
        self.sda_o.wr(0b1)
        self.sda_t.wr(OE)

    def recv_raw_data(self, check_slave_busy = False):
        self.sda_t.wr(Z)
        clkfence()

        r_data:bit8 = 0
        for i in range(8):
            r_data <<= 1
            self.scl_o.wr(SCL_HIGH)
            clkfence()
            if (check_slave_busy == True) and (i == 0):
                self.wait_slave_not_busy()
            msb:bit = self.sda_i.rd()
            r_data |= msb
            self.scl_o.wr(SCL_LOW)
            clkfence()

        return r_data

    def send_ack(self, ack_bit:bit = ACK):
        self.sda_t.wr(OE)
        clkfence()
        clksleep(4)

        self.sda_o.wr(ack_bit)
        clkfence()
        self.scl_o.wr(SCL_HIGH)
        clkfence()

        self.scl_o.wr(SCL_LOW)
        clkfence()


    def send_raw_data(self, raw_data:bit8, check_slave_busy = False):
        self.sda_t.wr(OE)
        clkfence()

        for i in range(8):
            msb:bit = 1 if (raw_data & 0x80) == 0x80 else 0
            raw_data <<= 1
            self.sda_o.wr(msb)
            clkfence()
            self.scl_o.wr(SCL_HIGH)
            clkfence()
            if (check_slave_busy == True) and (i == 0):
                self.wait_slave_not_busy()
            self.scl_o.wr(SCL_LOW)
            clkfence()

    def send_slave_addr(self, addr:bit8, addr0:bit):
        self.send_raw_data((addr << 1) | addr0)

    def wait_ack(self, wait_bit:bit = ACK):
        self.sda_t.wr(Z)
        self.sda_o.wr(1)
        
        err_i:bit8 = 0
        while err_i < WAIT_ACK_TIME_OUT_N:
            self.scl_o.wr(SCL_HIGH)
            clkfence()
            ack_check:bit = self.sda_i.rd()
            self.scl_o.wr(SCL_LOW)
            clkfence()
            if ack_check == wait_bit:
                err_i = 0
                break

            err_i += 1

        self.sda_t.wr(OE)
        return err_i

    def wait_slave_not_busy(self):
        while True:
            check_slave_scl:bit = self.scl_i.rd()
            if check_slave_scl != SLAVE_SCL_FORCE_LOW:
                break

    def pre_start_sequence(self):
        self.scl_o.wr(SCL_HIGH)
        clksleep(2)

    def start_sequence(self):
        self.sda_o.wr(0b0)
        clkfence()
        self.scl_o.wr(SCL_LOW)
        clkfence()

    def stop_sequence(self):
        self.scl_o.wr(SCL_HIGH)
        clkfence()
        self.sda_o.wr(1)
        clksleep(2)

    def write_data(self, w_addr:bit8, w_data:bit8):
        self.start_sequence()
        
        self.send_slave_addr(w_addr, WRITE_BIT0)
        self.wait_ack()

        self.send_raw_data(w_data, CHECK_SLAVE_BUSY)

        self.wait_ack(NACK)

        self.stop_sequence() 

    def read_data(self, r_addr:bit8):
        self.start_sequence()

        self.send_slave_addr(r_addr, READ_BIT0)
        self.wait_ack()

        r_data:bit8 = self.recv_raw_data(CHECK_SLAVE_BUSY)
        self.send_ack(NACK)

        self.stop_sequence()

        return r_data

    def write_reg(self, w_addr:bit8, reg_addr:bit16, w_data:bit8):
        self.start_sequence()
        
        self.send_slave_addr(w_addr, WRITE_BIT0)
        self.wait_ack()

        high_addr16:bit16 = (reg_addr & 0xFF00) >> 8
        high_addr8:bit8 = (high_addr16 & 0xFF)
        self.send_raw_data(high_addr8, CHECK_SLAVE_BUSY)
        self.wait_ack()

        low_addr8:bit8 = (reg_addr & 0xFF)
        self.send_raw_data(low_addr8, CHECK_SLAVE_BUSY)
        self.wait_ack()

        self.send_raw_data(w_data, CHECK_SLAVE_BUSY)
        self.wait_ack()

        self.stop_sequence() 

    def read_reg(self, slave_addr:bit8, reg_addr:bit16):
        self.start_sequence()
        
        self.send_slave_addr(slave_addr, WRITE_BIT0)
        self.wait_ack()

        high_addr16:bit16 = (reg_addr & 0xFF00) >> 8
        high_addr8:bit8 = (high_addr16 & 0xFF)
        self.send_raw_data(high_addr8, CHECK_SLAVE_BUSY)
        self.wait_ack()

        low_addr8:bit8 = (reg_addr & 0xFF)
        self.send_raw_data(low_addr8, CHECK_SLAVE_BUSY)
        self.wait_ack()

        self.stop_sequence() 

        self.start_sequence()

        self.send_slave_addr(slave_addr, READ_BIT0)
        self.wait_ack()

        r_data:bit8 = self.recv_raw_data(CHECK_SLAVE_BUSY)
        self.send_ack(NACK)

        self.stop_sequence()

        return r_data

    def write_reg8(self, w_addr:bit8, reg_addr:bit8, w_data:bit8):
        err:bit8 = 0
        self.start_sequence()
        
        self.send_slave_addr(w_addr, WRITE_BIT0)
        err = self.wait_ack()
        if err > 0:
            self.stop_sequence() 
            return err

        self.send_raw_data(reg_addr, CHECK_SLAVE_BUSY)
        self.wait_ack()

        self.send_raw_data(w_data, CHECK_SLAVE_BUSY)
        self.wait_ack()

        self.stop_sequence() 
        return err

    def read_reg8(self, slave_addr:bit8, reg_addr:bit8):
        self.start_sequence()
        
        self.send_slave_addr(slave_addr, WRITE_BIT0)
        self.wait_ack()

        self.send_raw_data(reg_addr, CHECK_SLAVE_BUSY)
        self.wait_ack()

        self.pre_start_sequence()
        self.start_sequence()

        self.send_slave_addr(slave_addr, READ_BIT0)
        self.wait_ack()

        r_data:bit8 = self.recv_raw_data(CHECK_SLAVE_BUSY)
        self.send_ack(NACK)

        self.stop_sequence()

        return r_data

    def bit8x2_to_bit16(self, data_high:bit8, data_low:bit8) -> bit16:
        data16:bit16 = data_high
        data16 = (data16 << 8) | data_low
        return data16

    def do_tpg(self, n):
        self.sda_t.wr(OE)
        clkfence()
        clksleep(3)

        b0:bit = 0

        for i in range(n):
            self.sda_o.wr(b0)
            b0 = not b0
            clkfence()
            self.scl_o.wr(SCL_HIGH)
            clkfence()

            self.scl_o.wr(SCL_LOW)
            clkfence()

##
##        self.init_bus()

