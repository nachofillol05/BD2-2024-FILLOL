#STRING FUNCTIONSS
select ascii('aho');#devuelve el codigo ascii del primer caracter
select bin(3);#devuelve el numero en binario
select bit_length('hola'); #devuelve el largo que ocupa en bits
select char('43',21,'43',55);#No se que devuelve BUUUUUUSCAAAAAAAAAAAAR
select char_length('holas');#dice la longitud del char
select concat('jola',' como andas');#concatena la string
select concat_ws(',', 'hola ', 'como andas'); #concatena pero con el primer parametro entre medio de las concats
SELECT CONV('a',16,2);#Ver que haceeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
SELECT ELT(1, 'ej', 'Heja', 'hej', 'foo');#te da el numero de indice que indicas es como si hicieras [1] pero se toma literalmente el numero no es que la 0 es la posicion 1 osea se empieza de 1
SELECT EXPORT_SET(4,'Yes','No',',',5);#INVESTIGAAAAAAAAAAAAAAAAAAR EXPORT_SET(bits,on,off[,separator[,number_of_bits]])
SELECT FIELD('ej', 'Hej', 'ej', 'Heja', 'hej', 'foo');#te devuelve en que posicion esta la palabra o el elemento buscado, devuelve cero si no encuentra
SELECT FIND_IN_SET('d','a,b,c,d');#devuelve el indice en una lista separada por comas
SELECT FORMAT(12332.123456, 1);#Devuelve el numero formateado y el ultimo numero es la cant de decimales que toma
SELECT HEX('FF');#pasa a hexadecimal puede ser una str o un int
SELECT INSERT('Quadratic', 3, 4, 'What');#INSERT(str,pos,len,newstr) la pos es donde empieza la cadena y len es el largo y newstr que inserta la cadena adentro de la otra reemplazando los caracteres
SELECT LEFT('foobarbar', 3);#devuelve los primeros caracteres de largo segundo numero
UPDATE table_test SET blob_col = LOAD_FILE('/tmp/picture') WHERE id = 1;#lee archivos
SELECT LOCATE('bar', 'foobarbar');#se fija en donde empieza la subcadena a buscar
SELECT LPAD('hi',4,'??');#LPAD(str,len,padstr)agrega a la izquierda los caracteres del final el de los params, el len es el largo total de la cadena si es mas corto se termina
SELECT STRCMP('MOHD', 'MOHD');#0 si son iguales, -1 si el primero es mas chico que el otro, 1 si estan "ordenados"
SELECT TRIM(LEADING 'x' FROM 'xxxbarxxx'); #BOTH | LEADING | TRAILING, Que hace cada uno nose pero saca lo que le madas
SELECT TRIM('  bar   ');#saca los espacios
select UNHEX('4D7953514C'); #desconvierte un hexadecimal

#date