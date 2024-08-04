Creacion de funciones

USE ecommerce;

-- Función para chequear todos los productos vendidos.

DROP FUNCTION IF EXISTS ecommerce.cantidad_vendida_por_producto;

DELIMITER //

CREATE FUNCTION cantidad_vendida_por_equipo(idproducto INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE cantidad_vendida INT;
    
    SELECT SUM(cantidad) INTO cantidad_vendida
    FROM VENTAS
    WHERE idproducto = idproducto;
    
    RETURN cantidad_vendida;
END //

DELIMITER ;

-- Funcion para contar las compras realizadas por un cliente.

DROP FUNCTION IF EXISTS ecommerce.compras_cliente_total;

DELIMITER //

CREATE FUNCTION compras_cliente_total (idcliente INT, fecha_inicio DATETIME, fecha_fin DATETIME) RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE compras_cliente_count INT;
    
    SELECT COUNT(*) INTO compras_cliente_count
    FROM PEDIDOS
    WHERE IDCLIENTE = cliente_id
    AND FECHA >= fecha_inicio
    AND FECHA <= fecha_fin;
    
    RETURN reservas_count;
END //

DELIMITER ;
