#!/usr/bin/env python
# coding: utf-8

import locale
locale.setlocale(locale.LC_NUMERIC, 'de_DE.UTF-8')

from pprint import pprint
#pprint(locale.localeconv())

#from math import pi
pi = 3.141593

float1 = 11111.**2/10**4
float1 = 123456789876./10**4
exemplos = [
    (123, ''),
    (123, 'd'),
    (123, '+'),
    (123, '#b'),
    (123, '7'),
    (123, '04d'),
    (123, 'x'),
    (123, '04x'),
    (123, '#x'),
    (123, '#06x'),
    (123, '<+6x'),
    (123, '^+6x'),
    (123, '0>+6x'),
    (123, '0=+6x'),
    (123, '0= 6x'),
    (123, '0=6x'),
    (-123, '0=6x'),
    (-123, '06x'),
    (2**32, '18,'),
    (2**32, '18d'),
    (2**32, '18x'),
    (2**32, '18n'),
    (2**32, '18f'),
    (pi, '8.3'),
    (pi, '8.4f'),
    (pi, '_>+8.3f'),
    (float1, '18f'),
    (float1, '18g'),
    (float1, '18e'),
    (float1, '18n'),
    (float1, '18,f'),
    (float1, '18,.2f'),
    (float1, '18.1n'),
    (float1, '18.2n'),
    (float1, '18.3n'),
    (float1, '18.8n'),
    (float1, '18.10n'),
    (float1, '18.12n'),
    (float1, '18.14n'),
    (float1, '18.1g'),
    (float1, '18.2g'),
    (float1, '18.3g'),
    (float1, '18.8g'),
    (float1, '18.10g'),
    (float1, '18.12g'),
    (float1, '18.14g'),
    ('Diretor', '.<12'),
    ('Diretor', '.6'),
]

for val, fmt in exemplos:
    fmt_call = 'format({0!r},{1!r})'.format(val, fmt)
    print '{0:30}\t{1!r}'.format(fmt_call, format(val, fmt))