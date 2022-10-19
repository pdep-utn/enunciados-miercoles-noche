# Notas sobre el testing

## Comenzamos primero con el ejemplo complejo de pepita

1. A pepita le gusta San Martín y Campana
2. Pepita cumple su deseo
   - toma el último lugar favorito, vuela hacia allá y el lugar favorito no existe más
   - San Martín es su nueva ciudad favorita
   - Debería estar en Campana
   - debería tener menos energía
3. Pepita agrega como ciudad favorita a Quilmes: quedan [San Martín, Quilmes]
4. Cumple dos veces su deseo
   - debería estar en San Martín (porque Quilmes se agregó al final)
   - no debería tener ciudades favoritas
   - podríamos chequear la energía resultante

### Preguntas

1. lo resuelvo en un solo test?
2. si no voy por un solo test y tengo varios tests, cómo reutilizo usar 1 y 2, vs. 1, 2, 3, 4
3. ¿puedo juntar todos los asserts en el mismo test? ¿Cómo los asocio?

## Conceptos generales

- **describe**: agrupa tests
- qué quiero: que el describe sea cohesivo
- fuerzas que se contraponen: el fixture suele compartirse entre tests. 

Variantes:

1. repito el mismo código en cada test, 
2. le pido a un objeto que inicialice los objetos que yo necesito (un objeto que crea otro objeto: un Factory o un Builder), 
3. ahora se abre la puerta al método initialize() que se ejecuta para todos los tests previos (algo parecido tienen los frameworks xUnit o Jasmine/Mocha => setup, beforeEach, beforeAll). Podemos también definir métodos. 

La dificultad de reutilizar en varios describe el mismo código hace que siga siendo 2. la mejor opción cuando pasa ésto. 

## Qué no debe hacer un test: 

1. tener lógica no trivial (lógica que requeriría de un testeo)
2. hacer ingeniería reversa del código que testea. Ejemplo:

```wollok
object pepita {
  var property energia = 100
  method volar(minutos) {
    energia = energia + (3 * minutos)
  }
 }
 
 test "pepita vuela como quiere" {
   const energiaInicial = pepita.energia()
   const minutos = 5
   pepita.volar(minutos)
   assert.equals(pepita.energia(), energiaInicial + (3 * minutos))
 }
 ```
 
 3. utilizar valores random para testear, viene de la mano de 2. A veces se arman 1000 fixtures para probar uno al azar. Eso es malísimo, corta el determinismo, tenés un bajo grado de cobertura y al no estar testeando casos te puede fallar un test muy ocasionalmente.
 4. no testear nada, en Wollok el test falla (naranja), en otros frameworks como JEST te tira un warning.
 5. obsesionarnos por el porcentaje de cobertura (ver más abajo), sobre todo se ve testeos de la misma clase de equivalencia. Los tipos no-nulos nos permiten evitar tests innecesarios.
 
 ## Testeo de errores

 Hacer el ejemplo del monedero.

## Porcentaje de cobertura

Mostrar [ejemplo de Tarea en Kotlin con codecov](https://app.codecov.io/gh/uqbar-project/eg-tareas-springboot-kotlin/blob/master/src/main/kotlin/org/uqbar/tareas/domain/Tarea.kt).
O [Wollok mismo](https://coveralls.io/github/uqbar-project/wollok).

## Repasar stub del TP

Mostrar una posible resolución del TP.
Si da, podemos mostrar el ejemplo de Tareas donde se genera un spy del router y otro del objeto httpClient.
