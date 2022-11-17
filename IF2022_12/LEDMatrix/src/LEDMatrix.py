from polyphony import testbench, module, is_worker_running
from polyphony.timing import clksleep, wait_value
from polyphony.io import Port
from polyphony.typing import bit, bit8

@module
class LEDMatrix:
    def __init__(self, interval):
        self.row = Port(bit8, 'out')
        self.col = Port(bit8, 'out')

        self.interval = interval
        self.append_worker(self.main)

    def main(self):
        from data import FONT_DATA
        row_cnt = 0
        while is_worker_running():
            self.col.wr(FONT_DATA[row_cnt])
            self.row.wr(1 << row_cnt)
            row_cnt = (row_cnt + 1) & 7

            self._wait()

    def _wait(self):
        for i in range(self.interval):
            pass

m = LEDMatrix(27000)

@testbench
def test(matrix_m):
    pass

test(m)
