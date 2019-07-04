# Instalación y configuración del entorno Prolog

Esta página te ayudará a instalar y configurar el entorno Prolog para realizar todas las prácticas del **paradigma lógico** para los cursos del miércoles a la noche.

## Prolog Online para salir del paso

Si necesitás hacer pruebas rápidas en tu celular, o tablet, o en el trabajo donde no te dejan instalar nada, utilizalo online mediante la página [SWISH](https://swish.swi-prolog.org/). Pero para las _katas_ o bien para el _trabajo práctico_, te dejamos el entorno recomendado.

## Ejecutable Prolog

El entorno ejecutable SWI Prolog se descarga desde este link: [https://www.swi-prolog.org/download/stable](https://www.swi-prolog.org/download/stable).

> **IMPORTANTE**: que sea la versión 7.6 ó posterior para que se integre con Visual Studio Code

Si instalaste la versión 6.20, te recomendamos que

- la desinstales
- instales la nueva versión.

> Acordate que debe respetar el sistema operativo en el que estás (sea de 32 ó 64 bits)

- incorporen a la variable PATH del entorno del sistema operativo. Esto lo pueden hacer de dos maneras: en el instalador seleccionan la opción para que lo incorpore automáticamente al PATH (además de crear un ícono de escritorio)

![image](../../images/prolog/installConfiguration.png)

en algunos casos pueden aparecer Warnings como `Path too long`, entonces lo configuran manualmente: por ejemplo, el ejecutable que está en `C:\Program Files\swipl\bin`. Te dejemos [este link de muestra](https://www.computerhope.com/issues/ch000549.htm)

![image](../../images/prolog/environmentVariables.png)

El ejecutable en Prolog será

- `swipl` si estás en Windows
- `prolog` si estás en Linux/Mac

Asegurate que te lo reconozca en cualquier directorio donde te pares o vas a tener una mala experiencia con Prolog.

## Editor de texto

Existen [muchas opciones](https://wiki.haskell.org/IDEs), nosotros elegimos [Visual Studio Code](https://code.visualstudio.com/)

### Plugins adicionales

Para mejorar nuestra experiencia de Haskell con Visual Studio Code, se deben instalar los siguientes plugins:

- **VSC-Prolog**, de Arthur Wang. Te dejamos [la página que trae tutoriales para trabajar con el plugin](https://marketplace.visualstudio.com/items?itemName=arthurwang.vsc-prolog)

Si no lo instalaste previamente, recomendamos que incorpores a la lista de plugins

- **Markdown All in One**, para leer los enunciados con el formato [Markdown](https://help.github.com/articles/basic-writing-and-formatting-syntax/)
- **GitLens**, para integrar Git con Visual Studio

## Configuración adicional para Windows

Si estás en Windows probablemente el plugin no encuentre el ejecutable donde está SWI Prolog para compilarlo y mostrarte errores en el código. Si es así, cambiá la configuración donde está el ejecutable siguiendo [estos pasos](https://github.com/arthwang/vsc-prolog/issues/4), en la configuración sobreescribí el valor por defecto de "Prolog: **Executable Path**" modificándolo a este valor

```json
C:\Program Files\swipl\bin\swipl
```

o donde hayas instalado SWI Prolog (en mi caso lo instalé en C:\Program Files\swipl, eso genera una carpeta bin donde está el ejecutable `swipl.exe`). Si tu default es `C:\Program Files\pl`, fijate si no instalaste la versión 6 que no funciona con el plugin de Visual Studio Code.

![image](../../images/prolog/vsc-prolog.gif)

Si te aparece un mensaje `Cannot lint the prolog file. The Prolog executable was not found. Use the 'prolog.executablePath' setting to configure` es que el path que le definiste no es el correcto.

## Cómo trabajar en el entorno

Podés levantar Prolog por afuera del Visual Studio Code o bien abrir una terminal y escribir

```bash
swipl nombreDelArchivo.pl  // por ejemplo, Solucion03.pl
```

Esto levantará el archivo y ejecutará los tests, que también podés correr haciendo

```prolog
? run_tests.
```

Para salir de Prolog

```prolog
? halt
```

Y cuando hagas cambios en Visual Studio Code, para refrescar los tests debés correr

```prolog
? make.
```

Lo mismo podés hacerlo en la ventana Prolog, a partir de los comandos `Consult...` (abre un archivo Prolog nuevo), `Reload modified files` (es el make) o `Edit` (levanta el editor de texto de Prolog)
