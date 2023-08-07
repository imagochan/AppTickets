# App de Tickets escrita en Flutter

Este proyecto de flutter se conecta al siguiente servidor utilizando APIs para su funcionamiento

- https://github.com/imagochan/ServidorTickets

## Pasos para usar para compilar y usar la app

- Ejecutar "flutter pub get" en la raiz del proyecto en una terminal para obtener todas las dependencias necesarias del proyecto
- El proyecto esta configurado para conectarse de forma local al servidor (server y cliente en el mismo computador) en windows/linux/macos
- Si desea correr la aplicación de forma física en un teléfono o con el emulador de android utilizando un proxy dentro de la configuración del emulador, debe cambiar la URL dentro de la variable "baseUrl" del archivo /lib/api.dart "static const baseUrl = "http://127.0.0.1:2000/api/" a la ip de su computador host, puede consultar esto corriendo el comando "ipconfig" en una consola de comandos de Windows
- Ejemplo de Cambio de IP: 127.0.0.1 => 192.168.0.254
- Pulsar el boton F5 en el teclado para correr el aplicativo en la plataforma deseada
