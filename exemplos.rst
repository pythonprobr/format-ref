>>> fmt = 'valor de {0} com 4 casas: {0:.4f}' 
>>> fmt.format(math.pi) 
'valor de 3.14159265359 com 4 casas: 3.1416' 
>>> fmt2 = 'valor de {0} com {n:02} casas: {0:.{n}f}'
>>> fmt2.format(math.pi, n=5) 
'valor de 3.14159265359 com 05 casas: 3.14159' 
>>> format(math.pi, '6.3f')
' 3.142'

