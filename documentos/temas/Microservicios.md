---
layout: index


prev: Desarrollo_basado_en_pruebas
next: PaaS
---

# Desplegando aplicaciones en la nube: Uso de PaaS


<!--@
prev: Desarrollo_basado_en_pruebas
next: PaaS
-->

<div class="objetivos" markdown="1">

<h2>Objetivos</h2>


<h3>Cubre los siguientes objetivos de la asignatura</h3>

2. Conocer los conceptos relacionados con el proceso de virtualización
tanto de software como de hardware y ponerlos en práctica.

4. Justificar la necesidad de procesamiento virtual frente a real en
   el contexto de una infraestructura TIC de una organización.

### Objetivos específicos

5. Entender los mecanismos de diseño, prueba y despliegue de un microservicio antes de efectuarlo y enviarlo a la nube.

6. Aplicar el concepto de *DevOps* a este tipo específico de plataforma.

7. Aplicar el sistema de control de fuentes `git` para despliegue de aplicaciones en la nube.

</div>

## Introducción

>Esta [presentación](https://jj.github.io/pispaas/#/) es un resumen del concepto de Plataforma como Servicio
>(PaaS) y alguna cosa adicional que no está incluida en este tema pero que conviene conocer de todas formas.

En general, un microservicio será un decorador o fachada que se
añadirá a una clase o módulo para acceder a esa funcionalidad a través
de Internet en el contexto de un grupo de microservicios desplegados
dentro de una aplicación. Un microservicio es, en sí, también una
funcionalidad que, como tal, habrá que testear de forma específica.

Aunque los frameworks de microservicios contienen servidores web
funcionales, en general es aconsejable colocarles algún servidor
adicional para su puesta en producción. Todos los lenguajes de
programación suelen tener interfaces específicos para que haya un buen
acoplamiento entre el microservicio y el servidor que hay por delante,
que además se asegura de que haya un número de copias ejecutándose,
por ejemplo. Finalmente, en muchos casos por delante de él hay un
servidor o proxy inverso genérico tal como nginx que, además, es capaz
de servir de forma más eficiente los ficheros estáticos.

## Creando un microservicio desde cero

> En este ejemplo usaremos Node; una alternativa está en
> [esta presentación sobre servicios web en Python](https://jj.github.io/tests-python/ws.html), en la que se da
> se da una introducción a los servicios web y cómo desplegarlos
> usando el micromarco de aplicaciones Hug.

Se pueden diseñar servicios web en cualquier lenguaje de programación;
pero en este apartado optaremos inicialmente por Node.js/Javascript;
que para diseñar interfaces REST de forma bastante simple, tiene
un [módulo llamado express](https://expressjs.com/). La idea de este módulo
es reflejar en el código, de la forma más natural posible, el diseño del
interfaz REST.

Pero primero hay que instalarlo. Node.js tiene un sistema de gestión de
módulos bastante simple llamado [npm](https://www.npmjs.org/) que ya hemos usado. Tras seguir las instrucciones en el
sitio para instalarlo (o, en el caso de Ubuntu, instalarlo desde
Synaptic o con `apt-get`), vamos al directorio en el que vayamos a crear
el programa y escribimos

`npm install express --save`

en general, no hace falta tener permiso de administrador, solo el
necesario para crear, leer y ejecutar ficheros en el directorio en el
que se esté trabajando. `--save` guarda la dependencia en `package.json` siempre que esté en el mismo directorio, que convendría que estuviera, así no tenemos que recordar qué es lo que está instalado.

Tras la instalación, el programa que hemos visto más arriba se
transforma en el siguiente:

```
#!/usr/bin/env node

var express=require('express');
var app = express();
var port = process.env.PORT || 8080;

app.get('/', function (req, res) {
	res.send( { Portada: true } );
});

app.get('/proc', function (req, res) {
	res.send( { Portada: false} );
});  

app.listen(port);
console.log('Server running at http://127.0.0.1:'+port+'/');
```


Para empezar, `express` nos evita todas las molestias de tener que
procesar nosotros el URL: directamente escribimos una
función para cada respuesta que queramos tener, lo que facilita mucho la
programación. Las órdenes  de expressreflejan directamente las órdenes de
HTTP a las que queremos responder, en este caso `get` y por
otro lado se pone directamente la función para cada una de ellas. Dentro
de cada función de respuesta podemos procesar las órdenes que
queramos. Dado que JS es un lenguaje asíncrono, la llamada a la
función será también asíncrona.

Por otro lado, se usa `send` sobre el objeto respuesta (`res`)  para enviar el resultado,
[una orden más flexible](https://expressjs.com/en/api.html#res.send)
que admite todo
tipo de datos que son procesados para enviar al cliente la respuesta
correcta. Tampoco hace falta establecer explícitamente el tipo MIME que
se devuelve, encargándose `send` del mismo.

En los dos casos, las peticiones devuelven JSON. Una aplicación de
este tipo puede devolver cualquier cosa, HTML o texto, pero conviene
acostumbrarse a pensar en estas aplicaciones como servidores a los
cuales se va a acceder desde un cliente, sea un programa que use un
cliente REST o el mismo cliente REST usando el navegador, es decir,
mediante JavaScript.


<div class='ejercicios' markdown="1">

Realizar una aplicación básica que use `express` para devolver alguna
estructura de datos del modelo que se viene usando en el curso.

</div>

El puerto se indica en una variable de entorno. Es siempre una buena
práctica hacerlo, ya que cada despliegue exigirá un puerto
determinado, y siempre se pueden usar variables de entorno para ello.

Con el mismo `express` se pueden generar aplicaciones no tan básicas
instalando [`express-generator`](https://expressjs.com/es/starter/generator.html) o el generador de aplicaciones [`yeoman`](https://yeoman.io)

    express prueba-rest

Se indica el camino completo a la aplicación, que sería el
puesto. Con esto se genera un directorio prueba-rest. Cambiándoos al
mismo y escribiendo simplemente `npm install` se instalarán las
dependencias necesarias. La aplicación estará en el fichero `index.js`,
lista para funcionar, pero evidentemente habrá que adaptarla a nuestras
necesidades particulares.

Por otro lado, el ejemplo anterior es un simple ejemplo de un servicio
web, sin ninguna funcionalidad. En general, deberemos tener una clase
por debajo, que esté testeada, y que refleje cuál es el verdadero
servicio que se está ofreciendo desde el microservicio. Por otro lado, el acceso a los parámetros de la llamada y la realización de diferentes
actividades según el mismo se denomina enrutado. En `express` se pueden
definir los parámetros de forma bastante simple, usando marcadores
precedidos por `:`. 


Por ejemplo, si queremos tener diferentes contadores
podríamos usar el [programa siguiente](https://github.com/JJ/node-app-cc/blob/master/index.js):

```
	var express = require('express');
	var app = express();

	// recuerda ejecutar antes grunt creadb
	var db_file = "porrio.db.sqlite3";
	var apuesta = require("./Apuesta.js");
	var porra = require("./Porra.js");

	var porras = new Array;

	app.set('port', (process.env.PORT || 5000));
	app.use(express.static(__dirname + '/public'));

	app.put('/porra/:local/:visitante/:competition/:year', function( req, response ) {
		var nueva_porra = new porra.Porra(req.params.local,req.params.visitante,
						  req.params.competition, req.params.year );
		porras.push(nueva_porra);
		response.send(nueva_porra);
	});

	app.get('/porras', function(request, response) {
		response.send( porras );
	});

	app.listen(app.get('port'), function() {
	  console.log("Node app is running at localhost:" + app.get('port'));
	});
```


Este [programa
(express-count.js)](https://github.com/JJ/node-app-cc/blob/master/index.js)
introduce otras dos órdenes REST: PUT, que, como recordamos, sirve para
crear nuevos recurso y es idempotente (se puede usar varias veces con el
mismo resultado) y además GET. Esa orden la vamos a usar para crear
contadores a los que posteriormente accederemos con `get`. PUT no es una
orden a la que se pueda acceder desde el navegador, así que para usarla
necesitaremos hacer algo así desde la línea de órdenes:
`curl -X PUT http://127.0.0.1:5000/porra/local/visitante/Copa/2013` para lo que
previamente habrá que haber instalado `curl`, claro. Esta orden llama a
PUT sobre el programa, y crea un partido con esas características. Una
vez creado, podemos acceder a él desde la línea de órdenes o desde el
navegador; la dirección `http://127.0.0.1:5000/porras` nos devolverá
en formato JSON todo lo que hayamos almacenado hasta el momento.

Todas las órdenes definen una *ruta*, que es como se denominan cada
una de las funciones del API REST. Las
[rutas](https://hub.packtpub.com/understanding-express-routes)
pueden ser simples cadenas (como `/porras` en el caso de `get`) o
incluir parámetros, como en el caso de `put`:
`/porra/:local/:visitante/:competition/:year` incluye una orden al
principio y cuatro parámetros. Estos parámetros se recuperan dentro de
la función *callback* como atributos de la variable `req.params`,
tales como `req.params.local` en las siguientes líneas.


<div class='ejercicios' markdown="1">

Realizar una app en express (o el lenguaje y marco elegido) que
incluya variables como en el caso anterior.

</div>

## Probando nuestra aplicación en la nube

Porque esté en la nube no significa que no tengamos que testearla como cualquier hija de vecina. En este caso no vamos a usar tests unitarios, sino test funcionales (o como se llamen); de lo que se trata es que tenemos que levantar la web y que vaya todo medianamente bien.

Los tests podemos integrarlos, como es natural, en el mismo marco que el resto de la aplicación, solo que tendremos que usar librerías de aserciones ligeramente diferentes, en este caso `supertest`

```
	var request = require('supertest'),
	app = require('../index.js');

	describe( "PUT porra", function() {
		it('should create', function (done) {
		request(app)
			.put('/porra/uno/dos/tres/4')
			.expect('Content-Type', /json/)
			.expect(200,done);
		});
	});
```

(que tendrá que estar incluido en el directorio `test/`, como el resto). En vez de ejecutar la aplicación (que también podríamos hacerlo), lo que hacemos es que añadimos al final de `index.js` la línea:

```
module.exports = app;
```

con lo que se exporta la app que se crea; `require` ejecuta el código y recibe la variable que hemos exportado, que podemos usar como si se tratara de parte de esta misma aplicación. `app` en este test, por tanto, contendrá lo mismo que en la aplicación principal, `index.js`. Usamos el mismo estilo de test con `mocha` que [ya se ha visto](https://jj.github.io/desarrollo-basado-pruebas/) pero usamos funciones específicas:

* `request` hace una llamada sobre `app` como si la hiciéramos *desde
  fuera*; `put`, por tanto, llamará a la ruta correspondiente, que
  crea un partido sobre el que apostar.
* `expect` expresa qué se puede esperar de la respuesta. Por ejemplo,
  se puede esperar que sea de tipo JSON (porque es lo que enviamos, un
  JSON del partido añadido) y además que sea de tipo '200', respuesta
  correcta. Y como esta es la última de la cadena, llamamos a `done`
  que es en realidad una función que usa como parámetro el callback.

Podemos hacer más pruebas, usando get, por ejemplo. Pero se deja como ejercicio al alumno.

Estas pruebas permiten que no nos encontremos con sorpresas una vez que despeguemos en el PaaS. Así sabemos que, al menos, todas las rutas que hemos creado funcionan correctamente.

<div class='ejercicios' markdown="1">

 Crear pruebas para las diferentes rutas de la aplicación.

</div>



## A dónde ir desde aquí


En el [siguiente tema](PaaS) veremos cómo hacer efectivamente el despliegue en la nube.
