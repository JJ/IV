<!--@
prev: Contenedores
next: 3.Uso_de_sistemas
-->

Orquestación de contenedores
---

Los contenedores son un ejemplo de máquinas virtuales, pero ya tienen
ciertas características, como el aislamiento y la gestión
independiente, que las asemeja a las máquinas virtuales *reales*. En
un momento determinado puede hacer falta crear una serie de máquinas
virtuales con características determinadas y usar un *script* con
órdenes de `juju` puede llegar a ser un poco molesto. Se hace
necesario que se usen herramientas para crear y configurar estos
entornos.

Estas herramientas se denominan, en general,
[gestores de configuración](http://en.wikipedia.org/wiki/Configuration_management). [Vagrant](http://en.wikipedia.org/wiki/Vagrant_%28software%29)
es uno de ellos, pero también hay otros: Chef, Salt y Puppet, por
ejemplo. 
