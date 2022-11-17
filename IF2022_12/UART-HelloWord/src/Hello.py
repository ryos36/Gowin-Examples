from polyphony import testbench, module, is_worker_running, pipelined
from polyphony.timing import clksleep, wait_value, clkfence
from polyphony.io import Port
from polyphony.typing import bit, bit3, bit8
from data import MSG_DATA

@module
class HelloWorld:
    RBR = 0x00
    THR = 0x00
    IER = 0x01
    LCR = 0x03
    LSR = 0x05

    BIT8 = 3

    def __init__(self):
        self.i_tx_en = Port(bit, 'out', 0)
        self.waddr = Port(bit3, 'out', 0)
        self.wdata = Port(bit8, 'out', 0)

        self.i_rx_en = Port(bit, 'out', 0)
        self.raddr = Port(bit3, 'out', 0)
        self.rdata = Port(bit8, 'in')

        self.append_worker(self.main)

    def init_uart(self):
        self.i_tx_en.wr(1);
        self.waddr.wr(self.LCR);
        self.wdata.wr(self.BIT8); 
        clkfence()

        self.i_tx_en.wr(0);
        clkfence()

    def wait_tx_not_busy(self):
        tx_empty:bit = 0
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

    def write_data(self, data):
        self.waddr.wr(self.THR);
        self.wdata.wr(data); 
        self.i_tx_en.wr(1);
        clkfence()

        self.i_tx_en.wr(0);
        clkfence()

    def main(self):
        self.init_uart()
        clksleep(10)

        while is_worker_running():
            for data in MSG_DATA:
                self.wait_tx_not_busy()
                self.write_data(data)
            

m = HelloWorld()

@testbench
def test(hello_m):
    clksleep(10)

test(m)
