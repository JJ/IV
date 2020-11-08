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

Se
denomina
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
localmente los despliegues.

> Los lenguajes más habituales suelen ser Node, Ruby, Python y Go. En
> algunos casos puede haver también Java o C#. Otra razón para probar
> Go, que ademas se usa regularmente para los clientes de estos
> servicios.

Dada esa naturaleza de limitación de recursos y de lenguajes, y
también desacoplamiento del resto de una aplicación, los caso de uso
de las funciones serverless son bastante específicos, pero eso no
evita su uso generalizado dentro de las arquitecturas en la nube.
- Prototipado rápido de rutas en
  un [microservicio](Microservicios). Abstrayendo adecuadamente la
  lógica de negocio y el acceso a datos, se pueden probar si algunas
  funciones trabajan adecuadamente.
- [*Single Page Applications*](https://es.wikipedia.org/wiki/Single-page_application)
  pueden basar su backend totalmente en este tipo de
  servicios. [Vercel, por ejemplo](https://vercel.com/guides/deploying-react-with-vercel-cra) contiene
  ejemplos para diferentes tipos de frameworks con una sola página de
  front-end.
- 
