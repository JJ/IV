Arquitecturas software para infraestructura virtual
==

<!--@
prev: Intro_concepto_y_soporte_fisico
next: PaaS
-->

<div class="objetivos" markdown="1">

## Objetivos

### Cubre los siguientes objetivos de la asignatura

1. Conocer los conceptos relacionados con el proceso de virtualización
tanto de software como de hardware y ponerlos en práctica.

4. Justificar la necesidad de procesamiento virtual frente a real en el contexto de una infraestructura TIC de una organización.

### Objetivos específicos

1. Entender la necesidad de infraestructura virtual en un contexto
   moderno de desarrollo de aplicaciones.

2. Asimilar los diferentes conceptos de las metodologías de desarrollo
   enfocadas a infraestructuras virtuales.

</div>

## Servicios web

En general el desarrollo de aplicaciones moderno está basado en la
[separación de intereses](https://es.wikipedia.org/wiki/Separaci%C3%B3n_de_intereses),
de forma que diferentes partes del programa se puedan desarrollar de
forma independiente y sin afectar a cómo se desarrolla el resto de las
partes. Esto, en la práctica, se lleva a cabo en la creación de
una serie de módulos o servicios, cada uno de ellos con un interfaz o API
(*application programming interface*) bien definido, de forma que sea
fácil para los desarrolladores de cada uno de ellos cambiar el código o
refactorizarlo, siempre que el API se mantenga invariable.

La *separación de intereses* más directa es la división entre
*front-end* y *back-end*, o en modelos, vista y controlador, aparte de
otros paradigmas como
la
[programación orientada a aspectos](https://en.wikipedia.org/wiki/Aspect-oriented_programming).

En programación *clásica*, esta separación se llevaba a cabo mediante
el concepto de bibliotecas. Un programa es una colección de
bibliotecas con un programa *principal* que se ejecuta. Cuando este
concepto se trasladó a aplicaciones en red, se empezaron a usar
conceptos como cliente-servidor o *multi-tier*, cuando entre cliente y
servidor hay otras aplicaciones denominadas genéricamente
*middleware*.

Sin embargo, cuando hay múltiples aplicaciones y además deseamos que
cada una tenga sus propios intereses y se ocupe de ellos es cuando
surgen
los [servicios web](https://en.wikipedia.org/wiki/Web_service). Los
servicios web especifican un API accesible mediante el protocolo HTTP
que permite encapsular la lógica de negocio y desarrollar de forma
independiente diferentes partes de una aplicación, partes que se
conectarán entre sí a través de la web usando las medidas de
seguridad, autenticación y autorización que sean convenientes.

Las aplicaciones modernas se basan en la concatenación de servicios
web. Es imprescindible entender el concepto para comprender cómo
funciona el desarrollo en infraestructuras virtuales.

<div class='nota' markdown='1'>

Un
[tutorial de unos 10 minutos sobre servicios Web](https://www.youtube.com/watch?v=KU3V25XABgg).
</div>

Aunque durante muchos años se han usado extensivamente servicios web
basados en protocolos tales como SOAP (*Simple Object Access Protocol*) u [OSGi](https://www.linkedin.com/pulse/20140903145139-12717948-qu%C3%A9-es-osgi), hoy en día se usan
sobre todo los llamados [sistemas RESTful](https://elbauldelprogramador.com/buenas-practicas-para-el-diseno-de-una-api-restful-pragmatica/), que usan exclusivamente
órdenes HTTP estándar y codifican las peticiones en URIs y las
respuestas usando,
generalmente, [JSON](https://es.wikipedia.org/wiki/JSON), un formato
que permite transmitir estructuras de datos generales.

<div class='nota' markdown='1'>

[Un tutorial breve sobre como construir APIs RESTful](https://www.codementor.io/olatundegaruba/nodejs-restful-apis-in-10-minutes-q0sgsfhbd)

</div>

## Marcos RESTful

Las órdenes en un servicio basado en REST se reciben en un servidor
HTTP y consisten en varias partes, el URL que se esté usando, que el
servidor tendrá que decodificar y convertir en una orden, y la
*carga*, generalmente escrita en JSON. En general, tendrán que
decodificarse las dos cosas para interpretar la orden y sus
parámetros, por lo que se suelen usar generalmente bibliotecas,
denominadas *frameworks* o *microframeworks*. Estas bibliotecas se
encargan de activar un bucle que va recibiendo peticiones y
encaminándolas o enrutándolas a las funciones que se encarguen de cada
una de ellas.

Por ejemplo, vamos a crear un pequeño servicio web que sirva los hitos
de la asignatura, basándose en la [biblioteca que los lee de un fichero en JSON](https://github.com/JJ/HitosIV)

A dónde ir desde aquí
-----

A la charla de [servicios web](https://jj.github.io/pilas/#/), por ejemplo.
