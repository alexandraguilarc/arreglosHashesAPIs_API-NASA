#Se establece conexión a la API de la NASA a fin de descargar fotos de los rovers y filtrar resultados.

# requerimos las gemas necesarias para el consumo de la API.
require 'uri'
require 'net/http'
require 'json'


# Se crea método request que recibirá como parámetro la url a consultar

def request(url_requested)
# el cuerpo del método request tendrá el código asociado para permitir dicha conexión, veamos el cuerpo.
    # Crear la instancia URI con la URL proporcionada
    url = URI(url_requested)
    # Crear una instancia de Net::HTTP para realizar la solicitud HTTP
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true # Se agrega esta línea. .use_ssl es una bandera que pasamos para verificar si está habilitado el protocolo https.
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER # Se agrega esta otra línea, línea de código que posee como contexto el concepto de “hombre en el medio” (Man in the middle). Este concepto consiste en que un agente intercepta datos en el punto medio de conexión entre el cliente y el servidor. Al estar ubicado en ese punto medio puede capturar y hacer hacking de la información que fluye en el proceso de conexión. Para evitar esta vulnerabilidad, debemos cambiar la línea de código a“VERIFY_PEER”. http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    # Crear una solicitud HTTP GET con los encabezados necesarios
    request = Net::HTTP::Get.new(url)
    request["cache-control"] = 'no-cache'
    request["postman-token"] = '5f4b1b36-5bcd-4c49-f578-75a752af8fd5'

    # Realizar la solicitud HTTP y obtener la respuesta. Que retorna el hash con los resultados.
    response = http.request(request)
    JSON.parse(response.read_body)
end


data =
request('https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=100&api_key=W4nJ7craBakppnaCh5kirslp9cjT5REuyecbo9nk')


puts data

#Se crea método build_web_page que recibe el hash de respuesta con los datos obtenidos y construya una página web que hemos llamado index.html

def build_web(data)
    photos = data['photos'].map{|h| h['img_src']}

    index = "<html>\n<head>\n</head>\n<body>\n<ul>"
    photos.each do |photo|
        index += "\n\t<li><img src='#{photo}'></li>"
    end
    index += "\n</ul>\n</body>\n</html>"
    File.write('index.html', index)
end

build_web(data)

#Se crea método photo_count que recibe el hash de respuesta que devuelve un nuevo hash con el nombre de la cámara y la cantidad de fotos. La respuesta recibida luego de su ejecución: [["FHAZ", 4], ["RHAZ", 2], ["MAST", 302], ["CHEMCAM", 14], ["MARDI", 4], ["NAVCAM", 74]]

def photos_count(data)
    data['photos'].map { |h| h['camera']['name'] }.group_by { |h| h }.map { |k, v| [k, v.count] }
  end
print(photos_count(data))