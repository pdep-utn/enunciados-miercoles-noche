# Instalación y configuración del entorno Haskell

Esta página te ayudará a instalar y configurar el entorno Haskell para realizar todas las prácticas del **paradigma funcional** para los cursos del miércoles a la noche, necesario para hacer las _katas_ o el trabajo práctico. 

> **Nota importante:** respetá el orden de instalación de las cosas, porque algunos componentes necesitan que otros estén previamente instalados.

## Git

Primero que nada necesitarás instalar Git para versionar y subir tu código al hacer las prácticas (también te servirá para trabajar en conjunto). Te dejamos el [link para descargar Git](https://git-scm.com/downloads) (elegí el que corresponda a tu sistema operativo).

### Git en Windows

Si estás en Windows, necesitás descargar [Git Bash](https://gitforwindows.org/). **Cada vez que requieras hacer algo por línea de comando, tenés que usar Git Bash y no Power Shell/CMD**. En la solapa Terminal de Visual Studio Code teneś que cambiar la configuración de tu shell para usar Git Bash:

![select default shell](../../images/haskell/selectDefaultShell.png)

Luego en la lista de opciones, seleccioná Git Bash:

![Git Bash as select default shell](../../images/haskell/selectDefaultShell2.png)

Podés ver [este excelente video-tutorial de Franco Esposta](https://www.youtube.com/watch?v=rRKe7l-ZNvM) al respecto.

## Stack

**Stack** es un conjunto de herramientas que facilita enormemente el desarrollo comercial y académico en Haskell. Se instala siguiendo [estos pasos](https://docs.haskellstack.org/en/stable/README/#how-to-install): elegí el que corresponda para tu sistema operativo.



> Con la instalación de Stack **no es necesario instalar el compilador de Haskell**, de hecho desaconsejamos su instalación.

## Editor de texto

Existen [muchas opciones](https://wiki.haskell.org/IDEs), nosotros te recomendamos [Visual Studio Code](https://code.visualstudio.com/)

### Plugins necesarios

Para mejorar nuestra experiencia de Haskell con Visual Studio Code, se deben instalar los siguientes plugins:

- **Simple GHC (Haskell) Integration**, de dramforever
- **Haskutil**, de Eduard Sergeev, que te puede ayudar con los imports de funciones externas.
- **Haskell Syntax Highlighting**, de Justus Adam
- **Markdown All in One**, para leer los enunciados con el formato [Markdown](https://help.github.com/articles/basic-writing-and-formatting-syntax/)
- **GitLens**, para integrar Git con Visual Studio
- Y dadas las características de la cursada para 2021, recomendamos ampliamente instalar el extension **Live Share** (ms-vsliveshare.vsliveshare), con el que pueden no solo compartir sino también interactuar con sus compañer@s y tutores (todos pueden escribir en el mismo espacio de trabajo).

Si querés ver cómo se instalan los plugins en Visual Studio Code, podés ver este video que muestra cómo se instala el plugin principal de Haskell

![VSC Extensions for Haskell](../../videos/haskell/vscPluginHaskell.gif)

Al final de la instalación, podés ver las extensiones de Haskell instaladas buscando en la solapa Extensions:

```bash
@installed Haskell
```

o simplemente `@installed` para verificar que seguiste los mismos pasos con los demás plugins.

### Plugins opcionales

- **hoogle-vscode** (jcanero.hoogle-vscode): podés buscar funciones estándar de Haskell

Si te gustó el font que dibuja la igualdad y las flechas con signos más bonitos, te recomendamos que instales el font [Fira Code](https://github.com/tonsky/FiraCode) (seguí las instrucciones del repositorio).

Y un detalle más: podés descargarte temas para Visual Studio Code que modifiquen los colores con los que se marcan las variables, los nombres de las funciones, los números, los strings, etc. En la solapa Extensions podés buscar `Themes` y te aparecerá una larga lista para que elijas la que más te gusta.

## Entorno completo

Si todo quedó correctamente instalado, vas a tener un entorno integrado con el código que vayas escribiendo, como te muestra este video

![Linter for Haskell](../../videos/haskell/vscLinterForHaskell.gif)

Desplegando el menú `View > Problems (Ctrl + Shift + M)` tenés acceso a todos los errores y advertencias que tiene tu archivo `.hs`. Al hacer click sobre un problema te lleva directamente a la línea que origina el inconveniente.

Si tenés algún error, te recomendamos visitar la página [troubleshooting para ayudarte a resolver errores posibles en la instalación de Haskell](./troubleshooting.md)

> Es super importante que puedas contar con un entorno integrado, y que no tengas que escribir el código "a ciegas" para luego compilarlo en una especie de big bang que te fuerce a mirar todos los errores de una. No es una experiencia de usuario recomendable, sobre todo en Haskell...

## Video introductorio

Te dejamos un [tutorial que explica cómo se trabaja en Haskell con el Visual Studio Code](https://www.youtube.com/watch?v=xLsg-xk3tlg&feature=youtu.be)
