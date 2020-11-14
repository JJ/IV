---
layout: index


prev: REST
next: Microservicios
---

# Serverless computing

<!--@
prev: REST
next: Microservicios
-->

<div class="objetivos" markdown="1">

## Objetivos

### Cubre los siguientes objetivos de la asignatura

- Conocer las diferentes tecnologías y herramientas de virtualización
  tanto para procesamiento como para comunicación y almacenamiento.
- Entender los conceptos necesarios para diseñar, implementar y
  construir una aplicación sobre infraestructura virtual.
- Documentar, administrar, mantener y optimizar la infraestructura
  virtual de una aplicación.
- Saber aplicar diferentes tecnologías relacionadas con la
  virtualización al diseño de aplicaciones en infraestructura virtual:
  DevOps, contenedores, microservicios, serverless, integración y
  despliegue continuo y saber aplicarlos en la definición por software
  de la infraestructura y despliegue de una aplicación.

### Objetivos específicos

1. Entender los casos de uso de la tecnología *serverless* en el
   concepto de una aplicación virtual.

2. Aplicar el concepto de *DevOps* a este tipo específico de plataforma.

3. Aprender prácticas seguras en el desarrollo de aplicaciones en la nube.

</div>

## Introducción

Se denomina
[*serverless* computing](https://en.wikipedia.org/wiki/Serverless_computing),
o también Lambdas o FaaS (*Functions as a Service*) a un modelo de
computación en la nube en la cual se virtualiza una unidad mínima de
ejecución: una sola función. En este tipo de modelo, se despliega una
sola función, que se puede activar de diferentes formas, pero por
omisión con una llamada tipo REST. La función se *activa* durante su
ejecución, y, como en programación funcional, puede no tener efectos
secundarios, sino simplemente produce una salida, aunque puede usar
sistemas de almacenamiento en la nube para recibir contexto (tales
como autenticación u otro tipo de configuración) o depositar los
resultados también de la misma forma.

Este modelo tiene una activación rápida, y al ser sólo una función, no
suele durar más de unos segundos. El coste se cobra de forma mucho más
precisa que en otros modelos de la nube, por milisegundos de
activación.

Casi todos los servicios en el cloud ofrecen este tipo de funciones:
[AWS Lambda](https://aws.amazon.com/es/lambda/),
[Cloud Functions for Firebase](https://firebase.google.com/docs/functions),
o
[Azure functions](https://azure.microsoft.com/es-es/services/functions). Todos
ellos ofrecen una serie limitada de *runtimes*, que ejecutan
diferentes lenguajes de programación, pero no todos (como sucede en
otras plataformas). Por esta razón también suelen tener un *tier*
gratuito bastante amplio, con alrededor de un millón de invocaciones.

Aparte de estos grandes jugadores en la nube, hay otras empresas
como [Vercel](https://vercel.com) que tienen también este tipo de
estructura, también con un +tier* gratuito bastante amplio y
herramientas específicas tanto para desplegar como para testear
localmente los
despliegues;
[Netlify](https://docs.netlify.com/functions/build-with-go/#synchronous-function-format)
también
ofrece un servicio similar, enfocado a JamStack principalmente, pero
que permite alojar funciones, aparentemente en Node o Go (aunque
teóricamente funciona sobre AWS Lambda, así que posiblemente pueda
usar la gama completa de runtimes que se usan ahí. Finalmente,
[Back4App](https://back4app.com) lleva la
filosofía serverless hasta el extremo, permitiendo desplegar código
sólo en el cliente, provisionando en el servidor todos los servicios
que hagan falta para desplegar una
aplicación. [Catalyst](https://www.zoho.com/catalyst/use-cases.html)
(que antes se llamaba Parse) de Zoho aparentemente va por el mismo
camino.

> Los lenguajes más habituales suelen ser Node, Ruby, Python y Go. En
> algunos casos puede haber también Java o C#. Otra razón para probar
> Go, que ademas se usa regularmente para los clientes de estos
> servicios.

Dada esa naturaleza de limitación de recursos y de lenguajes, y
también desacoplamiento del resto de una aplicación, los caso de uso
de las funciones serverless son bastante específicos, pero eso no
evita su uso generalizado dentro de las arquitecturas en la nube. Por
ejemplo, los usos siguientes.

- Prototipado rápido de rutas en
  un [microservicio](Microservicios). Abstrayendo adecuadamente la
  lógica de negocio y el acceso a datos, se pueden probar si algunas
  funciones trabajan adecuadamente.
- [*Single Page Applications*](https://es.wikipedia.org/wiki/Single-page_application)
  pueden basar su backend totalmente en este tipo de
  servicios.
  [Vercel, por ejemplo](https://vercel.com/guides/deploying-react-with-vercel-cra)
  contiene ejemplos para diferentes tipos de frameworks con una sola
  página de front-end. De forma similar, se puede usar en
  arquitecturas de tipo [JamStack](https://jamstack.org/).
- Parte de una arquitectura que los incluya junto con otro tipo de
  servicios en contenedores o nodos, siempre que se trate de alguna
  parte de la aplicación relativamente independiente que se beneficie
  de este tipo de estructura de coste.
- Hay servicios que son capaces de ligar eventos a *endpoints*, como
  por ejemplo Telegram; cada vez que sucede un evento se hace una
  llamada; en este caso, si uno es capaz de integrar toda la lógica de
  negocio en una sola función, ésta puede actuar como un bot de
  Telegram sin necesidad de ninguna otra cosa; en general, cualquier
  función puede actuar como *webhook* de cosas como GitHub o cambios
  en una base de datos online.

Adicionalmente, en estas funciones no hay que preocuparse por el
escalado: se invocan simultáneamente todas las veces que se necesite,
teniendo en cuenta el costo, como es natural.

Los sistemas serverless permiten desplegar páginas completas, pero por
supuesto también sólo APIs. Lo veremos a continuación.

<div class='ejercicios' markdown="1">

Darse de alta en Vercel y Firebase, y descargarse los SDKs para poder
trabajar con ellos localmente.

</div>

## Funciones como servicio

Conceptualmente, lo que se despliega en un sistema serverless es una
única función. Esta función recibirá, en general, tres cosas:

- Una petición completa HTTP.
- Un handle a la respuesta, para que se pueda escribir en ella.
- En algunos casos un objeto con contexto adicional.

A diferencia del caso de los contenedores, en cada caso el layout de
lo que se despliegue. Vamos a ver como ejemplo una función en Vercel
(antiguo Zeit), que permite desplegar aplicaciones completas. Para
trabajar con él es mejor descargarse el CLI y dejar que te ayude a
crear un ejemplo. Trabajemos con uno básico, con una sola función, y,
como suele suceder aquí, si frontend. [El proyecto completo está en el
repo `JJ/vercel-cuantoqueda-go`](https://github.com/JJ/vercel-cuantoqueda-go/),
incluyendo ejemplos adicionales. Pero la función principal está en el
directorio `api` y se llama `cuantoqueda.go`.

```go
package handler

import (
    "fmt"
    "net/http"
    "time"
)

type Hito struct {
    URI  string
    Title string
    fecha time.Time
}

var hitos = []Hito {
    Hito {
        URI: "0.Repositorio",
        Title: "Datos básicos y repo",
        fecha: time.Date(2020, time.September, 29, 11, 30, 0, 0, time.UTC),
    }, // más hitos como este

}

func Handler(w http.ResponseWriter, r *http.Request) {
    currentTime := time.Now()
    var next int
    var queda time.Duration
    for indice, hito := range hitos {
        if ( hito.fecha.After( currentTime ) ) {
            next = indice
            queda = hito.fecha.Sub( currentTime )
        }
    }
    if ( next > 0 ) {
        fmt.Fprintf(w, queda.String())
    } else {
        fmt.Fprintf(w, "Ninguna entrega próxima" )
    }
}
```

Esta función está activada (en un endpoint que en este momento puede
esta o no activado) y las partes esenciales que tiene, aparte del
nombre, es las dos
variables que recibe. La respuesta se va a escribir en `w` como si se
tratara de un fichero; como se ve en las últimas líneas, eso es lo que
va a recibir quien la llame. Y `r` es la petición; en realidad no la
usamos en este caso, porque no necesitamos parámetros, pero contiene
el contexto completo, cabecera y cuerpo, que se puede usar,
efectivamente, para recibir un argumento que se mapeará a la salida.

> Para desplegar esta función, se puede conectar el repositorio a
> Vercel o bien simplemente ejecutar `vercel` en el directorio raíz
> del repo. Previamente se puede usar `vercel dev` para hacer un
> despliegue en local y testearla.

Las funciones que se desplieguen de esta forma se deben testear, como
cualquier otra función. Para ello es mejor desacoplar la lógica que
recibe la petición y la escribe de la lógica que ejecuta la
función. En este caso no se ha hecho, pero en general sí se debe
hacer. De esa forma se puede testear localmente todo lo que se vaya a
ejecutar.

<div class='ejercicios' markdown="1">

Tomar alguna de las funciones de prueba de Vercel, y hacer despliegues
de prueba con el mismo.

</div>

Al poder conectarse con otros APIs, estas funciones como servicio
pueden "cerrar el bucle" y convertirse en soluciones completas, por
ejemplo
en
[este bot de Telegram](https://dev.to/jj/create-a-serverless-telegram-bot-using-go-and-vercel-4fdb),
que es una adaptación del programa anterior. Aparte de lo necesario
para interpretar las estructuras de datos que envía Telegram y crear
el JSON que, a su vez, admite, lo importante en esa función
es
[esta línea](https://github.com/JJ/vercel-kekeda/blob/6d5f8e0fb29c7fcbb264c06c17b8244bd4a80450/api/kekeda_iv.go#L102),
que establece que, como se ha explicado en [el capítulo que habla de
las peticiones REST](REST), la respuesta va a tener un tipo MIME
determinado. Desde el punto de vista de la arquitectura, es
interesante que se cambia un tipo de arquitectura *pull* (es decir,
que va interrogando periódicamente a un punto de contacto de Telegram)
por un tipo de arquitectura *reactiva* que solo se "despierta" cuando
efectivamente sucede un evento que necesita algún tipo de
procesamiento; en caso contrario, simplemente no existe (y por tanto
no hace ningún tipo de gasto).

## Usando parámetros

Evidentemente, lo interesante en estas funciones es poder usar
parámetros para hacer diferentes llamadas. Como se ha mostrado en el
tema de [REST](REST), esos parámetros forman parte de la petición
HTTP y por tanto están accesibles para la función.

Como ejemplo de este tipo de peticiones,
usaremos [Netlify](https://netlify.com). Netlify sigue un enfoque muy
parecido a Vercel; las funciones las despliega directamente en AWS
Lambda, así que, en principio, se puede usar cualquiera de esos
runtimes. Los ejemplos, sin
embargo
[se fijan sobre todo en Go y Node](https://functions-playground.netlify.app/).

Nosotros usaremos node para crear un API que agregue los datos de
contagios
de
[COVID](https://www.juntadeandalucia.es/institutodeestadisticaycartografia/badea/operaciones/consulta/anual/38842?CodOper=b3_2314&codConsulta=38842)
de los distritos sanitarios de Granada y devuelva, por omisión, los
datos de la última semana, o bien los datos de la semana del año en
curso que se le pase. Esta es la función:

```node
const data = require("./data" )

exports.handler = async event => {

  var weeks = {};
  for ( element in  data.data.data ) {
    const data_piece =  data.data.data[element];
    const week = data_piece[0].des;
    const cod = data_piece[1].cod[0];
    if ( !( week in weeks ) ) {
      weeks[week] = {};
    }
    weeks[week][cod] = data_piece[3].val? Math.round(parseFloat(data_piece[3].val)) : 0;
    if ( "total" in weeks[week] ) {
      weeks[week]['total'] +=  weeks[week][cod];
    } else {
      weeks[week]['total'] =  weeks[week][cod];
    }
  }

  const when = event.queryStringParameters.when || 'last';
  var result = 0;
  var week_keys = Object.keys(weeks);
  if ( when === "last" ) {
    result = weeks[ week_keys[ week_keys.length -1 ] ].total;
  } else if ( when in weeks ) {
    result = weeks[ when ].total;
  }

  return {
    statusCode: 200,
    body: result.toString(),
  }

}
```

Explicaremos a continuación cómo se extraen los datos; esos datos
tienen que procesarse para ponerse en un hash que usa como claves el
índice de la semana.

Esta línea:

```node
  const when = event.queryStringParameters.when || 'last';
```

es donde se extraen los parámetros de llamada. En el caso anterior se
recibían dos parámetros, la petición y donde había que escribir los
datos de salida. En este caso, sólo la petición. Los datos que se van
a devolver son los que la función devuelva. Con esa variable tendremos
o bien el valor `last` o una semana; en cualquier caso extraemos el
total calculado en las líneas anteriores.

Al devolverlo:

```node
return {
    statusCode: 200,
    body: result.toString(),
  }
```

hay que tener en cuenta que el `body` sólo puede tener el formato de
una cadena, no se admite JSON ni se serializa automáticamente a
JSON. Se puede enviar JSON, como es natural, pero sin poder establecer
la cabecera con el tipo MIME correspondiente, aparentemente. En todo
caso, el
resultado
[se puede ver aquí](https://affectionate-yonath-bf645c.netlify.app/.netlify/functions/covid-and).
Como se ve, la ruta con la que se accede a esta función es
`.netlify/functions/covid-and`, lo que viene determinado por el mismo
Netlify y el nombre del fichero (que será `functions/covid-and.js`).

Para desplegarlo, hay que dar de alta el repositorio en Netlify y
añadir
este
[fichero](https://github.com/JJ/netlify-covid-and/blob/main/netlify.toml) en
el raíz, en formato [TOML](https://toml.io).

> TOML corresponde a Tom's Obvious, Minimal Language y es una
> alternativa a otros lenguajes de serialización que se usa en
> diferentes sistemas cloud, sobre todo los ligados al lenguaje Go. Se
> parece a los ficheros INI, pero permite definir pares clave-valor de
> forma jerárquica, y añadir metadatos a las mismas.

```toml
[build]

  functions = "./functions"
```

Con esto únicamente se le indica que las funciones se encuentran en
ese directorio, y se usa para compilar y desplegar la función de forma
definitiva.

> Sólo una pequeña referencia a cómo se obtienen los datos. Haciendo
> uso de un modelo de despliegue continuo, se usa
> una
> [GitHub action](https://github.com/JJ/netlify-covid-and/blob/main/.github/workflows/descarga.yml)
> para
> generar el fichero `data.js` que se importa. Esa *action* se activa
> tanto cuando se hace push o PR como periódicamente cada día, para
> actualizar a los datos de la última semana. Es decir, se
> auto-despliega cada día de forma que la función tenga los últimos
> datos subidos; este es un ejemplo de despliegue continuo, y también
> de cómo se desacopla la obtención de los datos del servicio de los
> mismos, de forma que sea mucho más rápido para el usuario, y sobre
> todo determinista, el acceso a los datos que ha solicitado.

<div class='ejercicios' markdown="1">

Tomar alguna de las funciones de prueba de Netlify, y hacer despliegues
de prueba con el mismo.

</div>

## Ver también

Una
biblioteca, [`serverless`](https://github.com/serverless/serverless),
permite trabajar de forma común con los diferentes servicios, con una
línea de órdenes que permite también desplegar en estos
servicios. [OpenWhisk](https://openwhisk.apache.org/) te permite
tener, en tu propio ordenador (o nube), una plataforma serverless en
la que desplegar tus funciones en muchos lenguajes diferentes,
incluyendo Rust.

## Bibliografía y otros recursos

Algunos recursos a los que puedes acceder desde la
[Biblioteca de la UGR](https://biblioteca.ugr.es):

- [Beginning Serverless Computing Developing with Amazon Web Services,
  Microsoft Azure, and Google Cloud](https://granatensis.ugr.es/permalink/34CBUA_UGR/1p2iirq/alma991013959706004990).
  Me consta que los libros de [APress](https://apress.com) son de
  calidad, y este al menos tiene un enfoque para principiantes y con
  diferentes plataformas serverless.
- [Serverless Web Applications with React and Firebase: Develop
  real-time applications for web and mobile platforms](https://granatensis.ugr.es/permalink/34CBUA_UGR/1p2iirq/alma991014333329504990).
  Al menos cubre un framework común y una plataforma accesible. Sin
  embargo, poco concepto general, supongo.

