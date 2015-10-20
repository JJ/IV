---
layout: index


prev: Desarrollo_basado_en_pruebas
next: Tecnicas_de_virtualizacion
---

Creando aplicaciones en la nube: Uso de PaaS 
==

<!--@
prev: Desarrollo_basado_en_pruebas
next: Tecnicas_de_virtualizacion
-->

<div class="objetivos" markdown="1">

##Objetivos 


### Cubre los siguientes objetivos de la asignatura

2. Conocer los conceptos relacionados con el proceso de virtualización
tanto de software como de hardware y ponerlos en práctica. 

4. Justificar la necesidad de procesamiento virtual frente a real en el contexto de una infraestructura TIC de una organización.

### Objetivos específicos

5. Comprender los conceptos necesarios para trabajar con diferentes
   plataformas PaaS

6. Aplicar el concepto de *DevOps* a este tipo específico de plataforma.

7. Aplicar el sistema de control de fuentes `git` para despliegue de aplicaciones en la nube.

</div>


Usando un servicio PaaS
-----

Ya se ha visto [en el tema anterior](Desarrollo_basado_en_pruebas)
cómo configurar una aplicación de forma mínima para que se pueda
probar automáticamente en un servicio de integración continua. El que
los servicios funcionen correctamente y que la configuración esté bien
definida es una condición necesaria para que se pueda desplegar en la
nube, por ejemplo en un
[servicio PaaS](http://www.genbetadev.com/programacion-en-la-nube/entendiendo-la-nube-el-significado-de-saas-paas-y-iaas).  

La mayoría de los servicios PaaS están ligados a una pila de
soluciones determinada o a un vendedor determinado. Han surgido
muchos, por ejemplo, en torno a [node.js](http://nodejs.org), un
intérprete de JavaScript asíncrono que permite crear fácilmente
aplicaciones REST.

>Pila que se ha venido en llamar [MEAN](http://mean.io/#!/) y incluye
>también Mongo y Express. 

Algunos servicios PaaS son específicos (sólo alojan una solución
determinada, como [CloudAnt](https://cloudant.com/) que aloja una base
de datos con CouchDB o genéricos, permitiendo una serie de soluciones
en general relativamente limitada; [Heroku](http://www.heroku.com) y
[OpenShift](http://www.openshift.com) están entre estos últimos. 

<div class='ejercicios' markdown="1">

Darse de alta en algún servicio PaaS tal como Heroku,
[Nodejitsu](https://www.nodejitsu.com/), [BlueMix](https://console.ng.bluemix.net/) u OpenShift.

</div>

Estos servicios proveen un número limitado de máquinas virtuales y
siguen en general un modelo *freemium*: las capacidades básicas son
gratuitas y para conseguir mayores prestaciones o un uso más
intensivo, o bien capacidades que no entren en el paquete básico, hay
que pasar al modelo de pago.

Las *máquinas virtuales* (que en muchos casos son contenedores)
reciben diferente denominación: se denominan
[*dynos*](https://devcenter.heroku.com/articles/dynos) en Heroku y
simplemente aplicaciones en OpenShift, aunque los *dynos* son mucho
más flexibles que las aplicaciones de OpenShift.

La interacción con los PaaS se hace en general a través de una
herramienta de línea de órdenes que permite, para empezar, crear
fácilmente a partir de una plantilla una aplicación básica con las
características definidas; en ambos casos habrá que descargar una
aplicación libre para llevar a cabo ciertas tareas como monitorizar el
estatus y hacer tests básicos; una vez creado el fuente de la
aplicación el despliegue en la máquina virtual se hace mediante
`git` tal como hemos contado anteriormente, en algunos casos
*recubierto* de alguna comprobación más integrada en la herramienta de
la línea de órdenes que se haya descargado. 

Los lenguajes más habituales en las PaaS son los de scripting, que
permiten crear aplicaciones rápidamente; las bases de datos
disponibles son tanto las clásicas DBMS aunque, con más frecuencia, se
usan las bases de datos NoSQL como MongoDB, Redis o CouchDB.

En cualquier caso, los PaaS suelen tener un panel de control que
permite hacer ciertas cosas como configurar *plugins* o *add-ons*
desde la web fácilmente. Estos suelen seguir el mismo modelo freemium:
diferentes tamaños o instancias son gratuitas o tienen un coste; en
algunos casos cualquier instancia tiene un coste. 


<div class='ejercicios' markdown="1">

Crear una aplicación en OpenShift y dentro de ella instalar
WordPress. 

</div>

<div class='nota' markdown='1'>

Este
[vídeo explica como usar `heroku` para aplicaciones en Ruby](http://www.youtube.com/watch?v=dqAXmratgzE);
en
[este un poco más extenso y hecho por una persona de Heroku](http://www.youtube.com/watch?v=VZgHItD9bAQ)
te explica cómo usarlo. No hay muchos vídeos en español, pero en
[este explica cómo crear una aplicación Django y subirla a Heroku](http://www.youtube.com/watch?v=3k2eg0stnCI)
y
[este es una introducción general con ejemplos de Ruby](https://www.youtube.com/watch?v=ii9G9JMvoXM) 

</div>

## Despliegue en un PaaS

El despliegue en un PaaS es un ejemplo de despliegue básico en la nube
y es en todo similar al despliegue completo, en un IaaS, exceptuando
las partes en las cuales se crean las máquinas virtuales y se
configuran, porque en un PaaS ya está todo configurado. Cuando se
trabaja en un PaaS, normalmente hay que proporcionar este 
script de automatización al mismo para que construya el entorno una
vez desplegado. No se suele trabajar directamente con los ficheros *en
producción*, sino que, para hacerlo de la forma más cercana a como se
va a ejecutar, se copian los ficheros fuentes y el propio PaaS se
encarga de construir la aplicación.

<div class='ejercicios' markdown="1">

Identificar, dentro del PaaS elegido o cualquier otro en el que se dé
uno de alta, cuál es el fichero de automatización de construcción e
indicar qué herramienta usa para la construcción y el proceso que
sigue en la misma. 

</div>

A dónde ir desde aquí
-----

En el [siguiente tema](Tecnicas_de_virtualizacion) usaremos
diferentes técnicas de virtualización para la creación de contenedores
y jaulas que aislan procesos, usuarios y recursos del resto del sistema, creando por tanto máquinas *virtuales*. Previamente habrá que [realizar la
práctica correspondiente a esta materia](../practicas/2.XaaS).

