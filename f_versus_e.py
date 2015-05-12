umanove = 123456789.0
ns = [umanove/10**i for i in range(20)]
for n in reversed(ns):
    print '{0:6f}_{0:6e}_{0:6g}'.format(n)
