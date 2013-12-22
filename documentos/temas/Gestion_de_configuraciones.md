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
que hay que tener en cuenta a la hora de elegir uno u otro. 

