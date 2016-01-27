USE `ccjj`;
DROP procedure IF EXISTS `sp_login`;

DELIMITER $$
USE `ccjj`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_login`(IN `user_` VARCHAR(30), IN `pass` VARCHAR(25))
BEGIN
   SELECT id_Usuario,Id_Rol,esta_logueado FROM usuario WHERE nombre = user_ AND pass = udf_Decrypt_derecho(Password) AND Estado = 1;
END$$

DELIMITER ;
