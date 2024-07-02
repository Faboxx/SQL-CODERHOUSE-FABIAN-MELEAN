# PRIMERA ENTREGA - CODERHOUSE

**Comisión:** #57190
Alumno: Fabián Meleán.
**Lenguaje utilizado**: [SQL](https://dev.mysql.com/)



# BASE DE DATOS - PEDIDOS DE E-COMMERCE

## Problema:

Nos solicitan a nuestro equipo de desarrollo, una base de datos que pueda administrar todos los pedidos/reserva de la tienda de e-commerce para un manejo óptimo de todas las operaciones y también del retiro take-away por las sucursales.

## Descripción del Problema:

A. Gestión de clientes y pedidos: Desarrollar un registro de la información de los clientes con sus respectivo pedido.

B. Gestión de tipos de pedidos: Desarrollo de tipo de pedido, ya sea porque es un pedido realizado o solamente una reserva del producto sin abonarlo.

C. Gestión de stock: Desarrollo de base de datos, que contenga el stock del depósito de e-commerce.

D. Registro de pedido: Desarrollo de tabla, que pueda guardar toda la información del pedido/reserva, incluyendo la fecha y hora de la reserva, el cliente que la realizó y los productos que terminó cargando en el pedido.

# Descripción de la Base de Datos - Gestión de pedidos del e-commerce.

La base de datos desarrollada, esta hecha para gestionar todos los pedidos que vayan cayendo por el e-commerce con toda su respectiva información, desde el cliente que procesó la compra, como de los productos.



## Tablas:

1 - CLIENTE: 

Registro de información de los clientes.
Atributos: IDCLIENTE, NOMBRE, DNI, TELÉFONO, EMAIL, DIRECCIÓN DE ENTREGA.

2 - PRODUCTOS:

Registro de stock de los productos del depósito del e-commerce.
Atributos: IDPRODUCTO, MODELO, STOCK, PRECIO.

3 - TIPO DE PEDIDO/RESERVA:

Registro de tipo de pedido/reserva.
Atributos: IDTIPOPEDIDORESERVA, TIPO


4 - RETIRO TAKE AWAY:

Registro de almacenamiento de sucursales para retirar los productos.
Atributos: IDSUCURSAL, NOMBRE, DIRECCIÓN, TELÉFONO.

5 - PEDIDOS:

Registro de los pedidos realizados por los clientes.
Atributos: IDPEDIDORESERVA, IDCLIENTE, IDPRODUCTO, IDTIPOPEDIDORESERVA, FECHA.

## DER

Captura del DER una vez montado toda la base de datos en el lenguaje SQL.

<center>
<img src="https://github.com/Faboxx/SQL-CODERHOUSE-FABIAN-MELEAN/blob/main/der.png?raw=true" style="width: 100% ; aspect-ratio:12/9">
</center>

**Hipervínculo al script SQL** [(click aquí)](https://github.com/Faboxx/SQL-CODERHOUSE-FABIAN-MELEAN/blob/main/ecommerce.sql)









