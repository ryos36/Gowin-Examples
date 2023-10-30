 
from polyphony import testbench
from polyphony import rule
from polyphony import module
from polyphony.typing import bit, bit8, bit16
from polyphony.io import Port
from polyphony import is_worker_running
from polyphony.timing import clksleep, wait_value, clkfence

from i2c_lib import i2c_lib
from write_hex16 import write_hex16, write_ln, print_hex_port

from write_hex16 import write_hex16, write_ln
from data import ov2640_data

OV2640_SCCB_ADDR=0x60
OV2640_ADDR=(OV2640_SCCB_ADDR>>1)

@module
class ov2640:
    def __init__(self):
        self.i2c = i2c_lib()
        self.debug = print_hex_port()

        self.resend = Port(bit, 'in')
        self.done = Port(bit, 'out', init=0)

        self.append_worker(self.worker)

    def worker(self):
        self.i2c.init_bus()

        self.done.wr(0)
        self.debug.print_hex(0x01)

        while is_worker_running():
            for data_i in ov2640_data:
                reg_addr:bit8 = (data_i >> 8) & 0xFF
                send_data:bit8 = data_i & 0xFF

                err=self.i2c.write_reg8(OV2640_ADDR, reg_addr, send_data)
#                if err>0:
#                    break
                self.debug.print_hex(send_data)

            self.done.wr(1)
            self.debug.print_hex(0xF2)

            wait_value(1, self.resend)
            self.debug.print_hex(0xF3)

@testbench
def test(m):
    m.i2c.sda_i.wr(0)
    m.i2c.scl_i.wr(1)
    print('Start!!')
    wait_value(1, m.done)
    print('Finished')

if __name__ == '__main__':
    initiator = ov2640()
    test(initiator)
