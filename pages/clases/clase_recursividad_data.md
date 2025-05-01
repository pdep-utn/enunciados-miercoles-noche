## Múltiples constructores

```hs
data ColorPrimario = Rojo | Amarillo | Azul
```

Esto se lee: “el tipo de dato ColorPrimario tiene tres constructores: Rojo, Amarillo y Azul, todos sin parámetros”. En este caso sirve para representar una enumeración. Entonces podemos construir una función que discrimine ambos elementos por pattern matching

```hs
recargoPorColor :: ColorPrimario -> Int
recargoPorColor Rojo  = 50
recargoPorColor _     = 20 // por descarte, amarillo o azul
```

## Recursividad

Hablamos de caso base y caso recursivo y la relación entre inducción - recursividad - iteración.

### Factorial

vemos la versión con pattern matching

```hs
factorial 0  =  1
factorial n  =  n * factorial (n - 1)
```

vs. con guardas

```hs
factorial n 
  | n == 0     = 1
  | n > 0      = n * factorial (n - 1)
```

una diferencia es que si n es negativo en la primera variante entramos en loop infinito vs. error de exhaustive patterns.

### Segundo ejemplo: saber si un número primo

El primo busca los divisores, hay variantes más performantes (como armar la recursividad hasta maximo `div` 2)

```hs
noHayDivisores minimo maximo n 
    | minimo `esDivisorDe` n = False
    | minimo == maximo       = True
    | otherwise              = noHayDivisores (minimo + 1) maximo n

esDivisorDe unNumero otroNumero = mod otroNumero unNumero == 0

primo 1 = False
primo 2 = True
primo n = noHayDivisores 2 (n - 1) n
```

Se puede probar en Haskelite: https://pbv.github.io/haskelite/site/index.html

que hace el seguimiento paso a paso.

## Recursividad con listas

- primero length
- last
- take
- (!!)
- elem
- reverse

## RECREO

## Ejemplo de alumnos en C

Pensamos un alumno como un TAD

```c
typedef struct AlumnoType {
	char * nombre;
	char * apellido;
	char * direccion;
	int edad;
	int legajo;
	bool (*criterioEstudio)(Parcial*);
} Alumno;

char * nombreCompleto(Alumno * unAlumno);
void setCriterioDeEstudio(Alumno * unAlumno, bool (*criterioEstudio)(Parcial*));
bool esMayorDeEdad(Alumno * unAlumno);

Alumno * Alumno_new(char * nombre, char * apellido, char * direccion, int edad,
		int legajo, bool (*criterioEstudio)(Parcial *));
```

armamos el diagrama desde adentro hacia afuera.

## Ejemplo de alumnos en Typescript

```ts
type Parcial = {
  materia: string,
  cantidadDePreguntas: number
}

type CriterioEstudio = (_parcial: Parcial) => boolean

type Fecha = [number, number, number] // Tuplas en Typescript

type Alumno = {
  nombre: string,
  fechaNacimiento: Fecha,
  legajo: number,
  materiasQueCursa: string[],
  criterioEstudio: CriterioEstudio
}
```