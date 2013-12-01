Una introducción ligera al lenguaje Ruby
===

<div class="objetivos" markdown="1">


Objetivos específicos
--

 * Conocer la historia y origenes de este lenguaje
 * Entender los conceptos principales detrás del mismo
 * Conocer y saber usar la sintaxis 
 * Aprender las estructuras de datos y control principales
 * Instalar y usar bibliotecas
 * Hacer un pequeño programa

</div>


¿Ruby? Pero si es muy fácil
--

Si alguna vez habéis oído hablar de este lenguaje, posiblemente conozcáis [Ruby](http://ruby-lang.org) por [Ruby on Rails](http://rubyonrails.org), un marco
  web que sigue el paradigma MVC (Model, View, Controller) creado alrededor de 2005 que usa Ruby como lenguaje
  subyacente; mucha gente llega a Ruby desde la derecha (el On Rails)
  y se piensan que es como un lenguaje de macros que imita a Python o
    a Perl o a ambos... Pero no es así.

El lenguaje Ruby lo
  creó [`Matz`, Yukihiro Matsumoto](http://www.ruby-lang.org/en/about/), con la intención de que fuera fácil de aprender y se
  pareciera lo más posible a la forma en la que hablan las personas,
  no a cómo las máquinas quieren que hablemos. Y tiene mérito que no
  le haya salido mal del todo, porque las últimas dos veces que
  dijeron eso salió el COBOL y el SQL. Por otro lado, el nombre Ruby
  puede ser un juego de palabras con las perlas de Perl, o quizás
  no. El propio autor dice que es una mezcla de Python (que es
  anterior, pero no mucho) y Perl con un poco de Lisp y Smalltalk
  espolvoreado para que no falte de nada. 

¿Y qué es lo que sale? Pues un lenguaje interpretado, dinámico,
  orientado a objeto, reflexivo, que hasta no hace mucho no era
  demasiado rápido pero que últimamente está experimentando un
  incremento de rendimiento considerable. Ahora mismo va por la
  versión 1.9 (aunque es normal encontrarse instaladas versiones anteriores), pero la 2.0 no está lejos (menos que la 6.0 de Perl,
  seguro). Por supuesto que por lo que más se le sigue conociendo es
  por Ruby on Rails, pero aplicaciones muy populares como Amarok, Vagrant o Sketchup usan
  este lenguaje. Y tú puedes tambien usarlo, si prestas atención y
  haces los ejemplos y actividades de este tutorial, ¿por qué no?

<div class='ejercicios' markdown="1">

Instalar Ruby y usar

    ruby --version

para comprobar la versión instalada. A la vez, conviene instalar también `irb`, `rubygems` y `rdoc`.

</div>

Primer programa
--


Para programar en Ruby necesitas el editor y el intérprete de Ruby propiamente
  dicho. Descárgatelo e instálalo (o haz las dos cosas a la vez), aunque te vendrá bien también
  bajarte `irb`, un intérprete interactivo que te permitirá
  probar cosas sobre la marcha. Servidor usa Emacs como editor, pero
  cualquier otra cosa también servirá, incluso Notepad. Ahora, si
  quieres ir un poco más allá, te puedes
  descargar [un plugin para Eclipse](http://www.ibm.com/developerworks/opensource/library/os-rubyeclipse/) o
  el [RDE, sólo
    para Windows](http://homepage2.nifty.com/sakazuki/rde_en/). 

Ruby es un intérprete, así que no se "ejecuta" desde el menú. El
  ciclo es el habitual en programas para lenguajes interpretados: se
  escribe y se guarda el programa, nos vamos al directorio donde lo
  hemos guardado, si estamos en Linux/Unix lo hacemos ejecutable
  con `chmod +x`, y lo ejecutamos. Pero todavía no podemos
  ejecutar nada, porque no hemos visto ningún programa, así que vamos
  con el primero.

En cuanto al intérprete de Ruby que se puede instalar, hay muchas
  opciones; hay varias implementaciones de Ruby, aunque la más
  popular es la *oficial*, la de Matz (llamada a veces
  MRI). Hay, sin embargo, otras como JRuby (dentro de la máquina
  virtual Java) o
  incluso [YARV o KRI](http://en.wikipedia.org/wiki/YARV),
  que se ha convertido a partir de la versión 1.9 en la "oficial". En
  tu ordenador puede que tengas una u otra, aunque también te puedes
  instalar [cualquier
    otra](http://en.wikipedia.org/wiki/Ruby_(programming_language)#Implementations).

    #!/usr/bin/ruby
    puts "Esto es jauja"

La primera línea es la habitual en lenguajes interpretados: le dice
  al intérprete de órdenes de Linux (y al servidor Apache en Windows,
  también) dónde tiene que buscar el intérprete; así que habrá que
  comprobar que efectivamente se encuentra allí
  escribiendo `which ruby` (sí, en Linux, así que ya no lo
  voy a decir más y asumid directamente que cualquier cosa que diga es
  para Linux a no ser que se diga lo contrario).

  Y la otra no es tan habitual (aunque es como en C, `put
  string`), pero tampoco es que extrañe demasiado. La cadena va
  entre comillas, se usa el cambio de línea para acabar la sentencia,
    y ya está.

Para ejecutarlo se guarda y se hace lo que se ha dicho antes, no
  voy a repetirlo. Y el resultado será el esperado. También pasará lo
  mismo si lo hacemos desde `irb`:

    [jmerelo@leonard ruby-para-impacientes]$ irb
    pirb(main):001:0> puts "esto es jauja"
    esto es jauja
    => nil

Pero Ruby es un lenguaje orientado a objetos, o más bien empotrado
  de objetos: todo es un objeto en Ruby. Así que lo anterior (y algo más) podríamos
  escribirlo de la forma siguiente.

    puts "--" << "Esto es jauja".center(20) << "--"

 Lo que consigue este program es escribir una cadena centrada en
 una línea de 20 caracteres y rodeada por dos guiones
  (`--`). `&lt;&lt;` es el operador de 
 concatenación, que pega una cadena a la siguiente. Pero la 
 parte orientada a objetos está alrededor del 
    `.` .`center` es un método de la 
 clase [String](http://ruby-doc.org/core/classes/String.html), 
 pero como todo es un objeto en Ruby, no hace falta que lo 
 declaremos explícitamente, ya es un objeto de por sí, por lo que
 podemos aplicarle los métodos correspondientes, tales como
 ese. Pasándole el argumento 20, centra la cadena en un espacio de 20
 caracteres:

    usuario@usuario-desktop:~/code$ ./jauja-center.rb
    --   Esto es jauja    --  

También podíamos haber creado el objeto explícitamente, pero
  hubiera sido mucho más clásico:

    jauja = String::new( "Esto es jauja" )
    puts "--" << jauja.center(20) << "--"

En la primera línea vemos un par de cosas: como en otros lenguajes,
las variables en Ruby no tienen ningún tipo de carácter
adicional (en realidad se verán más adelante algunos caracteres, que
    se usan principalmente para resolución de ámbito). Sólo la variable, lo que tiene sentido, porque hace que uno
tenga que escribir menos. Por otro lado, `String` es una
clase, y además una clase estándar, por lo que no hay que decirle al
programa que la incluya ni nada. El método `new` es un
método de clase, con lo que la sintaxis para llamarlo, a diferencia del método de un
objeto, es de cuatro puntos (dos puntos dobles). El contenido de la
variable sigue siendo un objeto, así que se usa de la misma forma que
antes. 

<div class='ejercicios' markdown="1">

Crear un programa en Ruby que imprima los números desde el 1 hasta
otro contenido en una variable. 

</div>

El resto de los tipos de datos se define también de la forma más
lógica; Ruby trabaja bajo el principio de la mínima sorpresa (lo que
muchas veces provoca sorpresa si uno proviene de otros lenguajes, que nos tienen mal acostumbrados), o más bien
de la máxima coherencia: una vez aprendida parte del lenguaje, el
resto es más o menos igual. Por ejemplo, las matrices:

    matriz = ['esto','es',1,'matriz']
    puts matriz.join << " " << matriz.join("-")

Como ocurre en otros lenguajes dinámicos como el Ruby, no hay
distinción de tipos: una matriz puede contener números enteros,
cadenas e incluso otras matrices, y desde su creación son objetos de
pleno derecho, pudiéndosele aplicar métodos como `join` que
une todos los elementos de la matriz, con o sin algún carácter de por
medio. Este pequeño programa imprimirá:

    usuario@usuario-desktop:~/ruby-para-impacientes$ code/matriz.rb
    estoes1matriz esto-es-1-matriz

como, imagino, era de esperar. 

No son los únicos tipos de matrices: las matrices asociativas son
  aquellas que usan una clave para acceder a cada uno de los elementos
  (en vez de hacerlo en secuencia), sumamente útiles para evitar la
  distribución de la información de una estructura de datos por
  múltiples matrices y su acceso fácil usando una clave

    sonido_de = { :vaca => 'muuu',
	  :buho => 'uuu',
	  :caballo => 'iiiii' }
    puts sonido_de.inspect


Que, aparte de introducir las llaves (para claves... ¿lo ves como se
	  trata de no sorprender?) pone unos dos puntitos delante de
	  las mismas que la verdad que sí sorprenden. Y es porque se
	  trata de cadens un poco especiales, denominadas
	  *símbolos*. Los símbolos en Ruby son como cadenas con las que
	  no se va hacer nada de lo que se suele hacer con las mismas:
	  ni partirlas, ni añadirles nada, ni quitarles nada. Unas
	  cadenas constantes, más o menos, que no es otra cosa lo que
necesitamos en una variable asociativa,
	  denominada [Hash](http://ruby-doc.org/core/classes/Hash.html)
	  en Ruby. Por supuesto, se puede usar una cadena normal y
	  corriente como clave:

	  precio_de = { "pipas" => 'bajo',
	  "coche" => 'depende',
	  "plan E" => 'exagerado' }
	  puts precio_de.to_s

que al ejecutarse, por usar `to_s` para convertir a una
	  cadena la matriz asociativa en vez del inspect anterior no
se ve nada, pero es otra forma de hacer las cosas. `to_s` es también
	  un ejemplo de *casting*: convierte cualquier tipo (que use
	  ese método, claro) en una cadena. Ruby es un lenguaje con
	  tipificación fuerte, aunque dinámica: se le asigna tipo
	  dinámicamente a las variables, pero una vez asignado sólo se
	  pueden llevar a cabo las operaciones de ese tipo o bien se
	  les aplica las operaciones de una forma determinada: `+`
	  actúa como concatenación para cadenas y como suma para tipos
	  numéricos. 

<div class='ejercicios' markdown="1">

¿Se pueden crear estructuras de datos mixtas en Ruby? Crear un array
de hashes de arrays e imprimirlo.

</div>

Como los arrays y hashes son objetos, también se usa normalmente un
método para recorrerlos, como en el ejemplo siguiente:

    zipi = { :foo => 'bar', 
      :baz => 'quux'}

    zipi.keys().each do |zape|
      puts zipi[zape]
    end

`keys()` recorre las claves del hash y la función `each` ejecuta un
					       bloque. Cómo funciona
					       esto exactamente se
					       verá más adelante, pero
					       por lo pronto se puede ver la sintaxis en
					       la que se declara `zape` como variable de
					       bucle. Esa variable *recibe* cada valor,
					       equivalente a la variable de bucle
					       clásica. Si hacemos `each` sobre la
					       variable directamente recorrerá las claves
					       y los valores, escribiéndolas como las
					       cadenas que son.
						   
<div class='ejerccios' maridown='1'>

Recorrer una estructura compleja exhaustivamente, imprimiendo todos los datos.

</div>


Leyendo y escribiendo
--

Tratándose de un lenguaje orientado a objetos, habrá que buscar la
  clase para abrir y cerrar ficheros, que se llama en un alarde de
  originalidad `File`.


	fh = File::new( ARGV[0] )
	while (line = fh.gets ) 
		nombre, apellidos  = line.split(',')
		puts "* Nombre #{nombre}\n\tapellidos #{apellidos}"
	end

En este caso, tampoco es sorprendente la matriz que se usa para
acceder a la línea de comandos: `ARGV`, igual que en C (pero en
mayúsculas) o en Perl (pero sin dólares). Ya puestos, introducimos
también una esctructura de control: el bucle `while` que
va leyendo línea a línea con `gets` (lo contrario
que `puts`, que es para escribir). El cuerpo del bucle no
usa llaves, sólo la indentación y la palabra `end` para indicar el
final. 

Fijaros también en una cosa curiosa: el `=` de la primera línea
  tiene a la izquiera y a la derecha una matriz: dos variables a las
  que se le asigna lo que queda al partir (`split`) la línea del
  tipo `nombre, apellidos` por la coma que lo
  divide. Simplemente se ponen a la izquierda las variables a las que
  van a ir a parar los diferentes elementos de la matriz. Y en la
  línea siguiente se imprime la salida, interpolando las cadenas
  usando algo para distinguirlas: `#{}`. Como las variables
  no tienen ningún símbolo delante, hace falta eso al menos para saber
  que se trata de variables, y no de parte de la cadena. El
  resultado es el esperado:

    $ ruby code/fichero.rb code/nombres.txt
    * Nombre Ginés
	apellidos  Ibn Hassan Rodríguez
    * Nombre Sergei
	apellidos  Ben Ayoun
    * Nombre Malika
	apellidos  Maliki
    * Nombre Juan
	apellidos  Gómez Gómez

al menos sobre el fichero

    Ginés, Ibn Hassan Rodríguez
    Sergei, Ben Ayoun
    Malika, Maliki
    Juan, Gómez Gómez</pre>

Para leer de una web se tienen que usar módulos externos, que, como es
natural, están también organizadas en clases, y clases están
organizadas jerárquicamente en espacios de 
  nombres. `Net`, por ejemplo, agrupa diferentes funciones
  relacionadas con la red: web , FTP, y todas esas cosas; dentro de
  esa jerarquía, los descendientes se separan con `::`,
  igual que en
  Perl. [Net::HTTP](http://augustl.heroku.com/blog/ruby-net-http-cheat-sheet)
  serviría para leer cosas de la web. Pero no forma parte del núcleo o
  *core*, así que tendremos que importarla explícitamente con
  `require`:

    require 'net/http'
    Net::HTTP.get_print  'osl.ugr.es', '/'

En `require` cambia un poco la sintaxis: se separan las partes de la
librería con `/` y se pone todo en minúsculas. `require`
importa el código, pero no los identificadores; por eso para usar
alguna función del módulo hay que decir todo el nombre de la misma:
nombre de la clase `nombre_del_método`. `get_print` es un método
  de clase, y recibe como argumentos el nombre del servidor (el HTTP
  va de soi) y la dirección dentro de ese servidor, en este caso el
  directorio raíz. Al ejecutarlo nos dará de resultado un mogollón de
  texto, todo lo que haya en la página. De camino, conviene fijarse
  que aquí nos hemos ahorrado unos cuantos paréntesis, lo que,
sinceramente, me ha sorprendido.

Juntando todo lo anterior, y añadiendo alguna cosilla más de
  nuestra cosecha, podemos bajarnos una página web y
  meterla en un fichero

	require 'net/http'

	url = ARGV[0]
	puts "La url es " << url
	respuesta = Net::HTTP.get  url, '/'
	fname =  "#{url}.html"
	if ( File.writable?(fname) ) 
		salida = File.new fname, "w"	    
		salida.puts( respuesta )
	else
		puts("No puedo escribir en #{fname}")
	end

Nuestra cosecha incluye una interrogación y un `if`, que no
  habíamos visto antes. La interrogación se usa en los métodos que
  devuelven un valor lógico, verdadero o falso (valores que tienen un
  tratamiento diferente en Ruby y en otros lenguajes: un valor lógico
  es un valor lógico, no un 0 o una cadena nula). En este caso, si se
  trata o no de un fichero sobre el que tengamos derechos de escritura
  (en lo que, al parecer, es un poco peculiar este Ruby). El bloque
  `if` termina en `end`, como antes el bucle. Además, hemos usado "w"
  como segundo argumento de $File.new$ para abrirlo para
  escritura. Como se ve, no hace falta cerrarlo. Pa qué, si ya sabe
  hacerlo el ordenador. 
  
<div class='ejerccios' maridown='1'>

1. Almacenar un array en formato JSON en un fichero cuyo nombre se pase por línea de órdenes. 

</div>

Bloques
----

Después de las variables uno de los conceptos importantes en Ruby
  son los bloques. Un bloque es una secuencia de código con sus
  propias variables, y en Ruby se denota por
  llaves `{}` o por `do` - `done`. Se usa, por ejemplo, para bucles tales como los siguientes.

	host = ARGV[0]
	partes = host.split(".")
	partes.each do |p|
		puts "* #{p}"
	end

En este mini-programa le pasamos un nombre de servidor en internet
	(del tipo subdominio.dominio.tld) y nos da cada una de sus partes,
	que se guardan precisamente en una variable que se llama así. Pero
	el truco está en la tercera línea: `partes.each` es una función
	que recibe un bloque como argumento. También lo podríamos expresar
	de la forma siguiente: 
	
	host = ARGV[0]
	partes = host.split(".")
	partes.each { |p|
		puts "* #{p}"
	}

y sería exactamente lo mismo (salvo la precedencia, pero eso no nos importa ahora). 

Los bloques tienen todos la misma estructura: al principio se
  declara una variable, que será la variable que irá tomando los
  valores que reciba de su función uno por uno. En este caso la hemos
  llamado `p`, pero es un nombre arbitrario, porque estamos haciendo
  una declaración. Dentro ya del bloque metemos el código que
  consideremos necesario, y lo finalizamos con llaves o end,
  dependiendo de cómo lo hayamos comenzado

Lo que ocurre con los bloques en Ruby es que tienen entidad
  propia. Son como funciones anónimas (es decir, funciones que no
  tienen asignado un nombre), y de hecho se pueden usar como
  tales; además, como todo en Ruby, son objetos, o sea que podemos
  crearlos y pasarlos por ahí como queramos. 

	prefijos = %w( pre post ante super macro mega)
	prefijadores = Hash.new
	prefijos.each { |p|
		prefijadores[p] = lambda { |post| return "#{p}#{post}";}
	}

	puts prefijadores['macro'].call( 'objetivo' )
	puts prefijadores['super'].call( 'chanchi' )
	puts prefijadores['mega'].call( 'chuli' )
   
En este ejemplo hemos empezado definiendo una matriz de forma
abreviada: usando `%w` para ahorrarnos comas y comillas, y
hemos seguido creando un `Hash` (matriz asociativa) donde vamos a
guardar todas las funciones. Recorriendo el array creado y usando
`lambda` creamos una función que tiene una parte fija, `p` que recibe
del bucle, y una parte variable, `post`, que es el argumento que
recibirá cuando se llame, tal como se hace abajo usando `call`
(recordad que es un objeto, y para ejecutar esa función hay que llamar
al método `call` de ese objeto). La
función `prefijadores['macro']` se comportará de la misma
forma que si la hubiéramos definido así

	def prefijador( post ) 
		"macro#{post}";
	end

	puts prefijador('micro');

la única diferencia es que en este caso no hace falta usar `call` para
llamar a la función: se puede usar directamente el nombre de la
misma. De camino, vemos como se definen funciones en Ruby: usando
también `def`. Igual que antes, salvo que ahora damos un nombre al
bloque, lo que le da más derechos, al parecer.


<div class='ejercicios' markdown="1">

1. Crear una serie de funciones instanciadas con un URL que devuelvan
algún tipo de información sobre el mismo: fecha de última
modificación, por ejemplo. *Pista*: esa información está en la
cabecera HTTP que devuelve

</div>

Instalando nuevos módulos


Qué sería de cualquier lenguaje si tuviéramos que conformarnos con
  lo que nos da, y no pudiéramos instalar cosas nuevas... El usar
  repositorios centralizados de módulos o bibliotecas lo comenzó
  LaTeX con CTAN, luego siguió Perl con CPAN, y Ruby tiene su
  colección de gemas para poder bajártelas cómodamente. Sin embargo,
  hace falta instalar paquetes para usarlo, no se instala
  automáticamente junto con el
  intérprete. En Ubuntu habrá que instalar el paquete `rubygems`, y
  en otras distros hacer cosas más complicadas (o no). La manera más
  general es [bajarse
    el paquete de Rubyforge e instalarlo](http://docs.rubygems.org/read/chapter/3), tampoco es demasiado
  complicado. Afortunadamente, a partir de la versión 1.9 (que a fecha
  de 2013 ya empieza a aparecer en las distros) vendrá incluida.

Aparte de `gem`, hay que instalarse alguna cosa más, porque muchos
  módulos en Ruby necesitan herramientas de construcción
  adicionales. En concreto, la versión `-dev` del paquete
  Ruby que tengamos instalado. Por ejemplo, en alguna versión de Ubuntu habría que
  escribir 
  
    sudo apt-get install ruby1.8-dev

No siempre es necesario, pero si te da un error algún módulo típico,
  posiblemente sea por eso.

Una vez instalado todo eso, no hay más que usarlo. Empezamos por
  buscar algo que queramos instalar:

    jmerelo@sheldon:~/public_html/tutoriales/ruby-para-impacientes$ gem search mysql
    *** LOCAL GEMS ***

Joeves, no devuelve nada. Pero claro, es que busca en la colección
  local de gemas. Habrá que buscar en la remota:

	jmerelo@sheldon:~/public_html/tutoriales/ruby-para-impacientes$ gem search --remote mysql

	*** REMOTE GEMS ***

	activerecord-jdbcmysql-adapter (0.9.6)
	activerecord-mysql-adapter-flags (0.0.3)
	dbd-mysql (0.4.4)
	do_mysql (0.10.1)
	...

Y así hasta un mogollón de cosas. Tendremos un listado de todas las
  disponibles, y todas las versiones. Vamos a instalarnos la tercera;
  si queremos que esté disponible para todos los usuarios tendremos
  que lanzar la orden con privilegios de administrador:

    jmerelo@sheldon:~/ruby-para-impacientes$ sudo gem install ruby-mysql
Successfully installed ruby-mysql-2.9.2
1 gem installed
Installing ri documentation for ruby-mysql-2.9.2...
Installing RDoc documentation for ruby-mysql-2.9.2...
Could not find main page README
Could not find main page README
Could not find main page README
Could not find main page README

En algunos casos puede que dé error, porque falte alguna
  dependencia que haya que instalar desde el sistema operativo; en ese
  caso, es conveniente instalar el paquete correspondiente, en vez de
  hacerlo desde $gem$. Si no es la ultimísima versión luego se puede
  actualizar con gem update. Por ejemplo, un paquete de mysql se puede
  instalar con `sudo apt-get install libdbd-mysql-ruby`;
  posteriormente, al hacer `gem update` se actualizará
  alguna de las librerías dependientes que se han instalado con el
  paquete (en mi caso, sólo una denominada $deprecated$)

<div class='ejercicios' markdown="1">

1. Ver si está disponible Vagrant como una gema de Ruby e instalarla.

</div>



Referencias adicionales
--


 Como es de esperar, hay libros enteros gratuitos sobre
    Ruby: [Programming Ruby](http://ruby-doc.org/docs/ProgrammingRuby/), por ejemplo, pero el más curioso
    es [la guía intensa de Ruby por Why](http://mislav.uniqpath.com/poignant-guide), con cómics, vericuetos inefables,
    pero que finalmente termina enseñando bastante. 
Como seguramente conoces otro lenguaje de programación, prueba 
	[Ruby
	desde otros lenguajes](http://www.ruby-lang.org/es/documentation/ruby-from-other-languages/), con tutoriales en inglés y español
      que explican cómo trabajar  con Ruby si se conoce Perl, o Java,
	o Python.

En español se puede
  mirar [este tutorial de
  Ruby](http://rubytutorial.wikidot.com/), bastante completo,
  o [este resumen](http://rubytutorial.wikidot.com/ruby-15-minutos) para aprender en sólo 15 minutos. 

Cuando ya estés harto de
  Ruby,[también
    puedes aprender un poquico de Ruby on Rails](http://www.maestrosdelweb.com/editorial/rubyonrails/), ya puesto. 


