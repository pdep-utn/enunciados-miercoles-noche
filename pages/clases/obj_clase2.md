# Segunda clase de objetos

## Qué queremos enseñar

- Conceptos
  - objeto
  - mensaje (interfaz, cómo lo uso) vs. método (la implementación, el código)
  - pensar en mensajes me ayuda a encapsular la complejidad de un objeto
  - cómo conozco a un objeto: referencias globales y propias de un objeto
  - referencias constantes y variables, relacionados con la inmutabilidad que veremos más adelante
  - identidad de un objeto
  - polimorfismo
- Entorno de Wollok
  - cómo creo un proyecto
  - cómo creo un archivo Wollok con un objeto
  - codificación: highlighter, formatter
  - cómo buscar un objeto de Wollok: Ctrl + Shift + F3
  - autocompletado
  - wollokdoc
  - cómo lo pruebo: consola REPL (dejamos los programas para otro momento, quizás los tests si se da la ocasión)
  - se abre con un diagrama dinámico integrado
  - validadores
  - quick fixes
- Objetos básicos
  - números
  - strings
  - booleanos
  - fechas
  - algo de colecciones y bloques, pero conoceremos más en las próximas clases

## El ejemplo: docentes particulares

Requerimiento: ¿cuánto me cobra por hora _X_ para darme clases particulares de una materia?

### Primera parte: qué te puedo cobrar

- La materia la representamos como un String

## Implementando a Nico, el primer docente

- **nico**: te cobra 50 pesos por cada letra de la materia que da.
  Ejemplos: por "historia" te cobra 8 * 50 = 400
  por "matemáticas" te cobra 11 * 50 = 550

Resumen:

- es un objeto, es una de las abstracciones posibles en Wollok
- un objeto tiene estado y comportamiento, a diferencia de lo que pasaba en los paradigmas anteriores, donde datos y código iban por carriles separados
- pensar primero en cómo uso un objeto me permite esperar para implementarlo, aunque sean 5 minutos nomás
- en el envío de un mensaje siempre hay un objeto receptor, no tenemos funciones aisladas
- el tipo no se chequea, pero existe, qué pasa si digo `nico.cuantoCobraPor(9)`
- cada vez que se envía un mensaje hay un _method lookup_, por ahora es básico
- Nico vive como objeto global, si levanto el REPL está "ahí"
- La consola REPL muestra el estado de mis objetos, algo que no pasaba ni en Prolog ni en Haskell, por qué es ésto? por qué lo necesitamos? No tenemos una respuesta, puede que el modelo de objetos sea más complejo...
- Preguntas que te dejamos: te pareció difícil, fácil o meh la implementación de cuánto cobra Nico? No pareciera haber tanto gap respecto a otros paradigmas en cuanto al código que escribimos, pero participan varios conceptos propios del paradigma, al igual que lo que pasa en el Paradigma Lógico
  
## Implementando a Carlono, otro docente

- **carlono**
  cobra una cantidad variable (por ahora es 300, se ajusta por inflación)

Resumen:

- Carlono necesita definir estado, mientras que Nico no
- **En general, no queremos definir variables para lo que se pueda calcular**
- Pero acá sí queremos: consultar o asignar lo que cobra Carlono
- Con los atributos está la primera discusión de diseño: qué debe ser público? Conocer el valor (getter) / Actualizar la referencia (setter)
- Las propiedades como mecanismo para resolver lo burocrático
- Encapsulamiento no tiene nada que ver con tener getters y setters. Solo es una indirección más. En este caso está bien conocer y definir cuánto gana Carlono.
- Vemos en el REPL cómo se modifica ese valor

## Implementando a Camila, el último docente

- **camila**
  - si está de buen humor, te cobra 250 
  - si no, te cobra 700

  es de humor variable

Resumen:

- Camila también tiene estado
- Podemos ofrecer la propiedad como "setter", pero "enojarse" y "alegrarse" son métodos de más alto nivel que puede ofrecer "el negocio"
- Eso evita cargarle la responsabilidad a quien llama (el "usuario")
- Lo que sabe responderme un objeto: define su interfaz

## Implementando el primer alumno

- **lucas**, es un alumno
  - tiene plata ($ 400) y tiene un profe preferido, que puede cambiar.
  - está feliz si su profe preferido le puede dar clases particulares de geografía
  - nico le cobra 450 (9 * 50), carlono le cobra 300, camila 250 ó 700.

Resumen:
- el profe preferido nos hace ver, con el type system activado, que puede ser nico | carlono | camila
- este tipado se llama **estructural**: no necesitamos definir un nombre específico (en ese caso el tipado sería **nominal**)
- nico o carlono o camila es un union type (dibujamos el conjunto de los tipos que soportan profePreferido)
- el Type System todavía está verde (solo para profes), pero la idea de Wollok es que el chequeo de tipos se haga a partir de su type system
- por qué Nico o Carlono o Camila? Lo importante es **dónde uso ese profePreferido**...
- ...que es en el método

```wollok
method estaFeliz() = profePreferido.cuantoCobra("geografía") <= plata
```

- acá vemos que la interfaz `cuantoCobra(materia)` es compartida por los 3 docentes, entonces son **polimórficos** en ese contexto
- la ventaja se la lleva Lucas. No tiene que preguntar qué tipo de profesor es, le delega el cálculo a cada uno

### Segunda parte: me piace

- Sabemos las materias que estudia Lucas: "historia", "matematicas" y "fisica"
- Queremos saber si un profe le cae bien un alumno
  - A Nico le cae bien los que estudian Física.
  - A Carlono le caen bien todos.
  - A Camila le caen bien los que estudian más de 3 materias.

Una vez más aparece el polimorfismo en los profesores: bah, lo ideal es definir una interfaz común.

- Ahora aparece una alumna nueva: **Melanie**, qué necesitamos que sepa contestar para incorporarla a nuestra solución.

La respuesta, una vez más es polimorfismo: implementar tanto `estaFeliz()` , `estudia(materia)`, `cantidadDeMateriasQueEstudia()` o `materiasQueEstudia()`. Cómo lo resuelve es problema de cada alumno.

