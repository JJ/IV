Gestión de infraestructuras virtuales
===

<!--@
prev: Uso_de_sistemas
-->

<div class="objetivos" markdown="1">

<h2>Objetivos de la asignatura</h2>

* Diseñar, construir y analizar las prestaciones de un centro de
  proceso de datos virtual. 
  
* Documentar y mantener una plataforma virtual.

* Realizar tareas de administración en infraestructura virtual.

<h2>Objetivos específicos</h2>

1. Aprender lenguajes de configuración usados en infraestructuras virtuales.
2. Saber cómo aplicarlos en un caso determinado.

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
 
 
En una máquina tipo ubuntu, hay que comenzar instalando Ruby y Ruby
Gems, el gestor de librerías  

	sudo apt-get install ruby1.9.1 ruby1.9.1-dev rubygems
	
`chef` se distribuye como una gema, por lo que se puede instalar
siempre como

	sudo gem install ohai chef
	
[ohai](http://docs.opscode.com/ohai.html) acompaña a `chef` y es usado
desde el mismo para comprobar características del nodo antes de
ejecutar cualquier receta.

<div class='ejercicios' markdown='1'>

Instalar chef en la máquina virtual que vayamos a usar

</div>

Una *receta* de Chef
[consiste en crear una serie de ficheros](http://www.mechanicalrobotfish.com/blog/2013/01/01/configure-a-server-with-chef-solo-in-five-minutes/):
una *lista de ejecución* que especifica qué es lo que se va a
configurar; esta lista se incluye en un fichero `node.json`, 
o *recetario* (*cookbook*) que incluye una serie de *recetas* que
configuran, efectivamente, los recursos y, finalmente, un fichero de
configuración que dice dónde están los dos ficheros anteriores y
cualquier otro recursos que haga falta. Estos últimos dos ficheros
están escritos en Ruby. 

Vamos a empezar a escribir una recetilla del Chef. Generalmente,
[escribir una receta es algo más complicado](http://reiddraper.com/first-chef-recipe/),
pero comenzaremos por una receta muy simple que instale el
imprescindible `emacs` y le asigne un nombre al nodo. Creamos el
directorio `chef` en algún sitio conveniente y dentro de ese
directorio irán diferentes ficheros.

El fichero que contendrá efectivamente la receta se
llamará [`default.rb`](../../ejemplos/chef/default.rb)

	package 'emacs'
	directory '/home/jmerelo/Documentos'
	file "/home/jmerelo/Documentos/LEEME" do
		owner "jmerelo"
		group "jmerelo"
		mode 00544
		action :create
		content "Directorio para documentos diversos"
	end

El nombre del fichero indica que se trata de la receta por omisión,
pero el nombre de la receta viene determinado por el directorio en el
que se meta, que podemos crear de un tirón con

	mkdir -p chef/cookbooks/emacs/recipes

Este fichero tiene tres partes: instala el paquete `emacs`, crea un
directorio para documentos y dentro de él un fichero que explica, por
si hubiera duda, de qué se trata. Evidentemente, tanto caminos como
nombres de usuario se deben cambiar a los correspondientes en la
máquina virtual que estemos configurando.

El siguiente fichero, [`node.json`](../../ejemplos/chef/node.json),
incluirá una referencia a esta receta

	{
		"run_list": [ "recipe[emacs]" ]
	}

Este fichero hace referencia a un recetario, `emacs` y dado que no se
especifica nada más se ejecutará la receta por defecto. 

Finalmente, el fichero de configuración incluirá referencias a ambos.

	file_cache_path "/home/jmerelo/chef"
	cookbook_path "/home/jmerelo/chef/cookbooks"
	json_attribs "/home/jmerelo/chef/node.json"
	
Una vez más, cambiando los caminos por los que correspondan. Para
ejecutarlo,

	sudo chef-solo -c chef/solo.rb

(si se ejecuta desde el directorio raíz). Esta orden producirá una
serie de mensajes para cada una de las órdenes y, si todo va bien,
tendremos este útil editor instalado.

<div class='ejercicios' markdown='1'>

Crear una receta para instalar `nginx`, tu editor favorito y algún
directorio y fichero que uses de forma habitual. 

</div>
