---
layout: index


prev: Intro_concepto_y_soporte_fisico
next: PaaS
---

Desarrollo basado en pruebas
=========================

<!--@
prev: Intro_concepto_y_soporte_fisico
next: PaaS
-->

<div class="objetivos" markdown="1">

## Objetivos

### Cubre los siguientes objetivos de la asignatura

* Conocer los conceptos relacionados con el proceso de virtualización tanto de software como de hardware y ponerlos en práctica.

### Objetivos específicos

* Entender el concepto de <i>DevOps</i>.
* Usar herramientas para gestión de los ciclos de desarrollo de una aplicación y entender cuales son estos.
* Aprender a usar integración continua en cualquier aplicación.

</div>

## Introducción

Los ciclos de desarrollo de software actuales son ágiles y rápidos, de
forma que continuamente se están arreglando errores que se hayan
observado en producción, programando nuevas características y
desplegándolas en producción. Para que esto sea posible todo este
ciclo de vida del software debe estar automatizado en todo lo posible,
para que todas las fases se hagan esencialmente sin intervención
humana y se minimice la posibilidad de que haya en el proceso fallos
costosos de arreglar una vez echado a andar un sistema; también en ese
sentido, las aplicaciones de hoy en día ya no son monolíticas, de
forma que sea fácil rearrancar o escalar una parte de la misma sin
afectar al resto y, sobre todo, que no haya un tiempo en el que no
esté disponible. La aparición de la
[nube](https://es.wikipedia.org/wiki/Computaci%C3%B3n_en_la_nube) ha
hecho que en varias, o en todas, las partes del proceso, aparezcan
recursos *elásticos* y disponibles bajo demanda, algunos de ellos
gratuitos.

Para asegurar despliegues con éxito es esencial que se pruebe, antes
de que se comiencen a desplegar, que no hay ningún error y que el
software corresponde a los requisitos que se le habían planteado, sea
como historias de usuario o sea usando cualquier otra metodología de
especificación. 

Por eso, en esta parte del curso, veremos cómo desarrollar según la
metodología basada en pruebas con los
entornos de computación en nube y cómo configurarlos y usarlos para
hacer más rápido y eficiente el trabajo de un equipo de desarrollo,
test y sistemas. En otros capítulos se han descrito las diferentes fases
del ciclo de vida de una aplicación en la nube; en este capítulo veremos
como se llevan a cabo la mayoría de ellas. En siguientes capítulos se verá la
gestión de configuraciones, provisionamiento de los servidores,
despliegue continuo y virtualización. 

## Desarrollo basado en pruebas

El desarrollo basado en pruebas es una metodología que se integra con
el desarrollo en la nube que hemos venido viendo de forma inconsútil
(en inglés esto queda mejor; *seamless*). Hace falta pasar las pruebas
para hacer el despliegue, pero también para integrar código, por eso
el flujo de trabajo integra automáticamente las pruebas como paso
previo a la incorporación del código, que si es a la rama `master`
implicaría automáticamente el despliegue o pase a producción. Las
pruebas son a diferente nivel, pero las que vamos a usar, pruebas
unitarias, consisten en llamar a una función con diferentes valores y
comprobar los resultados esperados con los obtenidos. Los resultados
pueden ser de todo tipo: desde simples escalares respuesta a una
función hasta cambio en el DOM ([*Document Object Model*](https://en.wikipedia.org/wiki/Document_Object_Model)) de una página cuando se envía un JSON
desde una web. Cada uno tiene sus estrategias, pero al final se trata
de crear una serie de pruebas para que lo que nosotros queremos que
haga la aplicación efectivamente lo haga.

El desarrollo basado en pruebas consiste en escribir los tests antes
que el código que hace que esos tests *no* fallen. No siempre se hace
así, claro, pero el trabajar así permite tener claro qué
funcionalidades queremos, cómo queremos que respondan y qué
*contratos* o *aserciones* van a ser verdaderas cuando se ejecute el
código antes siquiera de escribirlo; una aserción es simplemente una
afirmación sobre los valores que devuelve una función para una entrada
determinada.

Las pruebas deben de corresponder a las especificaciones que queremos
que respete nuestro software, y como tales deben de ser previas a la
escritura del código en sí y del test. Es esencial entender
perfectamente qué queremos que nuestro software haga, y hay diferentes
formas de hacerlo, pero generalmente, en metodologías ágiles, tenemos
que hacerlo mediante [*historias de
usuario*](https://es.wikipedia.org/wiki/Historias_de_usuario),
narrativas de qué es lo que puede hacer un posible usuario y qué es lo
que el usuario debería esperar. Estas historias de usuario se
convertirán en *issues* del repositorio, cuyo cierre marcará que el
código está escrito, testeado, y se ajusta a la misma. 

En la mayoría de los entornos de programación y especialmente en `node`,
que es en el que nos estamos fijando, hay dos niveles en el test: el
primero es el marco de pruebas y el segundo la librería de pruebas que
efectivamente se está usando. El marco de pruebas será el que ejecute
todos los tests, examine el resultado y emita un informe, que
dependerá de si los tests se han superado o no.

> Para ello, todas las librerías de tests emiten sus resultados en un
> formato de texto estándar, que se llama TAP. Por eso los marcos de
> pruebas se pueden usar con cualquier librería de pruebas, incluso de
> cualquier lenguaje.

Por debajo del marco de pruebas (la librería que permite estructuras
las pruebas), a veces existe una biblioteca de aserciones, que son las
diferentes pruebas unitarias que se deben pasar o no. En muchos casos,
la biblioteca de pruebas incluye ya aserciones; en otros casos,
bibliotecas de pruebas pueden trabajar con diferentes bibliotecas de
aserciones. 

### Escribiendo tests en Go

Algunos lenguajes, como [Go](https://golang.org), integran este marco de pruebas en el
propio lenguaje, por lo que nos permite fijarnos exclusivamente en la
biblioteca de pruebas con la que estamos trabajando.

Por ejemplo, vamos a fijarnos
en
[esta pequeña biblioteca que lee de un fichero en JSON los hitos de la asignatura](https://github.com/JJ/HitosIV) escrita
en ese lenguaje, Go. La biblioteca
tiene
[dos funciones, una que devuelve un hito a partir de su ID y otra que
te dice cuantos
hay](https://github.com/JJ/HitosIV/blob/master/HitosIV.go).
[Go](https://golang.org/) es
un lenguaje que pretende evitar lo peor de C++ para crear un lenguaje
concurrente, de sintaxis simple y con más seguridad; además, Go provee
también un entorno de programación con una serie de herramientas
(*toolbelt*) de serie.

Los módulos en Go incluyen funciones simples, estructuradas en un
paquete o *package*, y para testear un paquete en Go simplemente se crea un fichero con el
mismo nombre y el sufijo `_test`
como
[el siguiente](https://github.com/JJ/HitosIV/blob/master/HitosIV_test.go):

```Go
package HitosIV

import (
	"testing"
	"reflect"
)

func TestHitos (t *testing.T){
	t.Log("Test Id");
	if CuantosHitos() <= 0 {
		t.Error("No milestones")
	}
}

func TestTodosHitos (t *testing.T){
	t.Log("Test Todos");
	these_milestones := Hitos()
	if reflect.TypeOf(these_milestones).String() == "Data" {
		t.Error("No milestones here")
	}
}
```

> Te puedes descargar todo el proyecto con `git clone
> https://github.com/JJ/HitosIV` o hacerle *fork*, es software
> libre. Se agradecen PRs e issues.

La sintaxis no es excesivamente complicada. Se importan las
bibliotecas para testear (`testing`) y para averiguar de qué tipo es
algo (`reflect`) y se crean dos funciones de test, una por cada función que
queremos probar. De este fichero se ejecutarán todas las funciones al
ejecutar desde la línea de órdenes `go test`, que devolverá algo así:

```
PASS
ok  	_/home/jmerelo/Asignaturas/infraestructura-virtual/HitosIV	0.017s
```

En vez de aserciones como funciones específicas, Go simplifica el interfaz de test haciendo que
se devuelva un error (con `t.Error()`) cuando el test no pasa. Si
todos funcionan, no hay ningún problema y se imprime `PASS` como se muestra arriba. Adicionalmente, `t.Log()`
(siendo `t` una estructura de datos que se le tiene que pasar a todos
los tests) se usa para mostrar algún mensaje sobre qué está ocurriendo en el test. En este caso, uno de los tests comprueba que efectivamente
haya hitos en el fichero JSON que se ha pasado, y el segundo comprueba que el tipo que se devuelve cuando
se solicita un hito es el correcto. Estos tests no están completos;
generalmente hay que escribir una función de test para todas las funciones del módulo. Se muestran solo estos para ilustrar cómo funciona en un lenguaje determinado.

## Escribiendo tests en Python

Para llevar a cabo los tests, Go busca módulos (ficheros) con un nombre
específico y en el mismo directorio que el módulo que se quiere
probar; sin embargo, en otros lenguajes de programación como Python
pasar las pruebas consiste simplemente en ejecutar un programa,
situado en cualquier directorio y con cualquier nombre, que use alguna
librería estándar de aserciones como `unittest`. Por ejemplo,
en [el programa siguiente](https://github.com/JJ/tdd-gdg).

> Este programa tiene como objeto ilustrar la sintaxis y la forma de
> trabajar de Python. En un programa real la funcionalidad debe ser
> real y corresponder a las especificaciones (historias de usuario o
> de otro tipo) que se hayan hecho.

```
import unittest

def devuelveTrue():
    return True

def sumaPositivos( a, b):
    if ( not (type(a) is int) ):
        return -1
    if ( not (type(b) is int) ):
        return -1
    if ( a >= 0 and b >= 0): 
        return a + b

def multiplo3o5o15( numero ):
    if numero % 15 == 0:
        return 3
    if numero % 3 == 0:
        return 1
    if numero % 5 == 0:
        return 2
    return 0
    
class SoloTest(unittest.TestCase):
    
    def testTrue(self):
        self.assertTrue(devuelveTrue(), "devuelveTrue devuelve True")

    def testSuma(self):
        self.assertEqual(sumaPositivos("cadena",3),-1, "Suma correcta con argumento incorrecto")
        self.assertEqual(sumaPositivos(4,8), 12, "Suma correcta con argumento correcto")

    def testMultiplos(self):
        self.assertEqual(multiplo3o5o15(3),1,"Multiplo de 3")
        self.assertEqual(multiplo3o5o15(5),2,u"Multiplo de 5")
        self.assertEqual(multiplo3o5o15(15),3,u"Multiplo de 15")
        self.assertEqual(multiplo3o5o15(7),0,u"No es multiplo")
        

if __name__ == '__main__':
unittest.main()
```

Tenemos tres funciones, que podrían estar en una clase o no, que vamos
a testear; en caso de pertenecer a una clase tendremos que instanciar
un objeto, pero lo dejamos así por lo pronto porque con lo que hay se pueden testear
funciones individuales tales como estas. Para testearlas sí tenemos
que crear una clase, y esa clase `SoloTest` tiene que ser una subclase
de `unittest.TestCase`, es decir, un único caso de test. En esta clase
definimos tres métodos, cada uno de los cuales tiene una serie de
aserciones de este tipo:

```Python
self.assertTrue(devuelveTrue(), "Tiene que fallar")
```

A diferencia de Go, en Python sí existen
[aserciones explícitas](https://docs.python.org/3/library/unittest.html). Todas
las aserciones tienen al final un mensaje que se imprimirá 
funcione o no, y que debe ser más o menos descriptivo. Es decir, lo
contrario de lo que es en este caso, pero bueno, está así en el
original así que se queda. Antes del mensaje, la aserción realiza un
test específico; en este caso
una llamada a una función. `assertTrue` fallará solo si no se
devuelve `True` (o equivalente), y `assertEqual` lo hará si los dos
primeros argumentos no lo son. 

<div class='notes' markdown='1'>

No solo se puede y debe probar el código,
también
[la documentación](https://docs.python-guide.org/writing/tests/) y
todo tipo de cosas, incluyendo los scripts de despliegue, por
ejemplo. 

Alternativamente al uso de esta biblioteca, se puede usar también `pytest`, un programa que
tiene una sintaxis un poco más simple para los tests, o `nose`. Cada
lenguaje tiene sus múltiples modos de testear, y este tema pretende
ser solamente una introducción. 

</div>

En este caso, para ejecutar el programa se ejecuta como otro
cualquiera, `python test.py`, presentando un informe de los tests que
se han pasado, todos en este caso. 

<div class='ejercicios' markdown='1'>

Descargar y ejecutar las pruebas de alguno de los proyectos anteriores, y si sale todo
bien, hacer un pull request a alguno de esos proyectos con tests adicionales, si es que
faltan (en el momento que se lea este tema).

</div>

### Escribiendo tests en Javascript

Go valora la simplicidad y además incluye de serie todo lo necesario
para llevar a cabo los tests. Python, el lenguaje en el que sólo hay
una buena forma de hacer las cosas, permite que se hagan las cosas de
varias formas diferentes, e incluye en su biblioteca estándar una
biblioteca de aserciones.

. Hay
[múltiples bibliotecas que se pueden
usar](https://stackoverflow.com/questions/14294567/assertions-library-for-node-js);
el [panorama de 2019 se presenta en este
artículo](https://medium.com/welldone-software/an-overview-of-javascript-testing-in-2019-264e19514d0a). La
librería de aserciones [`assert`](https://nodejs.org/api/assert.html) 
forma parte de la estándar de JS, pero hay otras como
[Unexpected](http://unexpected.js.org/) o aserciones parte de marcos
de tests más completos. Estos marcos de test incluyen [Chai](https://www.chaijs.com/), [Jasmine](https://jasmine.github.io/),
[Must.js](https://github.com/moll/js-must) y [jest](https://jestjs.io/).


Veamos el siguiente
[ejemplo](https://github.com/JJ/desarrollo-basado-pruebas/blob/master/src/prueba-assert.js)
de uso de `assert`:

> Hace uso de una clase en JavaScript, [`Apuesta`, que está en otro repo](https://github.com/JJ/desarrollo-basado-pruebas/)

```
var apuesta = require("./Apuesta.js"),
assert= require("assert");

var nueva_apuesta = new apuesta.Apuesta('Polopos','Alhama','2-3');
assert(nueva_apuesta, "Creada apuesta");
assert.equal(nueva_apuesta.as_string(), "Polopos: Alhama - 2-3","Creado");
console.log("Si has llegado aquí, han pasado todos los tests");
```

Este programa usa `assert` directamente y como se ve por la línea del
final, no hace nada salvo que falle. `assert` no da error si existe el
objeto, es decir, si no ha habido ningún error en la carga o creación
del mismo, y `equal` comprueba que efectivamente la salida que da la
función `as_string` es la esperada.

<div class='ejercicios' markdown='1'>
Para la aplicación que se está haciendo, escribir una serie de aserciones y probar que efectivamente no fallan. Añadir tests para una nueva funcionalidad, probar que falla y escribir el código para que no lo haga (vamos, lo que viene siendo TDD).
</div>

El programa anterior ilustra la sintaxis, y puede formar parte de un
conjunto de tests; se puede ejecutar directamente, pero para testearlo
los lenguajes de programación usan un segundo nivel, el marco de
ejecución de los tests. Estos marcos incluyen programas de línea de
órdenes que, a su vez, ejecutan los programas de test y escriben 
un informe sobre cuáles han fallado y cuáles no con más o menos
parafernalia y farfolla. Una vez más, [hay varios marcos de testeo](https://stackoverflow.com/questions/4308786/what-is-the-best-testing-framework-to-use-with-node-js) para
nodejs (y, por supuesto, uno propio para cada uno de los lenguajes de
programación, aunque en algunos están realmente estandarizados).

Como algunos marcos de prueba como Chai usan su propia biblioteca de
aserciones, podemos hacer este pequeño cambio para usarla: 

```
var assert = require("chai").assert,
    apuesta = require(__dirname+"/../Apuesta.js");

console.log(assert);
describe('Apuesta con Chai', function(){
    // Testea que se haya cargado bien la librería
    describe('Carga', function(){
	it('should be loaded', function(){
	    assert.ok(apuesta, "Cargado");
	});
	
    });
    describe('Crea', function(){
	it('should create apuestas correctly', function(){
	    var nueva_apuesta = new apuesta.Apuesta('Polopos','Alhama','2-3');
	    assert.equal(nueva_apuesta.as_string(), "Polopos: Alhama - 2-3","Creado");
	});
    });
});
```

Los únicos cambios son el usar `assert.ok` en vez de assert, y el usar
el objeto `assert` de la biblioteca `chai`, en vez de usar el que hay
por omisión. 

Cada uno de ellos tendrá sus promotores y detractores, pero
[Mocha](https://mochajs.org/), [Jasmine](https://jasmine.github.io/) y [Jest](https://github.com/facebook/jest)
parecen ser los más populares. Los tres usan un sistema denominado
[Behavior Driven Development](https://en.wikipedia.org/wiki/Behavior-driven_development),
que consiste en describir el comportamiento de un sistema más o menos
de alto nivel; para ello suelen incluir una serie de aserciones o su
propia biblioteca de aserciones para que la sentencia que lleve a cabo
el test sea lo más cercana posible a la frase (en inglés) que la describiría. Como hay que escoger uno y parece que Mocha es más
popular, nos quedamos con este para escribir este programa de test.

```
var assert = require("assert"),
		apuesta = require(__dirname+"/../Apuesta.js");

describe('Apuesta', function(){
	// Testea que se haya cargado bien la librería
	describe('Carga', function(){
	it('should be loaded', function(){
		assert(apuesta, "Cargado");
	});
});

describe('Crea', function(){
	it('should create apuestas correctly', function(){
		var nueva_apuesta = new apuesta.Apuesta('Polopos','Alhama','2-3');
		assert.equal(nueva_apuesta.as_string(), "Polopos: Alhama - 2-3","Creado");
		});
	});
});
```

Mocha puede usar diferentes librerías de aserciones. En este caso hemos
escogido la que ya habíamos usado, `assert`. A bajo nivel, los tests
que funcionen en este marco tendrán que usar una librería de este
tipo, porque mocha funciona a un nivel superior, con funciones como
`it` y `describe` que describe, a diferentes niveles, el
comportamiento que queremos comprobar. Se ejecuta con `mocha` y
el resultado de ejecutarlo será:


```
    Apuesta
      Carga
        ✓ should be loaded 
      Crea
        ✓ should create apuestas correctly 


    2 passing (6ms)
```

(pero con más colorines)

>Y la verdad es que debería haber puesto los mensajes en español.

Con la librería BDD de Chai, podríamos expresar los mismos tests de
esta forma: 

```
var assert = require("chai").should(),
    apuesta = require(__dirname+"/../Apuesta.js");

describe('BDD con Chai', function(){
    it('Debería cargar la biblioteca y poder instanciarse', function() {
	apuesta.should.exist;
	var nueva_apuesta = new apuesta.Apuesta('Polopos','Alhama','2-3');
	
	nueva_apuesta.as_string().should.equal( "Polopos: Alhama - 2-3","Creado");
    })
});
```

La única diferencia es que ejecutamos la función `should` de `chai`,
que añade a todos los objetos funciones que permite expresar, en
lenguaje más o menos natural, qué es lo que queremos probar: que el
objeto de la librería existe, y que se puede instanciar y que los
resultados que obtienen se pueden convertir a una cadena de la forma
esperada. Como se ve, el marco (que incluye las funciones `describe` e
`it`) no varía, lo que varía es como se describe el test en sí, que
depende de la biblioteca de aserciones.



Además, te indica el tiempo que ha tardado lo que te puede servir para
hacer un *benchmark* de tu código en los diferentes entornos en los
que se ejecute.

### Otros lenguajes

En general, en todos los lenguajes habrá dos niveles para llevar a
cabo  los tests: las aserciones, que permiten ejecutar código y
examinar el resultado del mismo, comparándolo con la salida deseada, y
generalmente un programa, que se encargará de buscar los ficheros de
tests siguiendo una convención determinada (nombre del fichero,
directorio en el que se encuentre), ejecutarlos, examinar la salida
(que, como hemos indicado arriba, sigue un protocolo determinado) y
decir si se han pasado todos los tests o no, en cuyo caso se indicará
alguna información adicional como qué scripts de tests no se ha
pasado o el mensaje de la misma. Algunos programas usados en otros
lenguajes son:

* Ruby usa [RSpec](http://rspec.info/), que además está basado en el
  comportamiento deseado, lo que permite tener descripciones mucho más
  informativas del test y el resultado del fallo.
  
* Perl usa [prove](https://perldoc.perl.org/prove.html), con múltiples
  opciones de configuración. De hecho, es el que se usa en el test de
  la asignatura.
  
* JUnit es el más cercano en Java.

Cada lenguaje incluye este tipo de marcos, sea como parte de su
distribución base o como parte de alguna biblioteca popular.


<div class='ejercicios' markdown='1'>

Crear algún conjunto de scripts de tests, usando tu lenguaje favorito,
y ejecutarlos desde el marco de test más adecuado (o el que más te
guste) para ese lenguaje.

</div>


## Gestores de versiones de lenguajes y bibliotecas.

Una de las partes esenciales de la cultura *DevOps* es la definición y
gestión de configuraciones que permite la automatización y
replicabilidad de la misma desde el entorno de desarrollo hasta el
entorno de ensayo o el de producción. El uso de *entornos
virtuales* (llamados así por uno de los primeros en Python, llamado
`virtualenv`) o *gestores de versiones*, que permite instalar desde el 
usuario la versión del lenguaje de programación y herramientas que uno
desee, cubre las dos necesidades: te permite independizar la
versión usada de la que proporcione el sistema, instalarla sin
necesidad de tener privilegios de superusuario, compartirla entre
todos los miembros del equipo y también automatizar la tarea 
de instalación del mismo mediante el uso de una sola orden que
seleccione la versión precisa que se va a usar. 

Y estos entornos virtuales vienen del hecho de que los lenguajes de scripting tales como Perl, Python y Ruby tienen
ciclos de desarrollo muy rápidos que hacen que a veces convivan en
producción diferentes versiones de los mismos, incluso versiones
*major*. Eso hace complicado desarrollar e incluso probar los 
programas que se desarrollan: si el sistema operativo viene con Perl
5.14, puede que haga falta probar o desarrollar para 5.16 o 5.18 o
incluso probar la versión más avanzada.

Por eso desde hacer cierto tiempo se han venido usando *entornos
virtuales de desarrollo* tales como:

*  [virtualenv](https://virtualenv.pypa.io/en/latest/) para Python,
*  [nvm](https://github.com/creationix/nvm), [`n`](https://github.com/tj/n) y [nave](https://github.com/isaacs/nave) para node.js,
*  [`phpenv` para, lo adivinaste, PHP](https://github.com/phpenv/phpenv),
*  [rbenv](https://github.com/sstephenson/rbenv) y [RVM](https://rvm.io) para Ruby
*  y [plenv](https://github.com/tokuhirom/plenv) y [perlbrew](https://perlbrew.pl) para Perl.

Generalmente, estos programa funcionan instalando binarios en
directorios del usuario y modificando el camino de ejecución para que
se usen estas versiones en vez de las instaladas en el sistema. En la
mayoría de los casos se coordinan también con el *shell* para mostrar
la versión que se está ejecutando en la línea de órdenes o para llevar
a cabo autocompletado. 

Una vez instalados, estos programas permiten instalar fácilmente
nuevas versiones de tu lenguaje de programación (con las librerías
asociadas) y probar un programa en todas ellas. Se usan principalmente
para reflejar localmente los entornos que se usan en producción; por
ejemplo, usar en el entorno de desarrollo local la misma versión y
librerías que nos vamos a encontrar en un PaaS tal como los que
veremos a continuación.

<div class='ejercicios' markdown='1'>

Instalar alguno de los entornos virtuales de `node.js` (o de cualquier
otro lenguaje con el que se esté familiarizado) y, con ellos,
instalar la última versión existente, la versión `minor` más actual
de la 4.x y lo mismo para la 0.11 o alguna impar (de desarrollo).
</div>

Generalmente, las librerías asociadas a una aplicación determinada, es decir, las dependencias, 
siguen un método similar. En vez de instalar en el sistema todas las
librerías necesarias (o instalar una cada vez que hay algún error),
la mayor parte de los entornos de programación incluyen alguna forma
de definir qué librerías (o módulos) necesitan y qué versiones
mínimas, máximas o exactas deben tener.

>Incidentalmente, el hecho de que todo sea software libre ayuda a que en ningún paso de este proceso haya que decidir qué licencia o modelo de pago o cosas similares hay que usar.

## Vamos a hacer una aplicación: gestionar porras de fútbol

Una porra de fútbol básicamente tiene un partido, que tendrá un nombre
y si acaso una fecha o descripción (por ejemplo, *Jaén-Osasuna Copa
2014*) y luego los participantes votan por un resultado determinado,
*JJ, 2-1*, por ejemplo. Este sería el *modelo* sobre el que vamos a
basar la aplicación.

El objeto básico, por tanto, será la `Apuesta` que irá asociada a un `Partido`.

<div class='ejercicios'  markdown="1">

Como ejercicio, algo ligeramente diferente: una web para calificar
las empresas en las que hacen prácticas los alumnos.

Las acciones serían

* Crear empresa
* Listar calificaciones para cada empresa
* crear calificación y añadirla (comprobando que la persona no la haya añadido ya)
* borrar calificación (si se arrepiente o te denuncia la empresa o algo)
* Hacer un ránking de empresas por calificación, por ejemplo
* Crear un repositorio en GitHub para la librería y crear un pequeño programa que use algunas de sus funcionalidades.

Si se quiere hacer con cualquier otra aplicación, también es válido.

Se trata de hacer una aplicación simple que se pueda hacer rápidamente
con un generador de aplicaciones como los que incluyen diferentes
marcos MVC. Si cuesta mucho trabajo, simplemente prepara una
aplicación que puedas usar más adelante en el resto de los ejercicios.

</div>


La aplicación tendrá más adelante un interfaz web, pero por lo pronto,
y a efectos de la prueba continua de más adelante, vamos a quedarnos
solo con un pequeño programa que sirva para ver que funciona.

<div class='ejercicios'>

Ejecutar el programa en diferentes versiones del lenguaje. ¿Funciona en todas ellas?

</div>


Podemos almacenar esta información en una base de datos como SQLite
(la clásica). Para instalarla, `npm install sqlite` que es la forma
como se instalan los módulos de node. Además, se instala en
local. Pero el objeto del desarrollo moderno es asegurarse de que todo
lo necesario para programar algo está presente. Por eso, se usan
ficheros que describen qué se usa y, en general, que es necesario
instalar y tener para ejecutarlo. En node se usa un fichero en formato
JSON tal como este:

```
	{
	  "author": "J. J. Merelo <jjmerelo@gmail.com> (https://github.com/JJ/desarrollo-basado-pruebas)",
	  "name": "porrio",
	  "description": "Apuesta en una porra",
	  "version": "0.0.1",
	  "repository": {
	  "url": "git://github.com/JJ/desarrollo-basado-pruebas.git"
	  },
	  "main": "./Apuesta.js",
	  "scripts": {
	  "test": "make test"
	  },
	  "dependencies": {"sqlite3": "~3.0"},
	  "devDependencies": {},
	  "optionalDependencies": {},
	  "engines": {
	  "node": ">=0.8"
	  }
	}
```


Las partes que más nos interesan están hacia el final: las
dependencias diversas (`dependencies`). Es un *hash* que dice qué
módulo se usan (en este caso, `sqlite` solo) y qué versiones harán
falta. Al desplegarse, el entorno dependerá de muchas cuestiones y hay que asegurarse de que donde va a acabar el programa tiene todo lo necesario. En caso de que no lo tuviera, el programa no se instalará.

A este nivel, la descripción del entorno de trabajo ya constituye en sí un test: donde se va a desplegar o lo tiene o no lo tiene, en cuyo caso no se permitirá la ejecución.

Este fichero, además, permite instalar todas las dependencias usando solo `npm install .`. Casi todos los lenguajes habituales tienen algún sistema similar: `bundle` para Ruby o `cpanm` para Perl, por ejemplo. 

<div class='ejercicios' markdown='1'>

Crear una descripción del módulo usando `package.json`. En caso de que se trate de otro lenguaje, usar el método correspondiente.

</div>

`package.json` nos sirve para llevar un cierto control de qué es lo
que necesita nuestra aplicación y, por tanto, nos va a ser bastante
útil cuando digamos de desplegarlo o testearlo en la nube.

No solo eso, sino que es la referencia para otra serie de
herramientas, como las herramientas de construcción. Las herramientas
de construcción o de control de tareas se vienen usando
tradicionalmente en todos los entornos de programación. Quién no ha
usado alguna vez `make` o escrito un Makefile; lo que ocurre es que
tradicionalmente se dedicaban exclusivamente a la compilación. Hoy en
día el concepto de *construcción* es más amplio e incluye tareas que
van desde el uso de diferentes generadores (de hojas CSS a partir de
un lenguaje, por ejemplo) hasta la *minificación* o "compresión" de un
programa hasta que ocupe el mínimo espacio posible, para que sea más
*amigable* para móviles y otros dispositivos sin mucho ancho de banda.

Todos los lenguajes de programación tienen su propia [herramienta de construcción](https://en.wikipedia.org/wiki/Build_automation),  de las
cuales la más conocida y veterana es la
orden `make`, introducida [hace casi cuarenta años](https://es.wikipedia.org/wiki/Make). `make` automatiza el proceso
de construcción en un fichero llamado `Makefile` con una sintaxis
específica que se puede resumir en

* unos *objetivos* que hay que cumplir y que dependen unos de
  otros. Por ejemplo, antes de construir el ejecutable hay que
  construir las librerías.

* unas *tareas* que hay que hacer para cumplir esos objetivos. Por
  ejemplo, para obtener una librería hay que compilarla a partir del
  fuente.

Muchos lenguajes de programación, como el propio Perl, usan *make*
para la automatización de tareas y compilación. Sin embargo, otros lenguajes de programación
usan diferentes herramientas para ello: Ant, Ivy y Maven para Java, `sbt`
para Scala, Rake para Ruby y otras muchas.

En node.js se utilizan principalmente dos:
[Grunt](https://gruntjs.com) y [Gulp](https://gulpjs.com), aunque
también han aparecido
últimamente
[Broccoli y mimosa](https://www.freelancinggig.com/blog/2017/05/18/grunt-vs-cake-vs-gulp-vs-broccoli-js-task-runners-comparison-2017/),
así como [Brunch y webpack](https://brunch.io/docs/why-brunch).

>Aquí podíamos hacer una breve disquisición sobre
>[el código y la configuración](https://coding.abel.nu/2013/06/code-or-configuration-or-configuration-in-code/),
>algo a lo que nos vamos a enfrentar repetidamente en la nube. ¿Un
>fichero de construcción es, o debe ser, configuración o código?
>Diferentes herramientas toman diferentes aproximaciones al tema:
>`grunt` es, sobre todo, configuración, mientras que `gulp` es, sobre
>todo, código.

Algo fundamental en todo proyecto es la documentación; para empezar,
vamos a usar `grunt` para documentar el código. Tras la instalación de
`grunt`, que no viene instalado por defecto en nodejs, se puede usar
directamente.

```
sudo npm install -g grunt-cli
```

`-g` indica que se trata de una instalación global, aunque también se
puede instalar localmente. 
	
Igual que make usa
Makefiles, `grunt` usa `Gruntfile.js` tal como este

```Javascript
    'use strict';

    module.exports = function(grunt) {

	  // Configuración del proyecto
	  grunt.initConfig({
	  pkg: grunt.file.readJSON('package.json'),
	  docco: {
		  debug: {
		  src: ['*.js'],
		  options: {
			  output: 'docs/'
		  }
		  }
	  }
	  });

	  // Carga el plugin de grunt para hacer esto
	  grunt.loadNpmTasks('grunt-docco');

	  // Tarea por omisión: generar la documentación
	  grunt.registerTask('default', ['docco']);
    };
```

Para empezar, tenemos que instalar `docco` si queremos que funcione. Y
`grunt` enfoca las tareas como una serie de *plugins* que hay que
instalar, en este caso `grunt-docco`. Para instalarlos se usa la
herramienta habitual de instalación en node, `npm`, pero una vez que
usamos `package.json`, `npm` puede editarlo y cambiar la configuración
automáticamente si lo usamos de esta forma

```
	npm install docco grunt-docco --save-dev
```

El `--save-dev` indica que se guarde la configuración correspondiente
en `package.json`, donde efectivamente se puede ver:

```
	"devDependencies": {
	  "docco": "~0.6",
	  "grunt-docco": "~0.3.3"
	},
```

El fichero que se ve arriba tiene tres partes: la definición de la
tarea (en este caso, la que genera la documentación), la carga de la
tarea y finalmente el registro de la tarea.

Vayamos con la primera parte. Primero, le indicamos cuál es el fichero `package.json` que usamos. Este fichero tiene una serie de variables de configuración que podremos usar en el Gruntfile (pero que, por lo pronto, no vamos a hacerlo). Luego, definimos la tarea llamada `docco`, que a su vez tiene una subtarea llamada `debug`: toma los fuentes contenidos en el array indicado y deposita la salida en el directorio que le indicamos. No existe en Grunt una forma general de expresar este tipo de dependencias como en los Makefiles, solo una buena práctica: usar `src`, por ejemplo, para las fuentes. 

La siguiente parte carga el plugin de `grunt` necesario para ejecutar `docco`. Y finalmente, con `grunt.registerTask('default', ['docco']);` indicamos que la tarea que ejecuta docco es la que se ejecutará por defecto simplemente ejecutando `grunt`. También se puede ejecutar con `grunt docco` o `grunt docco:debug` que sacará esto en el terminal:

```
	bash$ grunt docco
	Running "docco:src" (docco) task
	docco: Apuesta.js -> docs/Apuesta.html
	docco: Gruntfile.js -> docs/Gruntfile.html
```

y producirá una documentación tal como [esta](http://jj.github.io/desarrollo-basado-pruebas/src/docs/Apuesta.html).

La automatización de Grunt se puede usar tanto para prueba como para despliegue. Pero hay también otras formas de probar en la nube, y lo veremos a continuación.

<div class='ejercicios' markdown='1'>

Automatizar con `grunt`, `gulp` u otra herramienta de gestión de
tareas en Node la generación de documentación de la librería que se
cree usando `docco` u otro sistema similar de generación de
documentación. Previamente, por supuesto, habrá que documentar tal librería.

</div>


## Añadiendo integración continua

A un primer nivel, la integración continua consiste en integrar los
cambios hechos por un miembro del equipo en el momento que estén y
pasen los tests. Pero eso, efectivamente, significa que deben pasar
los tests y para nosotros, consiste en crear una configuración para
una máquina externa que ejecute esos tests y nos diga cuáles han
pasado o cuáles no. Estas máquinas más adelante se combinan con las de
despliegue continuo, no permitiendo el mismo si algún test no ha
pasado.

En general, la integración continua se hace *en la nube*: una máquina
virtual creada ex profeso se descarga los ficheros, ejecuta los tests
y crea un informe, enviando también un correo al autor indicándole el
resultado. Por tanto, para que haga esto tenemos que indicar en la
configuración todo lo necesario para ejecutar los tests y,
posiblemente, nuestro programa: aplicaciones, librerías que necesita
nuestro programa, aparte de la configuración que tendrá el programa en
sí con las librerías del lenguaje de programación en el que está
desarrollado.

Un sistema bastante popular de integración continua es
[Jenkins](https://jenkins.io/). Para usar Jenkins puedes instalarlo en tu propio
ordenador, en un servidor propio en la nube o en [algún servicio en la nube](https://wiki.jenkins.io/display/JENKINS/Commercial+Support). Sin embargo, hay otros sistemas como [Travis](https://travis-ci.org) o
[Shippable](https://www.shippable.com/) que podemos usar también desde
la nube.

Para trabajar con estos sistemas, generalmente hay que ejecutar estos
tres pasos:

1. Darse de alta. Muchos están conectados con GitHub por lo que puedes
  autentificarte directamente desde ahí. A través de un proceso de
   autorización, puedes acceder al contenido e incluso informar del resultado
   de los tests a GitHub.

2. Activar el repositorio en el que se vaya a aplicar la
   integración continua. Travis permite hacerlo directamente desde tu
   configuración; en otros se dan de alta desde la web de GitHub.

3. Crear un fichero de configuración para que se ejecute la
   integración y añadirlo al repositorio.

<div class='ejercicios' markdown='1'>

Haced los dos primeros pasos antes de pasar al tercero.

</div>

Los ficheros de configuración de las máquinas de integración continua
corresponden, aproximadamente, a una configuración de una máquina
virtual que hiciera solo y exclusivamente la ejecución de los
tests. Para ello se provisiona una máquina virtual (o contenedor), se
le carga el sistema operativo y se instala lo necesario, indicado en
el fichero de configuración tal como este para Travis. 

```
language: node_js
node_js:
  - "0.10"
  - "0.11"
before_install:
  - npm install -g mocha
  - cd src; npm install .
script: cd src; mocha
```

Este fichero, denominado `.travis.yml`, contiene lo siguiente:

- `language` indica qué lenguaje se va a usar. Travis tiene
  [varios lenguajes](https://docs.travis-ci.com/user/getting-started/),
  incluyendo por supuesto nodejs. Las máquinas virtuales no suelen
  estar configuradas para lenguajes arbitrarios, aunque por supuesto
  se puede poner un lenguaje tal como C y luego descargar lo necesario
  para otro lenguaje.

- `node_js` en este caso indica las versiones que vamos a probar. Por
  el mismo precio podemos probar varias versiones, en este caso las
  dos últimas de node.

- `before_install` se ejecuta antes de la instalación de la aplicación
  (específica de cada lenguaje; por ejemplo en el caso de node.js
  sería `npm install .`. En nuestro caso tenemos que instalar `mocha`
  y además ejecutar este último paso en un subdirectorio que no es
  estándar.

- Finalmente, se ejecuta el script de prueba en sí (para el caso,
  cualquier cosa que quieras ejecutar). Una vez más, nos cambiamos al
  subdirectorio y ejecutamos `mocha` tal como lo hemos hecho
  anteriormente.

El resultado
[aparecerá en la web](https://travis-ci.org/JJ/desarrollo-basado-pruebas)
y también se enviará por correo electrónico. Y te da también un
*badge* que puedes poner en tu fichero para indicar que, por lo
pronto, todo funciona.

Si el informe indica que las pruebas son correctas, se puede proceder al despliegue. Pero eso
ya será en la siguiente clase.

> Configurar integración continua para nuestra aplicación usando Travis o algún otro sitio.

Esta configuración es esencial por varias razones: primero, porque nos
permite ser conscientes de todo lo necesario para desplegar nuestra
aplicación. Segundo, porque al crear tests integramos el paso de
control de calidad en el desarrollo. Y, finalmente, porque la
integración continua y los tests correspondientes son un paso esencial
para el despliegue continuo, que se verá más adelante.

## A dónde ir desde aquí

Una vez visto todo lo necesario para desplegar una aplicación, se
puede pasar a estudiar los
[*PaaS*, plataformas como servicio](PaaS), donde se pueden desplegar aplicaciones para prototipo o para producción de forma relativamente simple. 
