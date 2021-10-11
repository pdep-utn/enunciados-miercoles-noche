# El Juego de Pepita: Tutorial Wollok Game

El resultado de esta clase podés descargarla en https://github.com/wollok/JuegoPepitaMN.

## Primera parte

### El tablero

- Configuración básica
  - assets como carpeta fuente (agregar un directorio `assets` o como quieran llamarlo, botón derecho: "Ruta de construcción" > "Agregar como carpeta de fuentes", o "Build path" > "Add source folder")
  - allí ubicamos nuestro fondo preferido (pueden buscar [en esta página](https://opengameart.org/) fondos e imágenes permitidas). Nosotros nos vamos a basar en [el juego de Pepita](https://github.com/wollok/elJuegoDePepita)
  - un juego consiste en un programa que importa definiciones de wollok.game.* (no está implícito como sí pasa con las clases de wollok.lib o wollok.lang)


```wlk
import wollok.game.*

program PepitaGame {
  game.title("Pepita")
  game.height(10)
  game.width(10)
  game.boardGround("fondo2.jpg")

  game.start()
}
```

### Ezca, ezca, que pepita aparezca

Para incorporar a pepita, definimos en un archivo `pepita.wlk` o similar un objeto que tiene que entender dos mensajes: `image()` y `position()`.

- mientras que la imagen es en principio un valor fijo (tenemos un archivo `pepita.png` que tomamos de la carpeta assets)
- la posición queremos que cambie, porque refleja el lugar que ocupa en el tablero

```wlk
import wollok.game.*

object pepita {
  var property position = game.origin()
  
  method image() = "pepita.png"
}
```

Recuerden que es importante el import para que reconozca en este caso al objeto game, que tiene un método origin que devuelve una Position que refleja la posición en el tablero: (0, 0) hace que comience abajo a la izquierda.

En el programa principal vamos a decirle a game que se incorpora el personaje principal (character). Eso permite que podamos desplazarlo con las teclas:

```wlk
program PepitaGame {
  ...

  game.addVisualCharacter(pepita)
  game.showAttributes(pepita) //Debug

  game.start()
}
```

`addVisualCharacter` agrega a pepita en el tablero mientras que la configuración `showAttributes` nos va a permitir que cada vez que ubiquemos el mouse sobre pepita podamos ver su estado interno.

Ejecutamos el programa y ahora que pepita cobró vida!!!

> Cosas que pueden salir mal:
> - pepita define un método `position()` que es un getter, eso no va a permitir que se mueva y va a tirar un error al tratar de invocar al setter
> - si definís un método `posicion()` o con cualquier otro nombre, al tratar de agregar a pepita te va a tirar un error `wollok.lang.MessageNotUnderstoodException: pepita no entiende el mensaje position()`

### Si pepita hace ruido, ¿alguien la escucha?

Descargamos un archivo mp3 y vamos a hacer que pepita "salude" cuando arranque el juego. Para eso

- los sonidos se programan antes de que el juego comience
- pero no podemos ejecutarlos hasta tanto haya comenzado el juego

Para esta tarea es conveniente disponer de nuestros amigos los bloques, que modelan una porción de código para ejecutarlas en otro momento:

```wlk
program PepitaGame {
  // Antes de game.start(), conseguimos una referencia al objeto sonido de un archivo
  const saludoPepita = game.sound("pepita-start.mp3")
  // lo programamos para ejecutar 100 ms después de haber comenzado el juego
  game.schedule(100, { saludoPepita.play() })
  
  game.start()
}
```

Si necesitás que el sonido ejecute continuamente, podés invocar a `saludoPepita.shouldLoop(true)`. Como recomendación, conviene elegir sonidos de fondo que sean neutros, para no sobrecargar los sentidos al jugarlo.

> Cosas que pueden salir mal:
> - Que no programes el play: omitir la línea game.schedule(...) o hacer directamente `saludoPepita.play()` antes de que el juego haya comenzado
> - Hacer play de un sonido después de haber comenzado el juego.

### Descargamos los assets del repositorio base

El repositorio base es https://github.com/wollok/elJuegoDePepita.

### Me pareció ver un lindo gatito

Incorporamos ahora a silvestre, vamos a ubicarlo al lado de pepita inicialmente:

```wlk
object silvestre {
  method image() = "silvestre.png"
  method position() = game.at(1, 0)
}
```

Además tenemos que agregarlo en nuestro programa, antes de que comience el juego:

```wlk
program PepitaGame {
  ...
  
  game.addVisualCharacter(pepita)
  ...
  game.addVisual(silvestre)
```

Silvestre no va a ser un personaje, por lo tanto no se va a mover en base a las teclas que presionemos sino que tendrá un comportamiento que vamos a implementar a continuación.

## Vamos con los requerimientos del tutorial 1

> Objetivo del nivel: familiarizarse con el framework

### Contexto

Pepita es una golondrina que puede moverse libremente por el juego. Su objetivo es llegar al nido, es por eso que se muestra más grande al llegar a él. Para lograrlo debe evitar a Silvestre, un gato que está atento a sus pasos desde el piso.

### Requerimientos

- Hacer que Silvestre persiga a Pepita. Silvestre siempre se mueve a la altura del piso, pero va persiguiendo a Pepita hacia los lados, según donde ella se mueva.
- Hacer que Pepita se vea gris al ser atrapada por Silvestre. Esto es, que se muestre con la imagen `pepita-gris` al estar en la misma posición que Silvestre.
- **BONUS**: Silvestre no puede estar a la izquierda del eje x = 3, siendo éste el mínimo valor de x permitido para la posición de Silvestre.

### [Qué lo atrapen ya!!](https://www.youtube.com/watch?v=F_zEN4VFZ3I)

Si queremos que Silvestre persiga a pepita, pero siempre a la altura del piso, la posición será un valor calculado diferente:

- el valor para la abscisa o la _x_) corresponderá a la posición que ocupe pepita
- el valor para la ordenada o _y_ será siempre 0

```wlk
object silvestre {
  ...
  method position() = game.at(pepita.position().x(), 0)
```

Si además queremos que el valor mínimo de Silvestre para el eje x sea 3, tomaremos entonces el mayor valor entre la posición de pepita y 3 (si pepita está en la posición 2, quedará en 3 y si pepita está en la posición 4 consideraremos entonces el valor 4):

```wlk
object silvestre {
  ...
  method position() = game.at(pepita.position().x().max(3), 0)
```

Ahora vemos que pepita puede acercarse a silvestre y luego volar para arriba.

Por último, queremos dejar a pepita gris si está colisionando con silvestre. Para lograr eso, vamos a cambiar el método que calcula la imagen. Si coincide la posición con la de silvestre mostraremos la imagen gris:

```wlk
object pepita {
  ...
  method image() = if (silvestre.position() == self.position()) "pepita-gris.png" else "pepita.png"
```

### Un pequeño refactor

Una buena práctica es no referenciar directamente a los singletons o wko, sino utilizar variables. Hacemos ese pequeño cambio:

```wlk
import wollok.game.*

object pepita {
  var property enemigo = silvestre
  var property position = game.origin()

  method image() = if (enemigo.position() == self.position()) "pepita-gris.png" else "pepita.png"

}

object silvestre {
  var property personajePrincipal = pepita

  method image() = "silvestre.png"
  method position() = game.at(personajePrincipal.position().x().max(3), 0)
}
```

### Se puede testear

Si bien el juego es algo que se suele testear visualmente, podemos construir tests para probar el comportamiento en la colisión:

```wlk
import pepita.*
import wollok.game.*

test "si pepita no es alcanzada por silvestre se ve normal" {
  pepita.position(game.at(1, 0))
  assert.equals("pepita.png", pepita.image())  
}

test "si pepita colisiona con silvestre eso afecta cómo se ve" {
  pepita.position(game.at(3, 0)) // caso borde
  assert.equals("pepita-gris.png", pepita.image())  
}
```

Hay algunas cosas discutibles, como lo frágil que puede ser cambiar el archivo con el que visualizamos a pepita al colisionar con silvestre y que se rompa el test, pero al menos podemos contar con tests que validan nuestro juego.

## Tutorial 2

> Objetivo del nivel: acciones con las teclas

### Contexto

Ahora necesitamos que pepita gaste energía cada vez que se mueve, es por eso que en este nivel necesitamos tener mayor control sobre qué hacer cuando se presionen determinadas teclas. Ya están configuradas las teclas de movimiento izquierda y derecha para que Pepita se mueva y pierda la energía correspondiente por volar dicha distancia.

Como Pepita pierde energía al moverse, vamos a necesitar que pueda comer las comidas para evitar que se quede sin energía...


### Requerimientos

- Pepita comienza con energía = 100.
- Configurar las teclas arriba, abajo, izquierda y derecha para que mueva a Pepita a las respectivas posiciones. Pepita debe gastar energía al volar dicha distancia, considerar la distancia recorrida, y asumir que gasta 9 joules de energía por cada kilómetro volado.
- Hacer que Pepita se vea gris al quedarse sin energía. Además, no debería poder moverse una vez que se quedó sin energía.
- Configurar la C para que Pepita coma la comida sobre la que está parada. Al comer una comida, pepita aumenta su energía correspondiente a la otorgada por la comida y ésta última desaparece del juego.
> Para obtener el objeto con el que pepita se encuentra colisionando usar el mensaje `game.uniqueCollider(pepita)`.
- **BONUS**: 
  - Antes de mover a pepita, controlar que no se vaya del rango visible del juego.
  - Luego de moverse, si se queda sin energía, terminar el juego.
  - Utilizar el evento `onTick` para agregar gravedad, haciendo que pepita pierda altura cada `800` milisegundos, es decir, descienda su coordenada `y` en 1, pero _sin perder energía_.

import wollok.game.*
import pepita.*

object tutorial2 {

  method configurar() {
    game.addVisual(pepita)
    game.showAttributes(pepita) // Debug
    game.addVisual(silvestre)
  }

}
### Nueva configuración del juego

Vamos a parametrizar el juego en niveles, entonces en nuestro programa haremos:

```wlk
import pepita.*
import wollok.game.*
import niveles.*

program PepitaGame {
  game.title("Pepita")
  game.height(10)
  game.width(10)
  game.boardGround("fondo2.jpg")
  
  tutorial2.configurar()
    
  const saludoPepita = game.sound("pepita-start.mp3")
  game.schedule(100, { saludoPepita.play() })
  
  game.start()
}
```

En el archivo niveles vamos a ubicar nuestro objeto tutorial2, que configurará a pepita, silvestre, etc.:

```wlk
import wollok.game.*
import pepita.*

object tutorial2 {

  method configurar() {
    // Deja de ser personaje porque lo vamos a manejar manualmente
    game.addVisual(pepita) 
    // *************************************************************** 
    game.showAttributes(pepita) // Debug
    game.addVisual(silvestre)
    teclado.configurar() // ver siguiente explicación
  }

}
```

### Manejo de las teclas

Vamos a configurar manualmente el movimiento de pepita, para lo cual cambiamos el `addVisualCharacter` para quedarnos con el `addVisual` a secas, y luego tenemos que decirle qué hacer cada vez que el usuario presione las flechas del cursor. Esto requiere una vez más de la configuración de objetos bloque:

```wlk
object teclado {
  method configurar() {
    keyboard.left().onPressDo { pepita.irA(pepita.position().left(1))}
    keyboard.right().onPressDo { pepita.irA(pepita.position().right(1))}
    keyboard.up().onPressDo { pepita.irA(pepita.position().up(1))}
    keyboard.down().onPressDo { pepita.irA(pepita.position().down(1))}
  }
}
```

Si pepita va a un cierto lugar, 

- calculamos la distancia de la anterior a la actual, enviando el mensaje `distance` a position
- y evaluamos la energía gastada en base a dicha distancia asumida en kilómetros

En pepita

```wlk
object pepita {
  ...
  var property energia = 100

  method volar(kms) {
    energia = energia - (kms * 9)
  }
  method irA(nuevaPosicion) {
    self.volar(nuevaPosicion.distance(position))
    position = nuevaPosicion
  }
```

Al probar nuestro juego, vemos que el debug de atributos es interesante para saber que la energía se está consumiendo:

![atributos de pepita](./atributsPepita.png)

### Pepita sin energía

Tenemos que hacer dos cambios

- no permitir movimientos si pepita se queda sin energía
- que se vea gris

Agregamos métodos de negocio: teAtraparon() y estaCansada() y los usamos para modificar a pepita:

```wlk
object pepita {
  method image() = if (self.estaCansada() || self.teAtraparon()) "pepita-gris.png" else "pepita.png"
  method volar(kms) {
    energia = energia - (kms * 9)
  }
  method irA(nuevaPosicion) {
    if (!self.estaCansada()) {
      self.volar(nuevaPosicion.distance(position))
      position = nuevaPosicion
    }
  }
  method estaCansada() = energia <= 0
  method teAtraparon() = enemigo.position() == self.position()
```

Ahora cuando se queda sin energía vemos que se visualiza gris y ya no puede moverse.

Podemos agregar aquí mismo el BONUS para que se termine el juego cuando pepita se quede sin energía:

```wlk
object pepita {
  ...
  method irA(nuevaPosicion) {
    if (!self.estaCansada()) {
      self.volar(nuevaPosicion.distance(position))
      position = nuevaPosicion
    }
    self.chequearEstadoJuego()
  }
  method chequearEstadoJuego() {
    if (self.estaCansada()) {
      game.sound("perdiste.wav").play()
      game.schedule(3000, { game.stop() })
    }
  }
```

El chequeo del estado del juego lo hacemos cada vez que nos movemos.

### Nido

Un detalle que hasta ahora pasamos por alto es el nido, que será nuestro destino feliz:

```wlk
object nido {
  method image() = "nido.png"
  method position() = game.center() // game.at(game.width(), game.height())
}
```

Vamos a hacer un poco de trampa, poniendo al nido en el medio del tablero. Para poder terminar el juego vamos a activar un **collider** sobre el nido:

```wlk
object tutorial2 {

  method configurar() {
    ...
    game.addVisual(nido)
    ...
    colisiones.configurar()
```

El singleton / wko colisiones configura lo que ocurre cuando algún objeto choca con el nido:

```wlk
object colisiones {
  method configurar() {
    game.onCollideDo(nido, { otroObjeto =>
      game.sound("ganaste.mp3").play()
      game.schedule(15000, { game.stop() }) // o el tiempo que quieras
    })
  }
}
```

¿No es raro ésto? Bueno, sí. Lo que podríamos hacer en todo caso es enviar un mensaje al otro objeto avisando que "encontrasteAlNido"

- pepita tendría el comportamiento que vemos arriba: el juego terminó y ganaste
- los otros objetos no harían nada

Agregar primero al nido, luego a silvestre y por último a pepita permite que uno tenga prevalencia sobre otro y se vea la figura de pepita encima del nido y no atrás.

> Como BONUS: deberíamos inhabilitar los movimientos una vez que el juego terminó.

Un dato importante es que aquí **usamos onCollideDo en lugar del whenCollideDo, porque queremos que ejecute una sola vez y no mientras pepita esté en el nido**. De lo contrario vas a ver que se activa múltiples veces el sonido y se va a escuchar en loop solo el comienzo.


