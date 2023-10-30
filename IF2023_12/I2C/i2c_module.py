#compile
from polyphony import testbench
from polyphony import rule
from polyphony import module
from polyphony.typing import bit, bit8, bit16
from polyphony.io import Queue, Port
from polyphony import is_worker_running
from polyphony.timing import clksleep, wait_value, clkfence

NOP_CMD=0
WRITE_CMD=1
READ_CMD=2
WRITE_REG_CMD=3
READ_REG_CMD=4
WRITE_REG8_CMD=5
READ_REG8_CMD=6

TPG_CMD=7

RESPONSE_FLAG=0x80
HAS_DATA_FLAG=0x40
DEBUG_FLAG=0x20

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

@module
class i2c_module:
    def __init__(self):
        self.scl_o  = Port(bit, 'out')
        self.scl_i  = Port(bit, 'in')
        self.scl_t  = Port(bit, 'out', Z)
        self.sda_o  = Port(bit, 'out')
        self.sda_i  = Port(bit, 'in')
        self.sda_t  = Port(bit, 'out', Z)

        self.cmd_q = Queue(bit8, 'in')
        self.res_q = Queue(bit8, 'out')

        self.append_worker(self.worker)

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
        clksleep(3)

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
        #clkfence()
        #clksleep(3)
        while True:
            self.scl_o.wr(SCL_HIGH)
            clkfence()
            ack_check:bit = self.sda_i.rd()
            self.scl_o.wr(SCL_LOW)
            clkfence()
            #if ack_check == wait_bit:
            #    break
            break

        self.sda_o.wr(1)
        self.sda_t.wr(OE)

    def wait_slave_not_busy(self):
        while True:
            check_slave_scl:bit = self.scl_i.rd()
            if check_slave_scl != SLAVE_SCL_FORCE_LOW:
                break

    def pre_start_sequence(self):
        #self.sda_o.wr(1)
        #clkfence()
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
        self.res_q.wr(DEBUG_FLAG | 9)

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
        self.start_sequence()
        
        self.send_slave_addr(w_addr, WRITE_BIT0)
        self.wait_ack()

        self.send_raw_data(reg_addr, CHECK_SLAVE_BUSY)
        self.wait_ack()

        self.send_raw_data(w_data, CHECK_SLAVE_BUSY)
        self.wait_ack()

        self.stop_sequence() 

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
            b0 = ~b0
            clkfence()
            self.scl_o.wr(SCL_HIGH)
            clkfence()

            self.scl_o.wr(SCL_LOW)
            clkfence()


    def worker(self):
        self.init_bus()
        
        while is_worker_running():
            cmd:bit8 = self.cmd_q.rd()
            res:bit8 = cmd | RESPONSE_FLAG
            has_data_flag:bit = 0
            r_data:bit8 = 0
            reg_addr_high:bit8 = 0
            reg_addr_low:bit8 = 0
            reg_addr:bit16 = 0 
            reg_addr8:bit8 = 0 
            slave_addr8:bit8 = 0 

            if cmd == WRITE_CMD:
                w_addr = self.cmd_q.rd()
                w_data = self.cmd_q.rd()
                self.write_data(w_addr, w_data)
            elif cmd == READ_CMD:
                r_addr = self.cmd_q.rd()
                r_data = self.read_data(r_addr)
                has_data_flag = 1
            elif cmd == WRITE_REG8_CMD:
                w_addr = self.cmd_q.rd()
                reg_addr8 = self.cmd_q.rd()
                w_data = self.cmd_q.rd()
                self.write_reg8(w_addr, reg_addr8, w_data)

            elif cmd == READ_REG8_CMD:
                slave_addr8 = self.cmd_q.rd()
                reg_addr8 = self.cmd_q.rd()
                r_data = self.read_reg8(slave_addr8, reg_addr8)

                has_data_flag = 1

            elif cmd == WRITE_REG_CMD:
                w_addr = self.cmd_q.rd()
                reg_addr_high = self.cmd_q.rd()
                reg_addr_low = self.cmd_q.rd()
                reg_addr = self.bit8x2_to_bit16(reg_addr_high, reg_addr_low)
                
                w_data = self.cmd_q.rd()
                self.res_q.wr(DEBUG_FLAG | 7)
                self.write_reg(w_addr, reg_addr, w_data)
                self.res_q.wr(DEBUG_FLAG | 6)
            elif cmd == READ_REG_CMD:
                r_addr = self.cmd_q.rd()
                reg_addr_high = self.cmd_q.rd()
                reg_addr_low = self.cmd_q.rd()
                reg_addr = self.bit8x2_to_bit16(reg_addr_high, reg_addr_low)

                r_data = self.read_reg(r_addr, reg_addr)

                has_data_flag = 1
            elif cmd == TPG_CMD:
                n_1 = self.cmd_q.rd()
                self.do_tpg(n_1 + 1)

            else:
                assert(cmd == NOP_CMD)
                pass

            if has_data_flag:
                res |= HAS_DATA_FLAG

            self.res_q.wr(res)

            if has_data_flag:
                self.res_q.wr(r_data)

@testbench
def test(m):
    PCA9548_ADDR = 0b1110100

    m.cmd_q.wr(NOP_CMD)
    res = m.res_q.rd()
    print("NOP:", res)

    m.sda_i.wr(0)
    m.scl_i.wr(1)

    m.cmd_q.wr(WRITE_CMD)
    m.cmd_q.wr(PCA9548_ADDR)
    m.cmd_q.wr(0x4)

    #d = m.debug.rd()
    clksleep(20)
    #print("debug", d)
    m.sda_i.wr(1)

    res = m.res_q.rd()
    print("WRITE_CMD", res)

#    m.cmd_q.wr(READ_CMD)
#    m.cmd_q.wr(PCA9548_ADDR)

#    res = m.res_q.rd()
#    print("READ_CMD", res)
#    data = m.res_q.rd()
#    print("READ data", res)

if __name__ == '__main__':
    m = i2c_module()
    test(m)
