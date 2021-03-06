#!/usr/bin/env python
# coding: utf-8

'''
>>> ############################################################ quadro 0
>>> import math
>>> '%6.3f' % math.pi
' 3.142'
>>> format(math.pi, '6.3f')
' 3.142'
>>> fmt = '{0} com 4 casas: {0:.4f}'
>>> fmt.format(math.pi)
'3.14159265359 com 4 casas: 3.1416'
>>> '%s com 4 casas: %.4f' % (math.pi, math.pi)
'3.14159265359 com 4 casas: 3.1416'
>>> fmt2 = '{0} com {n:02} casas: {0:.{n}f}'
>>> fmt2.format(math.pi, n=5)
'3.14159265359 com 05 casas: 3.14159'
>>> fmt2.format(math.pi, n=3)
'3.14159265359 com 03 casas: 3.142'
>>> ############################################################ quadro 1
>>> '{0} {1} {2}'.format(2, 3, 5)
'2 3 5'
>>> '{} {} {}'.format(2, 3, 5) # Python ≥ 2.7
'2 3 5'
>>> '%d %d %d' % (2, 3, 5)
'2 3 5'
>>> '{0.real} {0.imag}'.format(3j+4)
'4.0 3.0'
>>> '%s %s' % ((3j+4).real, (3j+4).imag)
'4.0 3.0'
>>> '{0.real:f} {0.imag:f}'.format(3j+4)
'4.000000 3.000000'
>>> '%f %f' % ((3j+4).real, (3j+4).imag)
'4.000000 3.000000'
>>> d = {'BRL':0.5457, 'EUR':1.3496}
>>> 'Euro: {EUR}, Real: {BRL}'.format(**d)
'Euro: 1.3496, Real: 0.5457'
>>> 'Euro: {0[EUR]}, Real: {0[BRL]}'.format(d)
'Euro: 1.3496, Real: 0.5457'
>>> 'Euro: %(EUR)s, Real: %(BRL)s' % d
'Euro: 1.3496, Real: 0.5457'
>>> from datetime import date
>>> dts = (date(2011,9,3), date(2011,9,7))
>>> 'de {0[0].day} a {0[1].day}'.format(dts)
'de 3 a 7'
>>> 'de {0.day} a {1.day}'.format(*dts)
'de 3 a 7'
>>> 'de {.day} a {.day}'.format(*dts) # ≥ 2.7
'de 3 a 7'
>>> 'de %s a %s' % (dts[0].day, dts[1].day)
'de 3 a 7'
>>> class Spam(object):
...     def __str__(self):
...         return 'Spam!!!'
...     def __format__(self, fmt):
...         return 'Spam'.replace(fmt, fmt*3)
>>> s = Spam()
>>> '{0!s}, {0!r}'.format(s) #doctest:+ELLIPSIS
'Spam!!!, <__main__.Spam object at ...>'
>>> '{0}, {0:a}, {0:m}'.format(s)
'Spam, Spaaam, Spammm'

>>> ############################################################ quadro 2
>>> s = 'Fotografia'
>>> format(s,'.<16')
'Fotografia......'
>>> s.ljust(16, '.')
'Fotografia......'
>>> format(s, '.>16')
'......Fotografia'
>>> s.rjust(16, '.')
'......Fotografia'
>>> format(s ,'.^16')
'...Fotografia...'
>>> s.center(16, '.')
'...Fotografia...'

>>> format(math.pi, '_>+8.3f')
'__+3.142'
>>> format(math.pi, '_=+8.3f')
'+__3.142'
>>> format(123, '0= 6x')
' 0007b'
>>> format(123, '0=+6x')
'+0007b'
>>> format(123, '#06x')
'0x007b'
>>> '{0:f} {0:e}'.format(2**32)
'4294967296.000000 4.294967e+09'
>>> '%f %e' % (2**32, 2**32)
'4294967296.000000 4.294967e+09'
>>> '{0:{1}} {0:{2}}'.format(2**32, 'f', 'e')
'4294967296.000000 4.294967e+09'
>>> format(12345678.9876,'18.10n')
'       12345678.99'
>>> format(12345678.9876,'18.2f')
'       12345678.99'
>>> '%18.2f' % 12345678.9876
'       12345678.99'

>>> n, t = 15, 42
>>> '{}/{} ({:.1%})'.format(n, t, float(n)/t)
'15/42 (35.7%)'
>>> '%s/%s (%0.1f%%)' % (n, t, float(n)/t * 100)
'15/42 (35.7%)'

>>> '{a:{b}}'.format(a=2**64, b='e')
'1.844674e+19'
>>> format(2**64,'e')
'1.844674e+19'

>>> from locale import setlocale, LC_NUMERIC
>>> setlocale(LC_NUMERIC, 'de_DE.UTF-8')
'de_DE.UTF-8'
>>> # http://bugs.python.org/issue16944
>>> format(12345678.9876,'18.10n') # doctest: +SKIP
'     12.345.678,99'
'''

def test():
    # doctest can't handle non-ASCII results, so here is the skipped test
    import math
    assert u'{} ≈ {}'.format(u'π', math.pi) == u'π ≈ 3.14159265359'

import sys
reload(sys)
sys.setdefaultencoding('utf8')
import doctest
doctest.testmod()
test()
