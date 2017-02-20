import sys

# pixel: 0  1  0  y7 y6 y2 y1 y0 y5 y4 y3 x7 x6 x5 x4 x3

def calculate_color_cell_pixel_address(x,y):
    result = (y & (0b00011000)) << 8
    result = result | ((y & 0b111) << 5)
    result = result | x
    result = result | 0b0100000000000000
    print hex(result)

func_name = sys.argv[1]
x = int(sys.argv[2])
y = int(sys.argv[3])

possibles = globals().copy()
possibles.update(locals())
func = possibles.get(func_name)
if not func:
    raise NotImplementedError("Function not implemented")
func(x,y)
