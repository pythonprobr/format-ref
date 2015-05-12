#!/usr/bin/env python

"""
    >>> s = Spam()
    >>> '{0.a:40}'.format(s) #doctest: +ELLIPSIS
    a
    __format__(40)
    '<__main__.Spam object at 0x...'
    >>> format(pi, '_>+8.3f') 
    '__+3.142'

"""

from math import pi

class Spam(object):
    def __getattr__(self, name):
        print name
        return self

    def __format__(self, fmt):
        print '__format__({0})'.format(fmt)
        return super(Spam, self).__format__(fmt)

if __name__=='__main__':
    import doctest
    doctest.testmod()
