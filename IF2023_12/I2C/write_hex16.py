#skip
import polyphony

from polyphony.io import Port
from polyphony import module
from polyphony.typing import bit8, bit16
from polyphony.timing import clksleep, clkfence, wait_value

CR=0x0D
LF=0x0A

def b16_to_ascii(h16:bit8):
    if h16 <= 9:
        rv = 0x30 + h16
    else:
        rv = 0x41 + ( h16 - 10 )
    return rv

def write_hex16(tx_q, v:bit8):
    d = (v >> 4) & 0xf
    tx_q.wr(b16_to_ascii(d))
    d = (v) & 0xf
    tx_q.wr(b16_to_ascii(d))

def write_ln(tx_q):
    tx_q.wr(CR)
    tx_q.wr(LF)

@module
class print_hex_port:
    def __init__(self):
        self.print_pin = Port(bit8, 'out')

    def print_addr_data(self, addr:bit16, data:bit8):
        write_hex16(self.print_pin, (addr >> 8) & 0xFF)
        self.print_pin.wr(0x5f)
        write_hex16(self.print_pin, addr & 0xFF)
        self.print_pin.wr(0x20)
        write_hex16(self.print_pin, data)
        write_ln(self.print_pin)
        #print("printf \"addr:%02x data:%02x\\n\"", addr, data)
        print("addr: ", addr, "data:", data)

    def print_hex(self, data:bit8):
        self.print_pin.wr(data)
        
