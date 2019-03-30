# Instalación y configuración del entorno Haskell

Esta página te ayudará a instalar y configurar el entorno Haskell para realizar todas las prácticas del **paradigma funcional** para los cursos del miércoles a la noche.

Seguir estas instrucciones no es obligatorio para hacer las _katas_ o el trabajo práctico, no obstante tené en cuenta que no vamos a dar soporte de otras tecnologías (son muchas y se vuelve muy difícil lograr que funcionen para todas las máquinas y sistemas operativos). Si tu intención es arreglarte con un _notepad_ asegurate que pase todos los controles necesarios que pide cada enunciado (más adelante los irás conociendo).

> **Nota importante:** respetá el orden de instalación de las cosas, porque algunos componentes necesitan que otros estén previamente instalados.

## Stack

**Stack** es un conjunto de herramientas que facilita enormemente el desarrollo comercial y académico en Haskell. Se instala siguiendo [estos pasos](https://docs.haskellstack.org/en/stable/README/#how-to-install): elegí el que corresponda para tu sistema operativo.

> Con la instalación de Stack **no es necesario instalar el compilador de Haskell**, de hecho desaconsejamos su instalación.

## Intero

Una vez que instalaste Stack, vas a poder descargarte **Intero**, que te permite habilitar el uso interactivo de Haskell para detectar errores y conocer información del programa que estás escribiendo (como los tipos de cada expresión). Para descargar Intero, te recomendamos descargarte [este ejemplo](https://github.com/pdep-utn/mn-funcional-kata00/archive/master.zip). Descomprimilo en cualquier directorio donde tengas permisos para tu usuario logueado, y ejecutá el siguiente comando en la terminal o línea de comando:

```bash
stack build intero
stack test
```

## Editor de texto

Existen [muchas opciones](https://wiki.haskell.org/IDEs), nosotros elegimos [Visual Studio Code](https://code.visualstudio.com/)

### Plugins adicionales

Para mejorar nuestra experiencia de Haskell con Visual Studio Code, **es obligatorio** instalar los siguientes plugins:

- **Haskero**
- **Markdown All in One**, para leer los enunciados con el formato [Markdown](https://help.github.com/articles/basic-writing-and-formatting-syntax/)

Y **opcional**, podés agregarle el siguiente plugin

- **GitLens**, para integrar Git con Visual Studio

Si querés ver cómo se instalan los plugins en Visual Studio Code, podés ver este video que muestra cómo se instala Haskero

![](../../videos/vscHaskell.gif)

## Entorno completo

Si todo quedó correctamente instalado, vas a tener un entorno integrado con el código que vayas escribiendo, como te muestra este video

![](../../videos/vscLinterHaskell.gif)

Si tenés algún error, te recomendamos visitar la página [troubleshooting para ayudarte a resolver errores posibles en la instalación de Haskell](./troubleshooting.md)

## Git

Luego necesitarás instalar Git para descargar o subir tu código al hacer las prácticas (y también te servirá para trabajar en conjunto). Te dejamos el [link para descargar Git](https://git-scm.com/downloads) (elegí el que corresponda a tu sistema operativo)
