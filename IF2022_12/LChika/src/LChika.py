from polyphony import testbench, module, is_worker_running
from polyphony.timing import clksleep, wait_value
from polyphony.io import Port
from polyphony.typing import bit

@module
class LChika:
    def __init__(self, interval):
        self.led = Port(bool, 'out', True)
        self.interval = interval
        self.append_worker(self.main)

    def main(self):
        led = True
        while is_worker_running():
            self.led(led)
            led = not led
            self._wait()

    def _wait(self):
        for i in range(self.interval // 2):
            pass

m = LChika(27000000)

@testbench
def test(lchika_m):
    if lchika_m.led.rd():
        print("LED off")
    else:
        print("LED on")

    wait_value(False, lchika_m.led)

    if lchika_m.led.rd():
        print("LED off")
    else:
        print("LED on")

    wait_value(True, lchika_m.led)

    if lchika_m.led.rd():
        print("LED off")
    else:
        print("LED on")

test(m)
