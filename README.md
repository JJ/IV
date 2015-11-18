#Material docente para Infraestructura Virtual


[Infraestructura virtual](http://grados.ugr.es/informatica/pages/infoacademica/guias_docentes/espti/infraestructuravirtual)
es una asignatura obligatoria de la rama Tecnologías de la Información del primer cuatrimestre del cuarto del Grado
de Ingeniería Informática.

La asignatura se imparte en el curso 2015-2016 [los miércoles  de 10:30 a
12:30 en la 1.5 y tiene tres grupos de prácticas los martes, miércoles y viernes en la -1.2 (a partir del 19 de octubre)](http://etsiit.ugr.es/pages/calendario_academico/horarios1516/horariosgii1516/!/download). Se usará
[GitHub](http://github.com) para las prácticas y trabajo final. Estos son los [objetivos de la asignatura](documentos/objetivos.md), cuyas sesiones de clase se irán reflejando en [un repositorio de GitHub; este es el de 2015-2016](https://github.com/JJ/IV-2015-16). 

Las aulas y horarios de los grupos de prácticas son los siguientes:

* Martes de 9:30 a 11:30, aula 3.10 (hasta el 20 de octubre), -1.2 (a partir de esa fecha).
* Miércoles de 8:30 a 10:30, aula 3.10 (hasta el 20 de octubre), -1.2 (a partir de esa fecha).
* Viernes de 9:30 a 11:30, aula 2.9 (hasta el 19 de octubre), -1.2 (a partir de esa fecha).

En resumen, mi intención es que el alumno al final de la asignatura sea capaz de hacer lo siguiente: 

1. Definir el entorno de trabajo y pruebas para desarrollo de una aplicación en particular y desplegarlo en un PaaS.
2. Usar ese entorno para configurar integración continua en una aplicación.
3. Crear un entorno virtual para desarrollar y alojar la aplicación y comprenda el soporte físico de las técnicas usadas para crear tal entorno virtual.
4. Entienda las técnicas de configuración automática de entornos virtuales y las sepa aplicar en los entornos anteriores.
5. Use lo aprendido para despliegue masivo de aplicaciones en la nube. 

Temario - Programa de la asignatura
------------------------------------------------------

Los materiales de la asignatura están enlazados desde aquí y
disponibles con una licencia libre. Los fuentes de los mismos están en
[GitHub](http://github.com/JJ/IV). La
[temporización de la asignatura y los objetivos de cada sesión figuran en la bitácora de clase](https://github.com/JJ/IV-2015-16/blob/master/sesiones/README.md). 

1. [Introducción: conceptos y soporte físico](documentos/temas/Intro_concepto_y_soporte_fisico.md).
2. [Iniciación a DevOps: desarrollo basado en pruebas](documentos/temas/Desarrollo_basado_en_pruebas.md).
2. [Platform as a Service](documentos/temas/PaaS.md).
3. [Usando contenedores](documentos/temas/Contenedores.md).

5. [Uso de sistemas de virtualización](documentos/temas/Uso_de_sistemas.md).
6. [Gestión de configuraciones](documentos/temas/Gestion_de_configuraciones.md).

Estos temas se pueden consultar como material adicional, pero no forman parte este año del temario de la asignatura:

2. [Técnicas de virtualización](documentos/temas/Tecnicas_de_virtualizacion.md).
4. [Aislamiento de recursos](documentos/temas/Aislamiento_de_recursos.md).
4. [Almacenamiento virtual](documentos/temas/Almacenamiento.md).

Seminarios
---------------

Material adicional interesante para la asignatura, que se impartirá fuera del horario lectivo.

1. [Introducción ligera al lenguaje Ruby](documentos/seminarios/ruby.md). 
2. Visita a las instalaciones de Trevenque el día 21 de octubre.


Prácticas - Actividades académicas dirigidas
-------------

Las prácticas consisten en la realización de un proyecto a lo largo de
la asignatura, con diferentes hitos cuyo contenido corresponde a los objetivos de aprendizaje
cumplidos hasta ese momento. Los proyectos
[consisten en crear la infraestructura virtual de una aplicación desarrollada según el modelo DevOps](documentos/practicas/README.md). A
grosso modo, los hitos se organizarán de la forma siguiente. 

1. [Organización de los grupos de práctica y creación del proyecto](documentos/practicas/1.Infraestructura.md)
2. [Integración continua en el repositorio](documentos/practicas/2.CI.md)
3. Desplegando a la nube: [Platform as a Service](documentos/practicas/3.PaaS.md).
4. Técnicas de virtualización [Contenedores para pruebas](documentos/practicas/4.Docker.md).
4. [Virtualización de aplicaciones.](documentos/practicas/4.Aplicaciones.md).

Tutorías virtuales
----

Las tutorías virtuales se realizarán preferiblemente a través de
[la plataforma de trabajo colaborativo GitHub](https://github.com/JJ/IV-2015-16/issues?state=open). Hay
también una
[lista de correo cerrada para los alumnos de la asignatura](https://groups.google.com/forum/#!forum/iv-ugr-2015)
que se puede usar para todo lo que no quepa en la anterior (preguntas
administrativas, principalmente). Finalmente, el profesor está
disponible por Telegram, Skype y Google Hangouts (en todos los casos: `jjmerelo`)
previa cita.

Criterios de evaluación
---

Los
[criterios de evaluación figuran en la ficha de la asignatura en la web del grado](http://grados.ugr.es/informatica/pages/infoacademica/guias_docentes/espti/infraestructuravirtual),
y
[se especifican en el repositorio de la clase](https://github.com/JJ/IV-2015-16/blob/master/Metodolog%C3%ADa_y_criterios_de_evaluaci%C3%B3n.md).

##Convocatoria de septiembre

Si no se ha superado la asignatura en la convocatoria ordinaria, la
extraordinaria consistirá en un examen escrito en septiembre que
puntuará sobre *8 puntos*, siendo el resto proporcional a la nota
obtenida en junio. El examen incluirá tanto preguntas de desarrollo
como ejercicios prácticos en los que se tendrá que esbozar un
programa, script o fichero de configuración o indicar cómo se
resolvería un problema con las técnicas aprendidas en la
asignatura. Se aconseja al alumno que haga los ejercicios de
autoevaluación para alcanzar los objetivos de aprendizaje que se
exigen tanto en junio como en septiembre. El método para preguntar
dudas será el mismo que en la convocatoria ordinaria: lista de correo
e issues de GitHub. 
