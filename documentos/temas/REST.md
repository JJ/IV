---
layout: index


prev: Desarrollo_basado_en_pruebas
next: Serverless
---

# REST en breve

<!--@
prev: Desarrollo_basado_en_pruebas
next: Serverless
-->

<div class="objetivos" markdown="1">

## Objetivos

### Cubre los siguientes objetivos de la asignatura

1. Conocer los conceptos relacionados con el proceso de virtualización
   tanto de software como de hardware y ponerlos en práctica.

### Objetivos específicos

1. Entender los conceptos necesarios para diseñar, implementar y
  construir una aplicación sobre infraestructura virtual.
2. Diseñar, construir y analizar las prestaciones de una aplicación en
  infraestructura virtual.
</div>

Los
sistemas
[REST (Representational State Transfer)](https://es.wikipedia.org/wiki/Transferencia_de_Estado_Representacional)
usan la sintaxis y semántica
del protocolo HTTP tanto para llevar a cabo peticiones a un
[microservicio](Microservicios.md) o una función en un
marco [serverless](Serverless.md).

Las *peticiones* HTTP tienen varias partes diferenciadas:

- Una cabecera HTTP, que contiene metadatos sobre la misma;
  codificación,
  [tipo MIME](https://developer.mozilla.org/es/docs/Web/HTTP/Basics_of_HTTP/MIME_types/Common_types)
  que se está enviando, y, sobre todo, *tokens* que permitan al
  autenticación.
- Un
  [comando HTTP como PUT o GET](https://developer.mozilla.org/es/docs/Web/HTTP/Methods),
  que indique qué es lo que se quiere que haga.
- Un
  [URI](https://es.wikipedia.org/wiki/Identificador_de_recursos_uniforme),
  o *uniform resource identifier*, un identificador único de un
  recurso sobre cuyo estado se quiere actuar. Para enviar datos en el
  URI, se usa la
  [*codificación porcentaje*](https://en.wikipedia.org/wiki/Percent-encoding)
  que permite meter todo tipo de información con cualquier
  codificación en la parte `query`(la que sigue al `?`, con estructura
  variable = valor).
- Un *cuerpo*, no siempre presente, que contiene los datos que se
  adjuntan a la petición; estos datos pueden ir añadidos como rutas o
  fragmentos en el URI anterior.

Aunque hay 10 comandos HTTP diferentes, en realidad los que más se
usan son sólo
cuatro. Se
[distinguen](https://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html)
por su *idempotencia* (la repetición de un comando sobre un URI dará
el mismo resultado) y *seguros* (cuando no realizan ningún cambio de
estado).

- `GET` es un comando idempotente y seguro, que recupera el contenido
  de un URI.
- `PUT` es idempotente, pero crea o sustituye el estado del URI que se
  use.
- `POST` no es idempotente ni seguro. Se usa para cambiar o parte de
  un recurso, o para crear un recurso cuyo URI no sabemos de antemano.
- `DELETE` es idempotente, pero no seguro.
- `PATCH` se puede usar
  para
  [cambiar parte de un recurso](https://medium.com/backticks-tildes/restful-api-design-put-vs-patch-4a061aa3ed0b).
  Si queremos hacer un API con separación estricta de
  responsabilidades, se puede añadir este también al mismo.

Lo anterior son convenciones, y lo que se ejecute por omisión
dependerá en realidad de la persona que lo implemente.

> En muchos casos `PUT` y `POST` se usan de forma intercambiable. Son
> muy diferentes, sin
> embargo:
> [aquí se muestran diferencias](https://stackoverflow.com/questions/107390/whats-the-difference-between-a-post-and-a-put-http-request)
> que van desde poder ser cacheables (o no) hasta el significado del URI
> que se vaya a usar. En una petición `PUT`, el URI que se usa es el
> que se va a crear. En un `POST`, es simplemente un punto que va
> manejar la petición. Por eso `PUT` se suele usar para crear (y
> modificar, siempre que la petición contenga la nueva versión)
> mientras que `POST` se puede usar para crear (siempre que sea un URI
> genérico) o modificar parte de un recurso.

La *respuesta HTTP* tendrá una estructura similar, pero incluirá
también
[códigos de estado HTTP](https://developer.mozilla.org/es/docs/Web/HTTP/Status).
Estos
códigos de estado pueden incluir códigos de error, que tendremos que
interpretar desde nuestra aplicación; los códigos 500 (error del
servidor) no serán códigos que podamos tratar, en general, desde
nuestra aplicación, porque indican que ha habido una excepción no
capturada en la misma.

Es conveniente conocer esta estructura general del protocolo HTTP,
porque se aprovechará para escribir APIs que usen su semántica tanto
para las peticiones como para las respuestas. En estas, diferentes
frameworks ofrecerán un API que permitirá trabajar fácilmente con las
cabeceras, los contenidos y los metadatos correspondientes.

## Buenos usos de las peticiones

Hay cuatro formas de enviar información en una petición:

- Mediante la petición en sí, es decir, componiéndolo en un URI.
- Mediante la cabecera HTTP.
- Mediante *queries* añadidos al URI, que no forman parte de él.
- Mediante el cuerpo de la petición.

La decisión de usar unos u otros no es arbitraria, sino que conviene
seguir [una serie de reglas](https://stackoverflow.com/q/25385559/891440). Para
empezar, normalmente ni `GET` ni `DELETE` van a tener nada en el
cuerpo; sólo se usará el cuerpo de la petición en `PUT` y `POST`.

> `PATCH` también tiene sus usos; para ver cuales son, ver más
arriba.

En estos casos, usar el *path* o el body dependerá, principalmente, del
tipo de información.

- Si hace falta simplemente un valor o valores, sin diferentes
  opciones o valores por defecto se puede usar el path, en plan
  `recursos/valor1/valor2`.
- Si hay varias combinaciones variable-valor, algunas de las cuales
  son optativas, se puede usar la parte del URL denominada *query*:
  `recursos/id?variable1=valor1`.
- Finalmente, para tipos de datos más complejos, o simplemente de más
  longitud, es mejor usar el cuerpo de la petición.

La cabecera del mensaje se usará para metadatos: cabeceras específicas
de la aplicación, *tokens* de autenticación y datos que, en general,
no formen parte del propio recurso, pero sirvan para interpretarlo o
para acceder a él.

## Buenos usos de las respuestas

Las respuestas también tienen su importancia, y se deben de configurar
correctamente para que el cliente entienda perfectamente qué es lo que
está recibiendo.

- El contenido estará en JSON, incluso cuando haya que dar algún
  mensaje de error (cuyo contenido principal, por supuesto, se tendrá que dar
  con el status de error correspondiente).
- Las cabeceras se usarán en algunos casos: por ejemplo, devolviendo
  la cabecera `Location` cuando se cree un recurso, con el URI del
  mismo.
- Los tipos MIME serán los correspondientes a lo que se va a enviar;
  si no lo hace por omisión el microframework, habrá que usar, por
  ejemplo, `application/json` para el caso de que sea JSON. Cuando se
  vayan a enviar ficheros, habrá que poner correctamente el tipo
  correspondiente.
- El código de estado debe ser el más adecuado a la respuesta y
  también a la petición, claro. Lo veremos a continuación.

## Buenos usos de los códigos de estado

Hemos visto antes que hay un montón de códigos de estado. En la mayor
parte de los casos, bastará con los código 2XX y 4xx, en concreto los
siguientes.

Los códigos 200 son códigos que indica que la petición ha ido bien,
por lo tanto sólo se deben usar en este caso; si ha habido algún error
o excepción, se deben usar códigos 4xx.

- **200** para una petición correcta. En general, el microframework
  devolverá este estado por ti si no hay nada chungo.
- **201** cuando se haya creado un recurso, cada vez que se use `POST` y
  `PUT`.
- **202**
  significa
  [aceptado](https://restfulapi.net/http-status-202-accepted/). Es
  cuando se ha dado una orden y ha funcionado correctamente, pero su
  efecto puede tardar un poco más; por ejemplo, cuando se ha dado una
  orden de borrado con DELETE.
- **204** o *no content* se devuelve cuando el *body* está vacío a
  propósito, simplemente
  con la intención de que el cliente entienda que toda la información
  está en la cabecera y no necesita leerlo.

Los códigos 4XX sólo se deben usar en caso de que haya habido algún
error y se considera que el cliente debe hacer algo para repararlo.

- **400** sólo se debe usar si el URI o la petición se han construido de
  forma incorrecta.
- **404** es el célebre no encontrado, pero debe usarse sólo cuando el
  recurso al que se refiere el URI no existe.
- **403** ó **401** no autorizado también se puede usar en estos
  casos.  La principal diferencia es que 401 indica que la
  autenticación es posible; si se devuelve 403 está prohibido por
  alguna otra razón.
- **405**,
  [método no permitido](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/405),
  se puede usar en ciertos casos cuando
  se trata de usar un método incorrecto (digamos un POST) sobre un URI
  que sólo admite PUT y GET.
- **409** es un conflicto, y tiene unos usos muy
  específicos.
  [En este artículo](https://dev.to/jj/solving-the-conflict-of-using-the-http-status-409-2iib)
  cuento posibles usos para el mismo.

El código 500 no se debe usar nunca, porque indica que la aplicación
está en un estado incorrecto y no se puede hacer nada al respecto. Hay
una posibilidad, y es que se esté lanzando desde nuestra aplicación
otra aplicación externa, pero en todo caso es mucho mejor si se
detecta un error de este estilo simplemente cesar la aplicación porque
en la mayor parte de los casos no se podrá hacer nada al respecto.

## Buenos usos de los verbos HTTP

Aunque es decisión del usuario de un microframework escoger qué hacer
con cada una de las peticiones, generalmente hay una serie de reglas
para cada uno de ellos, siguiendo [consejos de buenas
prácticas](https://hackernoon.com/restful-api-designing-guidelines-the-best-practices-60e1d954e7c9)
relacionados con su significado implícito. Para ello habrá que tener
en cuenta lo comentado arriba: los que son idempotentes y los que
cambian el estado. Y en todo caso, trabajar siempre con el concepto de
URI.

Los buenos usos dicen que se usa `PUT` cuando se conoce el URI, `POST`
cuando es el propio sistema el que lo va a generar.

## Buenos usos en el diseño de un API

Los APIs se diseñan alrededor del concepto de *recurso*, y el nombre
del recurso deberá ser el prefijo o primera parte en el *path* del URI
correspondiente.  A continuación, generalmente, se usará el ID del
recurso. Si hay parámetros que no se puedan confundir, u opciones que
tengan una sola palabra, se pondrán a continuación en el PATH. El
resto de la información se debe pasar mediante el *query* o en el
cuerpo de la petición.

Lo importante, por tanto, es identificar de qué recursos estamos
hablando. Un API REST puede tener por debajo cualquier tipo de lógica
de negocio: funcional, orientada a objetos o procedural. Sobre esa
lógica de negocio hay que poner una fachada en la cual el recurso sea
el concepto principal. Recursos relacionados entre sí pueden tener
diferentes URIs, pero en las peticiones en las que se usen
conjuntamente deberá seguirse el principio de que los recursos  sean
claramente identificables, y que se use siempre como prefijo el URI
del recurso principal.

Este recurso tendrá que haber sido identificado desde el principio,
usando métodos de diseño dirigido por dominio como los indicados
en [arquitecturas para la nube](Arquitecturas_para_la_nube). De esta
forma queda manifiesta la arquitectura software que se está
implementando.

Por eso es esencial, desde el principio de la implementación de un
sistema, tener claramente identificadas las diferentes entidades que
van a participar en el mismo, porque son decisiones que, a través de
las historias de usuario, van a ir a la lógica de negocio y
eventualmente al API externo (REST o de cualquier otro tipo).

## Ejemplo de diseño de un API y prueba del mismo

Vamos a diseñar un API usando [Starlette](https://www.starlette.io/),
un framework asíncrono en Python, que tiene una forma de crear las
rutas que permite diferenciar claramente entre las mismas y la
aplicación que las sirve. Al servirlas, se podrá hacer con cualquier
tipo de programa que use un interfaz asíncrono. Este API está definido
en [este repo](https://github.com/JJ/tests-python)

> Era un repositorio para practicar TDD con Python, pero me acabé
> viniendo arriba...

En este caso, el *recurso* del que estamos tratando es el `hito`. Por
eso usamos plural en las rutas: `hitos`, y las operaciones están
relacionadas con un URI que identifica, de forma única, un hito.

En este fichero se definen las rutas:

```Python
from starlette.applications import Starlette
from starlette.routing import Route, Router
from starlette.responses import JSONResponse

from HitosIV.core import HitosIV

""" Declara clase """
estos_hitos = HitosIV()

""" Define API """
async def hitos(request):
    """Devuelve todos los hitos o crea uno dependiendo del método"""
    if request.method == "GET":
        return JSONResponse( estos_hitos.todos_hitos() )
    elif request.method == "POST":
        file = str(int( estos_hitos.cuantos() ) + 1)
        return await construyeHito( file, request )

async def construyeHito( file, request ):
    print("Construye hito")
    form = await request.form()
    data = {}
    for i in ['title','fecha']:
        data[i] = form[i]
    data['file'] = file
    estos_hitos.nuevo( file, form['title'], form['fecha'] )
    return JSONResponse( data, status_code=201, headers={ 'Location': f"/hitos/{file}" })

async def unHito( request ):
    """ Crea un hito """
    file = request.path_params["file"]
    print("unHito ",  file, " ", request.method )
    print("unHito ", estos_hitos.uno_por_clave( file ))
    if request.method == "PUT":
        response = await construyeHito( file, request )
        print( "Response ", response )
        return response
    elif request.method == "GET":
        print("unHito ", estos_hitos.uno_por_clave( file ))
        try:
            return JSONResponse(estos_hitos.uno_por_clave( file ))
        except:
            return JSONResponse( { "error": f"No existe {file}" }, status_code=404 )
    else:
        return JSONResponse( { "error": f"Método no implementado {request.method}" }, status_code=405 )

rutas = Router( routes = [
    Route("/hitos/{file}", endpoint=unHito, methods=["GET","PUT"]),
    Route("/hitos", endpoint=hitos, methods=["GET","POST"])
])
```

Empecemos por las últimas líneas, aquí arriba. Starlette permite
definir directamente las rutas, asignándolas a una función que la
procesa, y con los métodos a los que va a responder.

> Es posible que se puedan definir diferentes rutas para diferentes
> métodos, pero en principio no he visto como, así que hay sólo dos
> funciones.

En este caso, el API que definimos tiene un solo sujeto,
correspondiente a una sola entidad o recurso: `hitos`. A
este sujeto se le añade el nombre del fichero donde está almacenado
(que es único). Podemos crear un recursos de dos formas: o bien
poniendo directamente un nombre de fichero y llamando a `PUT` o bien
dejando que `POST` lo haga por nosotros, en cuyo caso simplemente
usará un número que será posterior a los que ya tenemos en el objeto.

Por otro lado, hay dos rutas `GET`. Si no decimos nada, se devuelve el
objeto completo; si se usa como sufijo un ID, se tratará de recuperar
el recurso correspondiente.

Como se ve en el código, se usan los códigos 201 cuando se crea algo,
y adicionalmente se devuelve una cabecera con `Location`, que podemos
usar inmediatamente para recuperar ese recurso. Por otro lado, usamos
404 para no encontrado, y 405 para el caso de que estuviéramos usando
un método que no estuviera implementado (difícil, porque simplemente
no pasaría el filtro de rutas, pero quién sabe lo que se puede
programar).

> Conviene ver que se están creando funciones asíncronas, y así habrá
> que llamarlas. Cuando se usa `await` dentro de una función, se tiene
> que convertir a su vez en asíncrona.

<div class='ejercicios' markdown="1">

Diseñar un API teniendo en cuenta las historias de usuario que se
hayan hecho (u otras inventadas) teniendo en cuenta los principios y
buenas prácticas que se han mostrado arriba.

</div>

## A dónde ir desde aquí

En el [siguiente tema](Serverless.md) veremos cómo se usan estas
cabeceras para estructurar peticiones.
