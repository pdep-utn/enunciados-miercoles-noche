# Segunda clase de objetos

## Qué queremos enseñar

- repasar de la clase anterior
  - objeto
  - mensaje (interfaz, cómo lo uso) vs. método (la implementación, el código)
  - pensar en mensajes me ayuda a encapsular la complejidad de un objeto
  - cómo conozco a un objeto: referencias globales y propias de un objeto
  - referencias constantes y variables, relacionados con la inmutabilidad que veremos más adelante
  - identidad de un objeto
- polimorfismo
- entorno de Wollok
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
- objetos básicos
  - números
  - strings
  - booleanos
  - fechas
  - algo de colecciones y bloques, pero conoceremos más en las próximas clases

## El ejemplo: docentes particulares

Requerimiento: ¿cuánto me cobra para darme clases particulares de una materia, x una hora?

### Primera parte: qué te puedo cobrar

- La materia la representamos como un String
- **nico**: te cobra 50 pesos por cada letra de la materia que da.
  Ejemplos: por "historia" te cobra 8 * 50 = 400
  por "matemáticas" te cobra 11 * 50 = 550
  
- **carlono**
  cobra una cantidad variable (por ahora es 300, se ajusta por inflación)

- **camila**
  - si está de buen humor, te cobra 250 
  - si no te cobra 700
  es de humor variable

- **lucas**, es un alumno
  - tiene plata ($ 400) y tiene un profe preferido, que puede cambiar.
  - está feliz si su profe preferido le puede dar clases particulares de geografía
  - nico le cobra 450 (9 * 50), carlono le cobra 300, camila 250 ó 700.

### Segunda parte: me piace

- Sabemos las materias que estudia Lucas: [ "historia", "matematicas", "fisica" ]
- Queremos saber si un profe le cae bien un alumno
  - A Nico le cae bien los que estudian Física.
  - A Carlono le caen bien todos.
  - A Camila le caen bien los que estudian más de 3 materias.
- Ahora aparece una alumna nueva: **Melanie**, qué necesitamos que sepa contestar para incorporarla a nuestra solución.
