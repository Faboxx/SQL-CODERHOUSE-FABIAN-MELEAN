USE ecommerce;

-- IMPORTANTE PARA QUE ENTIENDA QUE DEBE HACER LA IMPORTACION
SET GLOBAL local_infile = true;

-- IMPORTACIÓN DE DATOS DESDE ARCHIVO CSV

LOAD DATA LOCAL INFILE 'data_csv/CLIENTES.CSV'
INTO TABLE CLIENTES
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(IDCLIENTE,NOMBRE,DNI,TELEFONO,EMAIL,DIRECCION_DE_ENTREGA);

LOAD DATA LOCAL INFILE 'data_csv/PRODUCTOS.csv'
INTO TABLE PRODUCTOS
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(IDPRODUCTO,MODELO,STOCK,PRECIO);

LOAD DATA LOCAL INFILE 'data_csv/TIPO_DE_PEDIDO_RESERVA.csv'
INTO TABLE TIPOPEDIDORESERVA
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(IDTIPOPEDIDORESERVA,TIPO);

LOAD DATA LOCAL INFILE 'data_csv/RETIRO_TAKE_AWAY.csv'
INTO TABLE RETIROTAKEAWAY
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(IDSUCURSAL,NOMBRE,DIRECCION,TELEFONO);

LOAD DATA LOCAL INFILE 'data_csv/PEDIDOS.csv'
INTO TABLE PEDIDOS
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(IDPEDIDORESERVA,IDCLIENTE,IDPRODUCTO,IDTIPOPEDIDORESERVA,FECHA);

LOAD DATA LOCAL INFILE 'data_csv/RESENAS.csv'
INTO TABLE RESENAS
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(IDPRODUCTO,IDCLIENTE,CALIFICACION,COMENTARIO,FECHA);

LOAD DATA LOCAL INFILE 'data_csv/HISTORIAL_STOCK.csv'
INTO TABLE HISTORIAL_STOCK
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(IDHISTORIAL_STOCK,IDPRODUCTO,CAMBIO,FECHA,RAZON);

LOAD DATA LOCAL INFILE 'data_csv/DIRECCION_FACTURACION.csv'
INTO TABLE DIRECCION_FACTURACION
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(IDCLIENTE,DIRECCION,CIUDAD,PAIS);



