-- Registro de un nuevo producto y asi mismo, obtener el id del mismo.
USE ecommerce;

 DROP PROCEDURE IF EXISTS ecommerce.nuevo_producto;

DELIMITER //

CREATE PROCEDURE ecommerce.nuevo_producto (
    IN modelo VARCHAR(100),
    IN stock INT,
    IN precio INT,
    OUT id_nuevo_producto INT
)
BEGIN
    -- VALOR DEL PARAMETRO DE SALIDA
    SET id_nuevo_producto = -1;

     -- INSERCIÓN NUEVO PRODUCTO
        INSERT INTO   (modelo, stock, precio)
        VALUES (modelo, stock, precio);

        -- OBTENER ID DEL PRODUCTO NUEVO
        SET id_nuevo_producto = LAST_INSERT_ID();
    END IF;
END //


USE ecommerce;

DROP PROCEDURE IF EXISTS actualizar_compra_cancelada_por_correo;

DELIMITER //

CREATE PROCEDURE actualizar_compra_cancelada_por_correo(
    IN p_email VARCHAR(100)
)
BEGIN
    DECLARE cliente_id INT;
    
    -- Obtener el ID del cliente usando el correo electrónico proporcionado
    SELECT IDCLIENTE INTO cliente_id
        FROM CLIENTE
    WHERE CORREO = p_email;
    
    -- Actualizar la compra si el cliente existe.
    IF IDCLIENTE IS NOT NULL THEN
        UPDATE IDTIPOPEDIDORESERVA
        SET CANCELACION = NULL,
            FECHA = NOW()
        WHERE IDCLIENTE = cliente_id
        AND CANCELACION IS NOT NULL;
        
        SELECT 'La compra fue cancelada. ', p_email, ' La base fue actualizada correctamente.';
    ELSE
        SELECT 'No se encontró ningún cliente con el correo electrónico ', p_email, '.';
    END IF;
    
END //

DELIMITER ;
