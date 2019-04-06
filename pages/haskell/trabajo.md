# Esquema de trabajo en el entorno Haskell

## Pruebas manuales

Tenemos la posibilidad de abrir un terminal del sistema operativo dentro de VSCode yendo al menú _Terminal -> nuevo terminal_, o bien abrir un terminal nativo del sistema. Allí podremos llamar a nuestro intérprete de Haskell (Ghci) mediante el comando

```bash
stack ghci
```

Y podemos jugar con nuestra función/es desarrolladas en el archivo `src/Library.hs`:

![](../../images/haskell/pruebas-manuales.png)

### Comandos útiles

> **IMPORTANTE:** Cuando modificamos el archivo en Visual Studio Code, para que la consola tome esos cambios debemos ingresar el comando `:r`

Otros comandos una vez que ingresaste a GHCi:

- `:q` ==> salís del intérprete Haskell
- `:h` ==> muestra la ayuda de los comandos existentes
- `:t expresión` ==> permite ver la definición de tipos de una expresión. Por ejemplo: `:t length` o `:t (1 +)`
- `:i definición` ==> permite ver la información asociada a un tipo/conjunto de tipos. Por ejemplo: `:i Int` o `:i Num`


### Colores en la consola

Si querés tener una mejor experiencia de usuario con la consola, podés probar descargarte este package (puede tardar un poco la primera vez, tratá de tener una buena conexión de Internet):

```bash
stack ghci --ghci-options "-interactive-print=Text.Pretty.Simple.pPrint" --package pretty-simple
```

![](../../images/haskell/ghciPrettyPrint.png)

## Pruebas automatizadas

Los tests están en el archivo `Spec.hs` de la carpeta `test`. Editá ese archivo y cuando esté listo se pueden correr los tests usando:

```bash
stack clean # con --full forzás a eliminar todos los archivos
stack test
```

El comando `stack clean` previo sirve a partir de la segunda vez (cuando hagas cambios a los archivos).

![](../../images/haskell/tests.png)

Aquí podemos ver de forma visual si nuestro desarrollo cumple con los requisitos esperados que fueron modelados mediante una batería de tests. Como se puede ver en la imágen anterior al estar todos los tests en verde tenemos la seguridad que la funcionalidad es correcta. En caso de tener un error nos muestra detalladamente cual es la falla:

![](../../images/haskell/fail.png)

Si querés podés correr el comando

```bash
stack test --file-watch
```

que ejecuta los tests y se queda esperando **cualquier cambio que hagas en los archivos** para volver a ejecutarlos.
