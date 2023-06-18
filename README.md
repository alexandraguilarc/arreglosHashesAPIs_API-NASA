# Arreglos, hashes y APIs

### Descripción

Arreglos, hashes y consumo de APIs con Ruby . Se establece conexión a la API de la NASA para descargar fotos de los Rovers y aplicar métodos de filtrado.
- Se hace consumo de una API Rest con autenticación sencilla.
- Se crean métodos que reciben parámetros.
- Se iterarn resultados dentro de un hash y un arreglo.
- Se filtran resultados dentro de un hash y un arreglo.
- Se genera un archivo HTML con los resultados de la consulta a la API.

### Estructura
-  Se crea el método request que recibe una url y retorna el hash con los resultados filtrados. En el parámetro ?sol= aparece el número 1000, se modifico el número a 100 a fin de que el retorno no sea tan extenso.

- Se crea el método build_web_page que se encarga de recibir el hash de respuesta contentivo de todos los datos y contruimos una página web, generando un HTML a partir de los datos obtenidos de la API.

- Se crea el método photos_count que recibe el hash de respuesta y devuelve un nuevo hash con el nombre de la cámara y cantidad de fotos que corresponde a cada una.




![](https://railsware.com/blog/wp-content/uploads/2013/04/API-with-Ruby.png)
