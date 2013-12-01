Virtualización del almacenamiento
===

<!--@
prev: Contenedores
next: Gestion_de_configuracion
-->

<div class="objetivos" markdown="1">

Objetivos
--

### Cubre los siguientes objetivos de la asignatura

* Conocer las diferentes tecnologías y herramientas de virtualización
  tanto para procesamiento, comunicación y almacenamiento. 
  
 * Configurar los diferentes dispositivos físicos para acceso a los
  servidores virtuales: acceso de usuarios, redes de comunicaciones o
  entrada/salida
  
 * Diseñar, implementar y construir un centro de procesamiento de
   datos virtual.
   
 * Realizar tareas de administración en infraestructura virtual.
 
 ### Objetivos específicos
 
 * Conocer las técnicas de provisionamiento de almacenamiento de datos
   para
   máquinas virtuales.
   
 * Saber usar diferentes órdenes y utilidades para crearlas.
 
 
 </div>
 
 La parte verdadera: un disco físico.
 --------
 
 Aunque en principio esté claro que un disco es un disco, en la
 práctica no tiene que ser así. El soporte físico del almacenamiento
 puede ser un disco duro de cualquier formato (rotatorio, SSD), pero
 también una
 [partición](http://en.wikipedia.org/wiki/Partition_%28computing%29)
 de uno, que aparecerá a todos los efectos como un disco físico o lo
 denominado
 [LUN (*Logical Unit Number*)](http://en.wikipedia.org/wiki/Logical_Unit_Number),
 un dispositivo al que se accede usando el protocolo SCSI, un
 protocolo veterano de acceso a discos que permitía conectar varios
 discos cuando nuestro querido SATA sólo podía tener un maestro y un
 esclavo y que se ha licenciado como protocolo para sistemas de discos
 accesibles desde la red, es decir,
 [Storage Area Networks](http://en.wikipedia.org/wiki/Storage_area_network). En
 la práctica, en esta asignatura vamos a usar sobre todo los dos
 primeros pero el segundo se usa en todo centro de datos que se
 precie. 
 
 Cada disco, partición o LUN constituye un volumen físico que tiene
 una serie de bloques llamados *physical extents* (PEs, extensiones
 físicas) y se puede combinar en un [*physical volume group* (PVG,
 grupo de volúmenes físicos)}(http://h30499.www3.hp.com/t5/LVM-and-VxVM/what-is-PVG-Physical-Volume-Group/td-p/4675294#.UpuJG0Pzt4w), de forma que un PE de cada volumen en el PVG se usará de forma combinada a la hora de escribir. 
 
 Esta estructura física se reflejará en la estructura lógica, pero la virtualización lo que hace es transformarla de forma que cada elemento lógico equivalga a uno, varios o ningún elemento físico.  
 
 <div class='ejercicios' markdown="1">
 
 1. ¿Cómo tienes instalado tu disco duro? ¿Usas particiones? ¿Volúmenes lógicos? 
 
2. Si tienes acceso en tu escuela o facultad a un ordenador común para las prácticas, ¿qué almacenamiento físico utiliza? 

3. Buscar ofertas SAN comerciales y comparar su precio con ofertas *locales* (en el propio ordenador) equivalentes.

</div>

