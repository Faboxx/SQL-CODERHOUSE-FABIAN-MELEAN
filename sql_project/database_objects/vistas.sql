USE ecommerce;

-- View para chequear el flujo de ventas por fecha.

CREATE OR REPLACE VIEW ecommerce.ventas_por_fecha AS
SELECT
    DATE (FECHA) AS Fecha,
    COUNT(*) AS Total_Compras
FROM
    PEDIDOS
GROUP BY
    DATE (FECHA);


-- View de pedidos con detalles de tipo de Pedido y sucursal.

CREATE OR REPLACE VIEW ecommerce.VistaPedidosDetalles AS
SELECT 
    p.IDPEDIDORESERVA,
    c.NOMBRE AS CLIENTE_NOMBRE,
    prod.MODELO AS PRODUCTO_MODELO,
    t.TIPO AS TIPO_PEDIDO,
    r.NOMBRE AS SUCURSAL_NOMBRE,
    p.FECHA,
    p.CANCELACION_PEDIDO
FROM 
    PEDIDOS p
    JOIN CLIENTE c ON p.IDCLIENTE = c.IDCLIENTE
    JOIN PRODUCTOS prod ON p.IDPRODUCTO = prod.IDPRODUCTO
    JOIN TIPOPEDIDORESERVA t ON p.IDTIPOPEDIDORESERVA = t.IDTIPOPEDIDORESERVA
    LEFT JOIN RETIROTAKEAWAY r ON p.IDTIPOPEDIDORESERVA = r.IDSUCURSAL;


-- View de pedidos cancelados.


CREATE OR REPLACE VIEW ecommerce.VistaPedidosCancelados AS
SELECT 
    p.IDPEDIDORESERVA,
    c.NOMBRE AS CLIENTE_NOMBRE,
    prod.MODELO AS PRODUCTO_MODELO,
    t.TIPO AS TIPO_PEDIDO,
    p.FECHA,
    p.CANCELACION_PEDIDO
FROM 
    PEDIDOS p
    JOIN CLIENTE c ON p.IDCLIENTE = c.IDCLIENTE
    JOIN PRODUCTOS prod ON p.IDPRODUCTO = prod.IDPRODUCTO
    JOIN TIPOPEDIDORESERVA t ON p.IDTIPOPEDIDORESERVA = t.IDTIPOPEDIDORESERVA
WHERE 
    p.CANCELACION_PEDIDO IS NOT NULL;

-- View productos con su stock.


CREATE OR REPLACE VIEW ecommerce.VistaProductosStock AS
SELECT 
    p.IDPRODUCTO,
    p.MODELO,
    p.STOCK,
    p.PRECIO
FROM 
    PRODUCTOS p;

-- View clientes con sus pedidos.


CREATE OR REPLACE VIEW ecommerce.VistaClientesPedidos AS
SELECT 
    c.IDCLIENTE,
    c.NOMBRE,
    c.DNI,
    c.TELEFONO,
    c.CORREO,
    c.DIRECCION_DE_ENTREGA,
    p.IDPEDIDORESERVA,
    p.IDPRODUCTO,
    p.IDTIPOPEDIDORESERVA,
    p.FECHA,
    p.CANCELACION_PEDIDO
FROM 
    CLIENTE c
    LEFT JOIN PEDIDOS p ON c.IDCLIENTE = p.IDCLIENTE;

-- View de reseñas en las compras de los clientes.

CREATE VIEW VistaResenas AS
SELECT 
    r.IDRESENA AS IDResena,
    p.MODELO AS Producto,
    c.NOMBRE AS Cliente,
    r.CALIFICACION AS Calificacion,
    r.COMENTARIO AS Comentario,
    r.FECHA AS Fecha
FROM 
    RESENAS r
JOIN 
    PRODUCTOS p ON r.IDPRODUCTO = p.IDPRODUCTO
JOIN 
    CLIENTE c ON r.IDCLIENTE = c.IDCLIENTE;

-- View para ver el historial del stock.

CREATE VIEW vista_historial_stock AS
SELECT 
    hs.IDHISTORIAL_STOCK,
    hs.IDPRODUCTO,
    hs.CAMBIO,
    hs.FECHA,
    hs.RAZON,
    p.MODELO
FROM 
    HISTORIAL_STOCK hs
JOIN 
    PRODUCTOS p ON hs.IDPRODUCTO = p.IDPRODUCTO;

