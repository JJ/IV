---
layout: index


prev: REST
next: PaaS
---

# Microservicios

<!--@
prev: REST
next: PaaS
-->

<div class="objetivos" markdown="1">

## Objetivos

### Cubre los siguientes objetivos de la asignatura

1. Conocer los conceptos relacionados con el proceso de virtualización tanto de
   software como de hardware y ponerlos en práctica.

2. Justificar la necesidad de procesamiento virtual frente a real en
   el contexto de una infraestructura TIC de una organización.

### Objetivos específicos

1. Entender los mecanismos de diseño, prueba y despliegue de un microservicio
   antes de efectuarlo y enviarlo a la nube.

2. Aplicar el concepto de *DevOps* a este tipo específico de plataforma.

3. Aprender prácticas seguras en el desarrollo de aplicaciones en la nube.

</div>

## Introducción

En general, un microservicio será un decorador o fachada que se
añadirá a una clase o módulo para acceder a esa funcionalidad a través
de Internet en el contexto de un grupo de microservicios desplegados
dentro de una aplicación. Un microservicio es, en sí, también una
funcionalidad que, como tal, habrá que testear de forma específica.

Los microservicios se van a ejecutar en la nube, y por ello hay que
tener en cuenta dos cosas: desde su creación tienen que tener una
forma de recuperar su configuración desde la nube (usando un sistema
de configuración distribuida), y, por otro lado, tienen que integrar
un servicio de log externo que permita también consultar sus
peticiones desde la misma.

Aunque los frameworks de microservicios contienen servidores web
funcionales, en general es aconsejable colocarles algún servidor
adicional para su puesta en producción. Todos los lenguajes de
programación suelen tener interfaces específicos para que haya un buen
acoplamiento entre el microservicio y el servidor que hay por delante,
que además se asegura de que haya un número de copias ejecutándose,
por ejemplo. Finalmente, en muchos casos por delante de él hay un
servidor o proxy inverso genérico tal como `nginx` que, además, es
capaz de servir de forma más eficiente los ficheros estáticos.

## Qué es un microservicio

Un microservicio es una aplicación que es capaz de trabajar de forma
autónoma con una parte del dominio del problema, conteniendo todos los
elementos necesarios para hacer las operaciones básicas sobre el mismo
y todas las funcionalidades que la aplicación requiera del mismo.

