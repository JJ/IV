---
layout: index


---
# Material docente para la asignatura Infraestructura Virtual

[![Comprueba README](https://github.com/JJ/IV/actions/workflows/check-readme.yml/badge.svg)](https://github.com/JJ/IV/actions/workflows/check-readme.yml)
|
[![Lint Markdown](https://github.com/JJ/IV/workflows/Lint%20Markdown/badge.svg)](https://github.com/JJ/IV/actions?query=workflow%3A%22Lint+Markdown%22)
|
[![markdown-link-check](https://github.com/JJ/IV/actions/workflows/linkchecker.yml/badge.svg)](https://github.com/JJ/IV/actions/workflows/linkchecker.yml)

[Infraestructura virtual](https://grados.ugr.es/sites/grados/default/public/guias-firmadas/2022-2023/296114N.pdf)
es una asignatura obligatoria de la rama "Tecnologías de la Información" del
primer cuatrimestre del cuarto curso del Grado de Ingeniería Informática y
optativa en otras ramas y en el Doble Grado de Informática y Matemáticas.

La asignatura en el curso 24-25 [se
imparte](https://etsiit.ugr.es/sites/centros/etsiit/public/inline-files/HorariosGII%2824-25%29.pdf)
en el aula 1.3 los viernes de 12:30 a 14:30 (grupo conjunto) y en la
-1.2 los jueves de 8:30 a 10:30 y de 12:30 a 14:30 (grupos
divididos). Se recuerda a los estudiantes que en todas las clases será
necesario llevar el portátil, ya que son siempre clases prácticas; por
lo mismo, se recomienda encarecidamente la asistencia a todas las
clases para realizar las prácticas in situ y que el profesor pueda
ayudarles.

> Las clases de cursos anteriores están grabadas, y puedes acceder a ellas [en
> esta lista de reproducción de
> YouTube](https://www.youtube.com/playlist?list=PLsYEfmwhBQdKIwbMDIwK64pt3Fs03BDz9).
> Conviene que te refieras a ellas *sólo para los conceptos*, no para los temas
> administrativos.

Se usará [GitHub](https://github.com) para el proyecto, la forma principal de
examinar la asignatura; cada una de las entregas representan haber alcanzado
objetivos de aprendizaje, y por lo tanto se denominan *objetivos*.

Los materiales de la asignatura están enlazados desde abajo y
disponibles con una licencia libre. Los fuentes de los mismos están en
[GitHub](https://github.com/JJ/IV).

La temporización de la asignatura y los objetivos de cada sesión figuran en la
[bitácora](https://github.com/JJ/IV-/blob/master/sesiones/README.md) de
clase. Enlazaremos también en ese fichero las grabaciones que se hagan de las
sesiones en vivo.

Estos son los [objetivos de la asignatura](documentos/objetivos.md), cuyas
sesiones de clase se irán reflejando en un repositorio de GitHub.

En resumen, nuestra intención es que el estudiante al final de la asignatura sea
capaz de hacer lo siguiente:

1. Definir el problema, entorno de trabajo y pruebas para desarrollo de una
   aplicación en particular y desplegarlo en un PaaS.
2. Usar ese entorno para configurar integración continua en una aplicación.
3. Crear un entorno virtual para desarrollar y alojar la aplicación y comprenda
   el soporte físico de las técnicas usadas para crear tal entorno virtual.
4. Entienda las técnicas de configuración automática de entornos virtuales y
   las sepa aplicar en los entornos anteriores.
5. Use lo aprendido para despliegue masivo de aplicaciones en la nube.

El *objetivo del proyecto* es que el estudiante se familiarice con la
metodología usada habitualmente en desarrollo de aplicaciones (en la nube y
cualquier otro tipo), por lo tanto, lo importante es que vaya, a través de la
puesta en práctica en un proyecto propio, interiorizando las mejores prácticas
en ingeniería de software.

## Prácticas - Actividades académicas dirigidas en grupos divididos

> Previo a la asignatura, es conveniente
> que [consultes este curso](https://jj.github.io/curso-tdd), con
> material suplementario a lo que se imparte en la asignatura. Los
> temas relevantes se enlazarán en cada hito.

La parte práctica de esta asignatura consiste en la realización de un proyecto a
lo largo de la misma, cubriendo diferentes objetivos de aprendizaje a la vez que
se realizan diferentes productos mínimamente viables de ese proyecto. Los
proyectos [consisten en crear la infraestructura virtual junto con una
aplicación desarrollada según el modelo
DevOps](documentos/proyecto/README). Los objetivos se organizarán de la forma
siguiente.

1. [Objetivo cero: Uso básico de herramientas de desarrollo, problema a
   resolver](documentos/proyecto/0.Repositorio).
2. [Historias de usuario y
   planificación](documentos/proyecto/1.Planificacion).
3. [Modelización del problema](documentos/proyecto/2.Modelo).
4. [Automatización de las tareas](documentos/proyecto/3.Automatizar).
5. [Tests unitarios para la clase/s diseñadas](documentos/proyecto/4.Tests).
6. Técnicas de virtualización: [Contenedores](documentos/proyecto/5.Docker)
   para pruebas.
7. [Integración continua](documentos/proyecto/6.CI).
8. [Servicios esenciales](documentos/proyecto/7.Servicios).
9. [REST](documentos/proyecto/8.REST).
10. [Implementación de REST](documentos/proyecto/9.Microservicio).

En estas prácticas se realizarán una serie de actividades para ayudar
a interiorizar los conceptos.

1. [Juego de rol: empatizar con el cliente para definir un problema](documentos/actividades/juego-rol-design-thinking).

Los objetivos iniciales tienen plazos obligatorios de entrega y superación. El
incumplimiento de esos plazos llevará a la no superación del objetivo *para la
convocatoria ordinaria*. Los números son las semanas máximas en las que habrá
que entregarlo.

| Objetivo | Entrega  | Superación                                    |
| -------- | -------- | --------                                      |
| 0        | 2        | 4                                             |
| 1        | 4        | 5                                             |
| 2        | 6        | 10                                            |
| 3        | 10       | 12                                            |
| 4        | 12       | 15                                            |
| 5        | 15       | Día antes de la fecha de evaluación ordinaria |

La asignatura se considerará superada **si se superan todos los objetivos hasta
el 5**. Si alguno de los objetivos hasta el 5 no se ha superado, pero sí los
siguientes, esta será la tabla de sustitución para que se considere aprobado (en
convocatoria ordinaria o extraordinaria).

| Si no se ha pasado el | Habrá que superar los objetivos |
| --------------------- | ------------------------------- |
| 0                     | 6                               |
| 1                     | 6 y 7                           |
| 2                     | 6, 7 y 8                        |
| 3                     | 6 y 7                           |
| 4                     | 6, 7 y 8                        |
| 5                     | 6                               |

Si no se han superado **dos** objetivos menores o iguales que el 5 en
convocatoria ordinaria o extraordinaria, sean cuales sean, se considera suspenso
en esa convocatoria.

Para la convocatoria extraordinaria se incrementa en **3 semanas** el plazo de
entrega y superación para cada uno de los objetivos, con la fecha de superación
máxima para el objetivo cinco un día antes de la fecha de evaluación
ordinaria. Dado que (como indica la guía docente) la evaluación en esta
convocatoria se hace de la misma forma que en la ordinaria, los plazos para
entrega y superación sólo se mueven con la diferencia entre las dos fechas.

Estas prácticas se han hecho otros años, y se dejan solo a título informativo:

1. [Provisionamiento de máquinas
   virtuales](documentos/proyecto/6.Provision).
2. [Virtualización de aplicaciones](documentos/proyecto/5.IaaS).
3. Sistemas [*serverless*](documentos/proyecto/5.Serverless).
4. [Creando microservicios](documentos/proyecto/6.Microservicio).
5. Desplegando a la nube: [Platform as a Service](documentos/proyecto/7.PaaS)
   en [dos versiones](documentos/proyecto/10.PaaS).

## Material adicional

> El temario está sólo como complemento, porque hay que partir de los objetivos
de aprendizaje semanales y los objetivos a entregar. Esto se ha usado como
material primario antes de 2021, pero ya no se considera material principal y
está, en muchos casos, sin actualizar.

1. [Introducción](documentos/temas/Intro_concepto_y_soporte_fisico):
   conceptos y soporte físico. Esta introducción es *cultura general*; aunque
   conviene conocerlo, no es imprescindible para llevar a cabo, en general, el
   proyecto de la asignatura. Se aconseja vivamente, sin embargo, leerlo y
   llevar a cabo los ejercicios de autoevaluación.
2. [Iniciación a DevOps: desarrollo basado en pruebas](documentos/temas/Desarrollo_basado_en_pruebas).
3. [Usando contenedores](documentos/temas/Contenedores).
4. [Integración continua](documentos/temas/Integracion_continua).
5. Breve introducción a [REST](documentos/temas/REST).
6. [Puesta en marcha de microservicios](documentos/temas/Microservicios).
7. [Platform as a Service](documentos/temas/PaaS).

Estos temas se pueden consultar como material adicional, han dejado de formar
parte del temario de la asignatura:

1. [Introducción e historia de los contenedores](documentos/temas/Intro_contenedores).
2. [Técnicas de virtualización](documentos/temas/Tecnicas_de_virtualizacion).
3. [Aislamiento de recursos](documentos/temas/Aislamiento_de_recursos).
4. [Almacenamiento virtual](documentos/temas/Almacenamiento).
5. [Gestión de configuraciones](documentos/temas/Gestion_de_configuraciones).
6. Computación [*serverless*](documentos/temas/Serverless).

## Seminarios

Material adicional interesante para la asignatura, que se impartirá
(en todo caso) fuera del horario lectivo.

1. [Mini-tutorial de Markdown, por Justo Javier Galera
   (JotaGalera)](documentos/seminarios/MarkDown_tutorial).
2. [Introducción ligera a git](preso/intro-git.html).
3. [Introducción ligera al lenguaje Ruby](documentos/seminarios/ruby).

## Tutorías virtuales

Las tutorías virtuales se realizarán preferiblemente a través del grupo
de Telegram; habrá que solicitar al profesor ser añadido. Finalmente, el
profesor está disponible por Telegram y Google Meet (en todos los
casos: `jjmerelo`); para cualquier videotutoría se pide consultar con cierta
antelación.

## Criterios de evaluación

Los criterios de evaluación figuran en la
[ficha de la asignatura](https://grados.ugr.es/sites/grados/default/public/guias-firmadas/2024-2025/296114N.pdf)
en la web del grado, y
[se especifican en el repositorio de la clase](https://github.com/JJ/IV-/blob/master/Metodolog%C3%ADa_y_criterios_de_evaluaci%C3%B3n.md).

## Convocatoria extraordinaria (AL FINAL DEL CUATRIMESTRE)

Si no se ha superado la asignatura en la convocatoria ordinaria, en la
extraordinaria habrá que entregar los diferentes objetivos del proyecto no
entregados, con fecha tope
el día que se haya anunciado oficialmente para el examen.
