CREATE PROCEDURE `PL_POA_MANTENIMIENTO_INSERTAR_NUEVA_AREA`(IN `name_` TEXT, IN `typeOfArea_` INT(11), IN `observation_` TEXT, OUT `message_` VARCHAR(150), OUT `Tmessage_` TINYINT)
    MODIFIES SQL DATA
    SQL SECURITY INVOKER
BEGIN START TRANSACTION; IF NOT EXISTS (
	SELECT 
		1 
	FROM 
		area 
	WHERE 
		area.nombre = name_ 
		AND area.id_tipo_area = typeOfArea_
) THEN INSERT INTO area (
	area.nombre, area.id_tipo_area, area.observacion
) 
VALUES 
	(name_, typeOfArea_, observation_); 
SET 
	message_ = "La nueva área ha sido ingresada exitósamente."; 
SET 
	Tmessage_ = 1; ELSE 
SET 
	message_ = "La área que quiere ingresar ya existe."; 
SET 
	Tmessage_ = 0; END IF; COMMIT; END$$


CREATE PROCEDURE `PL_POA_MANTENIMIENTO_MODIFICAR_AREA`(IN `name_` TEXT, IN `typeOfArea_` INT(11), IN `observation_` TEXT, OUT `message_` VARCHAR(150), OUT `Tmessage_` TINYINT, IN `id_` INT(11))
    MODIFIES SQL DATA
    SQL SECURITY INVOKER
BEGIN START TRANSACTION; IF NOT EXISTS (
	SELECT 
		1 
	FROM 
		area 
	WHERE 
		area.nombre = name_ 
		AND area.id_tipo_area = typeOfArea_
) THEN 
update 
	area 
set 
	area.nombre = name_, 
	area.id_tipo_area = typeOfArea_, 
	area.observacion = observation_ 
where 
	area.id_Area = id_; 
SET 
	message_ = "La área ha sido modificada exitósamente."; 
SET 
	Tmessage_ = 1; ELSE 
SET 
	message_ = "La modificación es inválida, ya existen esos valores."; 
SET 
	Tmessage_ = 0; END IF; COMMIT; END$$



