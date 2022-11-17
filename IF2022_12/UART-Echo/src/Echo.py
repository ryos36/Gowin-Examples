from polyphony import testbench, module, is_worker_running, pipelined
from polyphony.timing import clksleep, wait_value, clkfence
from polyphony.io import Port
from polyphony.typing import bit, bit3, bit8
from data import MSG_DATA

@module
class Echo:
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

        self.append_worker(self.echoback_worker)

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

    def read_char(self):
        self.i_rx_en.wr(1);
        self.raddr.wr(self.RBR);
        clkfence()

        self.i_rx_en.wr(0);
        clkfence()

        clksleep(3)

        data:bit8 = self.rdata.rd()

        return data

    def check_valid(self):
        self.raddr.wr(self.LSR);
        self.i_rx_en.wr(1);
        clkfence()

        self.i_rx_en.wr(0);
        clkfence()

        status = self.rdata.rd()
        rx_ready = 1 if ((status & 0x01) == 0x01) else 0
        clkfence()

        return rx_ready

    def write_data(self, data):
        self.waddr.wr(self.THR);
        self.wdata.wr(data); 
        self.i_tx_en.wr(1);
        clkfence()

        self.i_tx_en.wr(0);
        clkfence()

    def wait_write_data(self, d):
        self.wait_tx_not_busy()
        clksleep(1)

        self.write_data(d)
        clksleep(1)

    def echoback_worker(self):
        self.init_uart()
        clksleep(10)

        while is_worker_running():
            if self.check_valid():
                data = self.read_char()
                self.wait_write_data(data)
                clksleep(1)

            for i in range(10000):
                pass

m = Echo()

@testbench
def test(hello_m):
    clksleep(10)

test(m)
