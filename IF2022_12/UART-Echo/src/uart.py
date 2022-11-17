import polyphony
from polyphony import is_worker_running
from polyphony.io import Port, Queue
from polyphony.typing import bit, uint8, bit3, bit8
from polyphony.timing import clksleep, clkfence, wait_value

@polyphony.module
class Echo:
    RBR = 0x00
    THR = 0x00
    IER = 0x01
    LCR = 0x03
    LSR = 0x05

    BIT8 = 3

    def __init__(self):
        self.tx_start = Port(bit, 'out', 0)

        self.i_tx_en = Port(bit, 'out', 0)
        self.waddr = Port(bit3, 'out', 0)
        self.wdata = Port(bit8, 'out', 0)

        self.i_rx_en = Port(bit, 'out', 0)
        self.raddr = Port(bit3, 'out', 0)
        self.rdata = Port(bit8, 'in')

        self.tx_empty = Port(bit, 'out', 0)
        self.rx_valid = Port(bit, 'out', 0)

        self.kick_start = Port(bit, 'in')
        self.kick_done = Port(bit, 'out', 0)

        self.msg = (0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x21)

        self.append_worker(self.tx_worker)

    def init_uart(self):
        self.i_tx_en.wr(1);
        self.waddr.wr(self.LCR);
        self.wdata.wr(self.BIT8); 
        clkfence()

        self.i_tx_en.wr(0);
        clkfence()

    def check_valid(self):
        self.kick_done.wr(1)
        self.rx_valid.wr(0)

        self.raddr.wr(self.LSR);
        self.i_rx_en.wr(1);
        clkfence()

        self.i_rx_en.wr(0);
        clkfence()

        status = self.rdata.rd()
        rx_ready = 1 if ((status & 0x01) == 0x01) else 0

        self.rx_valid.wr(rx_ready)
        clkfence()

        self.kick_done.wr(0)

        return rx_ready

    def read_char(self):
        self.i_rx_en.wr(1);
        self.raddr.wr(self.RBR);
        clkfence()

        self.i_rx_en.wr(0);
        clkfence()

        clksleep(3)

        data:bit8 = self.rdata.rd()

        return data

    def wait_tx_empty(self):
        tx_empty:bit = 0
        self.tx_empty.wr(1)
        while tx_empty == 0:
            self.raddr.wr(self.LSR);
            self.i_rx_en.wr(1);
            clkfence()

            self.i_rx_en.wr(0);
            clkfence()
            clksleep(3)

            status = self.rdata.rd()
            clkfence()

            tx_empty = 1 if ((status & 0x40) == 0x40) else 0
            clkfence()

        self.tx_empty.wr(0)

    def write_data(self, d):
        self.waddr.wr(self.THR);
        self.wdata.wr(d); 
        self.i_tx_en.wr(1);
        clkfence()

        self.i_tx_en.wr(0);
        clkfence()

    def wait_write_data(self, d):
        self.wait_tx_empty()
        clksleep(1)

        self.write_data(d)
        clksleep(1)
        

    def tx_worker(self):
        self.init_uart()
        clksleep(10)

        self.kick_done.wr(1)
        wait_value(1, self.kick_start)
        self.kick_done.wr(0)

        wait_value(1, self.kick_start)
        data:bit8 = 0x48
        while is_worker_running():
            if self.check_valid():
                data = self.read_char()

                self.tx_start.wr(1)
                self.wait_write_data(data)
                clksleep(1)

                clksleep(0)
                clkfence()

                self.tx_start.wr(0)
                clkfence()
            for i in range(10000):
                pass



@polyphony.module
class Transmitter:
    def __init__(self):
        self.kick_tx = Port(bit, 'in')

        self.rx_valid = Port(bit, 'in', 0)
        self.rx_data = Port(uint8, 'in', 0)
        self.rx_req = Port(bit, 'out')

        self.tx_busy = Port(bit, 'in', 0)
        self.tx_data = Port(uint8, 'out', 0)
        self.tx_req = Port(bit, 'out')

        self.tx_q = Queue(uint8, 'any')

        self.append_worker(self.tx_worker)
        self.append_worker(self.func)

    def tx_worker(self):
        while is_worker_running():
            data = self.tx_q.rd()

            wait_value(0, self.tx_busy)

            self.tx_data.wr(data)
            self.tx_req.wr(1)
            clkfence()

            self.tx_req.wr(0)
            clkfence()

            #wait_value(1, self.tx_busy)

    def write_one(self, d):
         self.tx_q.wr(d)

    def write_hex0(self, v):
        if (v < 10):
            self.tx_q.wr(0x30 + v)
        else:
            va = v - 10
            self.tx_q.wr(0x41 + va)

    def write_hex16(self, v):
        self.tx_q.wr('[')
        d:bit8 = (v & 0xf0) >> 4
        self.write_hex0(d)

        d = (v & 0x0f)
        self.write_hex0(d)
        self.tx_q.wr(']')

        self.tx_q.wr(0x0d)
        self.tx_q.wr(0x0a)

    def func(self):
        while is_worker_running():
            if self.kick_tx.rd() == 1:
                msg = (0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x21)
                for d in msg:
                    self.write_one(d)

                wait_value(0, self.kick_tx)
                        
            elif self.rx_valid.rd() == 1:
                self.rx_req.wr(1)
                clkfence()

                self.rx_req.wr(0)

                clksleep(3)

                data = self.rx_data.rd()
                clkfence()
                self.write_hex16(data)

@polyphony.testbench
def test(tx):
    pass

if __name__ == '__main__':
    echo = Transmitter()
    u0 = Wrapper()
    chat0 = Chat()
    test(u0)
