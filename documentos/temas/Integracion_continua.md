---
layout: index


prev: Contenedores
next: PaaS
---

# Integración continua

<!--@
prev: Contenedores
next: PaaS
-->

<div class="objetivos" markdown="1">

## Objetivos

### Cubre los siguientes objetivos de la asignatura

- Conocer los conceptos relacionados con el proceso de virtualización tanto de
  software como de hardware y ponerlos en práctica.

### Objetivos específicos

- Entender el concepto de *DevOps*.
- Usar herramientas para gestión de los ciclos de desarrollo de una aplicación
  y entender cuales son estos.
- Aprender a usar integración continua en cualquier aplicación.

</div>

## Introducción

Las herramientas de integración y despliegue continuo tienen como
objetivo realizar una serie de comprobaciones sobre la base de código
como paso previo al despliegue, es decir, transformación del código
para su copia y arranque en el lugar donde se vayan a encontrar
definitivamente.

Hoy en día hay una serie de herramientas de integración continua tanto
privativas (generalmente basadas en la web) como libres. Las
privativas suelen tener un *tier* gratuito para proyectos públicos y
de software libre. Veremos los principales conceptos de las mismas a
continuación.

## Añadiendo integración continua

La integración continua es un tipo de acción que se ejecuta cuando
sucede algún evento en un repo; en general, se tratará de hacer pasar
tests sobre la base de código cada vez que algo se quiera incorporar a
la rama máster. Se habla de *integración continua* en oposición a
ciclos sucesivos de desarrollo, prueba y producción. En la nube, en
general, se usan entornos de desarrollo continuo donde siempre que el
código pasa los tests se incorpora a máster y todo lo que hay en
máster se pasa a producción.

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
[Jenkins](https://www.jenkins.io/). Para usar Jenkins puedes instalarlo en tu
propio ordenador, en un servidor propio o en
[algún servicio en la nube tal como CloudBees](https://CloudBees.com). Sin
embargo, hay otros sistemas como [Travis](https://travis-ci.org) o
[Shippable](https://www.shippable.com/) que podemos usar también desde la nube.
Hay otros muchos, como Circle-CI o AppVeyor, y todos ellos tienen servicios
gratuitos para proyectos open source. Las propias plataformas de hosting de
fuentes tienen su propio sistema de integración continua:
[GitHub Actions](https://github.com/features/actions) o
[GitLab pipelines](https://docs.gitlab.com/ee/ci/pipelines/), por ejemplo.

Los sitios de alojamiento de git como GitLab o GitHub tienen también
un sistema de acciones o *ganchos* que se ejecutan cada vez que sucede
algún evento en el sistema. Como estas acciones son más amplias,
engloban integración continua y se puede, por tanto, incluir en el
propio repo, con la ventaja de poder usar el API del mismo para pasar
algún tipo de tests.

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

```yaml
language: node_js
node_js:
  - "10"
  - "11"
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

Cada web tendrá sus propias órdenes para configurarlo; aunque Travis
es un poco estándar y otros sitios permiten importar la configuración
o usarla con ligeras variantes.

El resultado
[aparecerá en la web](https://travis-ci.org/JJ/desarrollo-basado-pruebas)
y también se enviará por correo electrónico. Y te da también un
*badge* que puedes poner en tu fichero para indicar que, por lo
pronto, todo funciona.

Si el informe indica que las pruebas son correctas, se puede proceder al
despliegue. Pero eso ya será en la siguiente clase.

<div class='ejercicios' markdown='1'>

Configurar integración continua para nuestra aplicación usando Travis o algún
otro sitio.

</div>

Esta configuración es esencial por varias razones: primero, porque nos
permite ser conscientes de todo lo necesario para desplegar nuestra
aplicación, y por tanto es una forma alternativa de describir la
infraestructura virtual. Segundo, porque al crear tests integramos el paso de
control de calidad en el desarrollo. Y, finalmente, porque la
integración continua y los tests correspondientes son un paso esencial
para el despliegue continuo, que se verá más adelante.

### Cachés y "artefactos"

Muchos sistemas de integración continua te permiten guardar parte de
lo hecho en un ciclo de CI para el siguiente usando un sistema de
caché, este sistema lo que hace es que almacena sistemas de ficheros
referenciados por una palabra clave. Se pueden usar tanto para
almacenar los módulos que se hayan instalado, como para resultados
parciales de compilación, o en general lo que se
desee. [Travis](https://docs.travis-ci.com/user/caching/) tiene un
sistema que ayuda a cachear dependencias, permitiendo definir para
ciertos lenguajes lo que se va a cachear, por
ejemplo. Las [GitHub Actions](https://github.com/actions/cache) tienen
una *action* específica para esto, y GitLab CI/CD [también permite
configurar una cache](https://docs.gitlab.com/ee/ci/caching/). En
general, puede ser una alternativa para lenguajes en los cuales la
instalación (y prueba) de las dependencias tarde excesivamente (y por
cualquier razón no se quiera hacer usando contenedores).

Por otro lado, los sistemas de CI/CD en ocasiones pueden producir
*artefactos*, que van desde los ejecutables o bibliotecas compiladas
hasta documentación generada a partir de los fuentes. En cualquiera de
los casos, hay sistemas,
como
[este en Travis](https://docs.travis-ci.com/user/uploading-artifacts/),
[este eh Shippable](http://docs.shippable.com/ci/push-artifacts/)
o
[este en AppVeyor](https://www.appveyor.com/docs/packaging-artifacts/),
que permiten o bien almacenar (de forma temporal) esos artefactos o
subirlos a almacenamiento en la nube, o bien a registros específicos,
si se trata de contenedores Docker, por ejemplo.

### Integración de los sistemas de CI con GitHub/GitLab

Todos los sistemas de integración continua se integran con los
diferentes repositorios de una forma más o menos sencilla, que incluye
habitualmente una autorización por parte del mismo de actuar y tener
ciertos privilegios en tu sistema de control de fuentes.

GitHub va un poco más allá, con
su
[*checks API*](https://github.blog/2018-05-07-introducing-checks-api/).
Este API *llama* a GitHub para indicarle el estado de la integración,
de forma que se puede tener esa información para proceder a otros
pasos en flujos de trabajo de que incluyan más adelante despliegue
continuo, por ejemplo.

Hay pocos sistemas que sigan este API: Travis y por supuesto GitHub
Actions. Estos sistemas son bastante aconsejables, sin embargo,
simplemente por la integración más estrecha con GitHub que permite ver
el resultado en la misma página de GitHub.

Para activar este API, en algunos casos (como Travis) funciona por
omisión; en otros,
como [CircleCI](https://circleci.com/docs/2.0/enable-checks/), hay que
activarlo explícitamente para que funcione. Otros,
como [Cirrus](https://github.com/apps/cirrus-ci), necesitan que se
instale como una aplicación de GitHub.

> Aparentemente,
> [Jenkins](https://www.jenkins.io/blog/2020/07/09/github-checks-api-plugin-coding-phase-1/)
> puede usarlo desde este verano tras un proyecto en el Summer of
> Code. Sin embargo, no es exactamente un API popular por el momento.

## Algunas buenas prácticas

Estos son algunos trucos que te ayudarán a sacarle más provecho a los
diferentes sistemas de integración continua que tengas configurados.

- Los sistemas de CI te deben servir para poder discernir los soportes
  sobre los que puede funcionar tu aplicación. Usa la llamada *matrix*
  para probar diferentes combinaciones de sistemas operativos (y
  versiones del mismo) y versiones del lenguaje que uses.
- Usa contenedores para acelerar los tests, metiendo en ellos todos
  los módulos que se instalarían durante el test, por ejemplo. Sin
  embargo, estos tests deben ser adicionales a los que comprueben
  diferentes sistemas operativos y versiones.
- Aprovecha diferentes sistemas de integración continua para ejecutar
  tests diferentes, si es posible en paralelo. Por ejemplo usa en uno
  un contenedor Docker con la última versión del lenguaje, y en otros
  testea versiones antiguas.
- Usa `[skip ci]` cuando no quieras por cualquier razón que se pasen
  los tests. Tampoco es necesario que hagas push con cada commit,
  puedes agrupar 10, o 12 o los que sean. Cuando termines un conjunto
  de cambios, o al final de una sesión.
- Pon siempre el *badge*. Los badges son importantes.

## A dónde ir desde aquí

Una vez visto todo lo necesario para desplegar una aplicación, se puede pasar a
estudiar los [*PaaS*, plataformas como servicio](PaaS), donde se pueden
desplegar aplicaciones para prototipo o para producción de forma relativamente
simple.

## Bibliografía y otros recursos

Algunos recursos a los que puedes acceder desde la
[Biblioteca de la UGR](https://biblioteca.ugr.es):

- [Python Continuous Integration and Delivery A Concise Guide with Examples](https://granatensis.ugr.es/permalink/34CBUA_UGR/1p2iirq/alma991014068498204990),
  de Moritz Lenz, especializado en Python, pero útil para cualquier lenguaje.

- [Cloud Native Continuous Integration](https://granatensis.ugr.es/permalink/34CBUA_UGR/1p2iirq/alma991014250986604990),
  un poco más genérico.

Esta
[página](http://www.jedi.be/blog/2010/02/12/what-is-this-devops-thing-anyway/)
lista una serie de recursos útiles, incluyendo blogs y canales de IRC, aparte
de diferentes herramientas que deben estar en el carcaj del arquero DevOps,
aunque la mayoría de los enlaces a estos están atrasados (y uno está en chino,
así que no tengo ni idea).
