
# Nuevo proyecto desde cero en Haskell

Para comenzar a trabajar en Haskell, vamos a utilizar una biblioteca llamada `pdepreludat` que es un juego de palabras entre

- PDP, el nombre de la materia
- `prelude` que es la biblioteca de funciones inicial de Haskell
- y [Ludat](https://github.com/ludat) o Lucas Damián Traverso, que es un amigo de la casa

El objetivo de la biblioteca es que tengas una experiencia más amistosa con algunos errores recurrentes que en anteriores cursadas generaban un dolor de cabeza a alumnos y docentes. Si querés investigar más te dejamos [el link a la página del proyecto](https://github.com/10Pines/pdepreludat/blob/master/README.md), pero no es necesario que hagas nada con él. Solo seguir las instrucciones que vienen a continuación.

## Ahora sí, comenzamos desde cero

En la terminal de Visual Studio Code, o bien en cualquier terminal Linux o Git Bash, podés correr el siguiente comando que va a crear una carpeta llamada `primer-proyecto` (o el nombre que ustedes quieran).

```bash
stack new primer-proyecto https://raw.githubusercontent.com/10Pines/pdepreludat/master/pdepreludat.hsfiles
```

Cualquier error, podés consultar la página de [troubleshooting](./troubleshooting.md).

## Build del proyecto

Una vez creada la carpeta, hay que descargar las dependencias del proyecto, de la siguiente manera:

```bash
cd primer-proyecto
stack build
```

A partir de aquí podés trabajar en Visual Studio Code. Recordá que podés abrirlo desde la consola Linux o Git Bash:

```
code .
```

## Editar funciones

El comando toma una plantilla y genera un proyecto Haskell con ciertas dependencias, para definir funciones, solamente necesitás editar el archivo `Library.hs` en la carpeta `src`.

## Prueba manual

Para hacer pruebas manuales, podés correr el intérprete, ejecutando:

```bash
stack ghci
```

### Tests

Los tests están en el archivo `Spec.hs` de la carpeta `test`. Editá ese archivo y cuando esté listo se pueden correr los tests usando:

```bash
stack clean
stack test
```
