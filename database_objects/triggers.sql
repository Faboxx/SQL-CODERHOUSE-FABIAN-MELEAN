USE ecommerce;

-- Verificación para saber si el email del cliente es único al agregar un nuevo cliente a la base.

DELIMITER //

CREATE TRIGGER ecommerce.cliente_mail;
BEFORE INSERT ON CLIENTE
FOR EACH ROW
BEGIN
    DECLARE correo_count INT;
    
    SELECT COUNT(*) INTO correo_count
        FROM CLIENTE
    WHERE CORREO = NEW.CORREO;
    
    IF correo_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El correo ya fue registrado por otro usuario.';
    END IF;
END //

DELIMITER ;


-- Verificación para no tener errores al momento de la compra por tipeo en el stock del producto.

DROP TRIGGER IF EXISTS ecommerce.max_cantidad_productos;

DELIMITER //
CREATE TRIGGER ecommerce.max_cantidad_productos
AFTER INSERT ON productos
FOR EACH ROW
BEGIN
    -- Colocaremos que la maxima operacion del mismo producto sea como máximo 2.
    IF NEW.cantidad_prodcutos > 2 THEN
        -- Devuelve el mensaje de error
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La cantidad de productos no puede superar las 2 unidades';
    END IF;
END //
DELIMITER ;	



-- Verificación para que tire la alerta de que no se registró el numero de contacto del cliente.

DROP TRIGGER IF EXISTS ecommerce.cliente_tel;

DELIMITER //
CREATE TRIGGER ecommerce.cliente_tel
AFTER INSERT ON cliente
FOR EACH ROW
BEGIN
    -- Verifición de que el campo de teléfono no quede null.
    IF NEW.cliente_telefono IS NULL OR NEW.cliente_telefono = '' THEN
        -- Dispara una alerta con lo que colocaremos a continuación.
        SIGNAL SQLSTATE '01000'
        SET MESSAGE_TEXT = 'El campo no puede quedar vacio.';
    END IF;
END //
DELIMITER ;
