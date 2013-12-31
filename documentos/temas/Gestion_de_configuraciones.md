Gestión de infraestructuras virtuales
===

<!--@
prev: Uso_de_sistemas
-->

<div class="objetivos" markdown="1">

<h2>Objetivos</h2>

1. Conocer los conceptos relacionados con el proceso de virtualización tanto de software como de hardware. 
2. Justificar la necesidad de procesamiento virtual frente a real en el contexto de una infraestructura TIC de una organización.
3. Conocer las diferentes tecnologías y herramientas de virtualización tanto para procesamiento, comunicación y almacenamiento. 

</div>

Introducción
---

Los [contenedores](Contenedores.md) son un ejemplo de máquinas virtuales, pero ya tienen
ciertas características, como el aislamiento y la gestión
independiente, que las asemeja a las máquinas virtuales *reales*. En
un momento determinado puede hacer falta crear una serie de máquinas
virtuales con características determinadas y usar un *script* con
órdenes de `juju` puede llegar a ser un poco molesto. Se hace
necesario que se usen herramientas para crear y configurar estos
entornos.

Estas herramientas se denominan, en general,
[gestores de configuración](http://en.wikipedia.org/wiki/Configuration_management). [Vagrant](http://en.wikipedia.org/wiki/Vagrant_%28software%29)
es uno de ellos, pero también hay otros: [Chef](http://www.getchef.com/chef/), Salt y Puppet, por
ejemplo. Todos son libres, pero
[tienen características específicas](http://en.wikipedia.org/wiki/Comparison_of_open_source_configuration_management_software)
que hay que tener en cuenta a la hora de elegir uno u otro. En el caso
específico de
[sistemas operativos](http://en.wikipedia.org/wiki/Configuration_management#Operating_System_configuration_management)
se trata de gestionar automáticamente todas las tareas de
configuración de un sistema, automatizando la edición de ficheros de
configuración, instalación de software y configuración del mismo,
creación de usuarios y autenticación, de forma que se pueda hacer de
forma automática y masiva. 

A continuación veremos diferentes ejemplos de sistemas de
configuración, empezando por Chef. En
[temas anteriores](Contenedores.md) hemos visto Juju, un ejemplo de
sistema de configuración también, aunque específico de Ubuntu. 

Usando Chef para gestión de configuración
-----

 [Chef](http://www.getchef.com/chef/) es una herramienta que, en
 general, se usa en un servidor que se encarga no sólo de gestionar la
 configuración, sino también las versiones. Empezar a usarlo
 [es complicado](http://wiki.opscode.com/display/chef/Documentation).
 Sin embargo, como
 introducción a la gestión de configuraciones se puede usar
 [`chef-solo`](http://docs.opscode.com/chef_solo.html), una versión
 aislada que permite trabajar en una máquina desde la misma y que, por
 tanto, se puede usar como introducción y para probar
 configuraciones. 
 
 <div class='nota' markdown='1'>
 
 Hay varios tutoriales que te permiten, con relativa rapidez, comenzar
 a trabajar con Chef-solo en un servidor;
 [este te proporciona una serie de ficheros que puedes usar](http://www.opinionatedprogrammer.com/2011/06/chef-solo-tutorial-managing-a-single-server-with-chef/)
 y
 [este otro es más directo, dando una serie de órdenes](http://www.mechanicalrobotfish.com/blog/2013/01/01/configure-a-server-with-chef-solo-in-five-minutes/). En
 todo caso, se trata básicamente tener acceso a un servidor o máquina
 virtual, instalar una serie de aplicaciones en él y ejecutarlas sobre
 un fichero de configuración
 
 </div>
 
 
