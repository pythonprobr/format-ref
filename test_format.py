# coding: utf-8

from nose.tools import eq_

def render_tup(fmt, tup):
    s1 = fmt[0] % tup
    s2 = fmt[1].format(*tup)
    return (s1, s2)

def render_dic(fmt, dic):
    s1 = fmt[0] % dic
    s2 = fmt[1].format(**dic)
    return (s1, s2)

def test_tuple_str_float():
    moeda = 'USD'
    valor = 3.456
    fmt = ('frete: %s %.2f/kg', 'frete: {0} {1:.2f}/kg')
    eq_(*render_tup(fmt, (moeda, valor)))

def test_dict_str_float():
    d = {'valor':3.456, 'moeda':'USD'}
    fmt = ('frete: %(moeda)s %(valor).2f/kg', 'frete: {moeda} {valor:.2f}/kg')
    eq_(*render_dic(fmt, d))

def test_int_id():
    idt = 23
    fmt = ('id: %04d', 'id: {0:04}')
    eq_(*render_tup(fmt, (idt,)))

def test_str_repr():
    s = 'avião'
    fmt = ('str: %s repr: %r', 'str: {0} repr: {1!r}')
    eq_(*render_tup(fmt, (s, s)))





