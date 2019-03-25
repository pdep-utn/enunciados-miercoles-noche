# Guía de resolución de una Kata / TP

> El presente instructivo sirve como descripción del proceso general de una kata o bien del Trabajo práctico integrador

## Entrar al link de github classroom

En primer lugar tenemos que acceder al link del _assignment_ en GitHub para la kata en cuestión que nos provee el docente. Para ello tenemos que encontrarnos logueados en el sitio. Entonces, presionamos el botón _"Accept this assignment"_:

![](../images/guia-katas/00-accepting.png)

Nos aparecerá una pantalla de creación de un repositorio sobre el cual vamos a trabajar.

![](../images/guia-katas/01.creando.png)

Una vez que termine el proceso nos va a brindar un link del repositorio que nos pertenece para resolver la Kata: el segundo link que dice "Your assignment has been created here".

![](../images/guia-katas/02.creado.png)

## Clonar el repositorio

Ya tenemos nuestro repositorio remoto con una serie de archivos y carpetas generadas que nos da la estructura de un proyecto Stack. A la derecha de nuestra pantalla tenemos un botón verde que dice **Clone or download**. Al presionarlo nos levanta un pequeño popup con un link a una pagina de GitHub finalizada en _.git_

![](../images/guia-katas/03.repositorio.png)

copiamos ese vínculo y procedemos desde un [terminal o GitBash](https://git-scm.com/downloads) a clonar el repositorio mediante el comando **git clone** seguido de la URL copiada. Por ejemplo

```bash
git clone https://github.com/pdep-utn/kata-0-primera-funcion-Juancete.git
```

![](../images/guia-katas/04.clonado.png)

## Editar en Visual Studio Code

Para poder editar el código necesitamos tener instalado el [entorno de Haskell](./entorno-haskell.md). Antes que nada, haremos un build del proyecto en la consola Git Bash o la de Linux:

```bash
cd nombre-de-tu-proyecto
stack build intero
```

Ahora sí abrimos el Visual Studio Code (VSCode), desde la línea de comandos es

```bash
code .
```

O bien buscás el acceso al ejecutable y abrís la carpeta (Archivo > Abrir carpeta... o el shortcut _ctrl + k + o_)

## Actualización del README.md

Un detalle muy importante es que deben escribir en el archivo `README.md` del directorio raíz quiénes son los integrantes del grupo que está resolviendo la kata. El formato de ese archivo es markdown, por eso te dejamos una [guía rápida](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) aunque es muy fácil acostumbrarse, solo tenés que escribir algo como

```
# Kata xxxxxxxx
...

## Integrantes

- Juan Contardo (Juancete)
- Fernando Dodino (fdodino)

## Objetivos
...
```

- Debemos publicar los nombres de los integrantes y el mail/usuario de github, anteponiendo los guiones para generar las viñetas. Para pre-visualizar el README, tenés que haber instalado previamente el plugin "Markdown all in one". Entonces aparecerá la opción "Abrir vista previa en el panel lateral" o bien las teclas `Ctrl + K + V`

![](../images/guia-katas/previsualizarMd.png)

## Trabajo de la kata propiamente dicha

Seleccionamos la carpeta donde clonamos nuestro repositorio. Ahora tenemos que trabajar en el archivo **Library.hs** de la capeta **src**

![](../images/guia-katas/05.editor.png)

## Probar manualmente el ejemplo

Tenemos la posibilidad de abrir un terminal del sistema operativo dentro de VSCode yendo a al menú _Terminal -> nuevo terminal_, o bien abrir un terminal nativo del sistema. Allí podremos llamar a nuestro intérprete de Haskell (Ghci) mediante el comando

```bash
stack ghci
```

Y podemos jugar con nuestra función/es desarrolladas

![](../images/guia-katas/06.pruebas.png)

Para poder salir del intérprete Haskell solamente es necesario ingresar el comando **:q**

## Pruebas automatizadas

Para correr los tests automatizados es necesario correr desde el terminal el siguiente comando:

```bash
stack test
```

![](../images/guia-katas/07.tests.png)

Aquí podemos ver de forma visual si nuestro desarrollo cumple con los requisitos esperados que fueron modelados mediante una batería de tests. Como se puede ver en la imágen anterior al estar todos los tests en verde tenemos la seguridad que la funcionalidad es correcta. En caso de tener un error nos muestra detalladamente cual es la falla:

![](../images/guia-katas/08.fail.png)

## Subir la Kata resuelta

Una vez finalizada la resolución de la Kata y si pasaron todos los tests correctamente, procedemos mediante el siguientes comandos:

* subir al repositorio local

```bash 
git add .
git commit -m "Kata xx resuelta"
```

* Subir al repositorio remoto

```
git push origin master
```  

## Continuous integration

Para terminar la kata, activaremos la [integración continua](https://martinfowler.com/articles/continuousIntegration.html). Esto permite que con cada cambio que hagamos, se compile el proyecto y se ejecuten los tests en un entorno aislado, lo que garantizará detectar el primer cambio en el código que genere un error en nuestro proyecto. En el contexto de una kata puede no parecer tan útil, cuando haya más de una persona trabajando en un ejercicio que tarde más de 2 horas será importante.

Ingresamos al sitio web **Circle-CI**: https://circleci.com/dashboard

![](../videos/circleCIstartBuild.gif)

Arriba a la izquierda, debemos cambiar el repositorio a navegar para que apunte a `pdep-utn`. Luego agregaremos nuestro nuevo proyecto, mediante la opcion `Add Projects`, que nos permite buscar por ejemplo `kata00`. Presionamos el botón `Set Up Project`, salteamos los primeros 4 pasos que ya lo hemos hecho por vos y solamente debemos presionar el botón `Start bulding`. Esto nos llevará a la ventana de Jobs donde

- clonarán el repositorio tuyo
- lo compilarán utilizando `stack`
- ejecutarán los tests
- y generará el nuevo status de tu proyecto
- en caso de error, te mandará un mail avisándote que el build falló

Luego tus tutores subirán un issue en tu repositorio con la corrección.