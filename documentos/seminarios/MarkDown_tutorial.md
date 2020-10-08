# Mini-tutorial de Markdown

MarkDown nació como un lenguaje de marcado que facilita aplicar un cierto formato a un texto plano. Para ello se utilizar distintos caracteres de forma especial.

En un principio MarkDown nació para elaborar textos cuyo destino fuera ser integrados en la web con facilidad y rapidez.

Hoy en día es una forma ágil y sencilla de tomar apuntes, documentar un trabajo o simplemente redactar un texto.

La extensión propia de MarkDown es ".md" y la conversión a PDF se realiza mediante algun pluggin que tengamos en nuestro editor, en mi caso utilizo: "MarkDown to PDF"

## Sintaxis de MarkDown:

### 1. Encabezados(#):

Para integrar un encabezado en nuestro texto utilizamos el caracter "#" al principio de este, pudiendo agregar más almohadillas podemos variar de nivel el encabezado, cuantas más almohadillas más pequeño será el encabezado:

~~~~
# Titulo1
## Subtitulo
### Apartado
....
~~~~

### 2. Cursiva y negrita:

Hay distintas formas de conseguir que nuestro texto se vea en _cursiva_, __negrita__ o ___ambos___, aquí se reflejarán dos de ellas:

~~~~
Cursiva:  _a_ ó *a*
Negrita: __a__ ó **a**
Ambos: ___a___ ó ***a***
~~~~

### 3. Listas enumeradas y no enumeradas:

Para conseguir una lista enumerada basta con agregar un número delante del texto junto a un punto y un espacio:

~~~~
1. Primer Elemento
2. Segundo Elemento
3. Tercer Elemento
~~~~

Se muestra así:

1. Primer Elemento
2. Segundo Elemento
3. Tercer Elemento

Para realizar la lista sin numerar cambiaríamos los números por `*`:

~~~~
*. Primer Elemento
*. Segundo Elemento
*. Tercer Elemento
~~~~

 Obtendríamos como resultado:

 * Primero
 * Segundo
 * Tercero

### 4. Crear enlaces:

Si queremos crear un enlace hacia una una página escribimos esta estructura:

~~~~
[El texto que queremos que se vea](Enlace, por ejemplo: https://google.com)
~~~~

Se vería así:

[Enlace a Google](https://google.com)

### 5. Añadir imágenes:

La estructura para añadir imágenes es similar a la de los enlaces pero añadiendo '!' al principio:

~~~~
![Texto que utilizamos por si no se visualiza la imagen](Ruta que ocupa la imagen
respecto a nuestro archivo .md)

Ejemplo:

![IconoMD](../img/iconMD.png)
~~~~

Y se vería así:

![IconoMD](../img/iconMD.png)

### 6. Escapar caracteres:

Si te estás preguntando cómo se escapan caracteres o como se están creando esos mágicos cuadraditos tan bonitos este es el truco, basta con utilizar: **`** ,(escapar caracteres) o repetir ~ cuatro veces para abrir y cuatro veces para cerrar, viendolo en un ejemplo quedará más claro:

Recuadro:

`~~~~`
Texto que queremos dentro
`~~~~`

Escapar caracteres:

`*`Escapamos la cursiva`*`
