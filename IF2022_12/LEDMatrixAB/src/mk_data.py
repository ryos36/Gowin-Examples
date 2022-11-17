DATA_SRC = ((
    '        ',
    '        ',
    '        ',
    '        ',
    '        ',
    '        ',
    '        ',
    '        '
    ),(
    '   #    ',
    '  # #   ',
    ' #   #  ',
    '#     # ',
    '####### ',
    '#     # ',
    '#     # ',
    '        '
    ),(
    '######  ',
    '#     # ',
    '#     # ',
    '######  ',
    '#     # ',
    '#     # ',
    '######  ',
    '        '
    ),(
    ' ##     ',
    '#       ',
    '#       ',
    ' ##  ## ',
    '    #  #',
    '    #  #',
    '     ## ',
    '       #'
))


delim = 'FONT_DATA = ('
for font in DATA_SRC:
    for data_row in font:
        print(f'{delim}0b', end='')
        for data in data_row: 
            v = '1' if data == '#' else '0'
            print(f'{v}', end='')
        delim = ', \n\t'
    print(' ')
    delim = ',	'
print(')')
