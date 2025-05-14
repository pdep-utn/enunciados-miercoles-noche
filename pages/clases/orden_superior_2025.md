## map

```hs
map f [] = []
map f (x:xs) = f x : map f xs
```

Usos

```hs
map (* 2) [1..5]                     -- [2, 4, 6, 8, 10]
map desgasteTotal autos where desgasteTotal auto = desgasteRuedas auto + desgasteChasis auto
map length ["que", "grande", "map"]  -- [3, 6, 3]
```

## and => all

```hs
and [True, True, False] -- False
and [True, True, True]  -- True

-- o sea que
all condicion lista = (and . map condicion) lista
all f = and . map f
```

Usos

```hs
all (> 4) [3..8]

data Cliente = Cliente {
    deuda :: Number,
    nombre :: String
}

clientes = [Cliente 1000 "Guerrero Hnos", Cliente 0 "Paz & Filosa" ]

all (primo . deuda) clientes
```

## sumOf

Siguiendo el ejemplo anterior:

```hs
sumOf f lista = (sum . map f) lista
sumOf f = sum . map f
```

Uso

```hs
sumOf deuda clientes
sumOf (length . nombre) clientes -- suma las letras de los nombres
```

## flip

La presentamos

```hs
flip :: (a -> b -> c) -> b -> a -> c
flip f x y = f y x
```

Un uso práctico

```hs
data Ciudad = Ciudad {
   nombre :: String,
   temperaturaPromedio :: Number
} deriving (Show)

ciudades = [ Ciudad "Rio" 30, Ciudad "Mendoza" 15 ]

haceMasDe :: Ciudad -> Number -> Bool
haceMasDe ciudad temperatura = ((> temperatura) . temperaturaPromedio) ciudad

ciudadesCalurosas :: [Ciudad] -> [Ciudad]
-- ciudadesCalurosas ciudades = filter (haceMasDe 25) ciudades
ciudadesCalurosas ciudades = filter (flip haceMasDe 25) ciudades
```

- haceMasDe toma la ciudad primero
- pero con flip hacemos de función adaptadora
- en el TP les pasaba bocha que definían la función penalidad como Auto -> Number -> Auto, a todos los grupos les pedía que pusieran juntas todas las funciones en una lista y no podían... con flip no hubieran tenido que redefinirla


## fold

### fold1

> [ 4 , 2 , 7 ] 
- para obtener el total de esa lista intercalamos una función binaria (+) (sumamos 4 + 2 = 6 + 7 = 13)
- para obtener el mayor de esa lista intercalamos la función binaria `max` (gana primero el 4 y después el 7)

- **foldl1** => a izquierda
- **foldr1** => a derecha, sumaríamos 2 + 7 = 9 + 4 = 13, y el mayor sería 7 ganador de 2 y luego 7 ganador de 4

Si tenemos [8, 2, 2] => foldl1 y foldr1 nos van a dar valores distintos (a derecha da 8 y a izquierda da 2). Hacemos el seguimiento.

fold_1 es porque necesitamos que la lista tenga al menos un elemento

### fold: semilla

Sumar longitudes de palabras

["uno", "por", "uno"]

lo descomponemos en
  
```  
           f
          / \
    "uno"    f
            / \
        "por"  \
                f
               / \
            "uno" \
                   semilla
```

semilla => 0
f = (+) . length

Hacemos el seguimiento:

```
[ "uno", "por", "uno" ]  0
                  - 3 ----
         -- 6 ------------
 -- 9 --------------------

```

Probemos en Haskell qué nos da:

```hs
:t ((+) . length)
[a] -> Number -> Number
```

Esto es porque 

```hs
length :: [a] -> Number
(+) :: Number -> Number -> Number

-- entonces
((+) . length) :: [a] -> (Number -> Number)
```

es decir, la asociatividad de la definición de las funciones es **a derecha**.

Si yo le paso dos parámetros, estoy aplicando parcialmente (+).

## Segundo ejemplo de foldr

data Cliente = Cliente {
    nombre :: String,
    saldo :: Number
}

foldr ((+) . saldo) 0 clientes

## Foldr vs. foldl

Veamos los tipos

```hs
foldr :: (a -> b -> b) -> b -> [a] -> b
foldl :: (b -> a -> b) -> b -> [a] -> b
```

La función está invertida, por lo que eso hace que no podamos usar la misma función para calcular el total de deuda de nuestros clientes:

```hs
foldl ((+) . deuda) 0 clientes -- error de tipos
```

Pero podemos llamar a flip:

```hs
foldl (flip ((+) . deuda)) 0 clientes -- error de tipos
```

eso da vuelta el orden de los parámetros que es justo lo que necesitamos.

## Implementación de fold

A izquierda el caso base es simple -> devuelvo la semilla.
Cuando voy a izquierda tengo que ir generando el nuevo valor (dejar en el pizarrón cómo lo vamos obteniendo): el nuevo valor primero es semilla operado con f primer elemento. En el caso de los clientes sumo 0 a la deuda del primer cliente.
La segunda vez es el valor anterior (que ya no es la semilla) operado con f del segundo elemento. En el caso de los clientes sumo la deuda del primer cliente con la deuda del segundo. Y así sucesivamente, voy sumando la deuda de los clientes hasta el que llegué + el cliente nuevo de la iteración.

```hs
foldl :: (b -> a -> b) -> b -> [a] -> b
foldl f valor [] = valor
foldl f valor (x:xs) = foldl f (f valor x) xs
```

- ventaja: no necesita stack, en la llamada recursiva estoy mandando el acumulado (tail recursion)
- desventaja: si la lista es infinita, no tengo forma de terminar


A derecha tengo que primero haber recorrido toda la lista, entonces voy a dejar suspendida la operación del primer elemento. Cuando tengo lista vacía, opero el último elemento con la semilla y voy hacia atrás. La deuda del penúltimo cliente se suma a la deuda del último cliente y así sucesivamente para atrás.

```hs
foldr :: (a -> b -> b) -> b -> [a] -> b
foldr f semilla [] = semilla
foldr f valor (x:xs) = f valor (foldr f valor xs)
```

- ventaja: si la lista es infinita hay algoritmos que convergen a un valor.

```hs
foldr ((&&) . (< 5)) True [1..]        -- False
-- vs
foldl (flip ((&&) . (< 5))) True [1..] -- no termina nunca
```

En el ejemplo queríamos ver si todos los números son menores a 5 (con fold podemos hacer all).

> **Tip**: todas las funciones map, filter, etc. se pueden implementar con fold


## ($) , la función aplicación

```hs
($) :: (a -> b) -> a -> b
f $ x = f x
```

Evita paréntesis

```hs
take 1 (filter even [1..10])
-- es lo mismo que
take 1 $ filter even [1..10]
```

## Foldr + ($)

Ejemplo de las personas

```hs
cumplirAnios persona = persona { edad = edad persona + 1 }

caminar kilometros persona = persona { felicidad = felicidad persona + kilometros * 2 }

hacerseAmigoDe amistad persona = persona { felicidad = felicidad persona + 100, amigos = amistad:amigos persona }

persona = Persona 28 90 ["juan", "mara"]
```

si queremos hacer que una persona

- cumpla años
- camine 10 kilómetros
- se haga amigo de Toby

```hs
foldr ($) persona [cumplirAnios, caminar 10, hacerseAmigoDe "toby"]
```
