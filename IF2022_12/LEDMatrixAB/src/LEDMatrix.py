from polyphony import testbench, module, is_worker_running
from polyphony.timing import clksleep, wait_value
from polyphony.io import Port
from polyphony.typing import bit, bit8
from data import FONT_DATA

@module
class LEDMatrixAB:
    def __init__(self, interval):
        self.swA = Port(bool, 'in')
        self.swB = Port(bool, 'in')

        self.row = Port(bit8, 'out')
        self.col = Port(bit8, 'out')

        self.interval = interval
        self.append_worker(self.main)

    def main(self):
        row_cnt = 0
        while is_worker_running():
            a = self.swA.rd()
            b = self.swB.rd()
            d =  8 if a == 0 and b == 1 else 16 if a == 1 and b == 0 else 24 if a == 0 and b == 0 else 0
            
            self.col.wr(FONT_DATA[d + row_cnt])
            self.row.wr(1 << row_cnt)
            row_cnt = (row_cnt + 1) & 7

            self._wait()

    def _wait(self):
        for i in range(self.interval // 2):
            pass

m = LEDMatrixAB(2700)

@testbench
def test(matrix_m):
    pass

test(m)
