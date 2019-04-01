# Integración continua con CircleCI

Para terminar la kata, activaremos la [integración continua](https://martinfowler.com/articles/continuousIntegration.html). Esto permite que con cada cambio que hagamos, se compile el proyecto y se ejecuten los tests en un entorno aislado, lo que garantizará detectar el primer cambio en el código que genere un error en nuestro proyecto. En el contexto de una kata puede no parecer tan útil, cuando haya más de una persona trabajando en un ejercicio que tarde más de 2 horas será importante.

Ingresamos al sitio web **Circle-CI**: https://circleci.com/dashboard

![](../videos/circleCIstartBuild2.gif)

Arriba a la izquierda, debemos cambiar el repositorio a navegar para que apunte a `pdep-utn`. Luego agregaremos nuestro nuevo proyecto, mediante la opcion `Add Projects`, que nos permite buscar por ejemplo `kata00`. Presionamos el botón `Set Up Project`, salteamos los primeros 4 pasos que ya lo hemos hecho por vos y solamente debemos presionar el botón `Start bulding`. Esto nos llevará a la ventana de Jobs donde CircleCI

- clonará el repositorio tuyo
- lo compilará utilizando `stack`
- ejecutará los tests
- y generará el nuevo status de tu proyecto
- en caso de error, te mandará un mail avisándote que el build falló

> Vos no tenés que hacer nada más que activar el build de tu proyecto. El resto lo hace solito CircleCI, que es un servidor de **Continuous Integration**

## Agregando el Badge al README

El _badge_ es un indicador visual de cómo resultó el último build, que ubicaremos en el archivo README para rápidamente darnos cuenta de si anduvo todo bien. Para eso, ingresamos a CircleCI, elegimos nuestro repositorio, a la derecha tenemos el link a `Settings` (Configuración), luego seleccionamos `Status Badge` y debemos generar un Token de seguridad para nuestro repositorio privado. Elegimos una etiqueta o _label_ para identificar ese token posteriormente, y volvemos al menú `Status Badge`. Entonces en el combo elegimos el token que acabamos de crear, y abajo de todo tendremos un cuadro de texto con el formato markdown para copiar.

![](../videos/circleCIstatusBadge.gif)

Vamos al editor Visual Studio Code y pegamos el texto. Si lo deseás, podés modificar la opción `style=svg` por `style=shield`, que tiene un aspecto más _cool_ (o cheto). El plugin "Markdown all in one" te permite visualizar el README (con `Ctrl + Shift + V` o bien se puede customizar las teclas).

![](../videos/circleCIBadgeInReadme.gif)

Por último, tendrás que subir esos cambios al repositorio remoto, una vez más hacemos:

```bash
git add .
git commit -m "Agregamos badge"
git push
```

Acordate que tenés [este apunte](https://docs.google.com/document/d/1ozqfYCwt-37stynmgAd5wJlNOFKWYQeIZoeqXpAEs0I/edit) para guiarte con el proceso de git y [este ayudamemoria](https://docs.google.com/document/d/147cqUY86wWVoJ86Ce0NoX1R78CwoCOGZtF7RugUvzFg/edit#).
