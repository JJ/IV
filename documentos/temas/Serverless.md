---
layout: index


prev: Integracion_continua
next: Microservicios
---

# Serverless computing

<!--@
prev: Integracion_continua
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
despliegues. Finalmente, [Back4App](https://back4app.com) lleva la
filosofía serverless hasta el extremo, permitiendo desplegar código
sólo en el cliente, provisionando en el servidor todos los servicios
que hagan falta para desplegar una
aplicación. [Catalyst](https://www.zoho.com/catalyst/use-cases.html)
(que antes se llamaba Parse) de Zoho aparentemente va por el mismo
camino.

> Los lenguajes más habituales suelen ser Node, Ruby, Python y Go. En
> algunos casos puede haver también Java o C#. Otra razón para probar
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

Esta función está activada
en
[este endpoint](https://vercel-cuantoqueda-go.jjmerelo.vercel.app/api/cuantoqueda)
y las partes esenciales que tiene, aparte del nombre, es las dos
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