Metodologías como
[diseño dirigido por el dominio](https://devexperto.com/domain-driven-design-1/)
nos enseñan a dividir un problema en partes y tomar cada una de esas partes
para convertirla en un microservicio. Los diferentes microservicios trabajarán
con diferentes estructuras de datos y se comunicarán entre sí usando diferentes
interfaces; en general será o peticiones REST, o sockets, o sistemas de
mensajería tales como RabbitMQ o sistemas de mensajería específicos.

En este tema trataremos principalmente de microservicios con un
[interfaz REST](REST).

> No todos los microservicios tienen por qué usarlo. Un microservicio
> puede usar websockets, por ejemplo, o puede dedicarse a ejecutar
> tareas. Nosotros nos concentraremos sólo en estos por el momento.

## Creando un microservicio desde cero

En general, es conveniente no hacer uso de generadores de
aplicaciones, que tendrán una idea determinada de la arquitectura de
la aplicación. Se debe usar un microframework que permita control
sobre todos los aspectos del mismo, y en el caso de un microframework,
tendremos que tener en cuenta, principalmente, los siguientes
aspectos: configuración, rutas y middleware.

### Configuración externa

La
[configuración externa](https://microservices.io/patterns/externalized-configuration.html)
es
uno de los patrones imprescindibles en la creación de aplicaciones
nativas en la nube. Lo principal de la misma es el uso de un servicio
externo para todas las diferentes opciones que haya que usar en cada
uno de las instancias de los servicios que se vayan a usar. También es
parte de la [aplicación de 12 factores](https://12factor.net/config),
que dice que hay que almacenar la aplicación en el entorno. No tiene
que ser necesariamente *las* variables de entorno, claro.

> Hay varios servidores de configuración distribuida, pero el más
> usado es `etcd` (otras alternativas son Zookeeper y Consul). Se
> puede instalar el cliente y servidor directamente de los
> repositorios, y a continuación es conveniente escribir `export
> ETCDCTL_API=3` para que funcione correctamente
> el [cliente](https://etcd.io/docs/v3.4.0/dl-build/).

Con estos sistemas de configuración distribuida, se debe tanto
establecer la configuración (antes de lanzarlo), como leer la
configuración. Y evidentemente, la configuración se tendrá que
almacenar en algún lugar. Por ejemplo, este script en Python (que está
alojado [aquí](https://github.com/JJ/tests-python) servirá para
establecer un valor leyéndolo desde varias fuentes diferentes:

```python
import etcd3
from dotenv import load_dotenv
import os
import sys

def main( argv = [] ):
    PORT_VAR_NAME= 'hugitos:PORT'
    etcd = etcd3.client()
    if ( argv ):
        etcd.put(PORT_VAR_NAME,argv[0])
    else:
        load_dotenv()
        if (os.getenv('PORT')):
            etcd.put(PORT_VAR_NAME,os.getenv('PORT'))
        else:
            etcd.put(PORT_VAR_NAME,3000)



if __name__ == "__main__":
    if len(sys.argv) > 1:
        main(sys.argv[1:])
    else:
        main()
```

Primero, establece el espacio de nombres y nombre de la variable que
vamos a usar, `hugitos`, que ese va a ser el nombre de la
aplicación. Sólo vamos a usar una variable aquí. Se lee en la
siguiente secuencia:

1. Se usa el primer argumento en la línea de órdenes si existe
2. Se lee el fichero `.env` (vía `load_dotenv`). Esa orden pone como
   variable de entorno lo que haya en el fichero; si existe esa
   variable de entorno, se usa.
3. Si nada de eso ocurre, se usa un valor por omisión.

Una vez hecho eso, las variables van a estar obligatoriamente
almacenadas en ese sistema de configuración distribuida. Pero eso
tiene que estar rodeado por un wrapper que se pueda usar en un *mock*
para hacer tests locales.

Esta clase, por ejemplo, encapsula la configuración y la incluye en un
objeto que puede usar cualquier modo de configuración presente:

```python
import etcd3
from dotenv import load_dotenv
import os
import sys


class Config:

    def __init__(self):
        PORT_VAR_NAME= 'hugitos:PORT'
        try:
            etcd = etcd3.client()
            self.port = int(etcd.get(PORT_VAR_NAME)[0].decode("utf8") )
        except:
            load_dotenv()
            if (os.getenv('PORT')):
                self.port = os.getenv('PORT')
            else:
                self.port = 3000
```

De forma que no es realmente necesario trabajar con *mocks*, sino que
se usa el método de configuración que haya presente, empezando, como
es natural, por `etcd`. Si no, se usa configuración local. Los tests
automáticamente usarán la configuración por omisión.

<div class='ejercicios' markdown="1">

Instalar `etcd3`, averiguar qué bibliotecas funcionan bien con el
lenguaje que estemos escribiendo el proyecto (u otro lenguaje), y
hacer un pequeño ejemplo de almacenamiento y recuperación de una
clave; hacer el almacenamiento desde la línea de órdenes (con
`etcdctl`) y la recuperación desde el mini-programa que hagáis.

</div>

### Rutas y middleware

> En este ejemplo usaremos Node; una alternativa está en
> [esta presentación sobre servicios web en Python](https://jj.github.io/tests-python/ws.html),
> en la que se da se da una introducción a los servicios web y cómo
> desplegarlos usando el micromarco de aplicaciones Hug.

Un microservicio se organiza alrededor del concepto de ruta, que a su
vez se organiza desde el concepto de *recurso*. Un recurso es un
objeto autónomo, con un ciclo de vida específico, que se corresponde a
un objeto de tu lógica de negocio, en general. Eso implica que las
rutas describen *objetos*, no acciones. Las acciones se van a expresar
mediante un verbo HTTP, tal como se contó en [REST](REST).

Las rutas, a su vez llaman a funciones, pero entre ellas y la función
que se llama se puede insertar un *middleware*, que son simplemente
*hooks* o llamadas que se producen antes o después de la activación de
una ruta. Este *middleware* se puede usar, por ejemplo, para llevar a
cabo autenticación o simplemente para emitir logs.

### Ejemplo en Python

El proceso será más o menos similar en otros lenguajes. Vamos a llevarlo a cabo
en Python diferenciando de forma explícita la clase y el servicio web
construido sobre ella. Empezaremos con
[esta clase, `HitosIV`](https://github.com/JJ/tests-python/blob/master/HitosIV/core.py),
que describe un hito de esta asignatura. Esa clase se inicializa con un fichero
JSON que estará en otro directorio; esto se hace en el fichero `__init__.py`
que está en el mismo directorio.

Sobre esa clase vamos a construir un microservicio basado en el microframework
[`hug`](https://www.hug.rest), un microframework alternativo al más célebre, que
hace su labor perfectamente.
[Esta](https://github.com/JJ/tests-python/blob/master/HitosIV/hugitos.py) es la
clase, y también el programa principal, que la implementa:

```python
import os
import logging

import hug
from hug.middleware import LogMiddleware

from pythonjsonlogger import jsonlogger

from datetime import datetime

from HitosIV.core import HitosIV

""" Define logger en JSON """
@hug.middleware_class()
class CustomLogger(LogMiddleware):
    def __init__(self):
        logger = logging.getLogger()
        logger.setLevel(logging.INFO)
        logHandler = logging.StreamHandler()
        formatter = jsonlogger.JsonFormatter()
        logHandler.setFormatter(formatter)
        logger.addHandler(logHandler)
        super().__init__(logger=logger)

    def _generate_combined_log(self, request, response):
        """Generate log format.

        Given a request/response pair, generate a logging format similar to the
        NGINX combined style.
        """
        current_time = datetime.utcnow()
        return {'remote_addr':request.remote_addr,
                'time': current_time,
                'method': request.method,
                'uri': request.relative_uri,
                'status': response.status,
                'user-agent': request.user_agent }

""" Declara clase """
estos_hitos = HitosIV()

""" Define API """
@hug.get('/')
def status():
    """Devuelve estado"""
    return { "status": "OK" }

@hug.get('/status')
def status():
    """Devuelve estado"""
    return { "status": "OK" }

@hug.get('/all')
def all():
    """Devuelve todos los hitos"""
    return { "hitos": estos_hitos.todos_hitos() }

@hug.get('/one/{id}')
def one( id: int ):
    """Devuelve un hito"""
    return { "hito": estos_hitos.uno( id ) }

if 'PORT' in os.environ :
    port = int(os.environ['PORT'])
else:
    port = 8000

api = hug.API(__name__)

if __name__ == '__main__':
    api.http.serve(port ) # Usamos la api definida
```

La primera parte de este fichero está destinada a configurar los
registros, que son esenciales en cualquier microservicio. Estos
registros nos permitirán ver y evaluar las peticiones, y también
permitirán monitorizar las prestaciones. Para implementarlos, usamos
el decorador `@hug.middleware_class()`; todos los microframeworks
permiten definir *middleware* que se ejecutarán sin importar qué
petición se haga. De esa forma se establecen mecanismos comunes a
todas las peticiones, uno de los cuales puede ser el logging o
registro.

El API REST y las rutas se crean en `hug` a base de una serie de
decoradores. Definimos varias funciones `get` que *decoran* las
funciones correspondientes de la clase; usamos JSON para devolverlo,
igual que antes, transformado automáticamente por el framework.

En este caso, como en el anterior, el puerto en el que se va a servir
es configurable, aunque tiene un valor asociado por defecto. Como en
el caso anterior, se usa una variable de entorno para hacer esta
configuración.

> Es muy importante que no haya ninguna constante relacionada con el
> despliegue en la configuración. Todas deben estar en un fichero
> `.env` que se puede cargar directamente usando alguna
> aplicación. Este fichero crea una serie de variables de entorno y
> les asigna valores; algo que podemos hacer directamente también a
> mano o, posteriormente, con la capacidad que nos dé el entorno donde
> vayamos a desplegar. Las variables de entorno son imprescindibles
> para configurar en la nube, y siempre se deben usar para cualquier
> posible configuración.

### Ejemplos en node

Se pueden diseñar servicios web en cualquier lenguaje de programación;
pero en este apartado optaremos inicialmente por Node.js/Javascript;
que para diseñar interfaces REST de forma bastante simple, tiene
un [módulo llamado express](https://expressjs.com/). La idea de este módulo
es reflejar en el código, de la forma más natural posible, el diseño del
interfaz REST.

Pero primero hay que instalarlo. Node.js tiene un sistema de gestión de módulos
bastante simple llamado [npm](https://www.npmjs.com/) que ya hemos usado. Tras
seguir las instrucciones en el sitio para instalarlo (o, en el caso de Ubuntu,
instalarlo desde Synaptic o con `apt-get`), vamos al directorio en el que
vayamos a crear el programa y escribimos

`npm install express --save`

en general, no hace falta tener permiso de administrador, solo el necesario
para crear, leer y ejecutar ficheros en el directorio en el que se esté
trabajando. `--save` guarda la dependencia en `package.json` siempre que esté
en el mismo directorio, que convendría que estuviera, así no tenemos que
recordar qué es lo que está instalado.

Tras la instalación, el programa que hemos visto más arriba se
transforma en el siguiente:

```javascript
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
programación. Las órdenes  de `express` reflejan directamente las órdenes de
HTTP a las que queremos responder, en este caso `get` y por
otro lado se pone directamente la función para cada una de ellas. Dentro
de cada función de respuesta podemos procesar las órdenes que
queramos. Dado que JS es un lenguaje asíncrono, la llamada a la
función será también asíncrona.

Por otro lado, se usa `send` sobre el objeto respuesta (`res`) para enviar el
resultado,
[una orden más flexible](https://expressjs.com/en/api.html#res.send) que admite
todo tipo de datos que son procesados para enviar al cliente la respuesta
correcta. Tampoco hace falta establecer explícitamente el tipo MIME que se
devuelve, encargándose `send` del mismo.

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

Con el mismo `express` se pueden generar aplicaciones no tan básicas instalando
[`express-generator`](https://expressjs.com/es/starter/generator.html)

```shell
express prueba-rest
```

> No estamos recomendando que se use express, y mucho menos el
> generador, para tu caso particular, simplemente estamos explicando
> la posibilidad de hacerlo, sólo si `express` es el framework
> adecuado para el problema que se está tratando de resolver, y sólo
> si el código generado se adapta a todas las historias de usuario. En
> general, el caso de uso adecuado de este generador es simplemente
> crear un ejemplo simple que pueda servir de guía para poder trabajar
> con este framework.

Se indica el camino completo a la aplicación, que sería el
puesto. Con esto se genera un directorio prueba-rest. Cambiándoos al
mismo y escribiendo simplemente `npm install` se instalarán las
dependencias necesarias. La aplicación estará en el fichero `index.js`,
lista para funcionar, pero evidentemente habrá que adaptarla a nuestras
necesidades particulares.

Por otro lado, el ejemplo anterior es un simple ejemplo de un servicio web, sin
ninguna funcionalidad. En general, deberemos tener una clase por debajo, que
esté testeada, y que refleje cuál es el verdadero servicio que se está
ofreciendo desde el microservicio. Por otro lado, el acceso a los parámetros de
la llamada y la realización de diferentes actividades según el mismo se
denomina enrutado. En `express` se pueden definir los parámetros de forma
bastante simple, usando marcadores precedidos por `:`.

Por ejemplo, si queremos tener diferentes contadores podríamos usar el
[programa siguiente](https://github.com/JJ/node-app-cc/blob/master/lib/index.js):

```js
var express = require('express');
var app = express();

// recuerda ejecutar antes grunt creadb
var db_file = "porrio.db.sqlite3";
var apuesta = require("./Apuesta.js");
var porra = require("./Porra.js");

var porras = new Array;

app.set('port', (process.env.PORT || 5000));
app.use(express.static(__dirname + '/public'));

app.put('/porra/:local/:visitante/:competition/:year',
    function( req, response ) {
        var nueva_porra = new porra.Porra(
            req.params.local,req.params.visitante,
            req.params.competition, req.params.year
        );
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
introduce otras dos órdenes REST: PUT, que, como recordamos, sirve para crear
nuevos recurso y es idempotente (se puede usar varias veces con el mismo
resultado) y además GET. Esa orden la vamos a usar para crear contadores a los
que posteriormente accederemos con `get`. PUT no es una orden a la que se pueda
acceder desde el navegador, así que para usarla necesitaremos hacer algo así
desde la línea de órdenes:
`curl -X PUT http://127.0.0.1:5000/porra/local/visitante/Copa/2013` para lo que
previamente habrá que haber instalado `curl`, claro. Esta orden llama a PUT
sobre el programa, y crea un partido con esas características. Una vez creado,
podemos acceder a él desde la línea de órdenes o desde el navegador; la
dirección `http://127.0.0.1:5000/porras` nos devolverá en formato JSON todo lo
que hayamos almacenado hasta el momento.

Todas las órdenes definen una *ruta*, que es como se denominan cada
una de las funciones del API REST. Las
[rutas](https://hub.packtpub.com/understanding-express-routes/)
pueden ser simples cadenas (como `/porras` en el caso de `get`) o
incluir parámetros, como en el caso de `put`:
`/porra/:local/:visitante/:competition/:year` incluye una orden al
principio y cuatro parámetros. Estos parámetros se recuperan dentro de
la función *callback* como atributos de la variable `req.params`,
tales como `req.params.local` en las siguientes líneas.

<div class='ejercicios' markdown="1">

Programar un microservicio en express (o el lenguaje y marco elegido) que
incluya variables como en el caso anterior.

</div>


## Probando nuestra aplicación en la nube

Porque esté en la nube no significa que no tengamos que testearla como
cualquier hija de vecina. En este caso no vamos a usar tests
unitarios, sino
[test funcionales](https://en.wikipedia.org/wiki/Functional_testing) (porque
proporcionamos una entrada y comprobamos que las salidas son correctas)o
[*de integración*](https://en.wikipedia.org/wiki/Integration_testing): un API,
generalmente, va a integrar diferentes clases y el testear el API REST
va a ser una prueba de cómo se *integran* esas diferentes clases entre
sí, o como se integran con los servicios que se usan desde las clases;
de lo que se
trata es que tenemos que levantar la web y que vaya todo medianamente
bien. Sin embargo, las funciones a las que se llaman desde un servicio
web son en realidad simples funciones, por lo que hay tanto marcos
como bibliotecas de test que te permiten probarlas.

> Consultad
> [esta pregunta en SO](https://stackoverflow.com/questions/2741832/unit-tests-vs-functional-tests)
> para entender las diferencias entre tests unitarios y de integración o
> funcionales.

Para hacer esas pruebas generalmente se crea un objeto cuyos métodos
son, en realidad, llamadas al API REST. Este objeto tendremos que
primero crearlo desde nuestro "programa principal" que responde a las
peticiones REST, y segundo importarlo desde el test. En el caso de
`express`, se crea un objeto `app`, que será el que usemos aquí.

Los tests podemos integrarlos, como es natural, en el mismo marco que
el resto de la aplicación, solo que tendremos que usar librerías de
aserciones ligeramente diferentes, en este caso `supertest`

```js
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

(que tendrá que estar incluido en el directorio `test/`, como el
resto). En vez de ejecutar la aplicación (que también podríamos
hacerlo), lo que hacemos es que añadimos al final de `index.js` la
línea:

```js
module.exports = app;
```

con lo que se exporta la `app` que se crea; los métodos de ese objeto
recibirán las peticiones del API REST que vamos a comprobar; `require`
ejecuta el código y recibe la variable que hemos exportado, que
podemos usar como si se tratara de parte de esta misma
aplicación. `app` en este test, por tanto, contendrá lo mismo que en
la aplicación principal, `index.js`. Usamos el mismo estilo de test
con `mocha`
que [ya se ha visto](https://jj.github.io/desarrollo-basado-pruebas/)
pero usamos funciones específicas:

* `request` hace una llamada sobre `app` como si la hiciéramos *desde
  fuera*; `put`, por tanto, llamará a la ruta correspondiente, que
  crea un partido sobre el que apostar.
* `expect` expresa qué se puede esperar de la respuesta. Por ejemplo,
  se puede esperar que sea de tipo JSON (porque es lo que enviamos, un
  JSON del partido añadido) y además que sea de tipo '200', respuesta
  correcta. Y como esta es la última de la cadena, llamamos a `done`
  que es en realidad una función que usa como parámetro el callback.

Podemos hacer más pruebas, usando `get`, por ejemplo, pero se deja como
ejercicio al alumno.

Estas pruebas permiten que no nos encontremos con sorpresas una vez
que despeguemos en el PaaS. Así sabemos que, al menos, todas las rutas
que hemos creado funcionan correctamente.

<div class='ejercicios' markdown="1">

Crear pruebas para las diferentes rutas de la aplicación.

</div>

## Microservicios en producción

En general, todos los microframeworks tienen un servidor web que es
usable principalmente para desarrollo. Casi ninguno te aconseja que se
use en producción, y esto por varias razones: si ocurre algún error no
recuperable, el programa dejará de ejecutarse, dejando el servicio
tirado; un microframework, por sí, también es incapaz de controlar que
se está ejecutando un número de procesos de sí mismo simultáneamente o
de mantener el mismo nivel independientemente de que alguno se caiga o
se produzca un error en el mismo; tampoco es capaz de monitorizar las
peticiones para escalarlo y, por último, si se ejecutan varias copias
es necesario también tener un sistema de registro (logs) centralizado
que pueda tratar con todos a la vez. Por eso, en producción, suelen
usarse servidores web que sean capaces de tener en cuenta todo eso.

En la base, sin embargo, muchos lenguajes de programación usan
simplemente **gestores de procesos** que son capaces de ejecutar
varias instancias de un servidor a la vez. Por ejemplo, en node uno de
los más populares es [`pm2`](https://pm2.keymetrics.io/), un gestor de
procesos que permite arrancar, rearrancar y gestionas las diferentes
instancias de un proceso.

Si lo aplicamos al programa de gestión de porras anterior, podemos
arrancarlo simplemente con:

```shell
pm2 start index.js -i 4
```

Lo que arrancará cuatro instancias de nuestro programa y equilibrará la carga
entre las cuatro. Estas instancias serán copias exactas de nuestro programa:
las cuatro escucharán en el puerto que esté definido, que ahora estará
gestionado por `pm2`. Este, además, recordará los números de proceso: para
pararlos, no hay más que escribir:

```shell
pm2 stop index
```

o

```shell
pm2 stop all
```

para parar todos los procesos que gestione. Los logs se almacenan en un
directorio específico y se pueden consultar con

```shell
pm2 logs
```

Hay
[muchos otros gestores de procesos](https://www.tecmint.com/process-managers-for-node-js-applications-in-linux/),
pero esto incluye también el systemd de Linux, un gestor que se puede usar con
éxito en sistemas que lo implementen, como es natural, y que está incluido en
cualquier distribución.

Pero en muchos lenguajes, estos gestores de procesos van un poco más allá, y
tienen un interfaz específico para llamar a las funciones a través de un
interfaz web. Este tipo de interfaz, que se llama genéricamente `*SGI`, de
*services (o server) gateway interface*, se implementa en lenguajes como
Python, Perl y Ruby de diferentes formas. Dado que el ejemplo que hemos hecho
antes es en Python, donde se llama
[WSGI](https://en.wikipedia.org/wiki/Web_Server_Gateway_Interface), o *web
server gateway interface*.

En lenguajes como este, los gestores de de procesos tendrán además un
interfaz WSGI para conectar directamente con las
funciones. Generalmente, el interfaz es un objeto creado
automáticamente por el microframework; en otros casos tendremos que
programarlo específicamente. Estos programas hacen más énfasis en el
hecho de que se tratan de un servidor HTTP con WSGI que con el hecho
de que puedan gestionar diferentes tareas, lo que en todo caso se
puede hacer con una capa por encima.  Por ejemplo, podemos ejecutar el
programa
[anterior](https://github.com/JJ/tests-python/blob/master/HitosIV/hugitos.py)
usando [Green Unicorn](https://gunicorn.org/)

```shell
gunicorn HitosIV.hugitos:__hug_wsgi__ --log-file -
```

(desde el directorio principal). A `gunicorn` se le pasa el nombre del
módulo que va a ejecutar, y, separado por dos puntos, el nombre del
interfaz WSGI que va a llamar dentro de ese módulo. En este caso, se
trata de una función generada automáticamente por Hug; en el caso de
otros microframeworks, tendrá un nombre diferente o habrá que llamarla
a mano. A continuación le indicamos que el fichero de log será la
propia consola, con lo que todo lo que ejecutemos irá directamente
ahí.

> Como la [documentación indica](http://docs.gunicorn.org/en/latest/run.html),
> `gunicorn` llama a la función que se le indica, con el entorno y la
> variable a la que se le añade la respuesta. La podemos escribir
> nosotros si queremos, pero los microframeworks se encargan de
> procesar el contexto y la respuesta de forma que se facilite el resultado.

También podemos ejecutar varios *workers* a la vez:

```shell
gunicorn -w 4 -b 0.0.0.0:31415 HitosIV.hugitos:__hug_wsgi__ --log-file -
```

Y a la vez hacer un *binding* a un puerto y un rango de direcciones
específico, en este caso 4 workers y el puerto 31415. Como este puerto
va a gestionarse por parte de gunicorn, importa relativamente poco el
que hayas puesto en el propio programa; ese se usará en desarrollo (o
cuando lo ejecutemos directamente), este en producción.

En todo caso, cuando se ejecuta `gunicorn` la consola se queda
bloqueada; tampoco te permite arrancar o rearrancar los procesos, o
añadir más workers. De hecho, `pm2` es independiente del proceso que
se ejecute o el lenguaje en el que se esté trabajando, y se puede usar
con [microframeworks en Python](https://stackoverflow.com/questions/53686057/running-gunicorn-flask-with-pm2-doesnt-load-proper-css),
pero para reducir las dependencias, es mejor usar una herramienta que
esté escrita también en Python. Esta herramienta puede ser `fabric`
(de la que se hablará más adelante), pero mientras tanto pm2 es
perfectamente adecuada para ello.

```shell
pm2 start \
    'gunicorn -w 4 -b 0.0.0.0:31415 HitosIV.hugitos:__hug_wsgi__ --log-file -'
```

Aunque, de hecho, se puede ejecutar directamente y se encargará de
gestionar los procesos

```shell
pm2 start -i 4 HitosIV/hugitos.py
```

En resumen: `pm2` es una herramienta excelente, que merece la pena
usar con cualquier programa que necesite ejecutar varias instancias.

<div class='ejercicios' markdown="1">

Experimentar con diferentes gestores de procesos y servidores web
front-end para un microservicio que se haya hecho con antelación, por
ejemplo en la sección anterior.

</div>

> Adicionalmente, la herramienta `systemd` que es común en todos los sistemas
> Linux actuales se puede usar también
> [para gestionar procesos](http://alesnosek.com/blog/2016/12/04/controlling-a-multi-service-application-with-systemd/).
> Como desventaja, aparte de no ser portable a diferentes sistemas operativos,
> es que hacen falta ficheros de configuración específicos por cada uno de los
> servicios.

### Arrancando desde una herramienta común

Dado que hay que realizar diferentes tipos de tareas tales como llevar
a cabo los tests y arrancar un servicio web, resulta bastante
conveniente usar una sola herramienta para que una orden +
`test|start|stop` sea capaz de gestionarlo y de una forma más o menos
estándar. Normalmente las herramientas de construcción o gestores de
tareas como gulp, babel, yarn o grunt pueden encargarse de este tipo de cosas.

Por ejemplo, podemos usar `gulp` con el servidor de porras anterior:

```javascript
const gulp  = require('gulp');
const mocha = require('gulp-mocha');
const pm2   = require('pm2');
var shell = require('gulp-shell');

gulp.task('test', () => (
    gulp.src('test/porra.js', {read: false})
        // `gulp-mocha` needs filepaths so you can't have any plugins before it
        .pipe(mocha({reporter: 'nyan'}))
));

gulp.task('start', function () {
  pm2.connect(true, function () {
    pm2.start({
      name: 'Porra',
      script: 'index.js',
      exec_mode: 'cluster',
      instances: 4
    }, function () {
         console.log('Arranca porra');
         pm2.streamLogs('all', 0);
       });
  });
});

gulp.task('stop', shell.task(['pm2 stop Porra' ]));
```

[`gulp`](https://gulpjs.com/) es un programa para automatizar el
workflow que funciona de forma asíncrona y que permite definir con
código las tareas a realizar. En este caso solo tres tareas: test,
start y stop, y para ello usamos una serie de *plugins* que integran
gulp con utilidades como `mocha` o el shell.

Usando esto, con

```shell
gulp start &
```

se puede arrancar el programa, y con

```shell
gulp stop
```

se detiene, invocando en los dos casos a `pm2`, en el primer caso
usando el API y en el segundo usando directamente una orden lanzada en
el shell.

<div class='ejercicios' markdown="1">

Usar `rake`, `invoke` o la herramienta equivalente en tu lenguaje de
programación para programar diferentes tareas que se puedan lanzar
fácilmente desde la línea de órdenes.

</div>

## A dónde ir desde aquí

En el [siguiente tema](PaaS) veremos cómo hacer efectivamente el despliegue
en la nube.
