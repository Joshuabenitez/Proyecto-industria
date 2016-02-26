-- phpMyAdmin SQL Dump
-- version 3.3.8.1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 14-02-2016 a las 14:37:53
-- Versión del servidor: 5.0.91
-- Versión de PHP: 5.3.6-pl0-gentoo

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `ccjj`
--
DROP DATABASE `ccjj`;
CREATE DATABASE `ccjj` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `ccjj`;

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `pa_eliminar_actividad`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `pa_eliminar_actividad`(
	in id_Actividades int,
	OUT `mensaje` VARCHAR(150), 
    OUT `codMensaje` TINYINT
)
SP: begin

   DECLARE EXIT HANDLER FOR SQLEXCEPTION
   BEGIN
     SET mensaje = "No se pudo realizar la operacion, por favor intende de nuevo dentro de un momento";
     SET codMensaje = 0;
     ROLLBACK;
   END;

    -- Determinar si ya se marcó como actividad terminada
    IF EXISTS
    (
		SELECT actividades_terminadas.id_Actividades_Terminadas
        FROM actividades_terminadas
        WHERE id_actividad = id_Actividades
    )
    THEN
		BEGIN
			set mensaje := 'La actividad se marcó como actividad terminada, no puede ser borrada.';
			LEAVE SP;
		END;
    END IF;
    
    
    -- Determinar si la actividad ya tiene sub actividades asociadas.
    IF EXISTS
    (
		SELECT id_sub_Actividad
        FROM sub_actividad
        WHERE idActividad = id_Actividades
    )
    THEN
		BEGIN
			set mensaje := 'La actividad ya tiene sub-actividades, para poder borrar esta actividad debería de borrar
							las sub-actividades primero.';
			LEAVE SP;        
        END;
	END IF;
	   
	delete from actividades where actividades.id_actividad=id_Actividades;
END$$

DROP PROCEDURE IF EXISTS `pa_eliminar_actividad_terminada`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `pa_eliminar_actividad_terminada`(
	in id_Actividades_Terminadas int,
	OUT `mensaje` VARCHAR(150), 
    OUT `codMensaje` TINYINT)
begin

   DECLARE EXIT HANDLER FOR SQLEXCEPTION
   BEGIN
     SET mensaje = "No se pudo realizar la operacion, por favor intende de nuevo dentro de un momento";
     SET codMensaje = 0;
     ROLLBACK;
   END;
   

	delete from actividades_terminadas where actividades_terminadas.id_Actividades_Terminadas=id_Actividades_Terminadas;
	
end$$

DROP PROCEDURE IF EXISTS `pa_eliminar_area`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `pa_eliminar_area`(
	in id_area int,
	OUT `mensaje` VARCHAR(150), 
    OUT `codMensaje` TINYINT)
SP: begin

   DECLARE EXIT HANDLER FOR SQLEXCEPTION
   BEGIN
     SET mensaje = "No se pudo realizar la operacion, por favor intende de nuevo dentro de un momento";
     SET codMensaje = 0;
     ROLLBACK;
   END;

    IF EXISTS
    (
		SELECT id_Objetivo
        FROM objetivos_institucionales
        WHERE id_Area = id_area
    )
    THEN
		BEGIN
			set mensaje := 'El área ya tiene objetivos específicos asociados, no puede ser borrada.';
			LEAVE SP;
		END;
    END IF;
	
	delete from area where tipo_area.id_Area=id_area;
	
end$$

DROP PROCEDURE IF EXISTS `pa_eliminar_costo_porcentaje_actividad_por_trimestre`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `pa_eliminar_costo_porcentaje_actividad_por_trimestre`(
	in id int,
	OUT `mensaje` VARCHAR(150), 
    OUT `codMensaje` TINYINT)
begin

   DECLARE EXIT HANDLER FOR SQLEXCEPTION
   BEGIN
     SET mensaje = "No se pudo realizar la operacion, por favor intende de nuevo dentro de un momento";
     SET codMensaje = 0;
     ROLLBACK;
   END;

   
	delete from costo_porcentaje_actividad_por_trimestre where id_Costo_Porcentaje_Actividad_Por_Trimesrte=id;
	
end$$

DROP PROCEDURE IF EXISTS `pa_eliminar_indicador`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `pa_eliminar_indicador`(
	in id_indicador int,
	OUT `mensaje` VARCHAR(150), 
    OUT `codMensaje` TINYINT)
SP: begin

   DECLARE EXIT HANDLER FOR SQLEXCEPTION
   BEGIN
     SET mensaje = "No se pudo realizar la operacion, por favor intende de nuevo dentro de un momento";
     SET codMensaje = 0;
     ROLLBACK;
   END;
   
   IF EXISTS
   (
		SELECT id_indicador
        FROM actividades
        WHERE actividades.id_indicador = id_indicador
   )
   THEN
	BEGIN 
		SET mensaje = "El indicador tiene actividades asociadas. No puede ser borrado.";
        LEAVE SP;
	END;
	END IF;
    
	delete from indicadores where indicadores.id_indicadores= id_indicador;
	
end$$

DROP PROCEDURE IF EXISTS `pa_eliminar_objetivo_institucional`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `pa_eliminar_objetivo_institucional`(
	in id_objetivo int,
	OUT `mensaje` VARCHAR(150), 
    OUT `codMensaje` TINYINT)
SP: begin

   DECLARE EXIT HANDLER FOR SQLEXCEPTION
   BEGIN
     SET mensaje = "No se pudo realizar la operacion, por favor intende de nuevo dentro de un momento";
     SET codMensaje = 0;
     ROLLBACK;
   END;

	-- TODO: ¿Se deben de poder eliminar objetivos institucionales cuando estas tengan ya indicadores asociados?
    IF EXISTS
    (
		SELECT id_indicadores
        FROM indicadores
        WHERE indicadores.id_ObjetivosInsitucionales = id_objetivo
    )
    THEN
		BEGIN
			SET mensaje = "El objetivo tiene indicadores asociados, no puede ser borrado.";        
            LEAVE SP;
		END;
	END IF;
    
    
   
	delete from objetivos_institucionales where objetivos_institucionales.id_Objetivo= id_objetivo;
	
end$$

DROP PROCEDURE IF EXISTS `pa_eliminar_poa`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `pa_eliminar_poa`(
	in id int,
	OUT `mensaje` VARCHAR(150), 
    OUT `codMensaje` TINYINT)
SP: begin

   DECLARE EXIT HANDLER FOR SQLEXCEPTION
   BEGIN
     SET mensaje = "No se pudo realizar la operacion, por favor intende de nuevo dentro de un momento";
     SET codMensaje = 0;
     ROLLBACK;
   END;
   
   IF EXISTS
   (
		SELECT id_Objetivo
        FROM objetivos_institucionales
        WHERE id_Poa = id
   )
	THEN
		BEGIN
			SET mensaje = 'El POA que intenta eliminar tiene objetivos asociados, no puede ser borrado.';
            LEAVE SP;
        END;
	END IF;

   
	delete from poa where poa.id_Poa=id;
end$$

DROP PROCEDURE IF EXISTS `pa_eliminar_responsables_por_actividad`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `pa_eliminar_responsables_por_actividad`(
	IN `id` INT,
	OUT `mensaje` VARCHAR(150), 
    OUT `codMensaje` TINYINT)
begin

   DECLARE EXIT HANDLER FOR SQLEXCEPTION
   BEGIN
     SET mensaje = "No se pudo realizar la operacion, por favor intende de nuevo dentro de un momento";
     SET codMensaje = 0;
     ROLLBACK;
   END;
   
	delete from responsables_por_actividad where responsables_por_actividad.id_Responsable_por_Actividad=id;
end$$

DROP PROCEDURE IF EXISTS `pa_eliminar_sub_actividad`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `pa_eliminar_sub_actividad`(in id_sub_Actividad int)
begin
delete from sub_actividad where sub_actividad.id_sub_Actividad=id_sub_Actividad;
end$$

DROP PROCEDURE IF EXISTS `pa_eliminar_sub_actividad_realizada`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `pa_eliminar_sub_actividad_realizada`(
	IN `id_subActividadRealizada` INT,
	OUT `mensaje` VARCHAR(150), 
    OUT `codMensaje` TINYINT)
begin

   DECLARE EXIT HANDLER FOR SQLEXCEPTION
   BEGIN
     SET mensaje = "No se pudo realizar la operacion, por favor intende de nuevo dentro de un momento";
     SET codMensaje = 0;
     ROLLBACK;
   END;
   
	delete from sub_actividades_realizadas where sub_actividades_realizadas.id_subActividadRealizada=id_subActividadRealizada;
end$$

DROP PROCEDURE IF EXISTS `pa_eliminar_tipo_area`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `pa_eliminar_tipo_area`(
	in id_tipo_area int,
	OUT `mensaje` VARCHAR(150), 
    OUT `codMensaje` TINYINT)
SP: begin

   DECLARE EXIT HANDLER FOR SQLEXCEPTION
   BEGIN
     SET mensaje = "No se pudo realizar la operacion, por favor intende de nuevo dentro de un momento";
     SET codMensaje = 0;
     ROLLBACK;
   END;
   
   IF EXISTS
   (
		SELECT id_Area
        FROM area
        WHERE area.id_tipo_area = id_tipo_area
   )
   THEN
		BEGIN
			SET mensaje = 'El tipo de área ya tiene asociadas áreas, no puede ser borrada.';
            LEAVE SP;
        END;
   END IF;
   
	delete from tipo_area where tipo_area.id_Tipo_Area=id_tipo_area;
end$$

DROP PROCEDURE IF EXISTS `pa_insertar_actividad`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `pa_insertar_actividad`(
	IN `id_Indicador` INT, 
	IN `descripcion` TEXT, 
	IN `correlativo` VARCHAR(10), 
	IN `supuestos` TEXT, 
	IN `justificacion` TEXT, 
	IN `medio_Verificacion` TEXT, 
	IN `poblacion_Objetivo` VARCHAR(20), 
	IN `fecha_Inicio` DATE, 
	IN `fecha_Fin` DATE,
	OUT `mensaje` VARCHAR(150), 
    OUT `codMensaje` TINYINT)
begin

   DECLARE EXIT HANDLER FOR SQLEXCEPTION
   BEGIN
     SET mensaje = "No se pudo realizar la operacion, por favor intende de nuevo dentro de un momento";
     SET codMensaje = 0;
     ROLLBACK;
   END;
   
	insert into actividades (id_indicador, descripcion, correlativo, supuesto,justificacion,
							medio_verificacion, poblacion_objetivo,fecha_inicio, fecha_fin) 
	values( id_Indicador, descripcion, correlativo, supuestos, justificacion,
			medio_Verificacion, poblacion_Objetivo,fecha_Inicio, fecha_Fin) ;
end$$

DROP PROCEDURE IF EXISTS `pa_insertar_actividades_terminadas`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `pa_insertar_actividades_terminadas`(IN `id_Actividad` INT, IN `fecha` DATE, IN `estado` VARCHAR(15), IN `id_Usuario` VARCHAR(20), IN `observaciones` TEXT)
begin 
	insert into actividades_terminadas (id_Actividad, fecha, estado, No_Empleado, observaciones) values (id_Actividad, fecha, estado, id_Usuario, observaciones);
end$$

DROP PROCEDURE IF EXISTS `pa_insertar_area`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `pa_insertar_area`(IN `nombre` VARCHAR(30), IN `id_tipo_Area` INT, IN `observacion` TEXT)
begin
	insert into area (nombre,id_tipo_area,observacion) values(nombre, id_tipo_Area,observacion);
end$$

DROP PROCEDURE IF EXISTS `pa_insertar_costo_porcentaje_actividad_por_trimestre`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `pa_insertar_costo_porcentaje_actividad_por_trimestre`(IN `id_Actividad` INT, IN `costo` INT, IN `porcentaje` INT, IN `observacion` TEXT, IN `trimestre` INT)
begin 
insert into costo_porcentaje_actividad_por_trimestre (id_Actividad, costo,porcentaje,observacion, trimestre)values(id_Actividad, costo,porcentaje,observacion, trimestre);
end$$

DROP PROCEDURE IF EXISTS `pa_insertar_indicador`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `pa_insertar_indicador`(IN `id_ObjetivosInstitucionales` INT, IN `nombre` VARCHAR(30), IN `descripcion` TEXT)
begin
	insert into indicadores (id_ObjetivosInsitucionales, nombre, descripcion) values (id_ObjetivosInstitucionales, nombre, descripcion);
end$$

DROP PROCEDURE IF EXISTS `pa_insertar_objetivos_institucionales`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `pa_insertar_objetivos_institucionales`(IN `definicion` TEXT, IN `area_Estrategica` TEXT, IN `resultados_Esperados` TEXT, IN `id_Area` INT, IN `id_Poa` INT)
begin 
	insert into objetivos_institucionales  (definicion,area_Estrategica,resultados_Esperados,id_Area,id_Poa) values (definicion,area_Estrategica,resultados_Esperados,id_Area,id_Poa);
end$$

DROP PROCEDURE IF EXISTS `pa_insertar_poa`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `pa_insertar_poa`(IN `nombre` VARCHAR(30), IN `fecha_de_Inicio` DATE, IN `fecha_Fin` DATE, IN `descripcion` TEXT)
begin
insert into poa (nombre,fecha_de_Inicio,fecha_Fin,descripcion) values (nombre,fecha_de_Inicio,fecha_Fin, descripcion);
end$$

DROP PROCEDURE IF EXISTS `pa_insertar_responsables_por_actividad`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `pa_insertar_responsables_por_actividad`(IN `id_Actividad` INT, IN `id_Responsable` INT, IN `fecha_Asignacion` DATE, IN `observacion` TEXT)
begin
	insert into responsables_por_actividad (id_Actividad,id_Responsable,fecha_Asignacion,observacion) values (id_Actividad,id_Responsable,fecha_Asignacion,observacion);
end$$

DROP PROCEDURE IF EXISTS `pa_insertar_sub_actividad`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `pa_insertar_sub_actividad`(IN `id_Actividad` INT, IN `nombre` VARCHAR(30), IN `descripcion` TEXT, IN `fecha_monitoreo` DATE, IN `id_Encargado` VARCHAR(20), IN `ponderacion` INT, IN `costo` INT, IN `observacion` TEXT)
begin
insert into sub_actividad (idActividad,nombre,descripcion,fecha_monitoreo,id_Encargado,ponderacion,costo,observacion) values(id_Actividad,nombre,descripcion,fecha_monitoreo,id_Encargado,ponderacion,costo,observacion);
end$$

DROP PROCEDURE IF EXISTS `pa_insertar_sub_actividades_realizadas`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `pa_insertar_sub_actividades_realizadas`(IN `id_SubActividad` INT, IN `fecha_Realizacion` DATE, IN `observacion` TEXT)
begin
	insert into sub_actividades_realizadas (id_SubActividad,fecha_Realizacion,observacion) values (id_SubActividad,fecha_Realizacion,observacion);
end$$

DROP PROCEDURE IF EXISTS `pa_insertar_tipo_area`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `pa_insertar_tipo_area`(IN `nombre_` TEXT, IN `observaciones_` TEXT, OUT `message_` VARCHAR(150), OUT `Tmessage_` TINYINT)
BEGIN START TRANSACTION; IF NOT EXISTS (
	SELECT 
		1 
	FROM 
		tipo_area 
	WHERE 
		tipo_area.nombre = nombre_
) THEN insert into tipo_area (nombre, observaciones) 
values 
	(nombre_, observaciones_); 
SET 
	message_ = "El nuevo tipo de área ha sido ingresada exitósamente."; 
SET 
	Tmessage_ = 1; ELSE 
SET 
	message_ = "El tipo de área que quiere ingresar ya existe."; 
SET 
	Tmessage_ = 0; END IF; COMMIT; END$$

DROP PROCEDURE IF EXISTS `pa_modificar_actividad`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `pa_modificar_actividad`(IN `id_Actividad` INT, IN `id_Indicador` INT, IN `descripcion` TEXT, IN `correlativo` VARCHAR(10), IN `supuestos` TEXT, IN `justificacion` TEXT, IN `medio_Verificacion` TEXT, IN `poblacion_Objetivo` VARCHAR(20), IN `fecha_Inicio` DATE, IN `fecha_Fin` DATE)
begin
update actividades set id_indicador=id_Indicador, descripcion=descripcion, correlativo=correlativo, supuesto=supuesto, justificacion=justificacion, medio_verificacion=medio_Verificacion, poblacion_objetivo=poblacion_Objetivo,fecha_inicio=fecha_Inicio, fecha_fin=fecha_Fin 
where actividades.id_actividad= id_Actividad;
end$$

DROP PROCEDURE IF EXISTS `pa_modificar_actividades_terminadas`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `pa_modificar_actividades_terminadas`(IN `id_Actividad_Terminada` INT, IN `id_Actividad` INT, IN `fecha` DATE, IN `estado` VARCHAR(15), IN `id_Usuario` VARCHAR(20), IN `observaciones` TEXT)
begin 
	update actividades_terminadas set id_Actividad=id_Actividad, fecha=fecha, estado=estado, No_Empleado=id_Usuario, observaciones=observaciones where actividades_terminadas.id_Actividades_Terminadas= id_Actividad_Terminada; 
end$$

DROP PROCEDURE IF EXISTS `pa_modificar_area`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `pa_modificar_area`(IN id_Area int ,IN nombre VARCHAR(30), IN id_tipo_Area INT, IN observacion TEXT)
begin
	update area set nombre=nombre,id_tipo_Area=id_tipo_Area,observaciones=observacion where area.id_Area=id_Area;
end$$

DROP PROCEDURE IF EXISTS `pa_modificar_costo_porcentaje_actividad_por_trimestre`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `pa_modificar_costo_porcentaje_actividad_por_trimestre`(IN id_Costo_Porcentaje_Actividad_Por_Trimesrte INT,IN id_Actividad INT, IN costo INT, IN porcentaje INT, IN observacion TEXT, IN trimestre INT)
begin 
update costo_porcentaje_actividad_por_trimestre set id_Actividad=id_ACtividad, costo=costo,porcentaje=porcentaje,observacion=observacion, trimestre=trimestre where costo_porcentaje_actividad_por_trimestre.id_Costo_Porcentaje_Actividad_Por_Trimesrte=id_Costo_Porcentaje_Actividad_Por_Trimesrte ;
end$$

DROP PROCEDURE IF EXISTS `pa_modificar_indicador`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `pa_modificar_indicador`(IN `id_Indicador` INT, IN `id_ObjetivosInstitucionales` INT, IN `nombre` VARCHAR(30), IN `descripcion` TEXT)
begin
update indicadores set id_ObjetivosInsitucionales=id_ObjetivosInstitucionales, nombre=nombre, descripcion=descripcion where indicadores.id_Indicadores=id_Indicador;
end$$

DROP PROCEDURE IF EXISTS `pa_modificar_objetivos_institucionales`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `pa_modificar_objetivos_institucionales`(IN id_Objetivo int,IN definicion TEXT, IN area_Estrategica TEXT, IN resultados_Esperados TEXT, IN id_Area INT, IN id_Poa INT)
begin 
update objetivos_institucionales set definicion=definicion,area_Estrategica=area_Estrategica,resultados_Esperados=resultados_Esperados,id_Area=id_Area,id_Poa=id_Poa where objetivos_institucionales.id_Objetivo= id_Objetivo ;
end$$

DROP PROCEDURE IF EXISTS `pa_modificar_poa`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `pa_modificar_poa`(in id_Poa int,IN nombre VARCHAR(30), IN fecha_de_Inicio DATE, IN fecha_Fin DATE, IN descripcion TEXT)
begin
update poa set nombre=nombre,fecha_de_Inicio=fecha_de_Inicio,fecha_Fin=fecha_Fin,descripcion=descripcion
where poa.id_Poa=id_Poa;
end$$

DROP PROCEDURE IF EXISTS `pa_modificar_responsables_por_actividad`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `pa_modificar_responsables_por_actividad`(IN `id_Responsable_por_Act` INT, IN `id_Actividad` INT, IN `id_Responsable` INT, IN `fecha_Asignacion` DATE, IN `observacion` TEXT)
begin
update responsables_por_actividad set id_Actividad=id_Actividad,id_Responsable=id_Responsable,fecha_Asignacion=Fecha_Asignacion,observacion=observacion where responsables_por_actividad.id_Responsable_por_Actividad=id_Responsable_por_Act;
end$$

DROP PROCEDURE IF EXISTS `pa_modificar_sub_actividad`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `pa_modificar_sub_actividad`(IN `id_sub_Act` INT, IN `id_Actividad` INT, IN `nombre` VARCHAR(30), IN `descripcion` TEXT, IN `fecha_monitoreo` DATE, IN `id_Encargado` VARCHAR(20), IN `ponderacion` INT, IN `costo` INT, IN `observacion` TEXT)
begin
update sub_actividad set idActividad=id_Actividad,nombre=nombre,descripcion=descripcion,fecha_monitoreo=fecha_monitoreo,id_Encargado=id_Encargado,ponderacion=ponderacion,costo=costo,observacion=observacion
where sub_actividad.id_sub_Actividad=id_sub_Act;
end$$

DROP PROCEDURE IF EXISTS `pa_modificar_sub_actividades_realizadas`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `pa_modificar_sub_actividades_realizadas`(in id_subActividadRealizada int,IN id_SubActividad INT, IN fecha_Realizacion DATE, IN observacion TEXT)
begin
update sub_actividades_realizadas set id_SubActividad=id_SubActividad,fecha_Realizacion=fecha_Realizacion,observacion=observacion 
where sub_actividades_Realizadas.id_subActividadRealizada=id_subActividadRealizada;
end$$

DROP PROCEDURE IF EXISTS `pa_modificar_tipo_area`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `pa_modificar_tipo_area`(IN id_Tipo_Area int,IN nombre VARCHAR(30), IN observaciones TEXT)
begin
	 update tipo_area set nombre=nombre,observaciones=observaciones where tipo_area.id_Tipo_Area=id_Tipo_Area;
end$$

DROP PROCEDURE IF EXISTS `PL_POA_MANTENIMIENTO_ELIMINAR_AREA`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `PL_POA_MANTENIMIENTO_ELIMINAR_AREA`(IN `id_` INT(11), OUT `message_` VARCHAR(150), OUT `Tmessage_` TINYINT)
    NO SQL
BEGIN START TRANSACTION; IF NOT EXISTS (
	SELECT 
		1 
	FROM 
		objetivos_institucionales 
	WHERE 
		objetivos_institucionales.id_Area = id_
) THEN 
delete from 
	area 
where 
	area.id_Area = id_; 
SET 
	message_ = "La área ha sido eliminada exitósamente."; 
SET 
	Tmessage_ = 1; ELSE 
SET 
	message_ = "No se puede eliminar la área, se encuentra asociada con un objetivo institucional."; 
SET 
	Tmessage_ = 0; END IF; COMMIT; END$$

DROP PROCEDURE IF EXISTS `PL_POA_MANTENIMIENTO_INSERTAR_NUEVA_AREA`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `PL_POA_MANTENIMIENTO_INSERTAR_NUEVA_AREA`(IN `name_` TEXT, IN `typeOfArea_` INT(11), IN `observation_` TEXT, OUT `message_` VARCHAR(150), OUT `Tmessage_` TINYINT)
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

DROP PROCEDURE IF EXISTS `PL_POA_MANTENIMIENTO_MODIFICAR_AREA`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `PL_POA_MANTENIMIENTO_MODIFICAR_AREA`(IN `name_` TEXT, IN `typeOfArea_` INT(11), IN `observation_` TEXT, OUT `message_` VARCHAR(150), OUT `Tmessage_` TINYINT, IN `id_` INT(11))
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

DROP PROCEDURE IF EXISTS `sp_actualizar_asignado_folio`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `sp_actualizar_asignado_folio`(
    IN numFolio_ VARCHAR(25), 
    IN usuarioAsg INT, 
    OUT `mensaje` VARCHAR(150), 
    OUT `codMensaje` TINYINT)
BEGIN 
 
   DECLARE id INTEGER DEFAULT 0;

   DECLARE EXIT HANDLER FOR SQLEXCEPTION
   BEGIN
     SET mensaje = "No se pudo realizar la operacion, por favor intende de nuevo dentro de un momento";
     SET codMensaje = 0;
     ROLLBACK;
   END;

   START TRANSACTION;
   
   UPDATE seguimiento SET UsuarioAsignado = usuarioAsg WHERE NroFolio = numFolio_;

     SET mensaje = "El usuario ha sido asignado correctamente al seguimiento de este folio."; 
     SET codMensaje = 1; 
   
   COMMIT;
END$$

DROP PROCEDURE IF EXISTS `sp_actualizar_categorias_folios`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `sp_actualizar_categorias_folios`(IN `Id_categoria_` INT(11), IN `NombreCategoria_` TEXT, IN `DescripcionCategoria_` TEXT, OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
BEGIN 

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
SET mensaje = "No se pudo actualizar la categoria de los folios por favor revise los datos que desea modificar";
		SET codMensaje = 0; 
END;

   START TRANSACTION;
        UPDATE categorias_folios
        SET  NombreCategoria=NombreCategoria_,DescripcionCategoria = DescripcionCategoria_ 
        WHERE Id_categoria=Id_categoria_;
		
		SET mensaje = "la categoria de los folios se ha actualizado satisfactoriamente."; 
		SET codMensaje = 1;               
COMMIT;   
end$$

DROP PROCEDURE IF EXISTS `SP_ACTUALIZAR_CIUDAD`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_ACTUALIZAR_CIUDAD`(
IN `pcnombre` VARCHAR(50), -- nuevo nombre que se le quiere poner a la ciudad
IN `pcCodigo` INT, -- codigo de la ciudad que queremos modificar
OUT `mensajeError` VARCHAR(500)
)
BEGIN 

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
SET mensajeError = "No se pudo actualizar la ciudad, por favor revise los datos que desea modificar";
END;

   START TRANSACTION;
        UPDATE sa_ciudades
        SET  sa_ciudades.nombre=pcnombre
        where sa_ciudades.codigo = pcCodigo;

		SET mensajeError = "La ciudad se ha actualizado satisfactoriamente."; 
               
COMMIT;   
end$$

DROP PROCEDURE IF EXISTS `sp_actualizar_estado_seguimiento`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `sp_actualizar_estado_seguimiento`(IN `Id_Estado_Seguimiento_` TINYINT(4), IN `DescripcionEstadoSeguimiento_` TEXT, OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
BEGIN 

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
SET mensaje = "No se pudo actualizar el estado por favor revise los datos que desea modificar";
		SET codMensaje = 0; 
END;

   START TRANSACTION;
        UPDATE estado_seguimiento
        SET  DescripcionEstadoSeguimiento=DescripcionEstadoSeguimiento_
        where Id_Estado_Seguimiento = Id_Estado_Seguimiento_;
		SET mensaje = "el estado se ha actualizado satisfactoriamente."; 
		SET codMensaje = 1;                  
COMMIT;   
end$$

DROP PROCEDURE IF EXISTS `sp_actualizar_folio`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `sp_actualizar_folio`( 
    IN numFolioAnt_ VARCHAR(25),
    IN numFolio_ VARCHAR(25), 
	IN fechaCreacion_ DATE, 
	IN fechaEntrada_ DATE, 
	IN personaReferente_ TEXT, 
	IN unidadAcademica_ INT, 
	IN organizacion_ INT, 
	IN descripcion_ TEXT,
	IN tipoFolio_ TINYINT, 
	IN ubicacionFisica_ INT(5), 
    IN prioridadAnt_ TINYINT,
	IN prioridad_ TINYINT,
    IN categoria_ INT,
    OUT mensaje VARCHAR(150), 
    OUT codMensaje TINYINT  
)
BEGIN 

   START TRANSACTION;

   IF (numFolioAnt_ = numFolio_) THEN
       UPDATE folios SET  FechaCreacion = fechaCreacion_, personaReferente = PersonaReferente_, UnidadAcademica = unidadAcademica_, Organizacion = organizacion_, DescripcionAsunto = descripcion_, TipoFolio = tipoFolio_, UbicacionFisica = ubicacionFisica_, Prioridad = prioridad_, categoria=categoria_ WHERE NroFolio = numFolio_;
       IF (prioridadAnt_ != prioridad_) THEN
          INSERT INTO prioridad_folio VALUES (NULL,numFolio_,prioridad_,CURDATE() );
       END IF;
	   SET mensaje = "Los datos del folio ha sido actualizados satisfactoriamente."; 
       SET codMensaje = 1; 
   ELSE 
       IF EXISTS ( SELECT 1 FROM folios WHERE NroFolio = numFolio_ ) THEN
	      SET mensaje = "El folio ya existe en sistema, por favor revise el numero del folio que desea ingresar";
          SET codMensaje = 0;
	   ELSE
	      UPDATE folios SET NroFolio = numFolio_, FechaCreacion = fechaCreacion_, PersonaReferente = personaReferente_, UnidadAcademica = unidadAcademica_, Organizacion = organizacion_, 
		  DescripcionAsunto = descripcion_,TipoFolio = tipoFolio_, UbicacionFisica = ubicacionFisica_, Prioridad = prioridad_, categoria=categoria_ WHERE NroFolio = numFolioAnt_;
		
       IF (prioridadAnt_ != prioridad_) THEN
         INSERT INTO prioridad_folio VALUES (NULL,numFolio_,prioridad_,CURDATE() );
       END IF;		
			
		  SET mensaje = "Los datos del folio han sido actualizados satisfactoriamente."; 
          SET codMensaje = 1;  
	   END IF;
   END IF;
   
   COMMIT;
END$$

DROP PROCEDURE IF EXISTS `SP_ACTUALIZAR_MENCION_HONORIFICA`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_ACTUALIZAR_MENCION_HONORIFICA`(
IN `pcnombre` VARCHAR(50), -- nuevo nombre que se le quiere poner a la mencion
IN `pcCodigo` INT, -- codigo de la mencion que queremos modificar
OUT `mensajeError` VARCHAR(500)
)
BEGIN 

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
SET mensajeError = "No se pudo actualizar la ciudad, por favor revise los datos que desea modificar";
END;

   START TRANSACTION;
        UPDATE sa_menciones_honorificas
        SET  sa_menciones_honorificas.descripcion=pcnombre
        where sa_menciones_honorificas.codigo = pcCodigo;

		SET mensajeError = "La mencion honorifica se ha actualizado satisfactoriamente."; 
               
COMMIT;   
end$$

DROP PROCEDURE IF EXISTS `sp_actualizar_organizacion`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `sp_actualizar_organizacion`(IN `Id_Organizacion_` INT(11), IN `NombreOrganizacion_` TEXT, IN `Ubicacion_` TEXT, OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
BEGIN 

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
SET mensaje = "No se pudo actualizar la organizacion por favor revise los datos que desea modificar";
		SET codMensaje = 0; 
END;

   START TRANSACTION;
        UPDATE organizacion
        SET  NombreOrganizacion=NombreOrganizacion_,Ubicacion = Ubicacion_ 
        WHERE Id_Organizacion=Id_Organizacion_;
		
		SET mensaje = "la organizacion se ha actualizado satisfactoriamente."; 
		SET codMensaje = 1;               
COMMIT;   
end$$

DROP PROCEDURE IF EXISTS `SP_ACTUALIZAR_ORIENTACION`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_ACTUALIZAR_ORIENTACION`(
IN `pcnombre` VARCHAR(50), -- nuevo nombre que se le quiere poner a la orientacion
IN `pcCodigo` INT, -- codigo de la ciudad que queremos modificar
OUT `mensajeError` VARCHAR(500)
)
BEGIN 

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
SET mensajeError = "No se pudo actualizar la orientacion, por favor revise los datos que desea modificar";
END;

   START TRANSACTION;
        UPDATE sa_orientaciones
        SET  sa_orientaciones.descripcion=pcnombre
        where sa_orientaciones.codigo = pcCodigo;

		SET mensajeError = "La Orientacion se ha actualizado satisfactoriamente."; 
               
COMMIT;   
END$$

DROP PROCEDURE IF EXISTS `SP_ACTUALIZAR_ORIENTACIONES`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_ACTUALIZAR_ORIENTACIONES`(
IN `pcnombre` VARCHAR(50), -- nuevo nombre que se le quiere poner a la orientacion
IN `pcCodigo` INT, -- codigo de la ciudad que queremos modificar
OUT `mensajeError` VARCHAR(500)
)
BEGIN 

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
SET mensajeError = "No se pudo actualizar la orientacion, por favor revise los datos que desea modificar";
END;

   START TRANSACTION;
        UPDATE sa_orientaciones
        SET  sa_orientaciones.descripcion=pcnombre
        where sa_orientaciones.codigo = pcCodigo;
               
COMMIT;   
END$$

DROP PROCEDURE IF EXISTS `SP_ACTUALIZAR_PERIODO`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_ACTUALIZAR_PERIODO`(
IN `pcnombre` VARCHAR(50), -- nuevo nombre que se le quiere poner al periodo
IN `pcCodigo` INT, -- codigo del periodo que queremos modificar
OUT `mensajeError` VARCHAR(500)
)
BEGIN 

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
SET mensajeError = "No se pudo actualizar la ciudad, por favor revise los datos que desea modificar";
END;

   START TRANSACTION;
        UPDATE sa_periodos
        SET  sa_periodos.nombre=pcnombre
        where sa_periodos.codigo = pcCodigo;

		SET mensajeError = "El periodo se ha actualizado satisfactoriamente."; 
               
COMMIT;   
end$$

DROP PROCEDURE IF EXISTS `SP_ACTUALIZAR_PERMISO`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_ACTUALIZAR_PERMISO`(
IN `pcnombre` VARCHAR(50), -- nuevo nombre que se le quiere poner al periodo
IN `pcCodigo` INT, -- codigo del periodo que queremos modificar
OUT `mensajeError` VARCHAR(500)
)
BEGIN 

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
SET mensajeError = "No se pudo actualizar el permiso, por favor revise los datos que desea modificar";
END;

   START TRANSACTION;
        UPDATE tipodepermiso
        SET  tipodepermiso.tipo_permiso = pcnombre
        where tipodepermiso.id_tipo_permiso = pcCodigo;

    SET mensajeError = "El Permiso se ha actualizado satisfactoriamente."; 
               
COMMIT;   
end$$

DROP PROCEDURE IF EXISTS `SP_ACTUALIZAR_PLAN_ESTUDIO`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_ACTUALIZAR_PLAN_ESTUDIO`(
IN pcnombre VARCHAR(50), -- nuevo nombre que se le quiere poner al plan de estudio
IN pcCodigo INT, -- codigo del plan que queremos modificar
OUT `mensajeError` VARCHAR(500)
)
BEGIN 
	DECLARE mensaje VARCHAR(500);

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
SET mensaje = "No se pudo actualizar el Plan de estudio, por favor revise los datos que desea modificar";
END;

   START TRANSACTION;
        UPDATE sa_planes_estudio
        SET  nombre=pcnombre
        where codigo = pcCodigo;

		SET mensaje = "El plan de estudio se ha actualizado satisfactoriamente."; 
               
COMMIT;   
end$$

DROP PROCEDURE IF EXISTS `sp_actualizar_prioridad`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `sp_actualizar_prioridad`(IN `Id_Prioridad_` TINYINT(4), IN `DescripcionPrioridad_` TEXT, OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
BEGIN 

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
SET mensaje = "No se pudo actualizar la prioridad por favor revise los datos que desea modificar";
		SET codMensaje = 0; 
END;

   START TRANSACTION;
        UPDATE prioridad
        SET  DescripcionPrioridad=DescripcionPrioridad_
        where Id_Prioridad = Id_Prioridad_;
		
		SET mensaje = "la prioridad se ha actualizado satisfactoriamente."; 
		SET codMensaje = 1;               
COMMIT;   
end$$

DROP PROCEDURE IF EXISTS `sp_actualizar_seguimiento`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `sp_actualizar_seguimiento`(IN `numFolio_` VARCHAR(25), IN `fechaFin_` DATE, IN `prioridad_` TINYINT, IN `seguimiento_` TINYINT, IN `notas_` TEXT, OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT, IN `us` INT)
BEGIN 
 
   DECLARE id INTEGER DEFAULT 0;

   DECLARE EXIT HANDLER FOR SQLEXCEPTION
   BEGIN
     SET mensaje = "No se pudo realizar la operacion, por favor intende de nuevo dentro de un momento";
     SET codMensaje = 0;
     ROLLBACK;
   END;

   START TRANSACTION;
   
   IF NOT EXISTS (SELECT 1 FROM folios WHERE NroFolio = numFolio_) THEN 
	 SET mensaje = "El folio no existe en sistema, por favor notifiquelo al administrador del sistema";
     SET codMensaje = 0;	 
   ELSE
     SET id = (SELECT Id_Seguimiento FROM seguimiento WHERE NroFolio = numFolio_);
     
	 IF( IFNULL(fechaFin_,0) = 0 ) THEN
       UPDATE seguimiento SET Notas = notas_, Prioridad = prioridad_, EstadoSeguimiento = seguimiento_ WHERE NroFolio = numFolio_;
	 ELSE
	   UPDATE seguimiento SET Notas = notas_, Prioridad = prioridad_, FechaFinal = fechaFin_, EstadoSeguimiento = seguimiento_ WHERE NroFolio = numFolio_;
       UPDATE alerta SET Atendido=1 WHERE NroFolioGenera = numFolio_;
	 END IF;
	 
     INSERT INTO seguimiento_historico VALUES(NULL,id,seguimiento_,notas_,prioridad_,NOW(),us);

     SET mensaje = "El seguimiento ha sido actualizado satisfactoriamente."; 
     SET codMensaje = 1; 
   END IF; 
   
   COMMIT;
END$$

DROP PROCEDURE IF EXISTS `SP_ACTUALIZAR_TIPO_DE_ESTUDIANTE`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_ACTUALIZAR_TIPO_DE_ESTUDIANTE`(
IN `pcnombre` VARCHAR(50), -- Nuevo nombre que se le quiere dar al tipo de estudiante
IN `pcCodigo` INT, -- codigo del tipo de estudiante que queremos modificar
OUT `mensajeError` VARCHAR(500)
)
BEGIN 

DECLARE errror VARCHAR(500);

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN


ROLLBACK;

SET mensajeError = "No se pudo actualizar el tipo de estudiante, por favor revise los datos que desea modificar";
END;

   START TRANSACTION;
        UPDATE sa_tipos_estudiante
        SET  sa_tipos_estudiante.descripcion=pcnombre
        where sa_tipos_estudiante.codigo = pcCodigo;

		SET mensajeError = "El tipo de estudiante se ha actualizado satisfactoriamente."; 
               
COMMIT;   
end$$

DROP PROCEDURE IF EXISTS `sp_actualizar_ubicacion_archivo_fisica`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `sp_actualizar_ubicacion_archivo_fisica`(IN `Id_UbicacionArchivoFisico_` INT(5), IN `DescripcionUbicacionFisica_` TEXT, IN `Capacidad_` INT(10), IN `TotalIngresados_` INT(10), IN `HabilitadoParaAlmacenar_` TINYINT(1), OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
BEGIN 

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
SET mensaje = "No se pudo actualizar la ubicacion fisica por favor revise los datos que desea modificar";
		SET codMensaje = 0; 
END;

   START TRANSACTION;

        UPDATE ubicacion_archivofisico
        SET  DescripcionUbicacionFisica=DescripcionUbicacionFisica_,Capacidad=Capacidad_,     TotalIngresados=TotalIngresados_,HabilitadoParaAlmacenar=HabilitadoParaAlmacenar_  where Id_UbicacionArchivoFisico = Id_UbicacionArchivoFisico_;
		
		SET mensaje = "la ubicacion se ha actualizado satisfactoriamente."; 
		SET codMensaje = 1;               
COMMIT;  
end$$

DROP PROCEDURE IF EXISTS `sp_actualizar_ubicacion_notificaciones`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `sp_actualizar_ubicacion_notificaciones`(IN `Id_UbicacionNotificaciones_` TINYINT(4), IN `DescripcionUbicacionNotificaciones_` TEXT, OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
BEGIN 

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
SET mensaje = "No se pudo actualizar la ubicacion de las notificaciones por favor revise los datos que desea modificar";
		SET codMensaje = 0; 
END;

   START TRANSACTION;
        UPDATE ubicacion_notificaciones
        SET  DescripcionUbicacionNotificaciones=DescripcionUbicacionNotificaciones_
        where Id_UbicacionNotificaciones = Id_UbicacionNotificaciones_;
		
		SET mensaje = "la ubicacion se ha actualizado satisfactoriamente."; 
		SET codMensaje = 1;               
COMMIT;   
end$$

DROP PROCEDURE IF EXISTS `sp_actualizar_unidad_academica`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `sp_actualizar_unidad_academica`(IN `Id_UnidadAcademica_` INT(11), IN `NombreUnidadAcademica_` TEXT, IN `UbicacionUnidadAcademica_` TEXT, OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
BEGIN 

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
SET mensaje = "No se pudo actualizar la unidad academica por favor revise los datos que desea modificar";
		SET codMensaje = 0; 
END;

   START TRANSACTION;
        UPDATE unidad_academica
        SET  NombreUnidadAcademica=NombreUnidadAcademica_,UbicacionUnidadAcademica=UbicacionUnidadAcademica_
        where  Id_UnidadAcademica = Id_UnidadAcademica_;
		SET mensaje = "la unidad academica se ha actualizado satisfactoriamente."; 
		SET codMensaje = 1;               
COMMIT;   
end$$

DROP PROCEDURE IF EXISTS `sp_actualizar_usuario`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `sp_actualizar_usuario`(IN `idUsuario` INT(11), IN `numEmpleado_` VARCHAR(13), IN `nombreAnt_` VARCHAR(30), IN `nombre_` VARCHAR(30), IN `Password_` VARCHAR(20), IN `rol_` INT(4), IN `fecha_` DATE, IN `estado_` BOOLEAN, OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
BEGIN 
   START TRANSACTION;
   IF (nombreAnt_ = nombre_) THEN 
     UPDATE usuario SET No_Empleado = numEmpleado_, nombre = nombre_, Password = udf_Encrypt_derecho(Password_), Id_Rol = rol_, Fecha_Alta = fecha_, Estado = estado_ 
     WHERE id_Usuario = idUsuario;
     
     SET mensaje = "El usuario ha sido modificado satisfactoriamente."; 
       SET codMensaje = 1; 
   ELSE
   
     IF NOT EXISTS (SELECT 1 FROM usuario WHERE nombre = nombre_) THEN 

       UPDATE usuario SET No_Empleado = numEmpleado_, nombre = nombre_, Password = udf_Encrypt_derecho(Password_), Id_Rol = rol_, Fecha_Alta = fecha_, Estado = estado_ 
       WHERE id_Usuario = idUsuario;

       SET mensaje = "El usuario ha sido modificado satisfactoriamente."; 
       SET codMensaje = 1;  
     ELSE
       SET mensaje = "El usuario ya existe en sistema, por favor revise el nombre del usuario que desea modificar";
       SET codMensaje = 0;
     END IF;
   END IF;
   
   COMMIT;
END$$

DROP PROCEDURE IF EXISTS `SP_BUSQUEDA_SECRETARIA`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_BUSQUEDA_SECRETARIA`(
	IN pcNumeroIdentidad VARCHAR(500),
    IN pdFechaSolicitud DATE, 
    IN pnCodigoTipoSolicitud INT,
	OUT pcMensajeError VARCHAR(500) -- Para mensajes de error
)
BEGIN
	
    DECLARE vcTempMensajeError VARCHAR(500) DEFAULT ''; -- Variable para posibles errores no con	trolados
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError, ' Server: ');
        SET pcMensajeError := vcTempMensajeError;
    
    END;    
    
    IF pcNumeroIdentidad IS  NULL AND pdFechaSolicitud IS NULL AND  pnCodigoTipoSolicitud IS NULL THEN

	SELECT
		PERSONA.*, ESTUDIANTE.no_cuenta AS NUMERO_CUENTA, ESTUDIANTE.indice_academico AS INDICE_ACADEMICO, 
        TIPO_ESTUDIANTE.descripcion AS DESCRIPCION_TIPO_ESTUDIANTE,
        TIPOS_SOLICITUDES.nombre as NOMBRE_TIPO_SOLICITUD, SOLICITUDES.fecha_solicitud AS FECHA_SOLICITUD 
	FROM
		(
			SELECT CONCAT(Primer_nombre,' ', Primer_apellido) AS NOMBRE,
            N_identidad AS NUMERO_IDENTIDAD
            FROM persona AS PERSONA
        )
        PERSONA INNER JOIN sa_estudiantes  as ESTUDIANTE ON(ESTUDIANTE.dni = PERSONA.NUMERO_IDENTIDAD)
        INNER JOIN sa_solicitudes AS SOLICITUDES ON(SOLICITUDES.dni_estudiante = PERSONA.NUMERO_IDENTIDAD)
        INNER JOIN sa_tipos_solicitud AS TIPOS_SOLICITUDES ON(TIPOS_SOLICITUDES.codigo = SOLICITUDES.cod_tipo_solicitud)
        INNER JOIN sa_estudiantes_tipos_estudiantes AS TIPOS_ESTUDIANTE_ESTUDIANTE 
        ON(TIPOS_ESTUDIANTE_ESTUDIANTE.dni_estudiante = PERSONA.NUMERO_IDENTIDAD)
        INNER JOIN sa_tipos_estudiante AS TIPO_ESTUDIANTE ON(TIPO_ESTUDIANTE.codigo = TIPOS_ESTUDIANTE_ESTUDIANTE.codigo_tipo_estudiante);  
        
	END IF;
    
    -- Buscar por número de identidad
    IF pcNumeroIdentidad IS  NOT NULL AND pdFechaSolicitud IS NULL AND  pnCodigoTipoSolicitud IS NULL THEN
    
	SELECT
		PERSONA.*, ESTUDIANTE.no_cuenta AS NUMERO_CUENTA, ESTUDIANTE.indice_academico AS INDICE_ACADEMICO, 
        TIPO_ESTUDIANTE.descripcion AS DESCRIPCION_TIPO_ESTUDIANTE,
        TIPOS_SOLICITUDES.nombre as NOMBRE_TIPO_SOLICITUD, SOLICITUDES.fecha_solicitud AS FECHA_SOLICITUD 
	FROM
		(
			SELECT CONCAT(Primer_nombre,' ', Primer_apellido) AS NOMBRE,
            N_identidad AS NUMERO_IDENTIDAD
            FROM persona AS PERSONA
			WHERE
			(
				pcNumeroIdentidad IS NOT NULL 
				AND N_identidad = pcNumeroIdentidad
			)
        )
        PERSONA INNER JOIN sa_estudiantes  as ESTUDIANTE ON(ESTUDIANTE.dni = PERSONA.NUMERO_IDENTIDAD)
        INNER JOIN sa_solicitudes AS SOLICITUDES ON(SOLICITUDES.dni_estudiante = PERSONA.NUMERO_IDENTIDAD)
        INNER JOIN sa_tipos_solicitud AS TIPOS_SOLICITUDES ON(TIPOS_SOLICITUDES.codigo = SOLICITUDES.cod_tipo_solicitud)
        INNER JOIN sa_estudiantes_tipos_estudiantes AS TIPOS_ESTUDIANTE_ESTUDIANTE 
        ON(TIPOS_ESTUDIANTE_ESTUDIANTE.dni_estudiante = PERSONA.NUMERO_IDENTIDAD)
        INNER JOIN sa_tipos_estudiante AS TIPO_ESTUDIANTE ON(TIPO_ESTUDIANTE.codigo = TIPOS_ESTUDIANTE_ESTUDIANTE.codigo_tipo_estudiante);    
        
	-- Buscar por número de identidad y fecha de solicitud
	ELSEIF pcNumeroIdentidad IS  NOT NULL AND pdFechaSolicitud IS NOT NULL AND  pnCodigoTipoSolicitud IS NULL THEN
    
	SELECT
		PERSONA.*, ESTUDIANTE.no_cuenta AS NUMERO_CUENTA, ESTUDIANTE.indice_academico AS INDICE_ACADEMICO, 
        TIPO_ESTUDIANTE.descripcion AS DESCRIPCION_TIPO_ESTUDIANTE,
        TIPOS_SOLICITUDES.nombre as NOMBRE_TIPO_SOLICITUD, SOLICITUDES.fecha_solicitud AS FECHA_SOLICITUD 
	FROM
		(
			SELECT CONCAT(Primer_nombre,' ', Primer_apellido) AS NOMBRE,
            N_identidad AS NUMERO_IDENTIDAD
            FROM persona AS PERSONA
			WHERE
			(
				pcNumeroIdentidad IS NOT NULL 
				AND N_identidad = pcNumeroIdentidad
			)
            AND
            (            
                pdFechaSolicitud IS NOT NULL
				AND N_identidad IN
                (
					SELECT dni_estudiante
                    FROM sa_solicitudes
                    WHERE fecha_solicitud  = pdFechaSolicitud
                )
            )
        )PERSONA INNER JOIN sa_estudiantes  as ESTUDIANTE ON(ESTUDIANTE.dni = PERSONA.NUMERO_IDENTIDAD)
        INNER JOIN sa_solicitudes AS SOLICITUDES ON(SOLICITUDES.dni_estudiante = PERSONA.NUMERO_IDENTIDAD AND SOLICITUDES.fecha_solicitud = pdFechaSolicitud)
        INNER JOIN sa_tipos_solicitud AS TIPOS_SOLICITUDES ON(TIPOS_SOLICITUDES.codigo = SOLICITUDES.cod_tipo_solicitud)
        INNER JOIN sa_estudiantes_tipos_estudiantes AS TIPOS_ESTUDIANTE_ESTUDIANTE 
        ON(TIPOS_ESTUDIANTE_ESTUDIANTE.dni_estudiante = PERSONA.NUMERO_IDENTIDAD)
        INNER JOIN sa_tipos_estudiante AS TIPO_ESTUDIANTE ON(TIPO_ESTUDIANTE.codigo = TIPOS_ESTUDIANTE_ESTUDIANTE.codigo_tipo_estudiante);  
        
	-- Buscar por número de identidad, fecha de solicitud y tipo de solicitud
	ELSEIF pcNumeroIdentidad IS  NOT NULL AND pdFechaSolicitud IS NOT NULL AND  pnCodigoTipoSolicitud IS NOT NULL THEN
    
        
	SELECT
		PERSONA.*, ESTUDIANTE.no_cuenta AS NUMERO_CUENTA, ESTUDIANTE.indice_academico AS INDICE_ACADEMICO, 
        TIPO_ESTUDIANTE.descripcion AS DESCRIPCION_TIPO_ESTUDIANTE,
        TIPOS_SOLICITUDES.nombre as NOMBRE_TIPO_SOLICITUD, SOLICITUDES.fecha_solicitud AS FECHA_SOLICITUD 
	FROM
		(
			SELECT CONCAT(Primer_nombre,' ', Primer_apellido) AS NOMBRE,
            N_identidad AS NUMERO_IDENTIDAD
            FROM persona AS PERSONA
			WHERE
			(
				pcNumeroIdentidad IS NOT NULL 
				AND N_identidad = pcNumeroIdentidad
			)
            AND
            (
				pcNumeroIdentidad IS NOT NULL 
				AND N_identidad = pcNumeroIdentidad            
                AND pdFechaSolicitud IS NOT NULL
				AND N_identidad IN
                (
					SELECT dni_estudiante
                    FROM sa_solicitudes
                    WHERE fecha_solicitud  = pdFechaSolicitud
                )
            )
            AND
            (
				pnCodigoTipoSolicitud IS NOT NULL
                AND N_identidad IN
                (
					SELECT dni_estudiante
                    FROM sa_solicitudes
                    WHERE fecha_solicitud  = pdFechaSolicitud
                    AND sa_solicitudes.cod_tipo_solicitud = pnCodigoTipoSolicitud
                )            
            )            
        )PERSONA INNER JOIN sa_estudiantes  as ESTUDIANTE ON(ESTUDIANTE.dni = PERSONA.NUMERO_IDENTIDAD)
        INNER JOIN sa_solicitudes AS SOLICITUDES ON(SOLICITUDES.dni_estudiante = PERSONA.NUMERO_IDENTIDAD AND SOLICITUDES.fecha_solicitud = pdFechaSolicitud)
        INNER JOIN sa_tipos_solicitud AS TIPOS_SOLICITUDES ON(TIPOS_SOLICITUDES.codigo = SOLICITUDES.cod_tipo_solicitud)
        INNER JOIN sa_estudiantes_tipos_estudiantes AS TIPOS_ESTUDIANTE_ESTUDIANTE 
        ON(TIPOS_ESTUDIANTE_ESTUDIANTE.dni_estudiante = PERSONA.NUMERO_IDENTIDAD)
        INNER JOIN sa_tipos_estudiante AS TIPO_ESTUDIANTE ON(TIPO_ESTUDIANTE.codigo = TIPOS_ESTUDIANTE_ESTUDIANTE.codigo_tipo_estudiante); 
        
	-- Buscar por fecha de solicitud
	ELSEIF pcNumeroIdentidad IS NULL AND pdFechaSolicitud IS NOT NULL AND  pnCodigoTipoSolicitud IS NULL THEN
    
	SELECT
		PERSONA.*, ESTUDIANTE.no_cuenta AS NUMERO_CUENTA, ESTUDIANTE.indice_academico AS INDICE_ACADEMICO, 
        TIPO_ESTUDIANTE.descripcion AS DESCRIPCION_TIPO_ESTUDIANTE,
        TIPOS_SOLICITUDES.nombre as NOMBRE_TIPO_SOLICITUD, SOLICITUDES.fecha_solicitud AS FECHA_SOLICITUD 
	FROM
		(
			SELECT CONCAT(Primer_nombre,' ', Primer_apellido) AS NOMBRE,
            N_identidad AS NUMERO_IDENTIDAD
            FROM persona
			WHERE
            (
				N_identidad IN
                (
					SELECT dni_estudiante
                    FROM sa_solicitudes
                    WHERE fecha_solicitud  = pdFechaSolicitud
                )
            )        
        )PERSONA INNER JOIN sa_estudiantes  as ESTUDIANTE ON(ESTUDIANTE.dni = PERSONA.NUMERO_IDENTIDAD)
        INNER JOIN sa_solicitudes AS SOLICITUDES ON(SOLICITUDES.dni_estudiante = PERSONA.NUMERO_IDENTIDAD AND SOLICITUDES.fecha_solicitud = pdFechaSolicitud)
        INNER JOIN sa_tipos_solicitud AS TIPOS_SOLICITUDES ON(TIPOS_SOLICITUDES.codigo = SOLICITUDES.cod_tipo_solicitud)
        INNER JOIN sa_estudiantes_tipos_estudiantes AS TIPOS_ESTUDIANTE_ESTUDIANTE 
        ON(TIPOS_ESTUDIANTE_ESTUDIANTE.dni_estudiante = PERSONA.NUMERO_IDENTIDAD)
        INNER JOIN sa_tipos_estudiante AS TIPO_ESTUDIANTE ON(TIPO_ESTUDIANTE.codigo = TIPOS_ESTUDIANTE_ESTUDIANTE.codigo_tipo_estudiante);     
        
	        
	-- Buscar por fecha de solicitud y tipo de solicitud
	ELSEIF pcNumeroIdentidad IS NULL AND pdFechaSolicitud IS NOT NULL AND  pnCodigoTipoSolicitud IS NOT NULL THEN
    
	SELECT
		PERSONA.*, ESTUDIANTE.no_cuenta AS NUMERO_CUENTA, ESTUDIANTE.indice_academico AS INDICE_ACADEMICO, 
        TIPO_ESTUDIANTE.descripcion AS DESCRIPCION_TIPO_ESTUDIANTE,
        TIPOS_SOLICITUDES.nombre as NOMBRE_TIPO_SOLICITUD, SOLICITUDES.fecha_solicitud AS FECHA_SOLICITUD 
	FROM
		(
			SELECT CONCAT(Primer_nombre,' ', Primer_apellido) AS NOMBRE,
            N_identidad AS NUMERO_IDENTIDAD
            FROM persona AS PERSONA
			WHERE
            (       
				N_identidad IN
                (
					SELECT dni_estudiante
                    FROM sa_solicitudes
                    WHERE fecha_solicitud  = pdFechaSolicitud
                )
            )
            AND
            (
                N_identidad IN
                (
					SELECT dni_estudiante
                    FROM sa_solicitudes
                    WHERE sa_solicitudes.cod_tipo_solicitud = pnCodigoTipoSolicitud
                )            
            )            
        )PERSONA INNER JOIN sa_estudiantes  as ESTUDIANTE ON(ESTUDIANTE.dni = PERSONA.NUMERO_IDENTIDAD)
        INNER JOIN sa_solicitudes AS SOLICITUDES ON(SOLICITUDES.dni_estudiante = PERSONA.NUMERO_IDENTIDAD AND SOLICITUDES.fecha_solicitud = pdFechaSolicitud)
        INNER JOIN sa_tipos_solicitud AS TIPOS_SOLICITUDES ON(TIPOS_SOLICITUDES.codigo = SOLICITUDES.cod_tipo_solicitud)
        INNER JOIN sa_estudiantes_tipos_estudiantes AS TIPOS_ESTUDIANTE_ESTUDIANTE 
        ON(TIPOS_ESTUDIANTE_ESTUDIANTE.dni_estudiante = PERSONA.NUMERO_IDENTIDAD)
        INNER JOIN sa_tipos_estudiante AS TIPO_ESTUDIANTE ON(TIPO_ESTUDIANTE.codigo = TIPOS_ESTUDIANTE_ESTUDIANTE.codigo_tipo_estudiante);     
        
		        
	-- Buscar por tipo de solicitud
	ELSEIF pcNumeroIdentidad IS NULL AND pdFechaSolicitud IS NULL AND  pnCodigoTipoSolicitud IS NOT NULL THEN
    
        
	SELECT
		PERSONA.*, ESTUDIANTE.no_cuenta AS NUMERO_CUENTA, ESTUDIANTE.indice_academico AS INDICE_ACADEMICO, 
        TIPO_ESTUDIANTE.descripcion AS DESCRIPCION_TIPO_ESTUDIANTE,
        TIPOS_SOLICITUDES.nombre as NOMBRE_TIPO_SOLICITUD, SOLICITUDES.fecha_solicitud AS FECHA_SOLICITUD 
	FROM
		(
			SELECT CONCAT(Primer_nombre,' ', Primer_apellido) AS NOMBRE,
            N_identidad AS NUMERO_IDENTIDAD
            FROM persona AS PERSONA
			WHERE
            (
				pnCodigoTipoSolicitud IS NOT NULL
                AND N_identidad IN
                (
					SELECT dni_estudiante
                    FROM sa_solicitudes
                    WHERE sa_solicitudes.cod_tipo_solicitud = pnCodigoTipoSolicitud
                )            
            )            
        )PERSONA INNER JOIN sa_estudiantes  as ESTUDIANTE ON(ESTUDIANTE.dni = PERSONA.NUMERO_IDENTIDAD)
        INNER JOIN sa_solicitudes AS SOLICITUDES ON(SOLICITUDES.dni_estudiante = PERSONA.NUMERO_IDENTIDAD)
        INNER JOIN sa_tipos_solicitud AS TIPOS_SOLICITUDES ON(TIPOS_SOLICITUDES.codigo = SOLICITUDES.cod_tipo_solicitud)
        INNER JOIN sa_estudiantes_tipos_estudiantes AS TIPOS_ESTUDIANTE_ESTUDIANTE 
        ON(TIPOS_ESTUDIANTE_ESTUDIANTE.dni_estudiante = PERSONA.NUMERO_IDENTIDAD)
        INNER JOIN sa_tipos_estudiante AS TIPO_ESTUDIANTE ON(TIPO_ESTUDIANTE.codigo = TIPOS_ESTUDIANTE_ESTUDIANTE.codigo_tipo_estudiante);   
        
		        
	-- Buscar por tipo de solicitud e identidad
	ELSEIF pcNumeroIdentidad IS NOT NULL AND pdFechaSolicitud IS NULL AND  pnCodigoTipoSolicitud IS NOT NULL THEN        
    
        
	SELECT
		PERSONA.*, ESTUDIANTE.no_cuenta AS NUMERO_CUENTA, ESTUDIANTE.indice_academico AS INDICE_ACADEMICO, 
        TIPO_ESTUDIANTE.descripcion AS DESCRIPCION_TIPO_ESTUDIANTE,
        TIPOS_SOLICITUDES.nombre as NOMBRE_TIPO_SOLICITUD, SOLICITUDES.fecha_solicitud AS FECHA_SOLICITUD 
	FROM
		(
			SELECT CONCAT(Primer_nombre,' ', Primer_apellido) AS NOMBRE,
            N_identidad AS NUMERO_IDENTIDAD
            FROM persona AS PERSONA
			WHERE
            (
				pnCodigoTipoSolicitud IS NOT NULL
                AND N_identidad IN
                (
					SELECT dni_estudiante
                    FROM sa_solicitudes
                    WHERE sa_solicitudes.cod_tipo_solicitud = pnCodigoTipoSolicitud
                )
			)
            AND
			(
				pcNumeroIdentidad IS NOT NULL 
				AND N_identidad = pcNumeroIdentidad                
			)  
        )PERSONA INNER JOIN sa_estudiantes  as ESTUDIANTE ON(ESTUDIANTE.dni = PERSONA.NUMERO_IDENTIDAD)
        INNER JOIN sa_solicitudes AS SOLICITUDES ON(SOLICITUDES.dni_estudiante = PERSONA.NUMERO_IDENTIDAD)
        INNER JOIN sa_tipos_solicitud AS TIPOS_SOLICITUDES ON(TIPOS_SOLICITUDES.codigo = SOLICITUDES.cod_tipo_solicitud)
        INNER JOIN sa_estudiantes_tipos_estudiantes AS TIPOS_ESTUDIANTE_ESTUDIANTE 
        ON(TIPOS_ESTUDIANTE_ESTUDIANTE.dni_estudiante = PERSONA.NUMERO_IDENTIDAD)
        INNER JOIN sa_tipos_estudiante AS TIPO_ESTUDIANTE ON(TIPO_ESTUDIANTE.codigo = TIPOS_ESTUDIANTE_ESTUDIANTE.codigo_tipo_estudiante);       
    
    END IF;
    
    

END$$

DROP PROCEDURE IF EXISTS `sp_check_seguimiento`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `sp_check_seguimiento`( 
    IN numFolio_ VARCHAR(25),
	IN seguimiento INT(11)
)
BEGIN 
    DECLARE v_finished INTEGER DEFAULT 0;
    DECLARE prioridad_ INTEGER DEFAULT 0;
    DECLARE fechaIni DATE;	
	DECLARE usuario INTEGER DEFAULT 0;
	DECLARE rol TINYINT DEFAULT 0;
	DECLARE alertId INTEGER DEFAULT 0;
	
	-- declare cursor 
	DEClARE usuarios_cursor CURSOR FOR
    SELECT id_usuario FROM usuario WHERE Estado = 1;
	
	-- declare NOT FOUND handler
    DECLARE CONTINUE HANDLER
    FOR NOT FOUND SET v_finished = 1;
	
    START TRANSACTION;
	
	    SET fechaIni = (SELECT FechaCambio FROM seguimiento_historico WHERE Id_Seguimiento = seguimiento ORDER BY FechaCambio DESC LIMIT 1);
	
        IF( DATEDIFF(NOW(),DATE_ADD(fechaIni,INTERVAL 3 DAY)) > 0 ) THEN
		
		    SET prioridad_ = (SELECT sp_get_prioridad (numFolio_));
			
		    INSERT INTO alerta VALUES(NULL,numFolio_,NOW(),0);
			
			SET alertId = LAST_INSERT_ID();

		    IF(prioridad_ < 3) THEN
			    UPDATE folios SET Prioridad = prioridad_ + 1 WHERE NroFolio = numFolio_;
				INSERT INTO prioridad_folio VALUES (NULL,numFolio_,prioridad_,CURDATE());
			END IF;	
			
				OPEN usuarios_cursor;
				    usuarios_loop: LOOP
				        FETCH usuarios_cursor INTO usuario;
						
						IF v_finished = 1 THEN
					        LEAVE usuarios_loop;
                        END IF;
						
						SET rol = (SELECT Id_Rol FROM usuario WHERE id_Usuario = usuario);

						IF( rol > 39 AND rol < 51 AND prioridad_ + 1 = 2 ) THEN
						    INSERT INTO usuario_alertado VALUES (NULL,alertId,usuario);
						END IF;
						IF( rol > 49 AND prioridad_ = 3 ) THEN
						    INSERT INTO usuario_alertado VALUES (NULL,alertId,usuario);
						END IF;
				    END LOOP usuarios_loop;
				CLOSE usuarios_cursor;		
		END IF;
    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `SP_DAR_ALTA_SOLICITUD`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_DAR_ALTA_SOLICITUD`(
	IN pnCodigoSolicitud INT, -- Código de la solicitud
    IN pnNotaHimno INT, -- Nota del examen del himno en caso de que aplique
    OUT pcMensajeError VARCHAR(500) -- Parámetro para mensajes de error
)
SP:BEGIN

    DECLARE vcTempMensajeError VARCHAR(500) DEFAULT ''; -- Variable para almacenar ERRORES DE servidor
    DECLARE vnCodigoSolicitudDesactiva INT DEFAULT 2; -- Código del estado de solicitud DESACTIVADA
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    
    END;
    
    START TRANSACTION;
    
    -- Desactivar solicitud
    SET vcTempMensajeError := 'Al actualizar el estado de la solicitud';
    UPDATE sa_solicitudes
    SET cod_estado = vnCodigoSolicitudDesactiva
    WHERE codigo = pnCodigoSolicitud;
    
    -- Determinar si aplica para el himno
    IF EXISTS
    (
		SELECT cod_solicitud
		FROM sa_examenes_himno
		WHERE cod_solicitud = pnCodigoSolicitud
    )
    THEN
		BEGIN
			
			-- Actualizar la nota del himno
			SET vcTempMensajeError := 'Al actualizar la nota del himno';
            
            UPDATE sa_examenes_himno
            SET nota_himno = pnNotaHimno
            WHERE cod_solicitud = pnCodigoSolicitud;
            
        END;
	END IF;	
        
    
    COMMIT;
    
END$$

DROP PROCEDURE IF EXISTS `SP_ELIMINAR_ACONDICIONAMIENTOS`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_ELIMINAR_ACONDICIONAMIENTOS`(
    IN pnCodigoAcondicionamiento INT, -- Código de acondicionamiento (En caso de que acción sea actualizar o eliminar)
    OUT pcMensajeError VARCHAR(1000) -- Parámetro para los mensajes de error
)
SP: BEGIN
 DECLARE vcTempMensajeError VARCHAR(1000); -- Variable para anteponer los posibles mensajes de error
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN    
  ROLLBACK;
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
        END;
-- Determinar si el acondicionamiento tiene vinculacion con algun 
        SET vcTempMensajeError := 'Error determinar si acondicionamiento tiene vinculación en instancias_acondicionamientos ';
        IF EXISTS
        (
SELECT cod_acondicionamiento
            FROM ca_instancias_acondicionamientos
            WHERE cod_acondicionamiento = pnCodigoAcondicionamiento
        )
        THEN
   BEGIN
    SET pcMensajeError := 'Hay instancias_acondicionamientos que estan viculadas con este acondicionamiento, no puede ser borrada.';
                LEAVE SP;
   END;
  END IF;         
  -- Eliminar el acondicionamiento
        SET vcTempMensajeError := 'Error al eliminar el acondicionamiento';        
        START TRANSACTION;
        DELETE FROM ca_acondicionamientos
        WHERE codigo = pnCodigoAcondicionamiento;
        COMMIT;
end$$

DROP PROCEDURE IF EXISTS `SP_ELIMINAR_AREAS`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_ELIMINAR_AREAS`(
    IN pnCodigoArea INT, -- Código de area (En caso de que acción sea actualizar o eliminar)
    OUT pcMensajeError VARCHAR(1000) -- Parámetro para los mensajes de error
)
SP: BEGIN
 DECLARE vcTempMensajeError VARCHAR(1000); -- Variable para anteponer los posibles mensajes de error
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN    
  ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
        END;
-- Determinar si la area tiene vinculacion con algun proyecto
        SET vcTempMensajeError := 'Error determinar si el area tiene vinculación con algún proyecto';
        
        IF EXISTS
        (
SELECT cod_area
            FROM ca_proyectos
            WHERE cod_area = pnCodigoArea
        )
        THEN
   BEGIN
            
    SET pcMensajeError := 'Hay proyectos que estan viculados con esta area, no puede ser borrada.';
                LEAVE SP;
    
   END;
  END IF;         
        
  -- Eliminar el area
        SET vcTempMensajeError := 'Error al eliminar el area';        
        
        START TRANSACTION;
        
        DELETE FROM ca_areas
        WHERE codigo = pnCodigoArea;
        
        COMMIT;
end$$

DROP PROCEDURE IF EXISTS `sp_eliminar_categorias_folios`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `sp_eliminar_categorias_folios`(IN `sp_Id_categoria` INT, OUT `mensaje` VARCHAR(150), IN `codMensaje` TINYINT)
BEGIN 
   IF NOT EXISTS (SELECT 1 FROM folios WHERE Categoria = sp_Id_categoria) THEN 
     DELETE FROM categorias_folios WHERE Id_categoria = sp_Id_categoria; 
     SET mensaje = "Exito al eliminar la categoria de los folios"; 
     SET codMensaje = 1;  -- codigo del mensaje de salida
   ELSE
     SET mensaje = "Error al eliminar la categoria de los folios, esta esta enlazada a un folio"; -- mensaje de salida
     SET codMensaje = 0; -- codigo del mensaje de salida
   END IF; 
END$$

DROP PROCEDURE IF EXISTS `SP_ELIMINAR_CIUDADES`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_ELIMINAR_CIUDADES`(
	in pcCodigo int, -- Codigo asociado a la ciudad que queremos eliminar
	OUT `mensaje` VARCHAR(150)
)
SP: begin

   DECLARE EXIT HANDLER FOR SQLEXCEPTION
   BEGIN
     SET mensaje = "No se pudo realizar la operacion, por favor intende de nuevo dentro de un momento";
     ROLLBACK;
   END;
   
   IF EXISTS
   (
		SELECT
			cod_ciudad_origen
		FROM 	
			sa_estudiantes
		WHERE 
			cod_ciudad_origen = pcCodigo
   )
   THEN
		BEGIN
			SET mensaje = 'Existen estudiantes registrados con esta ciudad. No puede ser borrada.';
            LEAVE SP;
        END;
   END IF;
   
	delete from sa_ciudades where sa_ciudades.codigo= pcCodigo;
END$$

DROP PROCEDURE IF EXISTS `SP_ELIMINAR_ESTADOS`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_ELIMINAR_ESTADOS`(
    IN pnCodigo INT, -- Codigo de estado
    OUT pcMensajeError VARCHAR(1000) -- Parámetro para los mensajes de error
)
SP: BEGIN
 DECLARE vcTempMensajeError VARCHAR(1000); -- Variable para anteponer los posibles mensajes de error
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN    
  ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
        END;

-- Determinar si el estado tiene vinculacion con algun proyecto
        SET vcTempMensajeError := 'Error al determinar si el estado tiene vinculación con alguna carga academica';
        
        IF EXISTS
        (
	    SELECT cod_estado
            FROM ca_cargas_academicas
            WHERE cod_estado = pnCodigo
        )
        THEN
   BEGIN
            
    SET pcMensajeError := 'Existen cargas academicas vinculadas con este estado, no puede ser borrado.';
                LEAVE SP;
    
   END;
  END IF;         
        
-- Eliminar el estado
        SET vcTempMensajeError := 'Error al eliminar el estado, intentelo de nuevo';        
        
        START TRANSACTION;
        
        DELETE FROM ca_estados_carga
        WHERE codigo = pnCodigo;
        
        COMMIT;
end$$

DROP PROCEDURE IF EXISTS `sp_eliminar_estado_seguimiento`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `sp_eliminar_estado_seguimiento`( 
IN `Id_Estado_Seguimiento_` tinyint(4), 
    OUT mensaje VARCHAR(150), -- Parametro de salida
    OUT codMensaje TINYINT  -- ParamentroId_Prioridad
)
BEGIN 
   IF NOT EXISTS (SELECT 1 FROM seguimiento_historico WHERE  Id_Estado_Seguimiento = Id_Estado_Seguimiento_) THEN -- Revisa si NO hay un registro en seguimiento historico con este estado
     DELETE FROM estado_seguimiento WHERE Id_Estado_Seguimiento  = Id_Estado_Seguimiento_; -- Borra la ubicacion si no existe el registro 
     SET mensaje = "Exito al eliminar el estado de seguimiento"; -- mensaje de salida
     SET codMensaje = 1;  -- codigo del mensaje de salida
   ELSE
     SET mensaje = "Error al eliminar el estado, esta esta enlazada a un seguimiento historico"; -- mensaje de salida
     SET codMensaje = 0; -- codigo del mensaje de salida
   END IF; 
END$$

DROP PROCEDURE IF EXISTS `SP_ELIMINAR_FACULTADES`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_ELIMINAR_FACULTADES`(
IN pnCodigoFacultad INT, -- Código de facultad (En caso de que acción sea actualizar o eliminar)
OUT pcMensajeError VARCHAR(1000) -- Parámetro para los mensajes de error
)
SP: BEGIN
DECLARE vcTempMensajeError VARCHAR(1000); -- Variable para anteponer los posibles mensajes de error
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN    
ROLLBACK;    
SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
SET pcMensajeError := vcTempMensajeError;
END;
-- Determinar si la area tiene vinculacion con algun proyecto
SET vcTempMensajeError := 'Error determinar si facultad tiene vinculación en vinculaciones ';        
IF EXISTS
(
SELECT cod_facultad
FROM ca_vinculaciones
WHERE cod_facultad = pnCodigoFacultad
)
THEN
BEGIN            
SET pcMensajeError := 'Hay vinculaciones que estan viculadas con esta facultad, no puede ser borrada.';
LEAVE SP;    
END;
END IF;                 
-- Eliminar el area
SET vcTempMensajeError := 'Error al eliminar la facultad';                
START TRANSACTION;        
DELETE FROM ca_facultades
WHERE codigo = pnCodigoFacultad;        
COMMIT;
end$$

DROP PROCEDURE IF EXISTS `SP_ELIMINAR_INSTANCIA_ACONDICIONAMIENTO`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_ELIMINAR_INSTANCIA_ACONDICIONAMIENTO`(
    IN pnCodigoInstanciaA INT, -- Código de instancia_acondicionamiento (En caso de que acción sea actualizar o eliminar)
    OUT pcMensajeError VARCHAR(1000) -- Parámetro para los mensajes de error
)
SP: BEGIN
 DECLARE vcTempMensajeError VARCHAR(1000); -- Variable para anteponer los posibles mensajes de error
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN    
  ROLLBACK;
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
        END;
-- Determinar si el acondicionamiento tiene vinculacion con algun 
        SET vcTempMensajeError := 'Error determinar si la instancia_acondicionamiento tiene vinculación en aulas_instancias_acondicionamientos ';
        IF EXISTS
        (
SELECT cod_instancia_acondicionamiento
            FROM ca_aulas_instancias_acondicionamientos
            WHERE cod_instancia_acondicionamiento = pnCodigoInstanciaA
        )
        THEN
   BEGIN
    SET pcMensajeError := 'Hay aulas_instancias_acondicionamientos que estan viculadas con esta instancia_acondicionamiento, no puede ser borrada.';
                LEAVE SP;
   END;
  END IF;         
  -- Eliminar el acondicionamiento
        SET vcTempMensajeError := 'Error al eliminar la instancia_acondicionamiento';        
        START TRANSACTION;
        DELETE FROM ca_instancias_acondicionamientos
        WHERE codigo = pnCodigoInstanciaA;
        COMMIT;
end$$

DROP PROCEDURE IF EXISTS `SP_ELIMINAR_MENCION_HONORIFICA`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_ELIMINAR_MENCION_HONORIFICA`(
	in pcCodigo int, -- codigo de la mencion  que se quiere eliminar
	OUT mensaje VARCHAR(150) 
)
SP: begin

    DECLARE codMensaje INT;

   DECLARE EXIT HANDLER FOR SQLEXCEPTION
   BEGIN     
     SET mensaje = "No se pudo realizar la operacion, por favor intende de nuevo dentro de un momento";
     SET codMensaje = 0;
     ROLLBACK;
   END;
   
	delete from sa_menciones_honorificas where sa_menciones_honorificas.codigo= pcCodigo;
END$$

DROP PROCEDURE IF EXISTS `sp_eliminar_organizacion`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `sp_eliminar_organizacion`( 
    IN sp_Id_Organizacion TINYINT, 
    OUT mensaje VARCHAR(150), -- Parametro de salida
    OUT codMensaje TINYINT  -- Paramentro
)
BEGIN 
   IF NOT EXISTS (SELECT 1 FROM folios WHERE Organizacion = sp_Id_Organizacion) THEN -- Revisa si NO hay un registro en folios con esta organizacion
     DELETE FROM organizacion WHERE Id_Organizacion = sp_Id_Organizacion; -- Borra la organizacion si no existe el registro 
     SET mensaje = "Exito al eliminar la organizacion"; -- mensaje de salida
     SET codMensaje = 1;  -- codigo del mensaje de salida
   ELSE
     SET mensaje = "Error al eliminar la organizacion, esta esta enlazada a un folio"; -- mensaje de salida
     SET codMensaje = 0; -- codigo del mensaje de salida
   END IF; 
END$$

DROP PROCEDURE IF EXISTS `SP_ELIMINAR_ORIENTACION`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_ELIMINAR_ORIENTACION`(
	in pcCodigo int, -- codigo de la orientacion que se quiere eliminar
	OUT mensaje VARCHAR(150) 
)
SP: begin

    DECLARE codMensaje INT;

   DECLARE EXIT HANDLER FOR SQLEXCEPTION
   BEGIN
     SET mensaje = "No se pudo realizar la operacion, por favor intende de nuevo dentro de un momento";
     SET codMensaje = 0;
     ROLLBACK;
   END;
   
   IF EXISTS
   (
		SELECT dni
        FROM sa_estudiantes
        WHERE cod_orientacion = pcCodigo
   )
   THEN
		BEGIN
			SET mensaje := 'Existen estudiantes asociados a esta orientacion. No puede ser borrada.';
            LEAVE SP;
        END;
	END IF;
   
	delete from sa_orientaciones where sa_orientaciones.codigo= pcCodigo;
END$$

DROP PROCEDURE IF EXISTS `SP_ELIMINAR_PERIODO`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_ELIMINAR_PERIODO`(
	in pcCodigo int, -- Codigo asociado al periodo que queremos eliminar
	OUT `mensaje` VARCHAR(150)
)
SP: begin

   DECLARE EXIT HANDLER FOR SQLEXCEPTION
   BEGIN
     SET mensaje = "No se pudo realizar la operacion, por favor intende de nuevo dentro de un momento";
     ROLLBACK;
   END;   
	delete from sa_periodos where sa_periodos.codigo= pcCodigo;
END$$

DROP PROCEDURE IF EXISTS `SP_ELIMINAR_PERMISO`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_ELIMINAR_PERMISO`(
	in pcCodigo int, -- Codigo asociado al periodo que queremos eliminar
	OUT `mensaje` VARCHAR(150)
)
SP: begin

   DECLARE EXIT HANDLER FOR SQLEXCEPTION
   BEGIN
     SET mensaje = "No se pudo realizar la operacion, por favor intende de nuevo dentro de un momento";
     ROLLBACK;
   END;   
	delete from tipodepermiso where tipodepermiso.id_tipo_permiso = pcCodigo;
END$$

DROP PROCEDURE IF EXISTS `SP_ELIMINAR_PLANES_ESTUDIO`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_ELIMINAR_PLANES_ESTUDIO`(
	in pcCodigo int, -- codigo del plan que se quiere eliminar
	OUT mensaje VARCHAR(150) 
)
SP: begin

    DECLARE codMensaje INT;

   DECLARE EXIT HANDLER FOR SQLEXCEPTION
   BEGIN
     SET mensaje = "No se pudo realizar la operacion, por favor intende de nuevo dentro de un momento";
     SET codMensaje = 0;
     ROLLBACK;
   END;
   
   IF EXISTS
   (
		SELECT
			cod_plan_estudio
		FROM 
			sa_estudiantes
		WHERE cod_plan_estudio = pcCodigo
   )
   THEN
		BEGIN
			SET mensaje = 'Existen estudiantes registrados con este plan de estudio. No puede ser borrado.';
            LEAVE SP;
        END;
   END IF;
   
	delete from sa_planes_estudio where sa_planes_estudio.codigo= pcCodigo;
END$$

DROP PROCEDURE IF EXISTS `sp_eliminar_prioridad`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `sp_eliminar_prioridad`( 
	IN `Id_Prioridad_` tinyint(4),
    OUT mensaje VARCHAR(150), -- Parametro de salida
    OUT codMensaje TINYINT  -- ParamentroId_Prioridad
)
BEGIN 
   IF NOT EXISTS (SELECT 1 FROM folios WHERE  Prioridad = Id_Prioridad_) THEN -- Revisa si NO hay un registro en folios con esta prioridad
     DELETE FROM prioridad WHERE Id_Prioridad = Id_Prioridad_; -- Borra la prioridad si no existe el registro 
     SET mensaje = "Exito al eliminar la prioridad"; -- mensaje de salida
     SET codMensaje = 1;  -- codigo del mensaje de salida
   ELSE
     SET mensaje = "Error al eliminar la prioridad, esta esta enlazada a un folio"; -- mensaje de salida
     SET codMensaje = 0; -- codigo del mensaje de salida
   END IF; 
END$$

DROP PROCEDURE IF EXISTS `SP_ELIMINAR_TIPOS_DE_SOLICITUD`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_ELIMINAR_TIPOS_DE_SOLICITUD`(
IN pnCodigoTipoSolicitud INT, -- Código de area (En caso de que acción sea actualizar o eliminar)
OUT pcMensajeError VARCHAR(1000) -- Parámetro para los mensajes de error
)
SP: BEGIN
DECLARE vcTempMensajeError VARCHAR(1000); -- Variable para anteponer los posibles mensajes de error
	DECLARE EXIT HANDLER FOR SQLEXCEPTION

	BEGIN    
		ROLLBACK;    
		SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
		SET pcMensajeError := vcTempMensajeError;
	END;

-- Determinar si la area tiene vinculacion con algun proyecto
	SET vcTempMensajeError := 'Error determinar si el tipo_de_solicitud tiene vinculación en Solicitudes ';        
	IF EXISTS
	(
		SELECT cod_tipo_solicitud
		FROM sa_solicitudes
		WHERE cod_tipo_solicitud = pnCodigoTipoSolicitud
	)
	THEN
		BEGIN            
			SET pcMensajeError := 'Hay solicitudes que estan viculadas con este tipo de solicitud, no puede ser borrada.';
			LEAVE SP;    
		END;
	END IF;        
    
	-- Eliminar el area
	SET vcTempMensajeError := 'Error al eliminar el tipo de solicitud';                
	START TRANSACTION;        
    
		DELETE FROM	 sa_tipos_solicitud_tipos_alumnos
        WHERE cod_tipo_solicitud = pnCodigoTipoSolicitud;
        
		DELETE FROM sa_tipos_solicitud
		WHERE codigo = pnCodigoTipoSolicitud;        
	COMMIT;
end$$

DROP PROCEDURE IF EXISTS `SP_ELIMINAR_TIPO_DE_ESTUDIANTE`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_ELIMINAR_TIPO_DE_ESTUDIANTE`(
	in pcCodigo int, -- codigo del tipo de estudiante que se quiere eliminar
	OUT mensaje VARCHAR(150) 
)
SP: begin

    DECLARE codMensaje INT;

   DECLARE EXIT HANDLER FOR SQLEXCEPTION
   BEGIN
     SET mensaje = "No se pudo realizar la operación, por favor intente de nuevo, dentro de un momento.";
     SET codMensaje = 0;
     ROLLBACK;
   END;
   
   IF EXISTS
   (
		SELECT codigo_tipo_estudiante
        FROM sa_estudiantes_tipos_estudiantes
        WHERE codigo_tipo_estudiante = pcCodigo
   )
   THEN
		BEGIN
			SET mensaje := 'Existen estudiantes asociados a este tipo. No puede ser borrado.';
            LEAVE SP;
        END;
	END IF;
   
	delete from sa_tipos_estudiante where sa_tipos_estudiante.codigo= pcCodigo;
END$$

DROP PROCEDURE IF EXISTS `sp_eliminar_ubicacion_archivo_fisica`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `sp_eliminar_ubicacion_archivo_fisica`( 
IN `Id_UbicacionArchivoFisico_` int(5), 
    OUT mensaje VARCHAR(150), -- Parametro de salida
    OUT codMensaje TINYINT  -- ParamentroId_Prioridad
)
BEGIN 
   IF NOT EXISTS (SELECT 1 FROM folios WHERE  UbicacionFisica = Id_UbicacionArchivoFisico_) THEN -- Revisa si NO hay un registro en folios con esta ubicacion
     DELETE FROM ubicacion_archivofisico WHERE  Id_UbicacionArchivoFisico = Id_UbicacionArchivoFisico_; -- Borra la ubicacion si no existe el registro 
     SET mensaje = "Exito al eliminar la ubicacion"; -- mensaje de salida
     SET codMensaje = 1;  -- codigo del mensaje de salida
   ELSE
     SET mensaje = "Error al eliminar la ubicacion, esta esta enlazada a un folio"; -- mensaje de salida
     SET codMensaje = 0; -- codigo del mensaje de salida
   END IF; 
END$$

DROP PROCEDURE IF EXISTS `sp_eliminar_ubicacion_notificaciones`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `sp_eliminar_ubicacion_notificaciones`( 
IN `Id_UbicacionNotificaciones_` tinyint(4),
    OUT mensaje VARCHAR(150), -- Parametro de salida
    OUT codMensaje TINYINT  -- ParamentroId_Prioridad
)
BEGIN 
   IF NOT EXISTS (SELECT 1 FROM usuario_notificado WHERE  IdUbicacionNotificacion = Id_UbicacionNotificaciones_) THEN -- Revisa si NO hay un registro en usuario_notificado con esta ubicacion
     DELETE FROM ubicacion_notificaciones WHERE  Id_UbicacionNotificaciones = Id_UbicacionNotificaciones_; -- Borra la ubicacion si no existe el registro 
     SET mensaje = "Exito al eliminar la ubicacion"; -- mensaje de salida
     SET codMensaje = 1;  -- codigo del mensaje de salida
   ELSE
     SET mensaje = "Error al eliminar la ubicacion, esta esta enlazada a un folio"; -- mensaje de salida
     SET codMensaje = 0; -- codigo del mensaje de salida
   END IF; 
END$$

DROP PROCEDURE IF EXISTS `sp_eliminar_unidad_academica`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `sp_eliminar_unidad_academica`( 
	IN `Id_UnidadAcademica_` int(11), 
    OUT mensaje VARCHAR(150), -- Parametro de salida
    OUT codMensaje TINYINT  -- ParamentroId_Prioridad
)
BEGIN 
   IF NOT EXISTS (SELECT 1 FROM folios WHERE  UnidadAcademica = Id_UnidadAcademica_) THEN -- Revisa si NO hay un registro en permisos con esta unidad academica
     DELETE FROM unidad_academica WHERE Id_UnidadAcademica = Id_UnidadAcademica_; -- Borra la unidad si no existe el registro 
     SET mensaje = "Exito al eliminar el la unidad academica"; -- mensaje de salida
     SET codMensaje = 1;  -- codigo del mensaje de salida
   ELSE
     SET mensaje = "Error al eliminar la unidad, esta esta enlazada a un permiso"; -- mensaje de salida
     SET codMensaje = 0; -- codigo del mensaje de salida
   END IF; 
END$$

DROP PROCEDURE IF EXISTS `SP_GESTIONAR_AREAS_VINCULACION`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_GESTIONAR_AREAS_VINCULACION`(
	-- Descripción: Gestiona las Áreas de Vinculación.
    -- Registra, modifica y elimina en base al parámetro pnAccion
    -- pnAccion = 1 : Registrar Área de Vinculación
    -- pnAccion = 2 : Actualizar Área de Vinculación
    -- pnAccion = 3 : Registrar edificio
	-- CASalgadoMontoya 2015-07-17 Basado en el SP de LDeras SP_GESTIONAR_EDIFCIOS 2015-07-04
    
    IN pnCodigoArea INT, -- Código de Área (En caso de que acción sea actualizar o eliminar)
    IN pcNombreArea VARCHAR(200), -- Nombre del Área de Vinculación
    IN pnCodigoFacultad INT, -- Código de la Facultad asociada al Área de Vinculación
    IN pnAccion INT, -- Parámetro para determinar qué acción se realizará
    OUT pcMensajeError VARCHAR(1000) -- Parámetro para los mensajes de error
)
SP: BEGIN

	DECLARE vnAccionRegistrar INT DEFAULT 1; -- Acción que determina registrar
    DECLARE vnAccionActualizar INT DEFAULT 2; -- Acción que determina actualizar
    DECLARE vnAccionEliminar INT DEFAULT 3; -- Acción que determina elimiinar


	DECLARE vcTempMensajeError VARCHAR(1000); -- Variable para anteponer los posibles mensajes de error

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    
    END;
    
    -- **********************************REGISTRAR ÁREA DE VINCULACIÓN********************************
    IF pnAccion = vnAccionRegistrar THEN 
    
		-- Determinar que el código de área no exista ya en la base.
        SET vcTempMensajeError := 'Error al determinar existencia del Área de Vinculación.';
        
        IF EXISTS
        (
			SELECT codigo
            FROM ca_vinculaciones
            WHERE codigo = pnCodigoArea
        )
        THEN
			BEGIN
            
				SET pcMensajeError := 'Ya existe un Área de Vinculación con este código, intentelo de nuevo con otro código.';
                LEAVE SP;
				
			END;
		END IF;
        
        START TRANSACTION;
        
        -- Registrar el área
        SET vcTempMensajeError := 'Error al registrar el Área de Vinculación. ';
        
        INSERT INTO ca_vinculaciones VALUES (pnCodigoArea, pcNombreArea, pnCodigoFacultad);
        
        COMMIT;
    
    -- **********************************ACTUALIZAR ÁREA********************************
    ELSEIF pnAccion = vnAccionActualizar THEN
    
		-- Determinar que el código del área no exista en la base de datos.
        SET vcTempMensajeError := 'Error al determinar existencia del Área de Vinculación.';
        
        IF NOT EXISTS
        (
			SELECT codigo
            FROM ca_vinculaciones
            WHERE codigo = pnCodigoArea
        )
        THEN
			BEGIN
            
				SET pcMensajeError := 'Ya existe un Área de Vinculación con este código, intentelo de nuevo con otro código.';
                LEAVE SP;
				
			END;
		END IF;   
        
        START TRANSACTION;
        
        -- Actualizar el nombre y/o facultad asociadas al área de Vinculación
        SET vcTempMensajeError := 'Error al actualizar la información del Área de Vinculación.';
        
		UPDATE ca_vinculaciones 
		SET 
			nombre = pcNombreArea,
            cod_facultad = pnCodigoFacultad
		WHERE
			codigo = pnCodigoArea;
        COMMIT;
    
    -- **********************************ELIMINAR AREA********************************
    ELSE
        
		-- Eliminar el edificio
        SET vcTempMensajeError := 'Error al eliminar el Área de Vinculación.';        
        
        START TRANSACTION;
        
		DELETE FROM ca_vinculaciones
		WHERE
			codigo = pnCodigoArea;
        COMMIT;
    
    END IF;
		
END$$

DROP PROCEDURE IF EXISTS `SP_GESTIONAR_AULAS`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_GESTIONAR_AULAS`(
	-- Descripción: Gestiona las aulas en los edificios
    -- Registra, modifica y elimina en base al parámetro pnAccion
    -- pnAccion = 1 : Registrar aula
    -- pnAccion = 2 : actualizar aula
    -- pnAccion = 3 : Registrar aula
	-- LDeras 2015-07-04
    
    IN pnCodigoEdificio INT, -- Código de edificio 
    IN pcNumeroAula VARCHAR(100), -- Número de aula o nombre de aula
    IN pnCodigoAula INT, -- Código de aula (En caso de que acción sea actualizar o eliminar)
    IN pnAccion INT, -- Parámetro para determinar qué acción se realizará
    OUT pcMensajeError VARCHAR(1000) -- Parámetro para los mensajes de error
)
SP: BEGIN

	DECLARE vnAccionRegistrar INT DEFAULT 1; -- Acción que determina registrar un edificio
    DECLARE vnAccionActualizar INT DEFAULT 2; -- Acción que determina actualizar un edificio
    DECLARE vnAccionEliminar INT DEFAULT 3; -- Acción que determina eliimiinar un edificio
    
    DECLARE vnSiguienteCodigoAula INT; -- Variable para almacenar el siguiente código (NEXTVAL)


	DECLARE vcTempMensajeError VARCHAR(1000); -- Variable para anteponer los posibles mensajes de error

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError, ' ', ms );
        SET pcMensajeError := vcTempMensajeError;
    
    END;
    
    -- **********************************REGISTRAR AULA********************************
    IF pnAccion = vnAccionRegistrar THEN 
    
		-- Determinar que el número de aula no esté repetido
        SET vcTempMensajeError := 'Error al determinar existencia del número de aula';
        
        IF EXISTS
        (
			SELECT codigo
            FROM ca_aulas
            WHERE cod_edificio = pnCodigoEdificio
            AND numero_aula = pcNumeroAula
        )
        THEN
			BEGIN
            
				SET pcMensajeError := CONCAT('Ya se ha registrado un aula con el número ', pcNumeroAula, ' en este edificio. Intentelo de nuevo.');
                LEAVE SP;
				
			END;
		END IF;   

        
        START TRANSACTION;
        
        SELECT 
			IFNULL(CONVERT(MAX(codigo), SIGNED), 0)
		INTO
			vnSiguienteCodigoAula
		FROM
			ca_aulas;
        
        
        
        
        -- Registrar el edificio
        SET vcTempMensajeError := 'Error al registrar aula ';
        
        INSERT INTO ca_aulas(codigo, cod_edificio, numero_aula)
        VALUES ( CAST(vnSiguienteCodigoAula + 1 AS CHAR), pnCodigoEdificio, pcNumeroAula);
        
        COMMIT;
    
    -- **********************************ACTUALIZAR AULA********************************
    ELSEIF pnAccion = vnAccionActualizar THEN
    
		-- Determinar que el número de aula ya esté registrado
        SET vcTempMensajeError := 'Error al determinar existencia del número de aula';
        
        IF EXISTS
        (
			SELECT codigo
            FROM ca_aulas
            WHERE cod_edificio = pnCodigoEdificio
            AND numero_aula = pcNumeroAula
            AND codigo != pnCodigoAula
        )
        THEN
			BEGIN
            
				SET pcMensajeError := CONCAT('Ya se ha registrado un aula con el número ', pcNumeroAula, ' en este edificio. Intentelo de nuevo.');
                LEAVE SP;
				
			END;
		END IF;         
        
        START TRANSACTION;
        
        -- Actualizar el número de aula
        SET vcTempMensajeError := 'Error al actualizar el número de aula';
        
        UPDATE ca_aulas
        SET numero_aula = pcNumeroAula
        WHERE codigo = pnCodigoAula;
        
        COMMIT;
    
    -- **********************************ELIMINAR AULA********************************
    ELSE
    
		-- Determinar si el aula tiene acondicionamientos asignados
        SET vcTempMensajeError := 'Error determinar el aula tiene acondicionamientos asignados';
        
        IF EXISTS
        (
			SELECT cod_aula
            FROM ca_aulas_instancias_acondicionamientos
            WHERE cod_aula = pnCodigoAula
        )
        THEN
			BEGIN
            
				SET pcMensajeError := 'El aula tiene acondicionamientos asignados, no puede ser borrada.';
                LEAVE SP;
				
			END;
		END IF;         
        
		-- Eliminar el aula
        SET vcTempMensajeError := 'Error al eliminar el aula';        
        
        START TRANSACTION;
        
        DELETE FROM ca_aulas
		WHERE codigo = pnCodigoAula;
        
        COMMIT;
    
    END IF;
		
END$$

DROP PROCEDURE IF EXISTS `SP_GESTIONAR_EDIFICIOS`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_GESTIONAR_EDIFICIOS`(
	-- Descripción: Gestiona los edificios de la universidad
    -- Registra, modifica y elimina en base al parámetro pnAccion
    -- pnAccion = 1 : Registrar edificio
    -- pnAccion = 2 : actualizar edificio
    -- pnAccion = 3 : Registrar edificio
	-- LDeras 2015-07-04
    
    IN pnCodigoEdificio INT, -- Código de edificio (En caso de que acción sea actualizar o eliminar)
    IN pcDescripcion VARCHAR(200), -- Descripción del edificio
    IN pnAccion INT, -- Parámetro para determinar qué acción se realizará
    OUT pcMensajeError VARCHAR(1000) -- Parámetro para los mensajes de error
)
SP: BEGIN

	DECLARE vnAccionRegistrar INT DEFAULT 1; -- Acción que determina registrar un edificio
    DECLARE vnAccionActualizar INT DEFAULT 2; -- Acción que determina actualizar un edificio
    DECLARE vnAccionEliminar INT DEFAULT 3; -- Acción que determina eliimiinar un edificio


	DECLARE vcTempMensajeError VARCHAR(1000); -- Variable para anteponer los posibles mensajes de error

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    
    END;
    
    -- **********************************REGISTRAR EDIFICIO********************************
    IF pnAccion = vnAccionRegistrar THEN 
    
		-- Determinar que el nombre del edificio ya esté registrado
        SET vcTempMensajeError := 'Error al determinar existencia del nombre del edificio';
        
        IF EXISTS
        (
			SELECT descripcion
            FROM edificios
            WHERE descripcion = pcDescripcion
        )
        THEN
			BEGIN
            
				SET pcMensajeError := 'Ya existe un edificio con este nombre, intentelo de nuevo con otro nombre.';
                LEAVE SP;
				
			END;
		END IF;
        
        START TRANSACTION;
        
        -- Registrar el edificio
        SET vcTempMensajeError := 'Error al registrar edificio ';
        
        INSERT INTO edificios(descripcion)
        VALUES (pcDescripcion);
        
        COMMIT;
    
    -- **********************************ACTUALIZAR EDIFICIO********************************
    ELSEIF pnAccion = vnAccionActualizar THEN
    
		-- Determinar que el nombre del edificio ya esté registrado
        SET vcTempMensajeError := 'Error al determinar existencia del nombre del edificio';
        
        IF EXISTS
        (
			SELECT descripcion
            FROM edificios
            WHERE descripcion = pcDescripcion
            AND Edificio_ID != pnCodigoEdificio
        )
        THEN
			BEGIN
            
				SET pcMensajeError := 'Ya existe un edificio con este nombre, intentelo de nuevo con otro nombre.';
                LEAVE SP;
				
			END;
		END IF;    
        
        START TRANSACTION;
        
        -- Actualizar el nombre (DESCRIPCION) del edificio
        SET vcTempMensajeError := 'Error al actualizar la informaciónd el edificio ';
        
        UPDATE edificios
		SET descripcion = pcDescripcion
        WHERE Edificio_ID = pnCodigoEdificio;
        
        COMMIT;
    
    -- **********************************ELIMINAR EDIFICIO********************************
    ELSE
    
		-- Determinar si el edificio ya tiene aulas asignadas
        SET vcTempMensajeError := 'Error determinar si el edificio tiene aulas asignadas';
        
        IF EXISTS
        (
			SELECT cod_edificio
            FROM ca_aulas
            WHERE cod_edificio = pnCodigoEdificio
        )
        THEN
			BEGIN
            
				SET pcMensajeError := 'Ya hay aulas registradas en este edificio, no puede ser borrado.';
                LEAVE SP;
				
			END;
		END IF;         
        
		-- Eliminar el edificio
        SET vcTempMensajeError := 'Error al eliminar el edificio';        
        
        START TRANSACTION;
        
        DELETE FROM edificios
        WHERE Edificio_ID = pnCodigoEdificio;
        
        COMMIT;
    
    END IF;
		
END$$

DROP PROCEDURE IF EXISTS `SP_INSERTAR_AREAS`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_INSERTAR_AREAS`(
    IN pcnombre VARCHAR(50), -- Almacena el nombre de la solicitud
    OUT pcMensajeError VARCHAR(500) -- Mensaje mostrado el sistema
)
SP:BEGIN
 
	DECLARE vcTempMensajeError VARCHAR(500) DEFAULT ''; -- Variable para almacenar posibles errores no controlados de servidor
	DECLARE vnContadorArea INT DEFAULT 0; -- Variable para determinar si el nombre de solicitud ya estÃ¡ siendo usado
    DECLARE vcMensajeErrorServidor TEXT; -- Variable para almacenar el mensaje de error del servidor
    
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;    
    END;
    
     -- Determinar si el nombre de solicitud ya estÃ¡ siendo usado
    SET vcTempMensajeError := 'Error al seleccionar COUNT de nombre de usuario';
	SELECT
		COUNT(nombre)
	INTO
		vnContadorArea
	FROM
		ca_areas
	WHERE
		nombre = pcnombre;
        
        
	-- El nombre de solicitud ya estÃ¡ siendo usado
	IF vnContadorArea > 0 then
    
		SET pcMensajeError := 'El nombre de Solicitud ya esta¡ siendo usado, intenta otro';
        LEAVE SP;
    
    END IF;
    
    SET vcTempMensajeError := 'Error al crear el registro en la tabla ca_facultades';
    INSERT INTO ca_areas (nombre)
    VALUES (pcnombre);    

END$$

DROP PROCEDURE IF EXISTS `sp_insertar_categorias_folios`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `sp_insertar_categorias_folios`(
	 IN `NombreCategoria_` text, IN `DescripcionCategoria_` text,
    OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
BEGIN 

   START TRANSACTION;

   IF NOT EXISTS (SELECT 1 FROM categorias_folios WHERE NombreCategoria = NombreCategoria_) THEN 
     
     INSERT INTO categorias_folios (Id_categoria, NombreCategoria, DescripcionCategoria) 
     VALUES(null,NombreCategoria_,DescripcionCategoria_);				
     SET mensaje = "la categoria de los folios se ha insertado satisfactoriamente."; 
     SET codMensaje = 1;  
   ELSE
     SET mensaje = "esta categoria de los folios ya estÃ¡ en sistema, por favor revise el numero de la categoria que desea ingresar";
     SET codMensaje = 0;
   END IF; 
   
   COMMIT;
END$$

DROP PROCEDURE IF EXISTS `SP_INSERTAR_ESTADOS`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_INSERTAR_ESTADOS`(
    IN pcDescripcion VARCHAR(50), -- Almacena el nombre de estados
    OUT pcMensajeError VARCHAR(500) -- Mensaje mostrado el sistema
)
SP:BEGIN
 
	DECLARE vcTempMensajeError VARCHAR(500) DEFAULT ''; -- Variable para almacenar posibles errores no controlados de servidor
	DECLARE vnContadorEstados INT DEFAULT 0; -- Variable para determinar si el nombre de estado ya esta siendo usado
    DECLARE vcMensajeErrorServidor TEXT; -- Variable para almacenar el mensaje de error del servidor
    DECLARE vnCodigoEstado INT;
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;    
    END;
    
     -- Determinar si el nombre de estado ya esta siendo usado
    SET vcTempMensajeError := 'Error al determinar la existencia del estado';
	SELECT
		COUNT(descripcion)
	INTO
		vnContadorEstados
	FROM
		ca_estados_carga
	WHERE
		descripcion = pcDescripcion;
        
        
	-- El nombre de estado ya esta siendo usado
	IF vnContadorEstados > 0 then
    
		SET pcMensajeError := 'Ya existe un estado con este nombre, intente con otro nombre.';
        LEAVE SP;
    
    END IF;
    
    SELECT 
		IFNULL(MAX(codigo) + 1, 1)
	INTO
		vnCodigoEstado
	FROM 
		ca_estados_carga;
	
    
    SET vcTempMensajeError := 'Error al crear el registro, intentelo de nuevo';
    INSERT INTO ca_estados_carga (codigo, descripcion)
    VALUES (vnCodigoEstado, pcDescripcion);    

END$$

DROP PROCEDURE IF EXISTS `sp_insertar_estado_seguimiento`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `sp_insertar_estado_seguimiento`(
IN `DescripcionEstadoSeguimiento_` text,
OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
BEGIN 
   START TRANSACTION;
   IF NOT EXISTS 
		(
			SELECT 1 FROM estado_seguimiento WHERE DescripcionEstadoSeguimiento = DescripcionEstadoSeguimiento_
        ) 
	THEN 
    INSERT INTO  estado_seguimiento(DescripcionEstadoSeguimiento) 
    VALUES(DescripcionEstadoSeguimiento_);			
     
     SET mensaje = "el estado de seguimiento ha sido insertado satisfactoriamente"; 
     SET codMensaje = 1;  
   ELSE
     SET mensaje = "existe un seguimiento igual, por favor revise el numero del seguimiento que desea ingresar";
     SET codMensaje = 0;
   END IF; 
      COMMIT;
END$$

DROP PROCEDURE IF EXISTS `sp_insertar_folio`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `sp_insertar_folio`(IN `numFolio_` VARCHAR(25), IN `fechaCreacion_` DATE, IN `fechaEntrada_` TIMESTAMP, IN `personaReferente_` TEXT, IN `unidadAcademica_` INT, IN `organizacion_` INT, IN categoria_ INT, IN `descripcion_` TEXT, IN `tipoFolio_` TINYINT, IN `ubicacionFisica_` INT(5), IN `prioridad_` TINYINT, IN `seguimiento_` INT(11), IN `notas_` TEXT, IN encargado INT, OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
BEGIN 

   START TRANSACTION;

   IF NOT EXISTS (SELECT 1 FROM folios WHERE NroFolio = numFolio_) THEN 
     INSERT INTO folios (NroFolio, FechaCreacion, FechaEntrada, PersonaReferente, UnidadAcademica, Organizacion, Categoria, DescripcionAsunto, 
            TipoFolio,UbicacionFisica, Prioridad) VALUES(numFolio_,fechaCreacion_,fechaEntrada_,personaReferente_,unidadAcademica_,organizacion_, categoria_, descripcion_,
			tipoFolio_,ubicacionFisica_,prioridad_);
			
     INSERT INTO seguimiento VALUES(NULL,numFolio_,encargado,notas_,prioridad_,fechaEntrada_,NULL,seguimiento_);
	 
     INSERT INTO seguimiento_historico VALUES(NULL,LAST_INSERT_ID(),seguimiento_,notas_,prioridad_,NOW());
	 
     INSERT INTO prioridad_folio VALUES(NULL,numFolio_,prioridad_,fechaEntrada_);

     SET mensaje = "El folio ha sido insertado satisfactoriamente."; 
     SET codMensaje = 1;  
   ELSE
     SET mensaje = "El folio ya existe en sistema, por favor revise el numero del folio que desea ingresar";
     SET codMensaje = 0;
   END IF; 
   
   COMMIT;
END$$

DROP PROCEDURE IF EXISTS `sp_insertar_folio_2`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `sp_insertar_folio_2`(IN `numFolio_` VARCHAR(25), IN `fechaCreacion_` DATE, IN `fechaEntrada_` TIMESTAMP, IN `personaReferente_` TEXT, IN `unidadAcademica_` INT, IN `organizacion_` INT, IN categoria_ INT, IN `descripcion_` TEXT, IN `tipoFolio_` TINYINT, IN `ubicacionFisica_` INT(5), IN `prioridad_` TINYINT, IN `seguimiento_` INT(11), IN `notas_` TEXT, IN encargado INT, IN folioRef VARCHAR(25), OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
BEGIN 

      START TRANSACTION;

   IF NOT EXISTS (SELECT 1 FROM folios WHERE NroFolio = numFolio_) THEN 
     INSERT INTO folios (NroFolio, FechaCreacion, FechaEntrada, PersonaReferente, UnidadAcademica, Organizacion, Categoria, DescripcionAsunto, 
            TipoFolio,UbicacionFisica, Prioridad) VALUES(numFolio_,fechaCreacion_,fechaEntrada_,personaReferente_,unidadAcademica_,organizacion_, categoria_, descripcion_,
			tipoFolio_,ubicacionFisica_,prioridad_);
			
     INSERT INTO seguimiento VALUES(NULL,numFolio_,encargado,notas_,prioridad_,fechaEntrada_,NULL,seguimiento_);
	 
     INSERT INTO seguimiento_historico VALUES(NULL,LAST_INSERT_ID(),seguimiento_,notas_,prioridad_,NOW());
	 
     INSERT INTO prioridad_folio VALUES(NULL,numFolio_,prioridad_,fechaEntrada_);
     
     UPDATE folios SET NroFolioRespuesta = numFolio_ WHERE NroFolio = folioRef;
 
     SET mensaje = "El folio ha sido insertado satisfactoriamente."; 
     SET codMensaje = 1;  
   ELSE
     SET mensaje = "El folio ya existe en sistema, por favor revise el numero del folio que desea ingresar";
     SET codMensaje = 0;
   END IF; 
   
   COMMIT;
END$$

DROP PROCEDURE IF EXISTS `sp_insertar_organizacion`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `sp_insertar_organizacion`(
	 IN `nombreOrganizacion_` text, IN `ubicacion_` text,
    OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
BEGIN 

   START TRANSACTION;

   IF NOT EXISTS (SELECT 1 FROM organizacion WHERE NombreOrganizacion = nombreOrganizacion_) THEN 
     
     INSERT INTO organizacion (Id_Organizacion, NombreOrganizacion, Ubicacion) 
     VALUES(null,nombreOrganizacion_,ubicacion_);				
     SET mensaje = "la organizacion ha insertado satisfactoriamente."; 
     SET codMensaje = 1;  
   ELSE
     SET mensaje = "la organizacion ya estÃ¡ en sistema, por favor revise el numero de organizacion que desea ingresar";
     SET codMensaje = 0;
   END IF; 
   
   COMMIT;
END$$

DROP PROCEDURE IF EXISTS `sp_insertar_prioridad`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `sp_insertar_prioridad`(
IN `Id_Prioridad_` tinyint(4), 
IN `DescripcionPrioridad_` text,
 OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
BEGIN 
   START TRANSACTION;
   IF NOT EXISTS (SELECT 1 FROM prioridad WHERE Id_Prioridad = Id_Prioridad_) THEN 
     INSERT INTO  prioridad(Id_Prioridad, DescripcionPrioridad) 
     VALUES(Id_Prioridad_,DescripcionPrioridad_);			
     
     SET mensaje = "la prioridad ha sido insertado satisfactoriamente"; 
     SET codMensaje = 1;  
   ELSE
     SET mensaje = "existe una prioridad igual, por favor revise el nombre del folio que desea ingresar";
     SET codMensaje = 0;
   END IF; 
      COMMIT;
END$$

DROP PROCEDURE IF EXISTS `sp_insertar_ubicacion_archivo_fisica`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `sp_insertar_ubicacion_archivo_fisica`(
IN `DescripcionUbicacionFisica_` text,
IN `Capacidad_` int(10),
IN `TotalIngresados_` int(10),
IN `HabilitadoParaAlmacenar_` tinyint(1), OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
BEGIN 
   START TRANSACTION;
   
     INSERT INTO ubicacion_archivofisico (Id_UbicacionArchivoFisico, DescripcionUbicacionFisica, Capacidad,
     TotalIngresados,HabilitadoParaAlmacenar) 
     VALUES(NULL, DescripcionUbicacionFisica_, Capacidad_,
     TotalIngresados_,HabilitadoParaAlmacenar_);			
     
     SET mensaje = "la ubicacion ha sido insertado satisfactoriamente"; 
     SET codMensaje = 1;  
  
      COMMIT;
END$$

DROP PROCEDURE IF EXISTS `sp_insertar_ubicacion_notificacion`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `sp_insertar_ubicacion_notificacion`(
IN `DescripcionUbicacionNotificaciones_` text,
OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
BEGIN 
   START TRANSACTION;
  
     INSERT INTO ubicacion_notificaciones (Id_UbicacionNotificaciones, DescripcionUbicacionNotificaciones) 
     VALUES(NULL, DescripcionUbicacionNotificaciones_);			
     
     SET mensaje = "la ubicacion ha sido insertado satisfactoriamente"; 
     SET codMensaje = 1;  
  
      COMMIT;
END$$

DROP PROCEDURE IF EXISTS `sp_insertar_unidad_academica`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `sp_insertar_unidad_academica`( 
IN `NombreUnidadAcademica_` text,
in `UbicacionUnidadAcademica_` text,
OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
BEGIN 
   START TRANSACTION;

     INSERT INTO unidad_academica (Id_UnidadAcademica,NombreUnidadAcademica,UbicacionUnidadAcademica) 
     VALUES(NULL,NombreUnidadAcademica_,UbicacionUnidadAcademica_);			
     
     SET mensaje = "la unidad academica ha sido insertado satisfactoriamente"; 
     SET codMensaje = 1;  

      COMMIT;
END$$

DROP PROCEDURE IF EXISTS `sp_insertar_usuario`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `sp_insertar_usuario`(IN `numEmpleado_` VARCHAR(13), IN `nombre_` VARCHAR(30), IN `Password_` VARCHAR(25), IN `rol_` INT(4), IN `fechaCreacion_` DATE, OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
BEGIN 

   START TRANSACTION;

   IF NOT EXISTS (SELECT 1 FROM usuario WHERE nombre = nombre_) THEN 

     INSERT INTO usuario VALUES(NULL,numEmpleado_,nombre_,udf_Encrypt_derecho(Password_),rol_,fechaCreacion_,NULL,1,0);

     SET mensaje = "El usuario ha sido insertado satisfactoriamente."; 
     SET codMensaje = 1;  
   ELSE
     SET mensaje = "El usuario ya existe en sistema, por favor revise el nombre del usuario que desea ingresar";
     SET codMensaje = 0;
   END IF; 
   
   COMMIT;
END$$

DROP PROCEDURE IF EXISTS `sp_lee_actividades_no_terminadas_poa`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `sp_lee_actividades_no_terminadas_poa`()
begin

select id_actividad,(select nombre from indicadores where indicadores.id_Indicadores=actividades.id_indicador) as indicador,descripcion,correlativo,supuesto,justificacion,medio_verificacion,poblacion_objetivo,fecha_inicio,fecha_fin from actividades where id_actividad not in (SELECT actividades_terminadas.id_Actividad FROM actividades_terminadas) and (select fecha_Fin from poa where poa.id_Poa in (select id_Poa from objetivos_institucionales where objetivos_institucionales.id_Objetivo in (select id_ObjetivosInsitucionales from indicadores where indicadores.id_Indicadores in (select id_indicador from actividades ))) and year(fecha_Fin) = year(now())) and (select fecha_de_Inicio from poa where poa.id_Poa in (select id_Poa from objetivos_institucionales where objetivos_institucionales.id_Objetivo in (select id_ObjetivosInsitucionales from indicadores where indicadores.id_Indicadores in (select id_indicador from actividades ))) and year(fecha_de_Inicio) = year(now())) and id_indicador in (select id_indicadores from indicadores where id_ObjetivosInsitucionales in (select id_Objetivo from objetivos_institucionales where id_Poa in(select id_Poa from poa where objetivos_institucionales.id_Poa =poa.id_Poa)));
end$$

DROP PROCEDURE IF EXISTS `sp_lee_actividades_terminadas_poa`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `sp_lee_actividades_terminadas_poa`()
begin
select id_Actividad,No_Empleado,fecha,
(select nombre from indicadores where indicadores.id_Indicadores in (select id_indicador from actividades where id_actividad in (SELECT actividades_terminadas.id_Actividad FROM actividades_terminadas) and id_indicador in (select id_indicadores from indicadores where id_ObjetivosInsitucionales in (select id_Objetivo from objetivos_institucionales where id_Poa = ID_POA)))) as id_Indicador,
(select descripcion from actividades where id_actividad in (SELECT actividades_terminadas.id_Actividad FROM actividades_terminadas) and id_indicador in (select id_indicadores from indicadores where id_ObjetivosInsitucionales in (select id_Objetivo from objetivos_institucionales where objetivos_institucionales.id_Poa in(select id_Poa from poa where objetivos_institucionales.id_Poa =poa.id_Poa)))) as Descripcion,
(select correlativo from actividades where id_actividad in (SELECT actividades_terminadas.id_Actividad FROM actividades_terminadas) and id_indicador in (select id_indicadores from indicadores where id_ObjetivosInsitucionales in (select id_Objetivo from objetivos_institucionales where objetivos_institucionales.id_Poa in(select id_Poa from poa where objetivos_institucionales.id_Poa =poa.id_Poa)))) as Correlativo,
(select supuesto from actividades where id_actividad in (SELECT actividades_terminadas.id_Actividad FROM actividades_terminadas) and id_indicador in (select id_indicadores from indicadores where id_ObjetivosInsitucionales in (select id_Objetivo from objetivos_institucionales where objetivos_institucionales.id_Poa in(select id_Poa from poa where objetivos_institucionales.id_Poa =poa.id_Poa)))) as Supuesto,
(select justificacion from actividades where id_actividad in (SELECT actividades_terminadas.id_Actividad FROM actividades_terminadas) and id_indicador in (select id_indicadores from indicadores where id_ObjetivosInsitucionales in (select id_Objetivo from objetivos_institucionales where objetivos_institucionales.id_Poa in(select id_Poa from poa where objetivos_institucionales.id_Poa =poa.id_Poa)))) as Justificacion,
(select medio_verificacion from actividades where id_actividad in (SELECT actividades_terminadas.id_Actividad FROM actividades_terminadas) and id_indicador in (select id_indicadores from indicadores where id_ObjetivosInsitucionales in (select id_Objetivo from objetivos_institucionales where objetivos_institucionales.id_Poa in(select id_Poa from poa where objetivos_institucionales.id_Poa =poa.id_Poa)))) as Medio_De_Verificacion,
(select poblacion_objetivo from actividades where id_actividad in (SELECT actividades_terminadas.id_Actividad FROM actividades_terminadas) and id_indicador in (select id_indicadores from indicadores where id_ObjetivosInsitucionales in (select id_Objetivo from objetivos_institucionales where objetivos_institucionales.id_Poa in(select id_Poa from poa where objetivos_institucionales.id_Poa =poa.id_Poa)))) as Poblacion_Objetivo,
(select fecha_inicio from actividades where id_actividad in (SELECT actividades_terminadas.id_Actividad FROM actividades_terminadas) and id_indicador in (select id_indicadores from indicadores where id_ObjetivosInsitucionales in (select id_Objetivo from objetivos_institucionales where objetivos_institucionales.id_Poa in(select id_Poa from poa where objetivos_institucionales.id_Poa =poa.id_Poa)))) as Fecha_Inicio,
(select fecha_fin from actividades where id_actividad in (SELECT actividades_terminadas.id_Actividad FROM actividades_terminadas) and id_indicador in (select id_indicadores from indicadores where id_ObjetivosInsitucionales in (select id_Objetivo from objetivos_institucionales where objetivos_institucionales.id_Poa in(select id_Poa from poa where objetivos_institucionales.id_Poa =poa.id_Poa)))) as Fecha_Fin
from actividades_terminadas where actividades_terminadas.id_Actividad in (select id_actividad from actividades where id_indicador in (select id_indicadores from indicadores where id_ObjetivosInsitucionales in (select id_Objetivo from objetivos_institucionales where id_Poa in(select id_Poa from poa where objetivos_institucionales.id_Poa =poa.id_Poa))))
AND (select fecha_de_Inicio  from poa where poa.id_Poa in (select id_Poa from objetivos_institucionales where objetivos_institucionales.id_Objetivo in (select id_ObjetivosInsitucionales from indicadores where indicadores.id_Indicadores in (select id_indicador from actividades ))) and year(fecha_de_Inicio) = year(now()))
AND(select fecha_Fin as ff from poa where poa.id_Poa in (select id_Poa from objetivos_institucionales where objetivos_institucionales.id_Objetivo in (select id_ObjetivosInsitucionales from indicadores where indicadores.id_Indicadores in (select id_indicador from actividades ))) and year(fecha_Fin) = year(now()))
;
end$$

DROP PROCEDURE IF EXISTS `sp_login`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `sp_login`(IN `user_` VARCHAR(30), IN `pass` VARCHAR(25))
BEGIN
   SELECT id_Usuario,Id_Rol FROM usuario WHERE nombre = user_ AND pass = udf_Decrypt_derecho(Password) AND Estado = 1;
END$$

DROP PROCEDURE IF EXISTS `sp_log_user`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `sp_log_user`(IN `usuario_` INT(11), IN `ip` VARCHAR(45))
begin
    insert into usuario_log values (null,usuario_,now(),ip);
end$$

DROP PROCEDURE IF EXISTS `SP_MODIFICAR_ACONDICIONAMIENTOS`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_MODIFICAR_ACONDICIONAMIENTOS`(
	IN pccodigo CHAR(7), -- Almacena el codigo del acondicionamiento que se va a MODIFICAR
    IN pcnombre VARCHAR(50), -- Almacena el nombre del acondicionamiento
    OUT pcMensajeError VARCHAR(500) -- Mensaje mostrado el sistema
)
BEGIN
	DECLARE vcTempMensajeError VARCHAR(500) DEFAULT ''; -- Variable para posibles errores no control
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN    
		ROLLBACK;    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
	END;    
    SET vcTempMensajeError := 'Error al MODIFICAR el registro en la tabla ca_acondicionamientos';
    UPDATE ca_acondicionamientos SET nombre=pcnombre
    WHERE 
    codigo = pccodigo;
END$$

DROP PROCEDURE IF EXISTS `SP_MODIFICAR_AREAS`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_MODIFICAR_AREAS`(
	IN pccodigo CHAR(7), -- Almacena el codigo de la solicitud que se va a MODIFICAR
    IN pcnombre VARCHAR(50), -- Almacena el nombre de la solicitud
    OUT pcMensajeError VARCHAR(500) -- Mensaje mostrado el sistema
)
BEGIN
	DECLARE vcTempMensajeError VARCHAR(500) DEFAULT ''; -- Variable para posibles errores no controlados
    DECLARE vcMensajeErrorServidor TEXT; -- Variable para almacenar el mensaje de error del servidor
        
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN    
		ROLLBACK;    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeErrorf);
        SET pcMensajeError := vcTempMensajeError;
	END;    
    
    SET vcTempMensajeError := 'Error al MODIFICAR el registro en la tabla ca_facultads';
    UPDATE ca_areas SET nombre=pcnombre
    WHERE 
    codigo = pccodigo;
END$$

DROP PROCEDURE IF EXISTS `SP_MODIFICAR_ESTADOS`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_MODIFICAR_ESTADOS`(
	IN pnCodigo CHAR(7), -- Almacena el codigo del estado que se va a modificar
    IN pcDescripcion VARCHAR(50), -- Almacena el nombre del estado
    OUT pcMensajeError VARCHAR(500) -- Mensaje mostrado el sistema
)
SP: BEGIN

	DECLARE vcTempMensajeError VARCHAR(500); -- Variable para anteponer los posibles mensajes de error

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    
    END;

-- Determinar que el nombre del estado ya esta registrado
        SET vcTempMensajeError := 'Error al determinar la existencia del estado';
        
        IF EXISTS
        (
			SELECT descripcion
            FROM ca_estados_carga
            WHERE descripcion = pcDescripcion
            AND codigo != pnCodigo
        )
        THEN
			BEGIN
            
				SET pcMensajeError := 'Ya existe este estado, intente de nuevo con otro nombre.';
                LEAVE SP;
				
			END;
		END IF;    
        
        START TRANSACTION;
        
        -- Actualizar el nombre de estado seleccionado
    	SET vcTempMensajeError := 'Error al actualizar la información del estado ';    

        UPDATE ca_estados_carga
		SET descripcion = pcDescripcion
        WHERE codigo = pnCodigo;
        
        COMMIT;

END$$

DROP PROCEDURE IF EXISTS `SP_MODIFICAR_FACULTADES`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_MODIFICAR_FACULTADES`(
IN pccodigo CHAR(7), -- Almacena el codigo de la solicitud que se va a MODIFICAR
IN pcnombre VARCHAR(50), -- Almacena el nombre de la solicitud
OUT pcMensajeError VARCHAR(500) -- Mensaje mostrado el sistema
)
BEGIN
DECLARE vcTempMensajeError VARCHAR(500) DEFAULT ''; -- Variable para posibles errores no controlados
DECLARE vcMensajeErrorServidor TEXT; -- Variable para almacenar el mensaje de error del servidor        
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN    
ROLLBACK;    
SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
SET pcMensajeError := vcTempMensajeError;
END;        
SET vcTempMensajeError := 'Error al MODIFICAR el registro en la tabla ca_facultads';
UPDATE ca_facultades SET nombre=pcnombre
WHERE 
codigo = pccodigo;
END$$

DROP PROCEDURE IF EXISTS `SP_MODIFICAR_PERIODO`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_MODIFICAR_PERIODO`(IN `pccodigo` INT, IN `pcnombre` VARCHAR(20), IN `pcMensajeError` TEXT)
    NO SQL
BEGIN
DECLARE vcTempMensajeError VARCHAR(500) DEFAULT ''; -- Variable para posibles errores no controlados
DECLARE vcMensajeErrorServidor TEXT; -- Variable para almacenar el mensaje de error del servidor        
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN    
ROLLBACK;    
SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
SET pcMensajeError := vcTempMensajeError;
END;        
SET vcTempMensajeError := 'Error al MODIFICAR el registro en la tabla sa_periodos';
UPDATE sa_periodos SET nombre=pcnombre
WHERE 
codigo = pccodigo;
END$$

DROP PROCEDURE IF EXISTS `SP_MODIFICAR_SOLICITUDES`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_MODIFICAR_SOLICITUDES`(
	IN pccodigo CHAR(7), -- Almacena el codigo de la solicitud que se va a MODIFICAR
    IN pcnombre VARCHAR(50), -- Almacena el nombre de la solicitud
    OUT pcMensajeError VARCHAR(500) -- Mensaje mostrado el sistema
)
BEGIN
	DECLARE vcTempMensajeError VARCHAR(500) DEFAULT ''; -- Variable para posibles errores no controlados
    DECLARE vcMensajeErrorServidor TEXT; -- Variable para almacenar el mensaje de error del servidor
        
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN    
		ROLLBACK;    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
	END;    
    
    SET vcTempMensajeError := 'Error al MODIFICAR el registro en la tabla sa_tipos_solicitud';
    UPDATE sa_tipos_solicitud SET nombre=pcnombre
    WHERE 
    codigo = pccodigo;
END$$

DROP PROCEDURE IF EXISTS `SP_MODIFICAR_TIPOS_SOLICITUDES`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_MODIFICAR_TIPOS_SOLICITUDES`(
IN pccodigo CHAR(7), -- Almacena el codigo de la solicitud que se va a MODIFICAR
IN pcnombre VARCHAR(50), -- Almacena el nombre de la solicitud
OUT pcMensajeError VARCHAR(500) -- Mensaje mostrado el sistema
)
BEGIN
DECLARE vcTempMensajeError VARCHAR(500) DEFAULT ''; -- Variable para posibles errores no controlados
DECLARE vcMensajeErrorServidor TEXT; -- Variable para almacenar el mensaje de error del servidor        
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN    
ROLLBACK;    
SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
SET pcMensajeError := vcTempMensajeError;
END;        
SET vcTempMensajeError := 'Error al MODIFICAR el registro en la tabla sa_tipos_solicitud';
UPDATE sa_tipos_solicitud SET nombre=pcnombre
WHERE 
codigo = pccodigo;
END$$

DROP PROCEDURE IF EXISTS `SP_OBTENER_AREAS`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_OBTENER_AREAS`(
	-- Descripción: Obtiene los edificios relacionados con la carga académica
	-- LDeras 2015-07-04
    
    OUT pcMensajeError VARCHAR(1000) -- Parámetro para los mensajes de error
)
BEGIN


	DECLARE vcTempMensajeError VARCHAR(1000); -- Variable para anteponer los posibles mensajes de error

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    
    END;
    
    -- Obtener los edificios
    SET vcTempMensajeError := 'Error al obtener las areas';
    
    SELECT 
		codigo, nombre
	FROM
		ca_areas;
		
END$$

DROP PROCEDURE IF EXISTS `SP_OBTENER_AREAS_POYECTO`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_OBTENER_AREAS_POYECTO`(
OUT pcMensajeError VARCHAR(500))
BEGIN


	DECLARE vcTempMensajeError VARCHAR(1000); -- Variable para anteponer los posibles mensajes de error

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    
    END;
    

    SET vcTempMensajeError := 'Error al obtener las areas del proyecto';
    
    SELECT
		codigo,nombre
	FROM 
		ca_areas;

END$$

DROP PROCEDURE IF EXISTS `SP_OBTENER_AREAS_VINCULACION`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_OBTENER_AREAS_VINCULACION`(
OUT pcMensajeError VARCHAR(500) -- Para mensajes de error
)
BEGIN

	DECLARE vcTempMensajeError VARCHAR(500) DEFAULT ''; -- Variable para posibles errores no controlados
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    
    END;       

	-- Obtener Areas_Vinculacion con el respectivo enlace a Facultades
    SET vcTempMensajeError := 'Error al obtener AREAS DE VINCULACION';
	SELECT 
		ca_vinculaciones.codigo, ca_vinculaciones.nombre, ca_facultades.nombre AS facultad 
	FROM 
		ccjj.ca_vinculaciones 
	INNER JOIN 
		ccjj.ca_facultades 
	ON 
		ca_vinculaciones.cod_facultad = ca_facultades.codigo;
END$$

DROP PROCEDURE IF EXISTS `SP_OBTENER_AREAS_VINCULACIONES`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_OBTENER_AREAS_VINCULACIONES`(
OUT pcMensajeError VARCHAR(500))
BEGIN


	DECLARE vcTempMensajeError VARCHAR(1000); -- Variable para anteponer los posibles mensajes de error

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    
    END;
    
    -- Obtener las areas de vinculacion
    SET vcTempMensajeError := 'Error al obtener las areas de vincilacion de los que puede formar parte un proyecto';
    
    SELECT
		codigo,nombre
	FROM 
		ca_vinculaciones;

END$$

DROP PROCEDURE IF EXISTS `SP_OBTENER_AULAS_POR_EDIFICIO`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_OBTENER_AULAS_POR_EDIFICIO`(
	-- Descripción: Obtiene las aulas asociadas a un edificio
	-- LDeras 2015-07-04
    IN pnCodigoEdificio INT, -- Código de edificio
    OUT pcMensajeError VARCHAR(1000) -- Parámetro para los mensajes de error
)
BEGIN


	DECLARE vcTempMensajeError VARCHAR(1000); -- Variable para anteponer los posibles mensajes de error

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    
    END;
    
    -- Obtener las aulas
    SET vcTempMensajeError := 'Error al obtener aulas';
    
    SELECT 
		codigo, cod_edificio, numero_aula
	FROM
		ca_aulas
	WHERE
		cod_edificio = pnCodigoEdificio;
		
END$$

DROP PROCEDURE IF EXISTS `SP_OBTENER_CIUDADES`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_OBTENER_CIUDADES`(
	OUT pcMensajeError VARCHAR(500) -- Para mensajes de error
)
BEGIN
DECLARE vcTempMensajeError VARCHAR(500) DEFAULT ''; -- Variable para posibles errores no controlados
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    
    END;    

	-- Obtener CIUDADES
    SET vcTempMensajeError := 'Error al obtener CIUDADES';
	SELECT
		*
	FROM
		sa_ciudades;
END$$

DROP PROCEDURE IF EXISTS `SP_OBTENER_EDIFICIOS`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_OBTENER_EDIFICIOS`(
	-- Descripción: Obtiene los edificios relacionados con la carga académica
	-- LDeras 2015-07-04
    
    OUT pcMensajeError VARCHAR(1000) -- Parámetro para los mensajes de error
)
BEGIN


	DECLARE vcTempMensajeError VARCHAR(1000); -- Variable para anteponer los posibles mensajes de error

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    
    END;
    
    -- Obtener los edificios
    SET vcTempMensajeError := 'Error al obtener los edificios';
    
    SELECT 
		Edificio_ID, descripcion
	FROM
		edificios;
		
END$$

DROP PROCEDURE IF EXISTS `SP_OBTENER_ESTADOS`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_OBTENER_ESTADOS`(
	-- Descripción: Obtiene los estados existentes
    
    OUT pcMensajeError VARCHAR(1000) -- Parámetro para los mensajes de error
)
BEGIN


    DECLARE vcTempMensajeError VARCHAR(1000); -- Variable para anteponer los posibles mensajes de error

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    
    END;
    
    -- Obtener estados
    SET vcTempMensajeError := 'Error al obtener estados';
    
    SELECT 
		codigo, descripcion
	FROM
		ca_estados_carga;
		
END$$

DROP PROCEDURE IF EXISTS `SP_OBTENER_ESTUDIANTES`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_OBTENER_ESTUDIANTES`(
	-- Descripción: Obtiene los estudiantes en base a los filtros parametrizados
	-- LDeras 2015-07-03
    
    IN pcIdentidadEstudiante VARCHAR(500), -- Número de identidad del estudiante
    IN pnCodigoTipoEstudiante INT, -- Código del tipo de estudiante al que se requiere realizar el cambio
    OUT pcMensajeError VARCHAR(1000) -- Parámetro para los mensajes de error
)
BEGIN


	DECLARE vcTempMensajeError VARCHAR(1000); -- Variable para anteponer los posibles mensajes de error

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    
    END;
    
    -- Obtener los estudiantes
    SET vcTempMensajeError := 'Error al obtener los estudiantes filtrados';
    
    SELECT
		CONCAT(Primer_nombre, ' ', Segundo_nombre, ' ', Primer_apellido, ' ', Segundo_apellido) AS nombre
	FROM persona
    WHERE
		pcIdentidadEstudiante IS NOT NULL  
		AND N_identidad = pcIdentidadEstudiante
        OR pnCodigoTipoEstudiante IS NOT NULL
        AND pnCodigoTipoEstudiante IN
        (
			SELECT codigo_tipo_estudiante
            FROM sa_estudiantes_tipos_estudiantes
            WHERE dni_estudiante = N_identidad
            AND fecha_registro = 
            (
				SELECT MAX(fecha_registro)
				FROM sa_estudiantes_tipos_estudiantes
				WHERE dni_estudiante = N_identidad                
            )
        );        
END$$

DROP PROCEDURE IF EXISTS `SP_OBTENER_ESTUDIANTE_CONDUCTA`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_OBTENER_ESTUDIANTE_CONDUCTA`(IN `Identidad` VARCHAR(20), OUT `pcMensajeError` VARCHAR(500))
    NO SQL
BEGIN

    DECLARE vcTempMensajeError VARCHAR(500) DEFAULT ''; -- Variable para posibles errores no con	trolados
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    
    END;    
    
    SET  vcTempMensajeError := 'Error al obtener las solicitudes';
    
    SELECT
		concat(persona.Primer_nombre, " ", persona.Segundo_nombre, " ", persona.Primer_apellido, " ", persona.Segundo_apellido) as NOMBRE,
    	persona.N_identidad as DNI,
        sa_estudiantes.no_cuenta as CUENTA,
    	sa_estudiantes.anios_inicio_estudio as ANIO
	FROM persona
		INNER JOIN sa_estudiantes on persona.N_identidad = sa_estudiantes.dni
	WHERE persona.N_identidad = Identidad;
END$$

DROP PROCEDURE IF EXISTS `SP_OBTENER_ESTUDIANTE_CONSTANCIA`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_OBTENER_ESTUDIANTE_CONSTANCIA`(IN `Identidad` VARCHAR(20), IN `pcMensajeError` VARCHAR(500))
    NO SQL
BEGIN

    DECLARE vcTempMensajeError VARCHAR(500) DEFAULT ''; -- Variable para posibles errores no con	trolados
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    
    END;    
    
    SET  vcTempMensajeError := 'Error al obtener las solicitudes';
    
    SELECT
		concat(persona.Primer_nombre, " ", persona.Segundo_nombre, " ", persona.Primer_apellido, " ", persona.Segundo_apellido) as NOMBRE,
    	persona.N_identidad as DNI,
        sa_estudiantes.no_cuenta as CUENTA,
        sa_planes_estudio.nombre as PLANESTUDIO,
        sa_orientaciones.descripcion as ORIENTACION
	FROM persona
		INNER JOIN (sa_estudiantes 
			INNER JOIN sa_planes_estudio on sa_estudiantes.cod_plan_estudio 			= sa_planes_estudio.codigo
			INNER JOIN sa_orientaciones on sa_estudiantes.cod_orientacion = 			sa_orientaciones.codigo) 
        	on persona.N_identidad = sa_estudiantes.dni
     WHERE persona.N_identidad = Identidad;
    
END$$

DROP PROCEDURE IF EXISTS `SP_OBTENER_ESTUDIANTE_CONSTANCIA_EGRESADO`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_OBTENER_ESTUDIANTE_CONSTANCIA_EGRESADO`(IN `Identidad` VARCHAR(20), OUT `pcMensajeError` VARCHAR(500))
    NO SQL
BEGIN

    DECLARE vcTempMensajeError VARCHAR(500) DEFAULT ''; -- Variable para posibles errores no con	trolados
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    
    END;    
    
    SET  vcTempMensajeError := 'Error al obtener las solicitudes';
    
SELECT 
	concat(persona.Primer_nombre, " ", persona.Segundo_nombre, " ", persona.Primer_apellido, " ", persona.Segundo_apellido) as NOMBRE,
    persona.N_identidad AS DNI,
    sa_estudiantes.no_cuenta as CUENTA,
    sa_estudiantes.uv_acumulados as UV,
    sa_orientaciones.descripcion as ORIENTACION,
    sa_estudiantes.anios_inicio_estudio as ANIOESTUDIO
FROM persona
	INNER JOIN (sa_estudiantes INNER JOIN sa_orientaciones on sa_estudiantes.cod_orientacion = sa_orientaciones.codigo) ON persona.N_identidad = sa_estudiantes.dni
	WHERE persona.N_identidad = Identidad;
END$$

DROP PROCEDURE IF EXISTS `SP_OBTENER_INFORMACION_ESTUDIANTE`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_OBTENER_INFORMACION_ESTUDIANTE`(
	-- Descripción: Obtiene la informaciónd el estudiante a partir de su número de identidad
	-- LDeras 2015-07-01
    
    IN pcIdentidadEstudiante VARCHAR(500), -- Número de identidad del estudiante
    OUT pcMensajeError VARCHAR(1000) -- Parámetro para los mensajes de error
)
SP: BEGIN

	DECLARE vcTempMensajeError VARCHAR(1000); -- Variable para anteponer los posibles mensajes de error

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    
    END;
    
    -- Determinar si el número de identidad existe (Si el estudiante está registrado)
    SET vcTempMensajeError := 'Error al determinar si el estudiante está registrado';
    IF NOT EXISTS
    (
		SELECT N_identidad
        FROM persona
        WHERE N_identidad = pcIdentidadEstudiante
    )
    THEN
		BEGIN
			SET pcMensajeError := CONCAT('El estudiante con el número de identidad ',  pcIdentidadEstudiante, ' no existe. Inténtelo de nuevo.');
            LEAVE SP;
        END;
	END IF;
    
    -- Error al obtener la información del estudiante
    SET vcTempMensajeError := 'Error al determinar si el estudiante está registrado';
    
    SELECT
		CONCAT(Primer_nombre, ' ', Segundo_nombre, ' ', Primer_apellido, ' ', Segundo_apellido) AS nombre, TIPO_ESTUDIANTE.*
	FROM persona ,
	(
		SELECT descripcion AS tipo
        FROM sa_tipos_estudiante
        WHERE sa_tipos_estudiante.codigo IN
        (
        
			SELECT codigo_tipo_estudiante
            FROM sa_estudiantes_tipos_estudiantes
            WHERE dni_estudiante = pcIdentidadEstudiante
            AND fecha_registro = 
            (
				SELECT MAX(fecha_registro)
				FROM sa_estudiantes_tipos_estudiantes
				WHERE dni_estudiante = pcIdentidadEstudiante                
            )
        )
	)TIPO_ESTUDIANTE
    WHERE N_identidad = pcIdentidadEstudiante;
	
    
    

END$$

DROP PROCEDURE IF EXISTS `SP_OBTENER_INSTANCIAS_ACONDICIONAMIENTOS`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_OBTENER_INSTANCIAS_ACONDICIONAMIENTOS`(
IN codInstanciaA INT)
BEGIN
SELECT codigo, cod_acondicionamiento FROM ca_instancias_acondicionamientos where 
cod_acondicionamiento=codInstanciaA;
end$$

DROP PROCEDURE IF EXISTS `SP_OBTENER_MENCIONES_HONORIFICAS`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_OBTENER_MENCIONES_HONORIFICAS`(
OUT pcMensajeError VARCHAR(500) -- Para mensajes de error
)
BEGIN

	DECLARE vcTempMensajeError VARCHAR(500) DEFAULT ''; -- Variable para posibles errores no controlados
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    
    END;       

	-- Obtener MENCION
    SET vcTempMensajeError := 'Error al obtener MENCIONES HONORIFICAS';
	SELECT
		*
	FROM
		sa_menciones_honorificas;
END$$

DROP PROCEDURE IF EXISTS `SP_OBTENER_PERIODOS_ACADEMICOS`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_OBTENER_PERIODOS_ACADEMICOS`(
	-- Descripción: Obtiene periodos académicos de la universidad
	-- LDeras 2015-07-03
    
    OUT pcMensajeError VARCHAR(1000) -- Parámetro para los mensajes de error
)
BEGIN


	DECLARE vcTempMensajeError VARCHAR(1000); -- Variable para anteponer los posibles mensajes de error

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    
    END;
    
    -- Obtener los periodos académicos
    SET vcTempMensajeError := 'Error al obtener los periodos académicos';
    
    SELECT
		codigo, nombre
	FROM 
		sa_periodos;

END$$

DROP PROCEDURE IF EXISTS `SP_OBTENER_PLANES_ESTUDIO`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_OBTENER_PLANES_ESTUDIO`(
OUT pcMensajeError VARCHAR(500) -- Para mensajes de error
)
BEGIN

	DECLARE vcTempMensajeError VARCHAR(500) DEFAULT ''; -- Variable para posibles errores no controlados
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    
    END;    

	-- Obtener PLAN ESTUDIO
    SET vcTempMensajeError := 'Error al obtener PLAN DE ESTUDIO';
	SELECT
		*
	FROM
		sa_planes_estudio;
END$$

DROP PROCEDURE IF EXISTS `SP_OBTENER_SOLICITUDES`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_OBTENER_SOLICITUDES`(OUT `pcMensajeError` VARCHAR(500))
BEGIN

    DECLARE vcTempMensajeError VARCHAR(500) DEFAULT '';     
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    
    END;    
    
    SET  vcTempMensajeError := 'Error al obtener las solicitudes';
    
	SELECT 
		sa_solicitudes.codigo AS CODIGO,
		concat(Primer_nombre," ",Primer_apellido) AS NOMBRE,
		sa_solicitudes.fecha_solicitud AS FECHA_SOLICITUD,
		IF(sa_solicitudes.observaciones IS NULL, 'Niguna', sa_solicitudes.observaciones) AS OBSERVACIONES,
        sa_estados_solicitud.descripcion AS ESTADO, 
		sa_solicitudes.dni_estudiante AS DNI_ESTUDIANTE,
        sa_periodos.nombre AS PERIODO,
        sa_tipos_solicitud.nombre AS TIPO_SOLICITUD,
        (SELECT IF((SELECT COUNT(sa_examenes_himno.cod_solicitud) FROM sa_examenes_himno WHERE sa_examenes_himno.cod_solicitud = sa_solicitudes.codigo)>=1,'Si','No')) AS APLICA_PARA_HIMNO
	FROM sa_solicitudes LEFT JOIN sa_examenes_himno ON(sa_solicitudes.codigo = sa_examenes_himno.cod_solicitud) 
		 INNER JOIN sa_periodos ON(sa_solicitudes.cod_periodo = sa_periodos.codigo)
		 INNER JOIN sa_tipos_solicitud ON(sa_tipos_solicitud.codigo = sa_solicitudes.cod_tipo_solicitud)
         INNER JOIN sa_estados_solicitud ON (sa_estados_solicitud.codigo = sa_solicitudes.cod_estado)
		inner join persona on (persona.N_identidad = sa_solicitudes.dni_estudiante);
END$$

DROP PROCEDURE IF EXISTS `SP_OBTENER_SOLICITUDES_REPORTES`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_OBTENER_SOLICITUDES_REPORTES`(OUT `pcMensajeError` VARCHAR(500))
    NO SQL
BEGIN

    DECLARE vcTempMensajeError VARCHAR(500) DEFAULT '';     
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    
    END;    
    
    SET  vcTempMensajeError := 'Error al obtener las solicitudes';
    
	SELECT 
		sa_solicitudes.codigo as CODIGO,
		concat(persona.Primer_nombre, " ", persona.Primer_apellido) as NOMBRE,
    	sa_solicitudes.dni_estudiante as DNI,
    	sa_solicitudes.fecha_solicitud as FECHA,
        sa_solicitudes.fecha_exportacion as FECHAEXP,
    	sa_tipos_solicitud.nombre as TIPOSOLICITUD,
    	sa_tipos_solicitud.codigo as CODTIPOSOLICITUD 
FROM sa_solicitudes
	INNER JOIN persona on sa_solicitudes.dni_estudiante = 	persona.N_identidad
    INNER JOIN sa_tipos_solicitud on sa_solicitudes.cod_tipo_solicitud = sa_tipos_solicitud.codigo
    WHERE sa_solicitudes.cod_tipo_solicitud IN (123488, 123489, 123491,123492) OR
     sa_solicitudes.codigo IN (SELECT sa_examenes_himno.cod_solicitud FROM sa_examenes_himno WHERE sa_examenes_himno.nota_himno BETWEEN 0 AND 100);
END$$

DROP PROCEDURE IF EXISTS `SP_OBTENER_TIPOS_ESTUDIANTES`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_OBTENER_TIPOS_ESTUDIANTES`(
	-- Descripción: Obtiene los tipos de estudiantes registrados
	-- LDeras 2015-07-03
    
    OUT pcMensajeError VARCHAR(1000) -- Parámetro para los mensajes de error
)
BEGIN


	DECLARE vcTempMensajeError VARCHAR(1000); -- Variable para anteponer los posibles mensajes de error

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    
    END;
    
    -- Obtener los tipos de estudiantes
    SET vcTempMensajeError := 'Error al obtener los tipos de estudiantes';
    
    SELECT
		codigo, descripcion
	FROM 
		sa_tipos_estudiante;

END$$

DROP PROCEDURE IF EXISTS `SP_OBTENER_TIPOS_SOLICITUDES_POR_ESTUDIANTE`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_OBTENER_TIPOS_SOLICITUDES_POR_ESTUDIANTE`(
	-- Descripción: Obtiene todas los tipos de solicitudes a los que un estudiante (en base a si es de pre o post grado tiene derecho)
	-- LDeras 2015-07-01
    
    IN pcIdentidadEstudiante VARCHAR(500), -- Número de identidad del estudiante
    OUT pcMensajeError VARCHAR(1000) -- Parámetro para los mensajes de error
)
SP: BEGIN

	DECLARE vcTempMensajeError VARCHAR(1000); -- Variable para anteponer los posibles mensajes de error
    DECLARE ERROR2 VARCHAR(500); 

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    		ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    
    END;
    
    -- Determinar si el número de identidad existe (Si el estudiante está registrado)
    SET vcTempMensajeError := 'Error al determinar si el estudiante está registrado';
    IF NOT EXISTS
    (
		SELECT N_identidad
        FROM persona
        WHERE N_identidad = pcIdentidadEstudiante
    )
    THEN
		BEGIN
			SET pcMensajeError := CONCAT('El estudiante con el número de identidad ',  pcIdentidadEstudiante, ' no existe. Inténtelo de nuevo.');
            LEAVE SP;
        END;
	END IF;
    
    START TRANSACTION;
    
    -- Obtener las solicitudes 
    SET vcTempMensajeError := 'Error al obtener las solicitudes por estudiante';
    SELECT 
		codigo, nombre
	FROM
		sa_tipos_solicitud
	WHERE
		sa_tipos_solicitud.codigo IN 
        (
			SELECT cod_tipo_solicitud
            FROM sa_tipos_solicitud_tipos_alumnos
            WHERE sa_tipos_solicitud_tipos_alumnos.cod_tipo_alumno IN
            (
				SELECT codigo
                FROM sa_tipos_estudiante
                WHERE sa_tipos_estudiante.codigo IN
                (
					SELECT codigo_tipo_estudiante
					FROM sa_estudiantes_tipos_estudiantes
                    WHERE dni_estudiante = pcIdentidadEstudiante
                )
            )
        );
    
    COMMIT;
    
    

END$$

DROP PROCEDURE IF EXISTS `SP_REALIZAR_CAMBIO_TIPO_ESTUDIANTE`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_REALIZAR_CAMBIO_TIPO_ESTUDIANTE`(
	-- Descripción: Realiza un cambio de tipo de estudiante de un estudiante.
    -- Por ejemplo, puede realizar el cambio de un estudiante de pre-gado que ahora es de post-grado
	-- LDeras 2015-07-03
    
    IN pcIdentidadEstudiante VARCHAR(500), -- Número de identidad del estudiante
    IN pnCodigoTipoEstudiante INT, -- Código del tipo de estudiante al que se requiere realizar el cambio
    OUT pcMensajeError VARCHAR(1000) -- Parámetro para los mensajes de error
)
SP: BEGIN

	DECLARE vcTempMensajeError VARCHAR(1000); -- Variable para anteponer los posibles mensajes de error
    DECLARE vnCodigoTipoEstudiante INT; -- Variable para almacenar el código de tipo de estudiante actual

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    
    END;
    
    -- Determinar si el número de identidad existe (Si el estudiante está registrado)
    SET vcTempMensajeError := 'Error al determinar si el estudiante está registrado';
    IF NOT EXISTS
    (
		SELECT N_identidad
        FROM persona
        WHERE N_identidad = pcIdentidadEstudiante
    )
    THEN
		BEGIN
			SET pcMensajeError := CONCAT('El estudiante con el número de identidad ',  pcIdentidadEstudiante, ' no existe. Inténtelo de nuevo.');
            LEAVE SP;
        END;
	END IF;
    
    -- Determinar si el tipo de estudiante existe
    SET vcTempMensajeError := 'Error al determinar si el tipo de estudiante existe';
    IF NOT EXISTS
    (
		SELECT codigo
        FROM sa_tipos_estudiante
        WHERE codigo = pnCodigoTipoEstudiante
    )
    THEN
		BEGIN
			SET pcMensajeError := CONCAT('El tipo de estudiante que seleccionó no existe');
            LEAVE SP;
        END;
	END IF;    
    
    -- Obtener el código de tipo de estudiante del estudiante
    SET vcTempMensajeError := 'Error al obtener el código actual de tipo de estudiante';
    SELECT
		codigo_tipo_estudiante
	INTO
		vnCodigoTipoEstudiante
	FROM 
		sa_estudiantes_tipos_estudiantes
	WHERE
		dni_estudiante  = pcIdentidadEstudiante
	ORDER by	
		fecha_registro DESC
	LIMIT 1;
    
    -- Determinar si los tipos de estudiante son iguales
    IF vnCodigoTipoEstudiante = pnCodigoTipoEstudiante THEN
    
		SET pcMensajeError := 'No puede realizar un cambio al mismo tipo de estudiante.';
        LEAVE SP;
    
    END IF;
    
    START TRANSACTION;
    
    -- Realizar el cambio de tipo de estudiante
    SET vcTempMensajeError := 'Error al realizar el cambio de tipo de estudiante';
    INSERT INTO sa_estudiantes_tipos_estudiantes(codigo_tipo_estudiante, dni_estudiante, fecha_registro)
    VALUES(pnCodigoTipoEstudiante, pcIdentidadEstudiante, NOW());
    
    
    COMMIT;

END$$

DROP PROCEDURE IF EXISTS `SP_REGISTRAR_ACONDICIONAMIENTOS`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_REGISTRAR_ACONDICIONAMIENTOS`(
	IN pcnombre VARCHAR(50), -- Almacena el nombre del acondicionamiento
    OUT pcMensajeError VARCHAR(500) -- Mensaje mostrado el sistema
)
SP:BEGIN
	DECLARE vcTempMensajeError VARCHAR(500) DEFAULT ''; -- Variable para almacenar posibles errores no controlados de servidor
	DECLARE vnContadorAcondicionamiento INT DEFAULT 0; -- Variable para determinar si el nombre del acondicionamiento ya estÃ¡ siendo usado
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    END;    
     -- Determinar si el nombre del acondicionamiento ya estÃ¡ siendo usado
    SET vcTempMensajeError := 'Error al seleccionar COUNT de nombre del acondicionamiento';
	SELECT
		COUNT(nombre)
	INTO
		vnContadorAcondicionamiento
	FROM
		ca_acondicionamientos
	WHERE
		nombre = pcnombre;
	-- El nombre del acondicionamiento ya estÃ¡ siendo usado
	IF vnContadorAcondicionamiento > 0 then
    
		SET pcMensajeError := 'El nombre del acondicionamiento ya esta¡ siendo usado, intentelo de nuevo.';
        LEAVE SP;
    END IF;
    SET vcTempMensajeError := 'Error al crear el registro en la tabla ca_acondicionamientos';
    INSERT INTO ca_acondicionamientos (nombre)
    VALUES (pcnombre);    
END$$

DROP PROCEDURE IF EXISTS `SP_REGISTRAR_CIUDAD`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_REGISTRAR_CIUDAD`(
    IN pcnombre VARCHAR(50), -- Almacena el nombre de la ciudad
    OUT pcMensajeError VARCHAR(500) -- Mensaje mostrado el sistema
    -- Descripción: Registra una ciudad 
	-- ClaudioPaz
)
SP:BEGIN
 
	DECLARE vcTempMensajeError VARCHAR(500) DEFAULT ''; -- Variable para almacenar posibles errores no controlados de servidor
	DECLARE vnContadorSolicitud INT DEFAULT 0; -- Variable determina si el nombre ya esta introducido
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    
    END;    
    
     -- Determinar si el nombre de la ciudad ya está siendo usado
    SET vcTempMensajeError := 'Error al seleccionar COUNT de nombre de ciudad';
	SELECT
		COUNT(nombre)
	INTO
		vnContadorSolicitud
	FROM
		sa_ciudades
	WHERE
		nombre = pcnombre;
        
        
	-- Ya hay una ciudad con ese nombre
	IF vnContadorSolicitud > 0 then
    
		SET pcMensajeError := 'Esta ciudad ya esta registrada, intenta otra';
        LEAVE SP;
    
    END IF;
    
    SET vcTempMensajeError := 'Error al crear el registro';
    INSERT INTO sa_ciudades (nombre)
    VALUES (pcnombre);    

END$$

DROP PROCEDURE IF EXISTS `SP_REGISTRAR_DOCENTE`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_REGISTRAR_DOCENTE`(
	-- Descripción: Registra un docente 
	-- LDeras 2015-07-03
    
    IN pcNumeroIdentidad VARCHAR(100), -- Número de identidad
    IN pcPrimerNombre VARCHAR(200), -- Primer nombre 
    IN pcSegundoNombre VARCHAR(200), -- Segundo nombre 
    IN pcPrimerApellido VARCHAR(200), -- Primer apellido
    IN pcSegundoApellido VARCHAR(200), -- Segundo apellido
    IN pdFechaNacimiento VARCHAR(200), -- Fecha de nacimiento 
    IN pcSexo CHAR(1), 				   -- Sexo 
    IN pcDireccion VARCHAR(100), 	   -- Dirección
    IN pcEstadoCivil VARCHAR(100), 	   -- Estado civil
    IN pcNacionalidad VARCHAR(100),	   -- Nacionalidad
    IN pcCorreo VARCHAR(100), 		   -- Correo
    IN pnNumeroEmpleado INT,		   -- Número de empleado
    OUT pcMensajeError VARCHAR(1000) -- Parámetro para los mensajes de error
)
SP: BEGIN


	DECLARE vcTempMensajeError VARCHAR(1000); -- Variable para anteponer los posibles mensajes de error
    DECLARE error2 VARCHAR(500);
    -- TODO: Debe de haber una tabla para esto
    DECLARE vcCodigoEstadoEmpleado VARCHAR(20) DEFAULT 'Activo';

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    
    END;
    
    -- Determinar si el número de identidad existe 
    SET vcTempMensajeError := 'Error al determinar si la persona con número de identidad ya existe';
    IF EXISTS
    (
		SELECT N_identidad
        FROM persona
        WHERE N_identidad = pcNumeroIdentidad
    )
    THEN
		BEGIN
			SET pcMensajeError := CONCAT('Ya existe una persona con el número de identidad  ',  pcNumeroIdentidad, '. Inténtelo de nuevo.');
            LEAVE SP;
        END;
	END IF;    
    
    START TRANSACTION;
    
    
	-- Insertar en la tabla persona
    SET vcTempMensajeError := 'Error al insertar en la tabla persona';
    INSERT INTO persona (N_identidad, Primer_nombre, Segundo_nombre, Primer_apellido, Segundo_apellido, Fecha_nacimiento,
						Sexo, Direccion, Correo_electronico, Estado_Civil, Nacionalidad)
	VALUES 	(pcNumeroIdentidad, pcPrimerNombre, pcSegundoNombre, pcPrimerApellido, pcSegundoApellido, 
			pdFechaNacimiento, pcSexo, pcDireccion, pcCorreo, pcEstadoCivil, pcNacionalidad);    
            
	-- Determinar si el número de empleado 
    SET vcTempMensajeError := 'Error al determinar si el número de empleado ya se está usando';
    
    IF EXISTS
    (
		SELECT No_Empleado
        FROM empleado
        WHERE No_Empleado = pnNumeroEmpleado
    )
    THEN
		BEGIN
			SET pcMensajeError := 'El número de empleado ya está siendo usado. Inténtelo de nuevo.';
            LEAVE SP;
        END;
	END IF;
            

	-- Insertar en la empleado
    SET vcTempMensajeError := 'Error al insertar empleado';            
	INSERT INTO empleado (No_Empleado, N_identidad, Id_departamento, Fecha_ingreso, Observacion, estado_empleado)
	VALUES (pnNumeroEmpleado, pcNumeroIdentidad,'2', CURDATE(),"ninguna", 1);
    
    -- TODO: No hay una distinción entre empleados. ¿Tabla de tipos de empleados?
	
    
    COMMIT;

END$$

DROP PROCEDURE IF EXISTS `SP_REGISTRAR_ESTUDIANTE`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_REGISTRAR_ESTUDIANTE`(
-- By Carlos Salgado, Luis Deras, Axel Herrera.
	IN pc_N_identidad VARCHAR(20), -- Llave primaria del estudiante
	IN pcPrimer_nombre VARCHAR(20), -- Primer nombre del estudiante
	IN pcSegundo_nombre VARCHAR(20),  -- Segundo nombre del estudiante
    IN pcPrimer_apellido VARCHAR(45), -- Primer apellido del usuario
    IN pcSegundo_apellido VARCHAR(20), -- Segundo apellido del estudiante
	IN pdFecha_nacimiento DATE, 	-- Fecha de nacimiento del estudiante
	IN pcSexo VARCHAR(1), -- Sexo del estudiante
    -- IN pcdni CHAR(13), -- Relacion del estudiante-persona
	IN pnCiudadOrigen INT, -- Referencia a la ciudad de Origen
    IN pnResidenciaActual INT, -- Nombre de la ciudad actual en que mora el estudiante
    IN pcNumeroCuenta VARCHAR(11), -- Numero de cuenta del estudiante
    IN pccorreo VARCHAR(200), -- Correo del estudiane
    IN pccod_tipo_estudiante INT, -- Codigo del tipo de estudiante   
	IN pccod_plan_estudio INT, -- Codigo del paln de estudio de estudiante   
    IN pnuv_acumulados INT, -- UV aculadas por el estudiante
    IN pnanios_inicio_estudio INT, -- Años de estudio en la UNAH
    IN pnanios_final_estudio INT,
    IN pnindice_academico DECIMAL, -- Indice global obtenido por el estudiante
    IN pccod_mencion INT,
    IN pnOrientacionEstudiante INT, -- Orientación del estudiante
    IN pcDireccion VARCHAR(200),
    IN pcEstadoCivil VARCHAR(100),
    IN pcNacionalidad VARCHAR(100),
    IN pcTelefono VARCHAR(200),
    IN pnCodigoTitulo INT,
    OUT pcMensajeError VARCHAR(500) -- Parámetro para mensajes de error
)
SP:BEGIN

    DECLARE vcTempMensajeError VARCHAR(500) DEFAULT ''; -- Variable para almacenar ERRORES DE servidor
    DECLARE vnContadorN_identidad INT DEFAULT 0; -- Variable para determinar si ya hay un PERSONAJE
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    
    END;
    
     -- Determinar si el ID del PERSONAL ya existe
    SET vcTempMensajeError := 'Error al seleccionar el id del estudiante';
    
    SELECT 
		COUNT(N_identidad)
	INTO
		vnContadorN_identidad

	FROM
		persona
	WHERE
		N_identidad = pc_N_identidad;
        
	IF vnContadorN_identidad > 0 THEN
    
		SET pcMensajeError := 'Ya hay un sujeto con ese nombre, inténtelo de nuevo';
		LEAVE SP;
    
    END IF;
    
    START TRANSACTION;
    
     -- Registrar persona
    SET vcTempMensajeError := 'Error al insertar nuevo persona';
    INSERT INTO persona(N_identidad, Primer_nombre, Segundo_nombre,Primer_apellido, Segundo_apellido, Fecha_nacimiento, Sexo, Direccion, Correo_electronico, Estado_Civil, Nacionalidad)
    VALUES(pc_N_identidad, pcPrimer_nombre,pcSegundo_nombre,pcPrimer_apellido,pcSegundo_apellido, pdFecha_nacimiento,pcSexo, pcDireccion, pccorreo, pcEstadoCivil, pcNacionalidad);
	
    -- Registrar Estudiante
    SET vcTempMensajeError := 'Error al insertar nuevo estudiante';
    INSERT INTO sa_estudiantes(dni,anios_inicio_estudio,indice_academico,uv_acumulados,cod_plan_estudio,cod_ciudad_origen, no_cuenta, 
				fecha_registro, cod_orientacion, cod_residencia_actual, anios_final_estudio)
    VALUES (pc_N_identidad,pnanios_inicio_estudio,pnindice_academico,pnuv_acumulados,pccod_plan_estudio,pnCiudadOrigen,pcNumeroCuenta,
				CURDATE(),pnOrientacionEstudiante, pnResidenciaActual, pnanios_final_estudio);
		
	-- Registrar tipo de estudiante
    SET vcTempMensajeError := 'Error al insertar el tipo de estudiante';
    INSERT INTO sa_estudiantes_tipos_estudiantes(codigo_tipo_estudiante, dni_estudiante, fecha_registro)
    VALUES(pccod_tipo_estudiante, pc_N_identidad, NOW());
    
       -- Registrar telefono estudiante
    SET vcTempMensajeError := 'Error al insertar nuevo telefono estudiante';
    INSERT INTO telefono(Numero,N_identidad)
    VALUES (pcTelefono,pc_N_identidad);
    
       -- Registrar correo estudiante
    SET vcTempMensajeError := 'Error al insertar nuevo correo estudiante';
    INSERT INTO sa_estudiantes_correos(dni_estudiante,correo)
    VALUES(pc_N_identidad,pccorreo);
    
       -- Registrar menciones 
    SET vcTempMensajeError := 'Error al insertar nuevo mencion honorifica estudiante';
    INSERT INTO sa_estudiantes_menciones_honorificas(dni_estudiante,cod_mencion)
    VALUES(pc_N_identidad,pccod_mencion);
    
    COMMIT;
    
END$$

DROP PROCEDURE IF EXISTS `SP_REGISTRAR_FACULTADES`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_REGISTRAR_FACULTADES`(
IN pcnombre VARCHAR(50), -- Almacena el nombre de la facultad
OUT pcMensajeError VARCHAR(500) -- Mensaje mostrado el sistema
)
SP:BEGIN
DECLARE vcTempMensajeError VARCHAR(500) DEFAULT ''; -- Variable para almacenar posibles errores no controlados de servidor
DECLARE vnContadorFacultad INT DEFAULT 0; -- Variable para determinar si el nombre de la facultad ya estÃ¡ siendo usado    
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN    
ROLLBACK;    
SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
SET pcMensajeError := vcTempMensajeError;    
END;        
-- Determinar si el nombre de la facultad ya estÃ¡ siendo usado
SET vcTempMensajeError := 'Error al seleccionar COUNT de nombre de la facultad';
SELECT
COUNT(nombre)
INTO
vnContadorFacultad
FROM
ca_facultades
WHERE
nombre = pcnombre;        
-- El nombre de la facultad ya estÃ¡ siendo usado
IF vnContadorFacultad > 0 then    
SET pcMensajeError := 'El nombre de la facultad ya esta¡ siendo usado, intentelo de nuevo.';
LEAVE SP;    
END IF;    
SET vcTempMensajeError := 'Error al crear el registro en la tabla ca_facultades';
INSERT INTO ca_facultades (nombre)
VALUES (pcnombre);    
END$$

DROP PROCEDURE IF EXISTS `SP_REGISTRAR_INSTANCIA_ACONDICIONAMIENTO`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_REGISTRAR_INSTANCIA_ACONDICIONAMIENTO`(
	IN pcnombre VARCHAR(50), -- Almacena el nombre de la instancia_acondicionamiento
    OUT pcMensajeError VARCHAR(500) -- Mensaje mostrado el sistema
)
SP:BEGIN
	DECLARE vcTempMensajeError VARCHAR(500) DEFAULT ''; -- Variable para almacenar posibles errores no controlados de servidor
	DECLARE vnContadorInstanciaAcondicionamiento INT DEFAULT 0; -- Variable para determinar si el nombre de la instancia_acondicionamiento ya estÃ¡ siendo usado
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    END;    
     -- Determinar si el nombre de la  instancia_acondicionamiento ya estÃ¡ siendo usado
    SET vcTempMensajeError := 'Error al seleccionar COUNT de nombre de la instancia_acondicionamiento';
	SELECT
		COUNT(cod_acondicionamiento)
	INTO
		vnContadorInstanciaAcondicionamiento
	FROM
		ca_instancias_acondicionamientos
	WHERE
		cod_acondicionamiento = pcnombre;
    
    SET vcTempMensajeError := 'Error al crear el registro en la tabla ca_instancias_acondicionamientos';
    INSERT INTO ca_instancias_acondicionamientos (cod_acondicionamiento)
    VALUES (pcnombre);    
END$$

DROP PROCEDURE IF EXISTS `SP_REGISTRAR_MENCION_HONORIFICA`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_REGISTRAR_MENCION_HONORIFICA`(
    IN pcDescripcion VARCHAR(50), -- Almacena el nombre de la mencion honorifica
    OUT pcMensajeError VARCHAR(500) -- Mensaje mostrado el sistema
    -- Descripción: Registra una nueva mencion Honorifica
	-- ClaudioPaz
)
SP:BEGIN
 
	DECLARE vcTempMensajeError VARCHAR(500) DEFAULT ''; -- Variable para almacenar posibles errores no controlados de servidor
	DECLARE vnContadorSolicitud INT DEFAULT 0; -- Variable determina si el nombre ya esta introducido
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    
    END;    
    
     -- Determinar si el nombre mencion ya está siendo usado
    SET vcTempMensajeError := 'Error al seleccionar COUNT de nombre de mencion';
	SELECT
		COUNT(descripcion)
	INTO
		vnContadorSolicitud
	FROM
		sa_menciones_honorificas
	WHERE
		descripcion = pcDescripcion;
        
        
	-- Ya hay una mencion con ese nombre
	IF vnContadorSolicitud > 0 then
    
		SET pcMensajeError := 'Esta mencion ya esta registrada, intenta otra';
        LEAVE SP;
    
    END IF;
    
    SET vcTempMensajeError := 'Error al crear el registro';
    INSERT INTO sa_menciones_honorificas (descripcion)
    VALUES (pcDescripcion);    

END$$

DROP PROCEDURE IF EXISTS `SP_REGISTRAR_ORIENTACIONES`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_REGISTRAR_ORIENTACIONES`(
    IN pcDescripcion VARCHAR(50), -- Almacena el nombre de la orientacion
    OUT pcMensajeError VARCHAR(500) -- Mensaje mostrado el sistema
    -- Descripción: Registra una nueva Oreitnacione
	-- ClaudioPaz
)
SP:BEGIN
 
	DECLARE vcTempMensajeError VARCHAR(500) DEFAULT ''; -- Variable para almacenar posibles errores no controlados de servidor
	DECLARE vnContadorSolicitud INT DEFAULT 0; -- Variable determina si el nombre ya esta introducido
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    
    END;    
    
     -- Determinar si el orientacion ya está siendo usado
    SET vcTempMensajeError := 'Error al seleccionar COUNT de nombre de la orientacion';
	SELECT
		COUNT(descripcion)
	INTO
		vnContadorSolicitud
	FROM
		sa_orientaciones
	WHERE
		descripcion = pcDescripcion;
        
        
	-- Ya hay una oreitnacion con ese nombre
	IF vnContadorSolicitud > 0 then
    
		SET pcMensajeError := 'Esta orientacion ya esta registrada, intenta otra';
        LEAVE SP;
    
    END IF;
    
    SET vcTempMensajeError := 'Error al crear el registro';
    INSERT INTO sa_orientaciones (descripcion)
    VALUES (pcDescripcion);    

END$$

DROP PROCEDURE IF EXISTS `SP_REGISTRAR_PERIODO`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_REGISTRAR_PERIODO`(
    IN pcnombre VARCHAR(50), -- Almacena el nombre del periodo
    OUT pcMensajeError VARCHAR(500) -- Mensaje mostrado el sistema
    -- Descripción: Registra un periodo
	-- ClaudioPaz
)
SP:BEGIN
 
	DECLARE vcTempMensajeError VARCHAR(500) DEFAULT ''; -- Variable para almacenar posibles errores no controlados de servidor
	DECLARE vnContadorSolicitud INT DEFAULT 0; -- Variable determina si el nombre ya esta introducido
    DECLARE vnCodigoPeriodo INT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    
    END;    
    
     -- Determinar si el nombre del periodo ya está siendo usado
    SET vcTempMensajeError := 'Error al seleccionar COUNT de nombre del periodo';
	SELECT
		COUNT(nombre)
	INTO
		vnContadorSolicitud
	FROM
		sa_periodos
	WHERE
		nombre = pcnombre;
        
        
	-- Ya hay un periodo con ese nombre
	IF vnContadorSolicitud > 0 then
    
		SET pcMensajeError := 'Este periodo ya esta registrado, intenta otra';
        LEAVE SP;
    
    END IF;
    
    SELECT 
		IFNULL(MAX(codigo) + 1, 1)
	INTO
		vnCodigoPeriodo
	FROM 
		sa_periodos;    
    
    SET vcTempMensajeError := 'Error al crear el registro';
    INSERT INTO sa_periodos (codigo, nombre)
    VALUES (vnCodigoPeriodo, pcnombre);    

END$$

DROP PROCEDURE IF EXISTS `SP_REGISTRAR_PERMISO`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_REGISTRAR_PERMISO`(
    IN pcnombre VARCHAR(50), -- Almacena el nombre del periodo
    OUT pcMensajeError VARCHAR(500) -- Mensaje mostrado el sistema

    -- Descripción: Registra un periodo


)
SP:BEGIN
 
	DECLARE vcTempMensajeError VARCHAR(500) DEFAULT ''; -- Variable para almacenar posibles errores no controlados de servidor
	DECLARE vnContadorSolicitud INT DEFAULT 0; -- Variable determina si el nombre ya esta introducido
    DECLARE vnCodigoPeriodo INT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;

    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    
    END;    
    
     -- Determinar si el nombre del periodo ya está siendo usado
    SET vcTempMensajeError := 'Error al seleccionar COUNT  el nombre del tipo de permiso';
	SELECT
		COUNT(tipo_permiso)
	INTO
		vnContadorSolicitud
	FROM
		tipodepermiso
	WHERE
		tipo_permiso = pcnombre;
        
        
	-- Ya hay un permiso  con ese nombre
	IF vnContadorSolicitud > 0 then
    
		SET pcMensajeError := 'Este periodo ya esta registrado, intenta otra';
        LEAVE SP;
    
    END IF;
    
    SELECT 
		IFNULL(MAX(id_tipo_permiso) + 1, 1)
	INTO
		vnCodigoPeriodo
	FROM 
		tipodepermiso;    
    
    SET vcTempMensajeError := 'Error al crear el registro';
    INSERT INTO tipodepermiso (id_tipo_permiso,tipo_permiso)
    VALUES (vnCodigoPeriodo, pcnombre);    

END$$

DROP PROCEDURE IF EXISTS `SP_REGISTRAR_PLAN_ESTUDIO`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_REGISTRAR_PLAN_ESTUDIO`(
    IN pcnombre VARCHAR(50), -- Almacena el nombre de el plan de estudio
    OUT pcMensajeError VARCHAR(500) -- Mensaje mostrado el sistema
)
SP: BEGIN
 
	DECLARE vcTempMensajeError VARCHAR(500) DEFAULT ''; -- Variable para almacenar posibles errores no controlados de servidor
	DECLARE vnContadorSolicitud INT DEFAULT 0; -- Variable determina si el nombre ya esta introducido
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    
    END;    
    
     -- Determinar si el nombre del plan ya esta siendo usado
    SET vcTempMensajeError := 'Error al seleccionar COUNT del plan';
	SELECT
		COUNT(nombre)
	INTO
		vnContadorSolicitud
	FROM
		sa_planes_estudio
	WHERE
		nombre = pcnombre;
        
        
	-- Ya hay un plan con ese nombre
	IF vnContadorSolicitud > 0 then
    
		SET pcMensajeError := 'Ya hay un plan con ese nombre, intente otro';
        LEAVE SP;
    
    END IF;
    
    SET vcTempMensajeError := 'Error al crear el registro.';
    INSERT INTO sa_planes_estudio (nombre)
    VALUES (pcnombre);    

END$$

DROP PROCEDURE IF EXISTS `SP_REGISTRAR_PROYECTO`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_REGISTRAR_PROYECTO`(
    IN pcCod_Area INT,IN pcCod_Vinculacion INT,IN pcNombre VARCHAR(100),OUT pcMensajeError VARCHAR(500))
BEGIN


	DECLARE vcTempMensajeError VARCHAR(1000); -- Variable para anteponer los posibles mensajes de error

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    
    END;
      
    SET vcTempMensajeError := 'Error al registrar el proyecto';
    
    
        INSERT INTO ca_proyectos(cod_area,cod_vinculacion,nombre)
		VALUES 	(pcCod_Area,pcCod_Vinculacion,pcNombre);

END$$

DROP PROCEDURE IF EXISTS `SP_REGISTRAR_SOLICITUD`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_REGISTRAR_SOLICITUD`(IN `pcIdentidadEstudiante` VARCHAR(500), IN `pcTipoSolicitud` INT, IN `pnCodigoPeriodo` INT, IN `pbSolicitudEsDeHimno` BOOLEAN, IN `pdFechaSolicitudExamen` DATE, OUT `pcMensajeError` VARCHAR(1000))
SP: BEGIN

	DECLARE vcTempMensajeError VARCHAR(1000);     DECLARE vnCodigoEstadoSolicitudActiva INT DEFAULT 1;     DECLARE vnCodigoNuevoRegistroSolicitud INT;     
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    
    END;
    
        SET vcTempMensajeError := 'Error al determinar si el estudiante está registrado';
    IF NOT EXISTS
    (
		SELECT N_identidad
        FROM persona
        WHERE N_identidad = pcIdentidadEstudiante
    )
    THEN
		BEGIN
			SET pcMensajeError := CONCAT('El estudiante con el número de identidad ',  pcIdentidadEstudiante, ' no existe. Inténtelo de nuevo.');
            LEAVE SP;
        END;
	END IF;
	
    START TRANSACTION;
    
        SET vcTempMensajeError := 'Error al registrar la solicitud ';
    
    INSERT INTO sa_solicitudes(fecha_solicitud, dni_estudiante, cod_periodo, cod_estado, cod_tipo_solicitud)
    VALUES (CURDATE(), pcIdentidadEstudiante, pnCodigoPeriodo, vnCodigoEstadoSolicitudActiva, pcTipoSolicitud);
    
    SET vnCodigoNuevoRegistroSolicitud := LAST_INSERT_ID();
    SET pbSolicitudEsDeHimno := (SELECT IF(COUNT(codigo)>=1,0,1) FROM sa_tipos_solicitud WHERE sa_tipos_solicitud.nombre like '%himno%' AND codigo = pcTipoSolicitud);
    
    IF pbSolicitudEsDeHimno = 0 THEN

				SET vcTempMensajeError := 'Error al registrar el examen de himno';
		INSERT INTO sa_examenes_himno(cod_solicitud, fecha_examen_himno, fecha_solicitud)
		VALUES(vnCodigoNuevoRegistroSolicitud, pdFechaSolicitudExamen, CURDATE());
    
    END IF;
    

    COMMIT;
    

END$$

DROP PROCEDURE IF EXISTS `SP_REGISTRAR_TIPO_DE_ESTUDIANTE`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_REGISTRAR_TIPO_DE_ESTUDIANTE`(
    IN pcnombre VARCHAR(50), -- Almacena el nombre del tipo de estudiante
    OUT pcMensajeError VARCHAR(500) -- Mensaje mostrado el sistema

)
SP:BEGIN
 
	DECLARE vcTempMensajeError VARCHAR(500) DEFAULT ''; -- Variable para almacenar posibles errores no controlados de servidor
	DECLARE vnContadorSolicitud INT DEFAULT 0; -- Variable determina si el nombre ya esta introducido
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    
    END;    
    
     -- Determinar si el nombre del tipo de estudiante ya está siendo usado
    SET vcTempMensajeError := 'Error al seleccionar COUNT de tipo de estudiante';
	SELECT
		COUNT(descripcion)
	INTO
		vnContadorSolicitud
	FROM
		sa_tipos_estudiante
	WHERE
		descripcion = pcnombre;
        
        
	-- Ya hay un tipo de estudiante con ese nombre
	IF vnContadorSolicitud > 0 then
    
		SET pcMensajeError := 'Este tipo de estudiante ya está registrado, intente con uno nuevo';
        LEAVE SP;
    
    END IF;
    
    SET vcTempMensajeError := 'Error al crear el registro';
    INSERT INTO sa_tipos_estudiante (descripcion)
    VALUES (pcnombre);    

END$$

DROP PROCEDURE IF EXISTS `SP_REGISTRAR_TIPO_SOLICITUD`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_REGISTRAR_TIPO_SOLICITUD`(
	IN pcnombre VARCHAR(50), -- Almacena el nombre de la solicitud
    IN pnCodigoTipoEstudiante INT, -- Código que determina para qué tipos de estudiantes será la solicitud
    OUT pcMensajeError VARCHAR(500) -- Mensaje mostrado el sistema
)
SP:BEGIN
 
	DECLARE vcTempMensajeError VARCHAR(500) DEFAULT ''; -- Variable para almacenar posibles errores no controlados de servidor
	DECLARE vnContadorSolicitud INT DEFAULT 0; -- Variable para determinar si el nombre de solicitud ya está siendo usado
    DECLARE vnNuevoCodigoSolicitud INT; -- Variable para almacenar el nuevo código que resulta para la tabla de tipos solicitudes
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    
    END;    
    
     -- Determinar si el nombre de solicitud ya está siendo usado
    SET vcTempMensajeError := 'Error al seleccionar COUNT de nombre de usuario';
	SELECT
		COUNT(nombre)
	INTO
		vnContadorSolicitud
	FROM
		sa_tipos_solicitud
	WHERE
		nombre = pcnombre;
        
        
	-- El nombre de solicitud ya está siendo usado
	IF vnContadorSolicitud > 0 then
    
		SET pcMensajeError := 'El nombre de solicitud ya está siendo usado, inténtelo de nuevo.';
        LEAVE SP;
    
    END IF;
    
    START TRANSACTION;
    
    SET vcTempMensajeError := 'Error al crear el registro en la tabla sa_tipos_solicitud';
    INSERT INTO sa_tipos_solicitud (nombre)
    VALUES (pcnombre);
    
    SET vcTempMensajeError := 'Error al obtener el código del tipo de solicitud';
    SET vnNuevoCodigoSolicitud := LAST_INSERT_ID();
    
    SET vcTempMensajeError := 'Error al insertar en la tabla SA_TIPOS_SOLICITUD_TIPOS_ALUMNOS';
    INSERT INTO sa_tipos_solicitud_tipos_alumnos(cod_tipo_solicitud,cod_tipo_alumno)
    VALUES(vnNuevoCodigoSolicitud, pnCodigoTipoEstudiante);
    
    COMMIT;

END$$

DROP PROCEDURE IF EXISTS `SP_REPORTE_CARGA_ACADEMICA`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_REPORTE_CARGA_ACADEMICA`(IN `pcAnio` YEAR, IN `pcPeriodo` INT)
SELECT
		ca.codigo,ca.cod_periodo,p.Primer_nombre, p.Primer_apellido,
        clases.Clase,cu.cod_seccion,ca_secciones.hora_inicio,hora_fin 
	FROM
		ca_cargas_academicas ca
        inner join persona p on ca.dni_empleado = p.N_identidad
        inner join ca_cursos cu on ca.codigo = cod_carga
        inner join clases on clases.ID_Clases = cu.cod_asignatura
        inner join ca_secciones on ca_secciones.codigo = cu.cod_seccion
	where
		ca.anio = pcAnio and pcPeriodo = ca.cod_periodo$$

DROP PROCEDURE IF EXISTS `SP_REPORTE_PROYECTOS`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_REPORTE_PROYECTOS`(
	OUT pcMensajeError VARCHAR(500) -- Para mensajes de error
)
BEGIN

    DECLARE vcTempMensajeError VARCHAR(500) DEFAULT ''; -- Variable para posibles errores no con	trolados
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    
    END;  
    
    
    SELECT 
		PROYECTOS.codigo AS CODIGO_PROYECTO,
		PROYECTOS.nombre AS PROYECTO_NOMBRE,
        VINCULACIONES.nombre AS VINCULACION_NOMBRE,
        AREAS.nombre AS NOMBRE_AREA,
        CONCAT(Primer_nombre, ' ', Primer_apellido) AS NOMBRE_COORDINADOR
    FROM    
		ca_proyectos PROYECTOS INNER JOIN ca_vinculaciones VINCULACIONES ON(PROYECTOS.cod_vinculacion =  VINCULACIONES.codigo)
        INNER JOIN ca_areas AREAS ON(AREAS.codigo = PROYECTOS.cod_area)
        INNER JOIN ca_empleados_proyectos EMPLEADOS_PROYECTOS ON (EMPLEADOS_PROYECTOS.cod_proyecto = PROYECTOS.codigo)
        INNER JOIN ca_roles_proyecto EMPLEADOS_ROLES_PROYECTO ON (EMPLEADOS_PROYECTOS.cod_rol_proyecto = EMPLEADOS_ROLES_PROYECTO.codigo)
		INNER JOIN persona PERSONA ON (PERSONA.N_identidad = EMPLEADOS_PROYECTOS.dni_empleado);
        
		
    
    

END$$

DROP PROCEDURE IF EXISTS `SP_REPROGRAMAR_SOLICITUD`$$
CREATE DEFINER=`ddvderecho`@`localhost` PROCEDURE `SP_REPROGRAMAR_SOLICITUD`(
	IN pnCodigoSolicitud INT, -- Código de la solicitud a reprogramar
    IN pdFechaNuevaSolicitud DATE, -- Fecha de la nueva solicitud
    IN pdFechaNuevaHimno DATE, -- Fecha de aplicación para examen del himno en caso de que la solicitud anterior aplique para himno
    OUT pcMensajeError VARCHAR(1000) -- Parámetro para los mensajes de error
)
SP: BEGIN

	DECLARE vcTempMensajeError VARCHAR(1000); -- Variable para anteponer los posibles mensajes de error
    DECLARE vnCodigoSolicitudActiva INT DEFAULT 1; -- Código del estado de solicitud DESACTIVADA
    DECLARE vnCodigoSolicitudDesactiva INT DEFAULT 2; -- Código del estado de solicitud DESACTIVADA
    
    DECLARE vnCodigoNuevaSolicitud INT; -- Variable para almacenar el código de la nueva solicitud generada

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		
		ROLLBACK;
    
        SET vcTempMensajeError := CONCAT('Error: ', vcTempMensajeError);
        SET pcMensajeError := vcTempMensajeError;
    
    END;
    
    START TRANSACTION;
    
    -- Desactivar solicitud
    SET vcTempMensajeError := 'Al actualizar el estado de la solicitud';
    UPDATE sa_solicitudes
    SET cod_estado = vnCodigoSolicitudDesactiva
    WHERE codigo = pnCodigoSolicitud;
    
    -- Registrar nueva solicitud
    SET vcTempMensajeError := 'Al registrar la nueva solicitud';
    INSERT INTO sa_solicitudes(fecha_solicitud, dni_estudiante, cod_periodo, cod_tipo_solicitud, cod_solicitud_padre, cod_estado)    
	SELECT NOW(), dni_estudiante, cod_periodo, cod_tipo_solicitud, pnCodigoSolicitud, vnCodigoSolicitudActiva
	FROM sa_solicitudes
	WHERE codigo = pnCodigoSolicitud;
    
    SET vnCodigoNuevaSolicitud := LAST_INSERT_ID();
    
    -- Determinar si aplica para el himno
    IF EXISTS
    (
		SELECT cod_solicitud
		FROM sa_examenes_himno
		WHERE cod_solicitud = pnCodigoSolicitud
    )
    THEN
		BEGIN
        
			-- Registrar nueva solicitud
			SET vcTempMensajeError := 'Al registrar examen del himno para la solicitud';
            
			INSERT INTO sa_examenes_himno(fecha_solicitud, cod_solicitud, fecha_examen_himno)
            VALUES(CURDATE(), vnCodigoNuevaSolicitud, pdFechaNuevaHimno);
            
        END;
	END IF;	
    
    COMMIT;
    
    
    
END$$

--
-- Funciones
--
DROP FUNCTION IF EXISTS `sp_get_prioridad`$$
CREATE DEFINER=`ddvderecho`@`localhost` FUNCTION `sp_get_prioridad`(`numFolio_` VARCHAR(25)) RETURNS int(11)
BEGIN
   DECLARE pri INTEGER;
   SELECT Prioridad INTO pri FROM folios WHERE NroFolio = numFolio_;
   RETURN pri;
END$$

DROP FUNCTION IF EXISTS `udf_Decrypt_derecho`$$
CREATE DEFINER=`ddvderecho`@`localhost` FUNCTION `udf_Decrypt_derecho`(`var` VARBINARY(150)) RETURNS varchar(25) CHARSET latin1
BEGIN
   DECLARE ret varchar(25);
   SET ret = cast(AES_DECRYPT(unhex(var), 'Der3ch0') as char);
   RETURN ret;
END$$

DROP FUNCTION IF EXISTS `udf_Encrypt_derecho`$$
CREATE DEFINER=`ddvderecho`@`localhost` FUNCTION `udf_Encrypt_derecho`(`var` VARCHAR(25)) RETURNS varchar(150) CHARSET latin1
BEGIN  
   DECLARE ret BLOB;
   SET ret = hex(AES_ENCRYPT(var, 'Der3ch0'));
   RETURN ret;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actividades`
--

DROP TABLE IF EXISTS `actividades`;
CREATE TABLE IF NOT EXISTS `actividades` (
  `id_actividad` int(11) NOT NULL auto_increment,
  `id_indicador` int(11) NOT NULL,
  `descripcion` text NOT NULL,
  `correlativo` varchar(20) NOT NULL,
  `supuesto` text NOT NULL,
  `justificacion` text NOT NULL,
  `medio_verificacion` text NOT NULL,
  `poblacion_objetivo` varchar(30) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  PRIMARY KEY  (`id_actividad`),
  KEY `id_indicador` (`id_indicador`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=261 ;

--
-- Volcar la base de datos para la tabla `actividades`
--

INSERT INTO `actividades` (`id_actividad`, `id_indicador`, `descripcion`, `correlativo`, `supuesto`, `justificacion`, `medio_verificacion`, `poblacion_objetivo`, `fecha_inicio`, `fecha_fin`) VALUES
(1, 1, 'Solicitud de dictámenes de aprobación de propuesta de reforma del Plan de la Carrera de Derecho ante las unidades correspondientes', '1.11', 'Se cuenta con los fondos', 'Es necesario seguir el proceso y requerimientos establecidos en la normativa universitaria para la aprobación de la reforma del Plan de Carrera de Derecho ', 'Dictámenes emitidos', 'Estudiantes', '2016-01-18', '2016-03-31'),
(2, 2, 'Solicitud de dictámenes de aprobación de propuesta de reforma del Plan de la Carrera de Derecho ante las unidades correspondientes', '1.1.1', 'Se cuenta con la aprobación de las unidades académicas y administrativas correspondientes', 'Es necesario seguir el proceso y requerimientos establecidos en la normativa universitaria para la aprobación de la reforma del Plan de Carrera de Derecho ', 'Dictámenes emitidos', 'Estudiantes', '2016-01-18', '2016-03-31'),
(3, 2, 'Solicitud de aprobación de la propuesta de Reforma del Plan de Carrera de la Licenciatura en Derecho a Consejo Universitario', '1.1.2', 'Se cuenta con los dictámenes correspondientes', 'Es necesario seguir el proceso y requerimientos establecidos en la normativa universitaria para la aprobación de la reforma del Plan de Carrera de Derecho', 'Dictamen de aprobación', 'Estudiantes', '2016-01-18', '2016-03-31'),
(4, 2, 'Solicitud de aprobación de la propuesta de Reforma del Plan de Carrera de la Licenciatura en Derecho ante el  Consejo de Educación Superior', '1.1.3', 'Se cuenta con la aprobación de Consejo Universitario', 'Es necesario seguir el proceso y requerimientos establecidos en la normativa universitaria para la aprobación de la reforma del Plan de Carrera de Derecho ', 'Dictamen de aprobación', 'Estudiantes', '2016-01-18', '2016-03-31'),
(5, 2, 'Ejecución del Plan de estudios reformado de la Carrera de Derecho', '1.1.4', 'Se cuenta con la aprobación del Plan Reformado de la Carrera de Derecho', 'Se debe contar con una evidencia de que hay fidelidad en la ejecución del Plan de estudios de la Carrera de Derecho y de sus reformas', 'Informe de Ejecución', 'Estudiantes', '2016-01-18', '2016-03-31'),
(6, 2, 'Elaboración y ejecución del Plan de Monitoreo y Seguimiento  a la Ejecución del Plan de Estudios reformado y aprobado de la Carrera de Derecho', '1.1.5', 'Se cuenta con un plan de seguimiento sobre la base de variables e indicadores que miden la calidad de la ejecución del plan ', 'Es necesario sistematizar las buenas práctica en el cumplimiento del Plan Reformado e identificar las necesidades de cambio para hacer los ajustes correspondientes en tiempo y forma', 'Documento del Plan de Seguimiento y Evaluación, Informe de Seguimiento y Evaluación', 'Estudiantes', '2016-01-18', '2016-03-31'),
(7, 3, 'Ejecutar las actividades de por lo menos el 70% de los  referentes mínimos planificados para el 2016 con propósitos de acreditación de la carrera en 2017 en la Comisión de Desarrollo e Innovación Curricular', '1.3.3', 'Se cuenta con los recursos logísticos y materiales para la ejecución de las actividades .', 'Se demanda para efectos de acreditación cumplir con los estándares, indicadores y referentes mínimos para lograr la acreditación en el 2017.', 'Planes de evaluación y seguimiento elaborados, instrumentos para seguimiento y evaluación elaborados, Informes de actividades ejecutadas.', 'Autoridades de la ca', '2016-01-18', '2016-03-31'),
(8, 4, 'Valoración del nivel de logro de los referentes mínimos como base para la elaboración del Plan de Evaluación y Certificación de la Carrera de Derecho', '1.4.1', 'Se cuenta ya con mas del 70% de referentes mínimos alcanzados y evidenciados documentalmente.', 'Es necesario contar con una valoración que nos indique el nivel de preparación alcanzado para someterse a una evaluación de pares externos con propósitos de acreditación y definir las actividades que corresponden para el plan.', 'Documento contentivo del Plan de Evaluación y Certificación.', 'Alumnos y docentes.', '2016-01-18', '2016-03-31'),
(9, 5, 'Definir sistema regulatorio y proceso interno para la aplicación del Reglamento de Servicio Comunitario en la Carrera de Derecho de la Facultad de Ciencias  Jurídicas , socializando dichas disposiciones con los actores involucrados ', '3.1.1', 'Se cuenta con la estructura necesaria en las carreras para el desarrollo del Servicio Comunitario', 'Las Carreras de la Facultad de Ciencias Jurídicas deben contribuir a la labor de Vinculación Universidad Sociedad', 'Informes de resultados de proyectos', 'Alumnos, docentes y ', '2016-01-18', '2016-03-31'),
(10, 5, 'Registrar los proyectos de Servicio Comunitario desarrollados en los distintos espacios de aprendizaje, siguiendo el proceso de aprobación definido para tal propósito', '3.1.2', 'Se cuenta con la estructura necesaria en las carreras para el desarrollo del Servicio Comunitario', 'Las Carreras de la Facultad de Ciencias Jurídicas deben contribuir a la labor de Vinculación Universidad Sociedad', 'Informes de resultados de proyectos', 'Alumnos, docentes y ', '2016-01-18', '2016-03-31'),
(11, 1, 'Solicitud de aprobación de la propuesta de Reforma del Plan de Carrera de la Licenciatura en Derecho a Consejo Universitario', '1.1.2', 'Se cuenta con los dictámenes correspondientes', 'Es necesario seguir el proceso y requerimientos establecidos en la normativa universitaria para la aprobación de la reforma del Plan de Carrera de Derecho ', 'Dictamen de aprobación\n', 'Estudiantes', '2016-01-18', '2016-03-31'),
(12, 1, 'Solicitud de aprobación de la propuesta de Reforma del Plan de Carrera de la Licenciatura en Derecho ante el  Consejo de Educación SuperiorSolicitud de aprobación de la propuesta de Reforma del Plan de Carrera de la Licenciatura en Derecho a Consejo Universitario', '1.1.3', 'Se cuenta con la aprobación de Consejo Universitario', 'Es necesario seguir el proceso y requerimientos establecidos en la normativa universitaria para la aprobación de la reforma del Plan de Carrera de Derecho ', 'Dictamen de aprobación\n', 'Estudiantes', '2016-01-18', '2016-03-31'),
(13, 1, 'Ejecución del Plan de estudios reformado de la Carrera de Derecho', '1.1.4', 'Se cuenta con la aprobación del Plan Reformado de la Carrera de Derecho', 'Se debe contar con una evidencia de que hay fidelidad en la ejecución del Plan de estudios de la Carrera de Derecho y de sus reformas', 'Informe de Ejecución\n', 'Estudiantes', '2016-01-18', '2016-03-31'),
(14, 1, 'Elaboración y ejecución del Plan de Monitoreo y Seguimiento  a la Ejecución del Plan de Estudios reformado y aprobado de la Carrera de Derecho', '1.1.5', 'Se cuenta con un plan de seguimiento sobre la base de variables e indicadores que miden la calidad de la ejecución del plan ', 'Es necesario sistematizar las buenas práctica en el cumplimiento del Plan Reformado e identificar las necesidades de cambio para hacer los ajustes ', 'Documento del Plan de Seguimiento y Evaluación, Informe de Seguimiento y Evaluación', 'Estudiantes', '2016-01-18', '2016-03-31'),
(15, 6, 'Realizar intercambios de experiencias para aplicar  buenas prácticas en procesos de certificación y acreditación  carreras logradas en la participación de redes ', '1.2.1', 'Los coordinadores de las comisiones de trabajo tienen conciencia de la  necesidad de articular esfuerzos para el cumplimiento de  los referentes mínimos de todos los factores para efectos de acreditación', 'Es necesario unificar criterios para el abordaje del desarrollo curricular en la aplicación del Modelo Educativo de la UNAH, sus enfoques y ejes integradores y Es necesario unificar criterios para el abordaje del desarrollo curricular en la aplicación del Modelo Educativo de la UNAH, sus enfoques y ejes integradores y funciones ( VUS, investigación y docencia)\n', 'Informes de resultados de los intercambios realizados', 'Estudiantes y docent', '2016-01-18', '2016-03-31'),
(16, 6, 'Planificar, ejecutar y evaluar  acciones  consensuadas de  investigación, elaboración de documentos, planes, programas e instrumentos, en grupos de red  para el logro de referentes mínimos compartidos o bajo  la responsabilidad de dos o más comisiones y unidades académicas con propósitos de acreditación.   tomando en cuenta la participación  de las  siguientes unidades:  unidad de plan de mejora y autoevaluación de Vicerrectoría Académica; Unidad de Desarrollo Curricular, Coordinación de carrera, Jefaturas de departamentos de la Facultad de Ciencias Jurídicas , y demás unidades que correspondan.', '1.2.2', 'Los coordinadores de las comisiones de trabajo tienen conciencia de la  necesidad de articular esfuerzos para el cumplimiento de  los referentes mínimos de todos los factores para efectos de acreditación', 'Es necesario unificar criterios para el abordaje del desarrollo curricular en la aplicación del Modelo Educativo de la UNAH, sus enfoques y ejes integradores y funciones ( VUS, investigación y docencia)', 'Ayudas memoria de reuniones, documentos  aprobado\n', 'Estudiantes y docent', '2016-01-18', '2016-03-31'),
(17, 6, 'Iniciar y desarrollar procesos de validación de los avances en la ejecución del plan de mejora de las carreras de la Facultad de Ciencias Jurídicas con agencias de acreditación nacionales e internacionales  determinadas como la UNAH como el SHACES y agencias de acreditación de  CSUCA', '1.2.3', 'Se han identificado los temas afines para la discusión y el tratamiento de redes para el abordaje del desarrollo curricular en las carreras de la FCJ', 'Es necesario unificar criterios para el abordaje del desarrollo curricular en la aplicación del Modelo Educativo de la UNAH, sus enfoques y ejes integradores y funciones ( VUS, investigación y docencia)', 'Informes de reuniones de integración ejecutadas\n', 'Estudiantes y docent', '2016-01-18', '2016-03-31'),
(18, 7, 'Ejecución del POA 2016 de las Comisiones de Trabajo del Plan de Mejora', '1.3.1', 'Todas las comisiones de trabajo poseen el POA 2016 correspondiente', 'Es necesario el desarrollo de actividades para el logro de los referentes mínimos y con ello los indicadores y estándares de calidad para efectos de acreditación', 'Cumplimiento de indicadores de alcance de logro de Referentes Mínimos', 'Estudiantes y docent', '2016-01-18', '2016-03-31'),
(19, 7, ' Elaborar y evaluar el  informe trimestral de ejecución de Plan de Mejora', '1.3.2', 'TCada comisión de trabajo ejecuta las actividades contenidas en el POA 2016 y se cuentan con los recursos necesarios para su ejecución', 'Es necesario el desarrollo de actividades para el logro de los referentes mínimos y con ello los indicadores y estándares de calidad para efectos de acreditación', 'Informes de reuniones de integración ejecutadas', 'Estudiantes y docent', '2016-01-18', '2016-03-31'),
(20, 7, 'Ejecutar las actividades de por lo menos el 70% de los  referentes mínimos planificados para el 2016 con propósitos de acreditación de la carrera en 2017 en la Comisión de Desarrollo e Innovación Curricular', '1.3.3', 'Se demanda para efectos de acreditación cumplir con los estándares, indicadores y referentes mínimos para lograr la acreditación en el 2017', 'Planes de evaluación y seguimiento elaborados, instrumentos para seguimiento y evaluación elaborados, Informes de actividades ejecutadas,', 'Planes de evaluación y seguimiento elaborados, instrumentos para seguimiento y evaluación elaborados, Informes de actividades ejecutadas,', 'Autoridades de la ca', '2016-01-18', '2016-03-31'),
(21, 9, 'Valoración del nivel de logro de los referentes mínimos como base para la elaboración del Plan de Evaluación y Certificación de la Carrera de Derecho', '1.4.1', 'Se cuenta ya con mas del 70% de referentes mínimos alcanzados y evidenciados documentalmente', 'Es necesario contar con una valoración que nos indique el nivel de preparación alcanzado para someterse a una evaluación de pares externos con propósitos de acreditación y definir las actividades que corresponden para el plan', 'Documento contentivo del Plan de Evaluación y Certificación', 'Alumnos y docentes', '2016-01-18', '2016-03-31'),
(47, 11, 'Puesta en marcha de la Maestría en Derecho Penal y Procesal Penal, con salida lateral de especialidad ', '1.5.11', 'Se cuenta con la aprobación de las unidades académicas correspondientes y del Consejo Universitario', 'La población demanda de la preparación de recurso humano en esta área de las ciencias jurídicas a nivel de maestría ', 'Plan de estudios aprobado por el Consejo de Educación Superior', 'Sociedad hondureña', '2016-01-18', '2016-03-31'),
(46, 11, 'Seguimiento de aprobación de  la Maestría en Derecho Penal y Procesal Penal, con salida lateral como especialidad ( transformación de la especialidad)', '1.5.10', 'Se cuenta con la aprobación de las unidades académicas correspondientes y del Consejo Universitario', 'La población demanda de la preparación de recurso humano en esta área de las ciencias jurídicas a nivel de maestría ', 'Plan de estudios aprobado por el Consejo de Educación Superior', 'Sociedad hondureña', '2016-01-18', '2016-03-31'),
(45, 11, 'Solicitud de aprobación de la Maestría en Derecho al Trabajo y Seguridad Social  ante el Consejo de Educación Superior', '1.5.9', 'Se cuenta con actividades definidas para garantizar la ejecución y complementación del proceso de ejecución del Plan Estratégico de Desarrollo de la Carrera ', 'Como es una carrera nueva requiere del desarrollo de actividades que garanticen un buen suceso en la ejecutoria del Plan Estratégico', 'Plan estratégico elaborado y la medición de avance de ejecución', 'Sociedad hondureña', '2016-01-18', '2016-03-31'),
(44, 11, 'Solicitud de aprobación de la Maestría en Derecho al Trabajo y Seguridad Social  ante el Consejo de Educación Superior', '1.5.8', 'Se cuenta con la aprobación de Consejo Universitario', 'En materia de Ciencias Jurídicas en el país no existe la oferta educativa de una maestría en Derecho al Trabajo y Seguridad Social la cual tiene demanda por la naturaleza de su  formación y las necesidades en el sector laboral', 'Dictamen de aprobación', 'Sociedad hondureña', '2016-01-18', '2016-03-31'),
(43, 11, 'Solicitud de aprobación de la propuesta de la Maestría en Derecho al Trabajo y Seguridad Social  al  Consejo Universitario', '1.5.7', 'Se cuenta con los dictámenes correspondientes', 'En materia de Ciencias Jurídicas en el país no existe la oferta educativa de una maestría en Derecho al Trabajo y Seguridad Social la cual tiene demanda por la naturaleza de su  formación y las necesidades en el sector laboral', 'Dictamen de aprobación', 'Sociedad hondureña', '2016-01-18', '2016-03-31'),
(42, 11, 'Solicitud de dictámenes de aprobación de propuesta de la Maestría en Derecho al Trabajo y Seguridad Social  ante las unidades de la UNAH correspondientes', '1.5.6', 'Se cuenta con la aprobación de las unidades académicas y administrativas correspondientes', 'En materia de Ciencias Jurídicas en el país no existe la oferta educativa de una maestría en Derecho al Trabajo y Seguridad Social la cual tiene demanda por la naturaleza de su  formación y las necesidades en el sector laboral', 'Dictámenes emitidos', 'Sociedad hondureña', '2016-01-18', '2016-03-31'),
(41, 12, 'Desarrollar una evaluación trimestral de los indicadores de logro de referentes mínimos de acreditación y certificación docente', '4.2.1', 'Docentes capacitados en estrategias didácticas', 'Necesidad de la reforma educativa de la UNAH', 'Evaluaciones escritas, instrumento de evaluación', 'Docentes de la FCJ', '2016-01-18', '2016-03-31'),
(40, 11, 'Solicitud de dictámenes de aprobación de propuesta de la Licenciatura en Solicitud de aprobación de  la carrera de Criminalística en el grado de  Ejecución del Plan Estratégico de la Carrera de Criminalística en el grado de Licenciatura con salida lateral de Técnico Universitario, con propósitos de ajuste y mejora de su puesta en marcha ', '1.5.5', 'La carrera cuenta con una planta docente que reúne todos los requisitos académicos para facilitar las distintas asignaturas o espacios de aprendizaje para su puesta en marcha, así como la infraestructura, equipos, insumos y alianzas estratégicas ', 'Es una carrera donde convergen distintas disciplinas científicas que requieren de especificaciones especializadas en materia de recursos humanos, laboratorios, insumos y aliados estratégicos, que se integraran en un proceso de construcción de la experiencia ', 'Plan estratégico elaborado y la medición de avance de ejecución', 'Sociedad hondureña', '2016-01-18', '2016-03-31'),
(39, 11, 'Solicitud de dictámenes de aprobación de propuesta de la Licenciatura en Solicitud de aprobación de  la carrera de Criminalística en el grado de Licenciatura con salida lateral de Técnico Universitario ante el Consejo de Educación Superior', '1.5.4', 'Se cuenta con la aprobación de las unidades académicas correspondientes y del Consejo Universitario', 'El país demanda de este recurso humano con título de educación superior para atender la mora de la investigación de los delitos,  los cuales se han incrementado exponencialmente en el país', 'Planes de estudios aprobados por el Consejo de Educación Superior', 'Sociedad hondureña', '2016-01-18', '2016-03-31'),
(38, 11, 'Solicitud de dictámenes de aprobación de propuesta de la Licenciatura en Solicitud de aprobación de la propuesta de la Licenciatura en Criminalística  al  Consejo Universitario', '1.5.3', 'Se cuenta con la aprobación de las unidades académicas correspondientes y del Consejo Universitario', 'El país demanda de este recurso humano con título de educación superior para atender la mora de la investigación de los delitos,  los cuales se han incrementado exponencialmente en el país', 'Planes de estudios aprobados por el Consejo de Educación Superior', 'Sociedad hondureña', '2016-01-18', '2016-03-31'),
(36, 11, 'Culminar  la propuesta de la Carrera de Licenciatura en Criminalística con la salida lateral de Técnico', '1.5.1', 'Se cuenta con la aprobación de las unidades académicas correspondientes y del Consejo Universitario', 'El país demanda de este recurso humano con título de educación superior para atender la mora de la investigación de los delitos,  los cuales se han incrementado exponencialmente en el país', 'Planes de estudios aprobados por el Consejo de Educación Superior', 'Sociedad hondureña', '2016-01-18', '2016-03-31'),
(37, 11, 'Solicitud de dictámenes de aprobación de propuesta de la Licenciatura en Criminalística con salida lateral de Técnico ante las unidades de la UNAH correspondientes', '1.5.2', 'Se cuenta con la aprobación de las unidades académicas correspondientes y del Consejo Universitario', 'El país demanda de este recurso humano con título de educación superior para atender la mora de la investigación de los delitos,  los cuales se han incrementado exponencialmente en el país', 'Planes de estudios aprobados por el Consejo de Educación Superior', 'Sociedad hondureña', '2016-01-18', '2016-03-31'),
(35, 8, 'Realizar reuniones de monitoreo y seguimiento de los indicadores de logro en la ejecución del Programa de Desarrollo Profesional Docente', '4.1.3', 'Disponibilidad de recursos para el desarrollo del programa y docentes dispuestos a capacitarse y a formarse permanentemente', 'Se necesitan los recursos para impulsar la ejecución del programa de desarrollo profesional y Los docentes requieren de capacitación o formación permanentemente para estar actualizados y mejorar su desempeño profesional ', 'Informe de actividades Informe de actividades;  certificados, diplomas o títulos recibidos; informes de cursos, diplomados y postgrados desarrollados o en curso. ', 'Docentes de la FCJ', '2016-01-18', '2016-03-31'),
(48, 11, 'Analizar los resultados del diagnóstico para la determinación de la elaboración o no de la propuesta del Plan de Estudios del Técnico en Derecho Parlamentario.', '1.5.12', 'Se cuenta con la aprobación de las unidades académicas correspondientes y del Consejo Universitario', 'El país demanda la preparación de profesionales técnicos en la materia para apoyar y tecnificar los procesos parlamentarios ', 'Planes de estudios aprobados por el Consejo de Educación Superior', 'Sociedad hondureña', '2016-01-18', '2016-03-31'),
(49, 13, 'Coordinar con VRA un jornada de reflexión sobre la actuación ética del docente y su impacto en el espacio de aprendizaje.', '4.6.2', 'Se cuenta con apoyo de la VRA', 'Transversalizar el eje de ética y la cultura de derechos humanos ', 'Listado de participación en los talleres y planes de estudios con el eje de ética y derechos humanos Transversalizado', 'Docentes y estudiant', '2016-01-18', '2016-03-31'),
(50, 14, 'Identificar y comunicar el proceso de certificación y acreditación docente', '8.3.1', 'Docentes comprometidos en su formación en miras de certificación y acreditación', 'Brindar una atención de calidad, oportuna, efectiva y pertinente en las función fundamental de docencia', 'Diplomas, certificaciones', 'Docentes', '2016-01-18', '2016-03-31'),
(51, 15, 'Desarrollar un taller de socialización de las políticas de calidad académica de la UNAH', '8.4.1', 'Se cuenta con las políticas de la calidad académica de la UNAH', 'Generar los espacios para que los docentes de la facultad conozcan las políticas de calidad y las apliquen', 'Material didáctico, talleres de socialización, diplomas, listas de asistencia, fotografías', 'Docentes', '2016-01-18', '2016-03-31'),
(52, 16, 'Coordinar con la unidad correspondiente de la UNAH la integración de los docentes de la FCJ al Plan de Relevo Docente', '4.3.1', 'Disponibilidad de recursos humanos con las competencias necesarias', 'Atención a la demanda educativa con cálida', 'Informes  de actualización de planta docente, Informe de ejecución del plan de relevo generacional', 'Docentes de la FCJ', '2016-01-18', '2016-03-31'),
(53, 16, 'Medir el avance de la actualización de la planta docente a través informes de resultados trimestrales ', '4.3.2', 'Disponibilidad de recursos humanos con las competencias necesarias', 'Atención a la demanda educativa con cálida', 'Informes  de actualización de planta docente, Informe de ejecución del plan de relevo generacional', 'Docentes de la FCJ', '2016-01-18', '2016-03-31'),
(54, 17, 'Desarrollar círculos de estudio del modelo educativo de la UNAH en cada departamento de las carreras de la Facultad de Ciencias Jurídicas, observando su operacionalización con clases demostrativas, videos y el acompañamiento de los responsables de la capacitación didáctica.', '4.4.1', 'Disposición a la capacitación por parte de los docentes', 'Atención a la demanda educativa con calidad', 'Informe de los círculos de estudio realizados', 'Docentes de la facul', '2016-01-18', '2016-03-31'),
(55, 18, 'Desarrollar clases demostrativas por cada departamento de las carreras de la FCJ ', '4.5.1', 'Disposición a la capacitación por parte de los docentes', 'Atención a la demanda educativa con calidad', 'Informe de clases demostrativas  desarrolladas ', 'Docentes de la facul', '2016-01-18', '2016-03-31'),
(56, 19, 'Desarrollar conferencias enfocadas a desarrollar  una cultura de ética y de derechos  humanos ', '4.6.1', 'Se cuenta con expertos  en ética profesional y derechos humanos disponibles ', 'Desarrollo de los ejes de ética y derechos humanos como política de la UNAH.', 'Certificados que acredite la participación, listas de asistencia, fotografías', 'Docentes y estudiant', '2016-01-18', '2016-03-31'),
(57, 19, 'Coordinar con VRA un jornada de reflexión sobre la actuación ética del docente y su impacto en el espacio de aprendizaje.', '4.6.2', 'Se cuenta con apoyo de la VRA', 'Transversalizar el eje de ética y la cultura de derechos humanos ', 'Listado de participación en los talleres y planes de estudios con el eje de ética y derechos humanos Transversalizado', 'Docentes y estudiant', '2016-01-18', '2016-03-31'),
(58, 20, 'Elaborar un calendario de las ofertas de Programas de Formación de Innovación Educativa ', '9.1.1', 'Se cuenta con la suficiente oferta para la Formación de Innovación Educativa', 'Ofrecer una educación de calidad a los estudiantes mediante la innovación e cada uno de sus funciones y procesos fundamentales', 'Lista de asistencia, certificado de aprobación de los cursos, informe de la capacitación recibida.', 'Docentes', '2016-01-18', '2016-03-31'),
(59, 20, 'Integrar a los docentes en los Programas de Formación de Innovación Educativa (20%,24 docentes)', '9.1.2', 'Se cuenta con la suficiente oferta para la Formación de Innovación Educativa', 'Ofrecer una educación de calidad a los estudiantes mediante la innovación e cada uno de sus funciones y procesos fundamentales', 'Lista de asistencia, certificado de aprobación de los cursos, informe de la capacitación recibida.', 'Docentes', '2016-01-18', '2016-03-31'),
(60, 21, 'Aplicación del Modelo de acuerdo al Programa Interno de Aplicación Modelo de Innovación Institucional y Educativa de la UNAH', '9.2.1', 'Se cuenta con la suficiente oferta para la Formación de Innovación Educativa', 'Ofrecer una educación de calidad a los estudiantes mediante la innovación e cada uno de sus funciones y procesos fundamentales', 'Documento de programa desarrollado y aprobado', 'Docentes', '2016-01-18', '2016-03-31'),
(61, 22, 'Desarrollar los proyectos de Innovación Educativa de acuerdo a los lineamientos del Modelo de Innovación Institucional y Educativa', '9.3.1', 'Se cuenta con gestores comprometidos y recursos para su desarrollo', 'Ofrecer una educación de calidad a los estudiantes mediante la innovación e cada uno de sus funciones y procesos fundamentales', 'Informe de resultados, aplicación', 'Docentes', '2016-01-18', '2016-03-31'),
(62, 23, 'Elaborar con apoyo de la SEAPI el diseño y presupuesto del edificio para Laboratorios de Investigación Forense ( considerando terreno en CJG)', '11.2.5', 'Se cuenta con la colaboración de SEAPI para la elaboración del  diseño y presupuesto, aprobación de fondos por parte de Consejo Universitario y Rectoría', 'l país demanda de este recurso humano con título de educación superior para atender la mora de la investigación de los delitos,  los cuales se han incrementado exponencialmente en el país y debida preparación técnica', 'Planos de edificio, presupuesto y dictámenes de aprobación', 'Alumnos, docentes y ', '2016-01-18', '2016-03-31'),
(63, 23, 'Presentar propuesta de diseño para gestión y aseguramiento de fondos necesarios para la construcción del edificio de Laboratorios de Investigación Forense', '11.2.6', 'Se cuenta con la colaboración de SEAPI para la elaboración del  diseño y presupuesto, aprobación de fondos por parte de Consejo Universitario y Rectoría', 'l país demanda de este recurso humano con título de educación superior para atender la mora de la investigación de los delitos,  los cuales se han incrementado exponencialmente en el país y debida preparación técnica', 'Planos de edificio, presupuesto y dictámenes de aprobación', 'Alumnos, docentes y ', '2016-01-18', '2016-03-31'),
(64, 24, 'Ejecutar el Plan Permanente de Desarrollo del Talento Humano', '12.1.11', 'Se cuenta con los apoyos de las unidades internas y recursos para su ejecución', 'Consolidar servicios de calidad en la Facultad de Ciencias Jurídicas mediante el desarrollo integral del talento humano( docente y administrativo)', 'Informes trimestrales de avances, ', 'Docentes y colaborad', '2016-01-18', '2016-03-31'),
(65, 24, 'Presentar informes trimestrales del avance del Plan Permanente de Desarrollo del Talento Humano', '12.1.12', 'Se cuenta con los apoyos de las unidades internas y recursos para su ejecución', 'Consolidar servicios de calidad en la Facultad de Ciencias Jurídicas mediante el desarrollo integral del talento humano( docente y administrativo)', 'Informes trimestrales de avances, ', 'Docentes y colaborad', '2016-01-18', '2016-03-31'),
(66, 25, 'Desarrollar el el Ciclo de Cine III Valores Democráticos en el marco de la semana del estudiante en al menos 5 sedes: CU, UNAH VS,La Ceiba, Comayagua y Choluteca en asocio con la Fundación Konrad Adenauer ', '7.3.2', 'Se cuenta con el apoyo de los centros regionales y aprobación del proyecto por las unidades competentes', 'Contribuir a la educación con énfasis en la construcción de ciudadanía en la comunidad universitaria de la UNAH a través de la educación en valores democráticos ', 'Listas de participación, fotografías, etc.', 'Alumnos y docentes', '2016-01-18', '2016-03-31'),
(67, 27, 'Identificar los instrumentos de armonización académica asumidos por la UNAH en el marco de la Internacionalización de la Educación Superior', '14.1.1', 'Se cuenta con instrumentos de armonización y el apoyo de la VRI en el proceso', 'Lograr la internacionalización de las carreras de la Facultad de Ciencias Jurídicas', 'Informes de cumplimiento de aplicación de los instrumentos de armonización académica asumidos por la UNAH', 'Docentes y estudiant', '2016-01-18', '2016-03-31'),
(68, 27, 'Definir la metodología de aplicación de los instrumentos de armonización académica en la Facultad de Ciencias Jurídicas', '14.1.2', 'Se cuenta con instrumentos de armonización y el apoyo de la VRI en el proceso', 'Lograr la internacionalización de las carreras de la Facultad de Ciencias Jurídicas', 'Informes de cumplimiento de aplicación de los instrumentos de armonización académica asumidos por la UNAH', 'Docentes y estudiant', '2016-01-18', '2016-03-31'),
(69, 27, 'Aplicar los instrumentos de armonización académica (10%)', '14.1.3', 'Se cuenta con instrumentos de armonización y el apoyo de la VRI en el proceso', 'Lograr la internacionalización de las carreras de la Facultad de Ciencias Jurídicas', 'Informes de cumplimiento de aplicación de los instrumentos de armonización académica asumidos por la UNAH', 'Docentes y estudiant', '2016-01-18', '2016-03-31'),
(70, 25, 'Ciclo de conferencias en temas de materia electoral , constitucional y derechos humanos en asocio con la Fundación Konrad Adenauer , a desarrollar en 3 centros universitarios: UNAH VS (2), CU(1) y CURLA (2) ', '7.3.3', 'Se cuenta con el apoyo de los centros regionales y aprobación del proyecto por las unidades competentes', 'Contribuir a la educación con énfasis en la construcción de ciudadanía en la comunidad universitaria de la UNAH a través de la educación en valores democráticos, derechos humanos y temas constitucionales', 'Proyectos aprobados, listas de participación, fotografías', 'Alumnos y docentes', '2016-01-18', '2016-01-31'),
(71, 28, 'Medir el avance en la mejora de los indicadores e índices mínimos en la aplicación del Plan de Mejoras', '14.2.1', 'El Plan de Mejoras se encuentra en fase de ejecución', 'Mejora de índices para el logro de la acreditación', 'Informes trimestrales de índices e indicadores del Plan de Mejoras', 'Facultad de Ciencias', '2016-01-18', '2016-03-31'),
(72, 29, 'Elaborar un calendario de las ofertas de Programas de Formación de Innovación Educativa ', '9.1.1', 'Se cuenta con la suficiente oferta para la Formación de Innovación Educativa', 'Ofrecer una educación de calidad a los estudiantes mediante la innovación e cada uno de sus funciones y procesos fundamentales', 'Lista de asistencia, certificado de aprobación de los cursos, informe de la capacitación recibida.', 'Docentes', '2016-01-18', '2016-03-31'),
(73, 29, 'Integrar a los docentes en los Programas de Formación de Innovación Educativa (20%,24 docentes)', '9.1.2', 'Se cuenta con la suficiente oferta para la Formación de Innovación Educativa', 'Ofrecer una educación de calidad a los estudiantes mediante la innovación e cada uno de sus funciones y procesos fundamentales', 'Lista de asistencia, certificado de aprobación de los cursos, informe de la capacitación recibida.', 'Docentes', '2016-01-18', '2016-03-31'),
(74, 30, 'Aplicación del Modelo de acuerdo al Programa Interno de Aplicación Modelo de Innovación Institucional y Educativa de la UNAH', '9.2.1', 'Se cuenta con la suficiente oferta para la Formación de Innovación Educativa', 'Ofrecer una educación de calidad a los estudiantes mediante la innovación e cada uno de sus funciones y procesos fundamentales', 'Documento de programa desarrollado y aprobado', 'Docentes', '2016-01-18', '2016-03-31'),
(75, 31, 'Desarrollar los proyectos de Innovación Educativa de acuerdo a los lineamientos del Modelo de Innovación Institucional y Educativa', '9.3.1', 'Se cuenta con gestores comprometidos y recursos para su desarrollo', 'Ofrecer una educación de calidad a los estudiantes mediante la innovación e cada uno de sus funciones y procesos fundamentales', 'Informe de resultados, aplicación', 'Docentes', '2016-01-18', '2016-03-31'),
(76, 32, 'Ejecutar el Plan Permanente de Desarrollo del Talento Humano', '12.1.1', 'Se cuenta con los apoyos de las unidades internas y recursos para su ejecución', 'Consolidar servicios de calidad en la Facultad de Ciencias Jurídicas mediante el desarrollo integral del talento humano( docente y administrativo)', 'Informes trimestrales de avances, ', 'Docentes y colaborad', '2016-01-18', '2016-03-31'),
(77, 32, 'Presentar informes trimestrales del avance del Plan Permanente de Desarrollo del Talento Humano', '12.1.2', 'Se cuenta con los apoyos de las unidades internas y recursos para su ejecución', 'Consolidar servicios de calidad en la Facultad de Ciencias Jurídicas mediante el desarrollo integral del talento humano( docente y administrativo)', 'Informes trimestrales de avances, ', 'Docentes y colaborad', '2016-01-18', '2016-03-31'),
(78, 32, 'Medir mediante reuniones de monitoreo y control de los avances y logros del Programa de Desarrollo Profesional', '12.2.3', 'Docentes y personal administrativa dispuestos a capacitarse o a formarse permanentemente.', 'os docentes y personal administrativo requieren de capacitación o formación permanentemente para estar actualizados y mejorar su desempeño profesional', 'Informe de actividades;  certificados, diplomas o títulos recibidos; informes de cursos, diplomados y postgrados desarrollados o en curso', 'Docentes y colaborad', '2016-01-18', '2016-03-31'),
(79, 33, 'Desarrollar la convocatoria para la delegación de los representantes docentes y estudiantiles a integrar el Comité Técnico de la Carrera y desarrollar la sesión de conformación del Comité Técnico', '15.2.1', 'Se cuenta con los delegados para la conformación del Comité Técnico', 'Cumplir con los requerimientos que establece el Reglamento de Juntas Directivas, Facultades y Centros Regionales', 'Ayudas memorias, bitácoras de reuniones realizadas', 'Docentes y alumnos', '2016-01-18', '2016-03-31'),
(80, 34, 'Definir la estructura de la Unidad de Estudiantes en la Facultad de Ciencias Jurídicas, estableciendo responsabilidades y alcances de gestión', '5.1.1', 'Se cuentan con personas comprometidas para su buen funcionamiento y con los recursos necesarios ', 'Los egresados de la Facultad de Ciencias Jurídicas deben contar con unidad de apoyo y seguimiento', 'Informes de actividades, bitácoras de reuniones', 'Estudiantes', '2016-01-18', '2016-01-31'),
(81, 34, 'Proveer a la Unidad de Estudiantes los recursos necesarios (espacio físico, computadora, impresora, etc.) de acuerdo a un diagnóstico de necesidades.', '5.1.2', 'Se cuentan con personas comprometidas para su buen funcionamiento y con los recursos necesarios ', 'Los egresados de la Facultad de Ciencias Jurídicas deben contar con unidad de apoyo y seguimiento', 'Informes de actividades, bitácoras de reuniones', 'Estudiantes', '2016-01-18', '2016-03-31'),
(82, 35, ' Levantamiento de información en el campo con los graduados en sus puestos de trabajo, también con empleadores, usuarios y  clientes ( 5% de la población de graduados)', '5.6.1', 'La Unidad de Egresados cuenta con los recursos necesarios para ejecutar el seguimiento', 'Las carreras deben contar con información fidedigna sobre los graduados ', 'Informes de actividades, estadísticas', 'Estudiantes graduado', '2016-01-18', '2016-03-31'),
(83, 35, 'Presentación trimestral de resultados del seguimiento', '5.6.2', 'La Unidad de Egresados cuenta con los recursos necesarios para ejecutar el seguimiento', 'Las carreras deben contar con información fidedigna sobre los graduados ', 'Informes de actividades, estadísticas', 'Estudiantes graduado', '2016-01-18', '2016-03-31'),
(84, 36, 'Ejecutar las actividades de por lo menos el 70% de los  referentes mínimos planificados para el 2016 con propósitos de acreditación de la carrera en 2017, en la Comisión de Graduados', '5.7.1', 'Se cuenta con los recursos logísticos y materiales para la ejecución de las actividades ', 'Se demanda para efectos de acreditación cumplir con los estándares, indicadores y referentes mínimos para lograr la acreditación en el 2017', 'Informes de resultados, cumplimiento de indicadores', 'Estudiantes graduado', '2016-01-18', '2016-03-31'),
(85, 37, 'Desarrollar  promoción de los programas de postgrados y establecer estrategias para priorizar la inserción de graduados  de la FCJ a los programas', '5.8.1', 'Los ofertas de postgrados satisfacen las necesidades de los egresados', 'La preparación de los estudiantes debe ser continua y es necesario para cumplir la función de formación de la UNAH', 'Informes de resultados, material de promoción', 'Estudiantes graduado', '2016-01-18', '2016-03-31'),
(86, 37, 'Presentación trimestral de estadísticas', '5.8.2', 'Los ofertas de postgrados satisfacen las necesidades de los egresados', 'La preparación de los estudiantes debe ser continua y es necesario para cumplir la función de formación de la UNAH', 'Informes de resultados, material de promoción', 'Estudiantes graduado', '2016-01-18', '2016-03-31'),
(87, 38, 'Identificar y establecer los contactos pertinentes: internos y externos a la UNAH para la negociación de convenios y participación', '6.2.1', 'Se cuenta con el apoyo de las máximas autoridades de la UNAH para la suscripción de convenio', 'Contribuir a la solución de los problemas nacionales mediante la generación de conocimiento científico en el marco de la internacionalización de la carrera', 'Convenios firmados, Informes', 'Docentes, alumnos, s', '2016-01-18', '2016-03-31'),
(88, 38, 'Gestionar ante los unidades correspondientes de la UNAH la firma de convenios', '6.2.2', 'Se cuenta con el apoyo de las máximas autoridades de la UNAH para la suscripción de convenio', 'Contribuir a la solución de los problemas nacionales mediante la generación de conocimiento científico en el marco de la internacionalización de la carrera', 'Convenios firmados, Informes', 'Docentes, alumnos, s', '2016-01-18', '2016-03-31'),
(89, 39, 'Desarrollar  capacitaciones en la calidad en la gestión administrativa', '8.2.1', 'Se cuenta con el apoyo de las unidades correspondientes', 'Brindar una atención de calidad, oportuna, efectiva y pertinente a las necesidades de la sociedad hondureña', 'Diplomas, listas de asistencia,  material didáctico, informes, fotografías', 'Colaboradores admini', '2016-01-18', '2016-03-31'),
(90, 40, 'Desarrollar un taller de socialización de las políticas de calidad académica de la UNAH', '8.4.1', 'Se cuenta con las políticas de la calidad académica de la UNAH', 'Generar los espacios para que los docentes de la facultad conozcan las políticas de calidad y las apliquen', 'Material didáctico, talleres de socialización, diplomas, listas de asistencia, fotografías', 'Colaboradores admini', '2016-01-18', '2016-03-31'),
(91, 41, 'Desarrollar un mapeo de agencias y organismos de cooperación cuyas líneas de apoyo contemplen el desarrollo de infraestructura y plataforma tecnológica', '11.4.1', 'Se cuenta con el apoyo de las máximas autoridades para la firma de convenios, proyectos que presentar a la cooperación y un grupo gestor comprometido', 'Fortalecer el presupuesto de la Facultad para tener la viabilidad de realizar diferentes proyectos en la Facultad que den soporte a las funciones sustantivas y cumplimiento de objetivos', 'Convenios e intención de convenios firmados, proyectos aprobados', 'Docentes, alumnos', '2016-01-18', '2016-03-31'),
(92, 41, 'Presentar proyectos y solicitudes a cooperantes identificados', '11.4.2', 'Se cuenta con el apoyo de las máximas autoridades para la firma de convenios, proyectos que presentar a la cooperación y un grupo gestor comprometido', 'Fortalecer el presupuesto de la Facultad para tener la viabilidad de realizar diferentes proyectos en la Facultad que den soporte a las funciones sustantivas y cumplimiento de objetivos', 'Convenios e intención de convenios firmados, proyectos aprobados', 'Docentes, alumnos', '2016-01-18', '2016-03-31'),
(93, 41, 'Gestionar ante las unidades internas los convenios de cooperación', '11.4.3', 'Se cuenta con el apoyo de las máximas autoridades para la firma de convenios, proyectos que presentar a la cooperación y un grupo gestor comprometido', 'Fortalecer el presupuesto de la Facultad para tener la viabilidad de realizar diferentes proyectos en la Facultad que den soporte a las funciones sustantivas y cumplimiento de objetivos', 'Convenios e intención de convenios firmados, proyectos aprobados', 'Docentes, alumnos', '2016-01-18', '2016-03-31'),
(94, 42, 'Elaborar e implementar el Plan de Asesorías para los estudiantes en riesgo académico en los diferentes espacios de aprendizaje', '5.3.1', 'Se han identificado los alumnos en riesgo y están dispuestos a someterse al proceso de asesoría', 'Identificar las razones especificas del riesgo académico ( índices bajos, bajo rendimiento) en los alumnos y contribuir mediante el tratamiento individualizado de los alumnos a que no culminen su carrera', 'Informes de resultados, listas de asistencia', 'Estudiantes', '2016-01-18', '2016-03-31'),
(95, 43, 'Planificar las actividades estratégicas y operativas de la Facultad  de Ciencias Jurídicas : Departamentos, Carreras de grado y  postgrado, Instituto de Investigación y Consultorio Jurídico, a través de un taller', '13.2.1', 'Presupuesto económico y  compromiso de la unidades académicas para la construcción del plan operativo anual.', 'cumplimiento de políticas y efectividad en los resultados de gestión de las unidades de la facultad .\n', 'POA\n', 'Facultad de Ciencias', '2016-01-18', '2016-03-31'),
(96, 44, 'Monitoreo y seguimiento de actividades.', '13.3.1', 'Presupuesto económico y  compromiso de la unidades académicas para la construcción del plan operativo anual.', 'Desempeño y resultados obtenidos', 'Informe y actividades realizadas', 'Facultad de Ciencias', '2016-01-18', '2016-03-31'),
(97, 44, 'Recolectar/documentar evidencias de actividades realizadas y no realizadas', '13.3.2', 'Presupuesto económico y  compromiso de la unidades académicas para la construcción del plan operativo anual.', 'Desempeño y resultados obtenidos', 'Informe y actividades realizadas', 'Facultad de Ciencias', '2016-01-18', '2016-03-31'),
(98, 44, 'Elaborar informe de resultados  trimestral.', '13.3.3', 'Presupuesto económico y  compromiso de la unidades académicas para la construcción del plan operativo anual.', 'Desempeño y resultados obtenidos', 'Informe y actividades realizadas', 'Facultad de Ciencias', '2016-01-18', '2016-03-31'),
(99, 44, 'Ejecutar las actividades de por lo menos el 70% de los  referentes mínimos planificados para el 2016 con propósitos de acreditación de la carrera en 2017, en la Comisión de Gestión Académica', '13.3.4', 'Presupuesto económico y  compromiso de la unidades académicas para la construcción del plan operativo anual.', 'Desempeño y resultados obtenidos', 'Informe y actividades realizadas', 'Facultad de Ciencias', '2016-01-18', '2016-03-31'),
(100, 45, 'Definir los instrumentos de evaluación del cumplimiento y desempeño del personal docente y administrativo de acuerdo a la normativa universitaria', '15.5.1', 'Apoyo de las autoridades de la Facultad ', 'Asegurar el cumplimiento  de la normativa universitaria', 'Evidencia del Cumplimiento de funciones académicas y administrativas de acuerdo a la normativa universitaria, por medio de informes y supervisiones', 'Facultad de Ciencias', '2016-01-18', '2016-03-31'),
(101, 45, 'Aplicación de los instrumentos de evaluación del cumplimiento y desempeño del personal docente y administrativo de acuerdo a la normativa universitaria', '15.5.2', 'Apoyo de las autoridades de la Facultad ', 'Asegurar el cumplimiento  de la normativa universitaria', 'Evidencia del Cumplimiento de funciones académicas y administrativas de acuerdo a la normativa universitaria, por medio de informes y supervisiones', 'Facultad de Ciencias', '2016-01-18', '2016-03-31'),
(102, 46, 'Desarrollar los encuentros entre las autoridades y la comunidad estudiantil', '15.6.1', 'Estudiantes y autoridades dispuestos para el desarrollo de los encuentros', 'Contribuir a la consolidación del ordenamiento jurídico de la UNAH', 'Encuentros realizados, listas de asistencia\n', 'Alumnos y docentes', '2016-01-18', '2016-03-31'),
(105, 49, 'Conformar comisiones para dictaminar y elaborar propuestas de actualización y reforma de la normativa del nivel', '15.8.1', 'Agilidad en los procesos y docentes comprometidos en la integración de comisiones', 'Contribuir a la consolidación del ordenamiento jurídico de la UNAH', 'Dictamen realizados, Informes de propuestas de actualización y reforma de la normativa del nivel', 'Facultad de Ciencias', '2016-01-18', '2016-03-31'),
(104, 48, 'Desarrollar los encuentros entre las autoridades y la comunidad docente', '15.7.1', 'Estudiantes y autoridades dispuestos para el desarrollo de los encuentros', 'Contribuir a la consolidación del ordenamiento jurídico de la UNAH', 'Encuentros realizados, listas de asistencia\n', 'Alumnos y docentes', '2016-01-18', '2016-03-31'),
(106, 49, 'Presentar los dictámenes de la normativa ', '15.8.2', 'Agilidad en los procesos y docentes comprometidos en la integración de comisiones', 'Contribuir a la consolidación del ordenamiento jurídico de la UNAH', 'Dictamen realizados, Informes de propuestas de actualización y reforma de la normativa del nivel', 'Facultad de Ciencias', '2016-01-18', '2016-03-31'),
(107, 50, 'Elaboración y presentación para aprobación de las propuestas de actualización y reforma de la normativa', '15.9.1', 'Agilidad en los procesos y docentes comprometidos en la integración de comisiones', 'Contribuir a la consolidación del ordenamiento jurídico de la UNAH', 'Actas de apropiación de acuerdos', 'Facultad de Ciencias', '2016-01-18', '2016-03-31'),
(108, 50, 'Socialización de los acuerdos, dictámenes y normativa aprobado', '15.9.2', 'Agilidad en los procesos y docentes comprometidos en la integración de comisiones', 'Contribuir a la consolidación del ordenamiento jurídico de la UNAH', 'Actas de apropiación de acuerdos', 'Facultad de Ciencias', '2016-01-18', '2016-03-31'),
(109, 51, 'Desarrollar el intercambio académico, cultural y deportivo entre estudiantes de  Facultades y escuelas de Derecho de  universidades nacionales y regionales', '5.4.1', 'Se cuenta con la aprobación de las autoridades y con los fondos necesarios para su desarrollo', 'Promover y generar espacios de intercambio estudiantil para lograr el desarrollo integral de los estudiantes', 'Informes de resultados, listas de asistencia, fotografías', 'Estudiantes', '2016-01-18', '2016-03-31'),
(110, 52, 'Definir la estructura de la Unidad de Seguimiento a Egresados en la Facultad de Ciencias Jurídicas, estableciendo responsabilidades y alcances de gestión', '5.5.1', 'Se cuentan con personas comprometidas para su buen funcionamiento y con los recursos necesarios ', 'Los egresados de la Facultad de Ciencias Jurídicas deben contar con unidad de apoyo y seguimiento', 'Informes de actividades, bitácoras de reuniones', 'Estudiantes graduado', '2016-01-18', '2016-03-31'),
(111, 52, 'Proveer a la Unidad de los recursos necesarios (espacio físico, computadora, impresora, etc.) de acuerdo a un diagnóstico de necesidades.', '5.5.2', 'Se cuentan con personas comprometidas para su buen funcionamiento y con los recursos necesarios ', 'Los egresados de la Facultad de Ciencias Jurídicas deben contar con unidad de apoyo y seguimiento', 'Informes de actividades, bitácoras de reuniones', 'Estudiantes graduado', '2016-01-18', '2016-03-31'),
(112, 53, 'Desarrollar  capacitaciones en Calidad Educativa Docente ', 'Desarrolla', 'Se cuenta con el apoyo de las unidades correspondientes', 'Brindar una atención de calidad, oportuna, efectiva y pertinente a las necesidades de la sociedad hondureña', 'Capacitaciones de calidad, listas de asistencia,  material didáctico, informes, fotografías, ', 'Docentes', '2016-01-18', '2016-03-31'),
(114, 55, 'Desarrollar un taller de socialización de las políticas de calidad académica de la UNAH', '8.4.1', 'Se cuenta con las políticas de la calidad académica de la UNAH', 'Generar los espacios para que los docentes de la facultad conozcan las políticas de calidad y las apliquen', 'Material didáctico, talleres de socialización, diplomas, listas de asistencia, fotografías', 'Docentes', '2016-01-18', '2016-03-31');
INSERT INTO `actividades` (`id_actividad`, `id_indicador`, `descripcion`, `correlativo`, `supuesto`, `justificacion`, `medio_verificacion`, `poblacion_objetivo`, `fecha_inicio`, `fecha_fin`) VALUES
(115, 56, 'Socializar trimestralmente los resultados e indicadores de la aplicación del Plan de Mejoras ', '8.7.1', 'El Plan de Mejoras se encuentra en etapa de implementación con los recursos necesarios para ello', 'Alcanzar los referentes mínimos para acreditar las Carreras de la Facultad de Ciencias Jurídicas', 'Informes de resultados verificables', 'Sociedad hondureña, ', '2016-01-18', '2016-03-31'),
(116, 57, 'Seguimientos trimestrales a casos atendidos por alumnos en practica profesional supervisada', '3.2.1', 'Se tiene definidas las problemáticas que la sociedad demanda solución y los practicantes cuentan con una buena supervisión', 'Fortalecer las prácticas que realizan los alumnos de la FCJ para convertirlas en el medio por excelencia de los procesos de vinculación', 'Informes de casos resueltos', 'Sociedad hondureña, ', '2016-01-18', '2016-03-31'),
(117, 58, 'Elaborar un Plan de Promoción y Difusión de los servicios y beneficios de los programas de vinculación que desarrollan las diferentes unidades de la Facultad de Ciencias Jurídicas. ', '3.3.1', 'El Consultorio Jurídico Gratuito cuenta con los fondos necesarios para la ejecución del presupuesto', 'La sociedad hondureña debe conocer y tener acceso a los servicios ofrecidos por los programas de vinculación  desarrollados por la facultad', 'Documento contentivo del Plan de Promoción y Difusión, fotografías, etc.', 'Sociedad hondureña, ', '2016-01-18', '2016-03-31'),
(118, 58, 'Aplicar trimestralmente las acciones y actividades definidas en el Plan de Promoción y Difusión ', '3.3.2', 'El Consultorio Jurídico Gratuito cuenta con los fondos necesarios para la ejecución del presupuesto', 'La sociedad hondureña debe conocer y tener acceso a los servicios ofrecidos por los programas de vinculación  desarrollados por la facultad', 'Documento contentivo del Plan de Promoción y Difusión, fotografías, etc.', 'Sociedad hondureña, ', '2016-01-18', '2016-03-31'),
(119, 58, 'Desarrollar reuniones de control y monitoreo de alcances del Plan de Promoción y Difusión', '3.3.3', 'El Consultorio Jurídico Gratuito cuenta con los fondos necesarios para la ejecución del presupuesto', 'La sociedad hondureña debe conocer y tener acceso a los servicios ofrecidos por los programas de vinculación  desarrollados por la facultad', 'Documento contentivo del Plan de Promoción y Difusión, fotografías, etc.', 'Sociedad hondureña, ', '2016-01-18', '2016-03-31'),
(120, 59, ' Ejecutar la planificación y responsabilidades de la Facultad de Ciencias Jurídicas en el marco del Plan de Sostenibilidad de Derechos Humanos ', '7.4.1', 'Se cuenta con  los recursos necesarios para su ejecución ', 'Fortalecer los procesos y compromisos adquiridos en el marco del Plan de Sostenibilidad de Derechos Humanos', 'Informes de procesos, Listas', 'Sociedad hondureña', '2016-01-18', '2016-03-31'),
(121, 61, 'Elaborar y evaluar  un informe trimestral de actividades desarrolladas por las Unidades de Investigación de las carreras de la Facultad de Ciencias Jurídicas', '2.1.1', 'Las Unidades de Investigación cuentan con un POA 2016 y con los recursos necesarios para su funcionamiento', 'Las Carreras de la Facultad deben contar con Unidad de Investigación establecida para el logro la  de certificación de las carreras y la coordinación de las actividades relacionadas con la investigación', 'Informes de avances', 'Docentes, alumnos ', '2016-01-18', '2016-03-31'),
(122, 62, 'Realizar mapeo de eventos de divulgación y publicación de investigaciones a nivel nacional e internacional en cada carrera de la FCJ', '2.9.1', 'Se cuentan con proyectos de investigación que cumplen con los requerimientos de calidad necesarios para su presentación', 'Compartir con la sociedad hondureña los resultados de las investigaciones realizadas en las carreras de la FCJ', 'Registro de participantes, Informes de ponencias realizadas', 'Sociedad hondureña ', '2016-01-18', '2016-03-31'),
(123, 62, 'Participar en un evento de divulgación o publicación de resultados de investigaciones realizadas en la FCJ, congreso de investigación científica, etc.', '2.9.2', 'Se cuentan con proyectos de investigación que cumplen con los requerimientos de calidad necesarios para su presentación', 'Compartir con la sociedad hondureña los resultados de las investigaciones realizadas en las carreras de la FCJ', 'Registro de participantes, Informes de ponencias realizadas', 'Sociedad hondureña ', '2016-01-18', '2016-03-31'),
(124, 63, 'Ejecutar la planificación y responsabilidades de la Facultad de Ciencias Jurídicas en el marco del Plan de Sostenibilidad de Derechos Humanos ', '7.4.1', 'Se cuenta con  los recursos necesarios para su ejecución ', 'Fortalecer los procesos y compromisos adquiridos en el marco del Plan de Sostenibilidad de Derechos Humanos', 'Informes de procesos, Listas', 'Sociedad hondureña', '2016-01-18', '2016-03-31'),
(125, 60, 'Planificar las actividades estratégicas y operativas de la Facultad  de Ciencias Jurídicas : Departamentos, Carreras de grado y  postgrado, Instituto de Investigación y Consultorio Jurídico, a través de un taller', '13.2.1', 'Presupuesto económico y  compromiso de la unidades académicas para la construcción del plan operativo anual.', 'cumplimiento de políticas y efectividad en los resultados de gestión de las unidades de la facultad .', 'POA', 'Facultad de Ciencias', '2016-01-18', '2016-03-31'),
(126, 64, 'Desarrollar la propuesta para la creación del Doctorado en Derecho Mercantil', '10.1.1', 'Se cuenta con la aprobación de las unidades académicas correspondientes y del Consejo Universitario', 'El país demanda la preparación de profesionales a nivel de posgrado en estas áreas específicas de las Ciencias Jurídicas y satisfagan la demanda de estas carreras a nivel nacional', 'Planes de estudios aprobados por el Consejo de Educación Superior', 'Sociedad hondureña', '2016-01-18', '2016-03-31'),
(127, 64, 'Presentación oficial y apertura del Doctorado en Derecho', '10.1.2', 'Se cuenta con la aprobación de las unidades académicas correspondientes y del Consejo Universitario', 'El país demanda la preparación de profesionales a nivel de posgrado en estas áreas específicas de las Ciencias Jurídicas y satisfagan la demanda de estas carreras a nivel nacional', 'Planes de estudios aprobados por el Consejo de Educación Superior', 'Sociedad hondureña', '2016-01-18', '2016-03-31'),
(128, 64, ' 0', '0', 'Se cuenta con la aprobación de las unidades académicas correspondientes y del Consejo Universitario', '0', '0', '0', '2016-01-18', '2016-03-31'),
(132, 65, 'Recolectar/documentar evidencias de actividades realizadas y no realizadas', '13.3.2', 'Presupuesto económico y  compromiso de la unidades académicas para la construcción del plan operativo anual.', 'Desempeño y resultados obtenidos', 'Informe y actividades realizadas', 'Facultad de Ciencias', '2016-01-18', '2016-03-31'),
(133, 66, 'Apertura de la Maestría en Derecho Penal y Procesal Penal con salida alterna de en grado de especialidad', '10.2.1', 'Se cuenta con la aprobación de las unidades académicas correspondientes y del Consejo Universitario', 'El país demanda la preparación de profesionales a nivel de posgrado en estas áreas específicas de las Ciencias Jurídicas y satisfagan la demanda de estas carreras a nivel nacional', 'Planes de estudios aprobados por el Consejo de Educación Superior', 'Sociedad hondureña', '2016-01-18', '2016-03-31'),
(129, 64, ' 0', '0', 'Se cuenta con la aprobación de las unidades académicas correspondientes y del Consejo Universitario', '0', '0', '0', '2016-01-18', '2016-03-31'),
(131, 65, 'Recolectar/documentar evidencias de actividades realizadas y no realizadas', '13.3.2', 'Presupuesto económico y  compromiso de la unidades académicas para la construcción del plan operativo anual.', 'Desempeño y resultados obtenidos', 'Informe y actividades realizadas', 'Facultad de Ciencias', '2016-01-18', '2016-03-31'),
(130, 65, 'Monitoreo y seguimiento de actividades.', '13.3.1', 'Presupuesto económico y  compromiso de la unidades académicas para la construcción del plan operativo anual.', 'Desempeño y resultados obtenidos', 'Informe y actividades realizadas', 'Facultad de Ciencias', '2016-01-18', '2016-03-31'),
(134, 66, 'Apertura de la Tercera Promoción de la Maestría Académica en Derechos Humanos', '10.2.2', 'Se cuenta con la aprobación de las unidades académicas correspondientes y del Consejo Universitario', 'El país demanda la preparación de profesionales a nivel de posgrado en estas áreas específicas de las Ciencias Jurídicas y satisfagan la demanda de estas carreras a nivel nacional', 'Planes de estudios aprobados por el Consejo de Educación Superior', 'Sociedad hondureña', '2016-01-18', '2016-03-31'),
(135, 67, 'Implementar el Plan de Mejoras de la Maestría en Derecho Mercantil en miras a la acreditación, que incluye : el rediseño curricular, elevar eficiencia terminal', '10.3.1', 'Se cuentan con las aprobaciones de las unidades superiores y con los recursos necesarios para su implementación', 'Lograr el aseguramiento de la calidad en las carreras de posgrados de la Facultad, que permita la acreditación de los mismos así como el reconocimiento regional e internacional', 'Informes de seguimiento trimestrales, planes de estudios reformados aprobados por Consejo Universitario', 'Sociedad hondureña', '2016-01-18', '2016-03-31'),
(136, 67, 'Implementar el Plan de Mejoras de la Especialidad en Derecho Penal y Procesal Penal', '10.3.2', 'Se cuentan con las aprobaciones de las unidades superiores y con los recursos necesarios para su implementación', 'Lograr el aseguramiento de la calidad en las carreras de posgrados de la Facultad, que permita la acreditación de los mismos así como el reconocimiento regional e internacional', 'Informes de seguimiento trimestrales, planes de estudios reformados aprobados por Consejo Universitario', 'Sociedad hondureña', '2016-01-18', '2016-03-31'),
(137, 67, 'Implementar el Plan de Mejoras en Maestría en Derechos Humanos y Desarrollo en miras a la acreditación de la carrera, que incluye: el rediseño curricular, elevar la eficiencia terminal, entre otros', '10.3.3', 'Se cuentan con las aprobaciones de las unidades superiores y con los recursos necesarios para su implementación', 'Lograr el aseguramiento de la calidad en las carreras de posgrados de la Facultad, que permita la acreditación de los mismos así como el reconocimiento regional e internacional', 'Informes de seguimiento trimestrales, planes de estudios reformados aprobados por Consejo Universitario', 'Sociedad hondureña', '2016-01-18', '2016-03-31'),
(138, 65, 'Elaborar informe de resultados  trimestral.', '13.3.3', 'Presupuesto económico y  compromiso de la unidades académicas para la construcción del plan operativo anual.', 'Desempeño y resultados obtenidos', 'Informe y actividades realizadas', 'Facultad de Ciencias', '2016-01-18', '2016-03-31'),
(139, 67, 'Implementar el Plan de Mejoras en Maestría en Derechos Humanos y Desarrollo Implementar el Plan de Mejoras en Maestría en Ciencias Políticas y Gestión Estatal en miras a la acreditación de la carrera, que incluye: el rediseño curricular, elevar la eficiencia terminal, entre otros', '10.3.4', 'Se cuentan con las aprobaciones de las unidades superiores y con los recursos necesarios para su implementación', 'Lograr el aseguramiento de la calidad en las carreras de posgrados de la Facultad, que permita la acreditación de los mismos así como el reconocimiento regional e internacional', 'Informes de seguimiento trimestrales, planes de estudios reformados aprobados por Consejo Universitario', 'Sociedad hondureña', '2016-01-18', '2016-03-31'),
(140, 68, 'Identificar los mejores proyectos de tesis desarrollados por los maestrandos en cada una de las carreras de posgrados de la Facultad de Ciencias Jurídicas para coordinar la publicación con el IIJ', 'Se cuenta ', 'Integrar los posgrados y el IIJ con el propósito de  producir y publicar para conocimiento de la sociedad hondureña el conocimiento jurídico que demanda', 'Documentos de tesis en proceso de revisión en conjunto con el IIJ, informes de avances, publicaciones', 'Sociedad hondureña', 'Coordinadores de mae', '2016-01-18', '2016-03-31'),
(141, 69, 'Desarrollar el II Congreso en Derecho Penal y Procesal Penal', '10.5.1', 'Se cuenta con resultados de investigación para presentar y con los recursos necesarios para la participación', 'Difundir y poner a disposición de la comunidad universitaria y la sociedad hondureña en general los resultados de las investigaciones desarrolladas en los diferentes posgrados de la Facultad de Ciencias Jurídicas', 'Informes de ponencias, fotografías, listas etc.', 'Sociedad hondureña', '2016-01-18', '2016-03-31'),
(142, 69, 'Participación de un posgrado en el Congreso de Investigación de la DICYP', '10.5.2', 'Se cuenta con resultados de investigación para presentar y con los recursos necesarios para la participación', 'Difundir y poner a disposición de la comunidad universitaria y la sociedad hondureña en general los resultados de las investigaciones desarrolladas en los diferentes posgrados de la Facultad de Ciencias Jurídicas', 'Informes de ponencias, fotografías, listas etc.', 'Sociedad hondureña', '2016-01-18', '2016-03-31'),
(143, 70, 'Elaborar artículos científicos para publicación en revistas científicas por los coordinadores de las maestrías ', '10.6.1', 'Se cuenta con la aprobación de las DICYP para la publicación en revistas u otros medios de divulgación', 'Difundir y poner a disposición de la comunidad universitaria y la sociedad hondureña en general los resultados de las investigaciones desarrolladas en los diferentes posgrados de la Facultad de Ciencias Jurídicas', 'Publicaciones en revistas', 'Sociedad hondureña', '2016-01-18', '2016-03-31'),
(144, 71, 'Desarrollar capacitaciones en Derecho Penal y Procesal Penal dirigidas instituciones: DEI, Ministerio Público, Sociedad Civil', '10.7.1', 'Se cuentan con los recursos necesarios para su ejecución , las alianzas estratégicas necesarias y la aprobación de las autoridades correspondientes', 'Necesario para desarrollar y fortalecer la agenda de vinculación de la Facultad de Ciencias Jurídicas, mediante el desarrollo de proyectos de vinculación con la sociedad hondureña aportando soluciones y contribuyendo al desarrollo en las áreas especificas del conocimiento jurídico que desarrolla cada carrera de posgrado', 'Informes trimestrales, listas de asistencia, fotografías', 'Sociedad hondureña', '2016-01-18', '2016-03-31'),
(145, 71, 'Desarrollar capacitaciones en Derecho Marítimo dirigidos a instituciones como: Marina Mercante, Comisión Nacional de Protección de Puertos, Cámara de Comercio', '10.7.2', 'Se cuentan con los recursos necesarios para su ejecución , las alianzas estratégicas necesarias y la aprobación de las autoridades correspondientes', 'Necesario para desarrollar y fortalecer la agenda de vinculación de la Facultad de Ciencias Jurídicas, mediante el desarrollo de proyectos de vinculación con la sociedad hondureña aportando soluciones y contribuyendo al desarrollo en las áreas especificas del conocimiento jurídico que desarrolla cada carrera de posgrado', 'Informes trimestrales, listas de asistencia, fotografías', 'Sociedad hondureña', '2016-01-18', '2016-03-31'),
(146, 71, 'Apertura de la segunda promoción del Diplomado en Formación de Formadores para prevención de la Violencia', '10.7.3', 'Se cuentan con los recursos necesarios para su ejecución , las alianzas estratégicas necesarias y la aprobación de las autoridades correspondientes', 'Necesario para desarrollar y fortalecer la agenda de vinculación de la Facultad de Ciencias Jurídicas, mediante el desarrollo de proyectos de vinculación con la sociedad hondureña aportando soluciones y contribuyendo al desarrollo en las áreas especificas del conocimiento jurídico que desarrolla cada carrera de posgrado', 'Informes trimestrales, listas de asistencia, fotografías', 'Sociedad hondureña', '2016-01-18', '2016-03-31'),
(147, 71, 'Por medio de la Maestría en Derechos Humanos y la Corte Interamericana de Derechos Humanos se desarrollara un programa de asistencia judicial gratuita para personas que no tiene recursos suficientes para acceder al sistema interamericano  de protección de los derechos humanos en asocio con CJG', '10.7.4', 'Se cuentan con los recursos necesarios para su ejecución , las alianzas estratégicas necesarias y la aprobación de las autoridades correspondientes', 'Necesario para desarrollar y fortalecer la agenda de vinculación de la Facultad de Ciencias Jurídicas, mediante el desarrollo de proyectos de vinculación con la sociedad hondureña aportando soluciones y contribuyendo al desarrollo en las áreas especificas del conocimiento jurídico que desarrolla cada carrera de posgrado', 'Informes trimestrales, listas de asistencia, fotografías', 'Sociedad hondureña', '2016-01-18', '2016-03-31'),
(148, 72, 'Participación de estudiantes de la Maestría de Derecho Marítimo y Gestión Portuaria en actividades curriculares en Autoridad Marítima y Tribunal Marítimo en Panamá', '10.8.1', 'Se cuenta con la aprobación de las autoridades correspondientes y los recursos necesarios para su ejecución', 'Enriquecer la formación de estudiantes de las carreras de posgrado a través de la integración en proyectos de movilidad en el marco de la internacionalización de las carreras que les permita tener un visión globalizada ', 'Cartas de aprobación y aceptación, informes,etc', 'Alumnos', '2016-01-18', '2016-03-31'),
(149, 72, 'Movilidad estudiantil en el marco de la red de universidades de la latinoamericana con pasantías o becas de investigación en la Maestría en Derecho Marítimo y Gestión Portuaria', '10.8.2', 'Se cuenta con la aprobación de las autoridades correspondientes y los recursos necesarios para su ejecución', 'Enriquecer la formación de estudiantes de las carreras de posgrado a través de la integración en proyectos de movilidad en el marco de la internacionalización de las carreras que les permita tener un visión globalizada ', 'Cartas de aprobación y aceptación, informes,etc', 'Alumnos', '2016-01-18', '2016-03-31'),
(150, 72, 'Desarrollo de pasantías en el Instituto Latinoamericano de las Naciones para el tratamiento de los reclusos por alumnos de la Especialidad en Derecho Penal y Procesal Penal', '10.8.3', 'Se cuenta con la aprobación de las autoridades correspondientes y los recursos necesarios para su ejecución', 'Enriquecer la formación de estudiantes de las carreras de posgrado a través de la integración en proyectos de movilidad en el marco de la internacionalización de las carreras que les permita tener un visión globalizada ', 'Cartas de aprobación y aceptación, informes,etc', 'Alumnos', '2016-01-18', '2016-03-31'),
(151, 73, 'Movilidad docente en la Maestría en Derecho Marítimo con la Universidad de Panamá', '10.9.1', 'Se cuenta con la aprobación de las autoridades correspondientes y los recursos necesarios para su ejecución', 'Enriquecer la formación de estudiantes de las carreras de posgrado a través de la integración en proyectos de movilidad  que permita el intercambio de docentes internacionales ', 'Cartas de aprobación y aceptación, informes,etc', 'Alumnos y docentes', '2016-01-18', '2016-03-31'),
(152, 73, 'Desarrollar intercambio docente con el Instituto de Estudios de Investigaciones jurídicas de Nicaragua en la Especialidad en Derecho Penal y Procesal Penal', '10.9.2', 'Se cuenta con la aprobación de las autoridades correspondientes y los recursos necesarios para su ejecución', 'Enriquecer la formación de estudiantes de las carreras de posgrado a través de la integración en proyectos de movilidad  que permita el intercambio de docentes internacionales ', 'Cartas de aprobación y aceptación, informes,etc', 'Alumnos y docentes', '2016-01-18', '2016-03-31'),
(153, 74, 'Desarrollar actividades de promoción y motivación al personal de los diferentes departamentos para el  fortalecimiento del desarrollo de la investigación científica en la Facultad de Ciencias Jurídicas con ofertas de capacitaciones, becas, pasantías e integración a experiencias de investigación inter y multidisciplinar en la UNAH', '2.1.1', 'Las Unidades de Investigación cuentan con un POA 2016 y con los recursos necesarios para su funcionamiento', 'Las Carreras de la Facultad deben contar con Unidad de Investigación establecida para el logro la  de certificación de las carreras y la coordinación de las actividades relacionadas con la investigación', 'Informes de avances', 'Docentes, alumnos ', '2016-01-18', '2016-03-31'),
(154, 75, 'Desarrollar actividades de promoción y motivación al personal de los diferentes departamentos para el  fortalecimiento del desarrollo de la investigación científica en la Facultad de Ciencias Jurídicas con ofertas de capacitaciones, becas, pasantías e integración a experiencias de investigación inter y multidisciplinar en la UNAH', '2.1.1', 'Las Unidades de Investigación cuentan con un POA 2016 y con los recursos necesarios para su funcionamiento', 'Las Carreras de la Facultad deben contar con Unidad de Investigación establecida para el logro la  de certificación de las carreras y la coordinación de las actividades relacionadas con la investigación', 'Informes de avances', 'Docentes, alumnos ', '2016-01-18', '2016-03-31'),
(155, 75, 'Elaborar y evaluar  un informe trimestral de actividades desarrolladas por las Unidades de Investigación de las carreras de la Facultad de Ciencias Jurídicas', '2.1.2', 'Las Unidades de Investigación cuentan con un POA 2016 y con los recursos necesarios para su funcionamiento', 'Las Carreras de la Facultad deben contar con Unidad de Investigación establecida para el logro la  de certificación de las carreras y la coordinación de las actividades relacionadas con la investigación', 'Informes de avances', 'Docentes, alumnos ', '2016-01-18', '2016-03-31'),
(156, 76, 'Desarrollar las investigaciones de acuerdo a las líneas definidas en las materias del conocimiento relacionadas a cada departamento ', '2.2.2', 'Se cuenta con docentes interesados y con vocación para el desarrollo de investigaciones', 'La Facultad de Ciencias Jurídicas debe producir y aportar a la sociedad hondureña el conocimiento jurídico que demanda', 'Documentos contentivos de la investigación, ', 'Docentes, alumnos y ', '2016-01-18', '2016-03-31'),
(157, 76, 'Realizar convocatoria para el desarrollo de investigaciones de acuerdo a las líneas definidas por el IIJ de la Facultad de Ciencias Jurídicas', '2.2.1', 'Se cuenta con docentes interesados y con vocación para el desarrollo de investigaciones', 'La Facultad de Ciencias Jurídicas debe producir y aportar a la sociedad hondureña el conocimiento jurídico que demanda', 'Unidad de Investigación conformada', 'Docentes y alumnos', '2016-01-18', '2016-03-31'),
(158, 77, 'Identificar y registrar  los proyectos de investigación en desarrollo en las carreras de la Facultad de Ciencias Jurídicas  en la unidad correspondientes de la UNAH. ', '2.4.1', 'Existen proyectos de investigación desarrollándose en la Facultad de Ciencias Jurídicas', 'La Facultad de Ciencias Jurídicas debe producir y aportar a la sociedad hondureña el conocimiento jurídico que demanda', 'Listado de proyectos registrados en la DICU', 'Docentes, alumnos y ', '2016-01-18', '2016-03-31'),
(159, 78, 'Identificar las becas disponibles para la formación de los docentes en materia de investigación.  ', '2.5.1', 'Contar con docentes que posean las calificaciones necesarias para optar a las becas de investigación en los departamentos de las carreras y se cuenta con la aprobación de las autoridades respectivas.', 'Las carreras de la FCJ deben contar con personal formado en materia de investigación', 'Certificados de cursos o diplomados recibidos, títulos de postgrados recibidos ', 'Docentes', '2016-01-18', '2016-03-31'),
(160, 78, ' Elaborar boletines y comunicaciones para promover la disponibilidad de becas de formación en investigación entre los docentes de la carrera de Derecho, para integrar un 5% del personal interesado', '2.5.2', 'Contar con docentes que posean las calificaciones necesarias para optar a las becas de investigación en los departamentos de las carreras y se cuenta con la aprobación de las autoridades respectivas.', 'Las carreras de la FCJ deben contar con personal formado en materia de investigación', 'Certificados de cursos o diplomados recibidos, títulos de postgrados recibidos ', 'Docentes', '2016-01-18', '2016-03-31'),
(161, 74, 'Elaborar y evaluar  un informe trimestral de actividades desarrolladas por las Unidades de Investigación de las carreras de la Facultad de Ciencias Jurídicas', '2.1.2', 'Las Unidades de Investigación cuentan con un POA 2016 y con los recursos necesarios para su funcionamiento', 'Las Carreras de la Facultad deben contar con Unidad de Investigación establecida para el logro la  de certificación de las carreras y la coordinación de las actividades relacionadas con la investigación', 'Informes de avances', 'Docentes, alumnos ', '2016-01-18', '2016-03-31'),
(162, 79, 'Elaborar un diagnostico de requerimientos tecnológicos y necesidades para el desarrollo de una plataforma electrónica que permita poner a disposición a estudiantes, docentes y alumnos de los resultados de los proyectos de investigación desarrollados en las diferentes carreras de la Facultad de Ciencias Jurídicas', '2.7.1', 'Se cuenta con la aprobación de las autoridades y los recursos humanos calificados ', 'Generar una herramienta que permita el fácil acceso de alumnos, docentes y sociedad hondureña a los resultados de las investigaciones desarrolladas en la FCJ', 'Base de datos establecida', 'Sociedad hondureña ', '2016-01-18', '2016-03-31'),
(163, 80, 'Identificar las becas disponibles para la formación de los docentes en materia de investigación.  ', '2.5.1', 'Contar con docentes que posean las calificaciones necesarias para optar a las becas de investigación en los departamentos de las carreras y se cuenta con la aprobación de las autoridades respectivas.', 'Las carreras de la FCJ deben contar con personal formado en materia de investigación', 'Certificados de cursos o diplomados recibidos, títulos de postgrados recibidos ', 'Docentes', '2016-01-18', '2016-03-31'),
(164, 80, 'Elaborar boletines y comunicaciones para promover la disponibilidad de becas de formación en investigación entre los docentes de la carrera de Derecho, para integrar un 5% del personal interesado', '2.5.2', 'Contar con docentes que posean las calificaciones necesarias para optar a las becas de investigación en los departamentos de las carreras y se cuenta con la aprobación de las autoridades respectivas.', 'Las carreras de la FCJ deben contar con personal formado en materia de investigación', 'Certificados de cursos o diplomados recibidos, títulos de postgrados recibidos ', 'Docentes', '2016-01-18', '2016-03-31'),
(165, 81, 'Elaborar la propuesta de  creación del Laboratorio de Investigación Forense', '2.6.1', '1. Fondos necesarios para la adquisición de equipos necesarios 2. Agilidad en los procesos de aprobación', 'El país demanda de este recurso humano con título de educación superior para atender la mora de la investigación de los delitos,  los cuales se han incrementado exponencialmente en el país y debida preparación técnica', 'Propuesta de laboratorio aprobada, fondos identificados y disponibles, laboratorio establecido, fotografía', 'Docentes, estudiante', '2016-01-18', '2016-03-31'),
(166, 82, 'Identificar proyectos de investigación que cumplen los requisitos de publicación', '2.8.1', 'Se cuentan con proyectos de investigación que cumplen con los requerimientos de calidad necesarios para la publicación', 'La Facultad de Ciencias Jurídicas debe producir y publicar para conocimiento de la sociedad hondureña el conocimiento jurídico que demanda', 'Publicaciones en revistas y otros medios electrónicos', 'Sociedad hondureña ', '2016-01-18', '2016-03-31'),
(167, 82, 'Publicar investigaciones en las revistas identificadas y con las que se tiene convenio', '2.8.2', 'Se cuentan con proyectos de investigación que cumplen con los requerimientos de calidad necesarios para la publicación', 'La Facultad de Ciencias Jurídicas debe producir y publicar para conocimiento de la sociedad hondureña el conocimiento jurídico que demanda', 'Publicaciones en revistas y otros medios electrónicos', 'Sociedad hondureña ', '2016-01-18', '2016-03-31'),
(168, 81, 'Gestionar los fondos necesarios para la creación del Laboratorio de Investigación Forense ', '2.6.2', '1. Fondos necesarios para la adquisición de equipos necesarios 2. Agilidad en los procesos de aprobación', 'El país demanda de este recurso humano con título de educación superior para atender la mora de la investigación de los delitos,  los cuales se han incrementado exponencialmente en el país y debida preparación técnica', 'Propuesta de laboratorio aprobada, fondos identificados y disponibles, laboratorio establecido, fotografía', 'Docentes, estudiante', '2016-01-18', '2016-03-31'),
(169, 83, 'Realizar mapeo de eventos de divulgación y publicación de investigaciones a nivel nacional e internacional en cada carrera de la FCJ', '2.9.1', 'Se cuentan con proyectos de investigación que cumplen con los requerimientos de calidad necesarios para su presentación', 'Compartir con la sociedad hondureña los resultados de las investigaciones realizadas en las carreras de la FCJ', 'Registro de participantes, Informes de ponencias realizadas', 'Sociedad hondureña ', '2016-01-18', '2016-03-31'),
(170, 83, 'Participar en un evento de divulgación o publicación de resultados de investigaciones realizadas en la FCJ, congreso de investigación científica, etc.', '2.9.2', 'Se cuentan con proyectos de investigación que cumplen con los requerimientos de calidad necesarios para su presentación', 'Compartir con la sociedad hondureña los resultados de las investigaciones realizadas en las carreras de la FCJ', 'Registro de participantes, Informes de ponencias realizadas', 'Sociedad hondureña ', '2016-01-18', '2016-03-31'),
(171, 81, 'Solicitud de aprobación de la creación del Laboratorio de Investigación Forense ante las unidades correspondientes', '2.6.3', '1. Fondos necesarios para la adquisición de equipos necesarios 2. Agilidad en los procesos de aprobación', 'El país demanda de este recurso humano con título de educación superior para atender la mora de la investigación de los delitos,  los cuales se han incrementado exponencialmente en el país y debida preparación técnica', 'Propuesta de laboratorio aprobada, fondos identificados y disponibles, laboratorio establecido, fotografía', 'Docentes, estudiante', '2016-01-18', '2016-03-31'),
(172, 84, 'Identificar revistas para la publicación de los resultados de la investigación en las carreras de la Facultad de Ciencias Jurídicas, estableciendo claramente requisitos, fechas límites, etc.', '2.10.1', 'Se cuenta con opciones de revistas para publicación', 'Difundir los resultados de las investigaciones desarrolladas en la FCJ ', 'Informes de resultados', 'Sociedad hondureña ', '2016-01-18', '2016-03-31'),
(173, 86, 'Desarrollar las investigaciones de acuerdo a las líneas definidas en las materias del conocimiento relacionadas a cada unidad académica', '6.4.1', 'Contar con docentes investigadores en la Facultad de Ciencias Jurídicas y se cuenta con fondos para la ejecución de las actividades', 'La Facultad de Ciencias Jurídicas debe producir y aportar a la sociedad hondureña el conocimiento jurídico que demanda', 'Listado de proyectos registrados en la DICU, Informes de investigaciones', 'Comunidad educativa(', '2016-01-18', '2016-03-31'),
(174, 85, 'Desarrollar una  capacitación en apoyo a la investigación: requisitos de publicación, proceso, etc. ofrecido a los docentes de los diferentes departamentos', '2.11.1', 'Se ha desarrollado la coordinación necesaria con el IIJ y la DICU para su desarrollo', 'Se ha desarrollado la coordinación necesaria con el IIJ y la DICU para su desarrollo', 'Listas de asistencia, ', 'Docentes', '2016-01-18', '2016-03-31'),
(175, 85, 'Promover la integración de docentes al Diplomado en Investigación que ofrece la DICU, definiendo mecanismos de apoyo y colaboración entre la FCJ y esa dirección para facilitar el acceso de docentes al mismo', '2.11.2', 'Se cuenta con el apoyo de la DICU', 'La carrera de Derecho debe contar con personal docente formado en materia de investigación', 'Diplomas de participación ', 'Docentes', '2016-01-18', '2016-03-31'),
(176, 86, 'Sostener reuniones de seguimiento y control de avances de las investigaciones en cada unidad académica', '6.4.2', 'Contar con docentes investigadores en la Facultad de Ciencias Jurídicas y se cuenta con fondos para la ejecución de las actividades', 'La Facultad de Ciencias Jurídicas debe producir y aportar a la sociedad hondureña el conocimiento jurídico que demanda', 'Listado de proyectos registrados en la DICU, Informes de investigaciones', 'Comunidad educativa(', '2016-01-18', '2016-03-31'),
(177, 87, 'Desarrollar un documento base en coordinación con la VRI para identificar los procesos de participación en redes académicas e investigativas de interés para la integración por parte de la Facultad de Ciencias Jurídicas', '14.5.1', 'Se cuenta con el apoyo de VRI y se cuenta con productividad investigativa y académica interna', 'Proyectar la Facultad de Ciencias Jurídicas a una posición de liderazgo en la Educación Superior a nivel internacional', 'Documento desarrollado, informes de participación', 'Docentes y estudiant', '2016-01-18', '2016-03-31'),
(178, 88, 'Identificar y desarrollar propuestas de proyectos dirigidos al fortalecimiento de la investigación en la FCJ a desarrollarlo en el año', '2.12.1', 'Se cuenta con el apoyo de las autoridades de la UNAH para la firma de convenios', 'Es necesario la gestión de alianzas para la generación de fondos externos para desarrollar  los proyectos de investigación ya que los fondos propios son insuficientes.', 'Propuestas de proyectos aprobados', 'Docentes, alumnos, s', '2016-01-18', '2016-03-31'),
(179, 88, ' Realizar un mapeo de posibles organizaciones que contemplan el  apoyo a proyectos identificados en la FCJ ', '2.12.2', 'Se cuenta con el apoyo de las autoridades de la UNAH para la firma de convenios', 'Es necesario la gestión de alianzas para la generación de fondos externos para desarrollar  los proyectos de investigación ya que los fondos propios son insuficientes.', 'Listado de posibles cooperantes', 'Docentes, alumnos, s', '2016-01-18', '2016-03-31'),
(180, 88, 'Establecer los contactos pertinentes y presentar los proyectos dirigidos al fortalecimiento de la investigación en la FCJ', '2.12.3', 'Se cuenta con el apoyo de las autoridades de la UNAH para la firma de convenios', 'Es necesario la gestión de alianzas para la generación de fondos externos para desarrollar  los proyectos de investigación ya que los fondos propios son insuficientes.', 'Listas, proyectos aprobados', 'Docentes, alumnos, s', '2016-01-18', '2016-03-31'),
(181, 88, ' 0', '0', 'Se cuenta con el apoyo de las autoridades de la UNAH para la firma de convenios', '0', '0', '0', '2016-01-18', '2016-03-31'),
(183, 87, 'Desarrollar actividades de socialización de productos y experiencias obtenidas en las redes de investigación y docencia', '14.5.3', 'Se cuenta con el apoyo de VRI y se cuenta con productividad investigativa y académica interna', 'Proyectar la Facultad de Ciencias Jurídicas a una posición de liderazgo en la Educación Superior a nivel internacional', 'Documento desarrollado, informes de participación', 'Docentes y estudiant', '2016-01-18', '2016-03-31'),
(182, 87, 'Integrar las unidades académicas a las redes de investigación y docencia identificadas', '14.5.2', 'Se cuenta con el apoyo de VRI y se cuenta con productividad investigativa y académica interna', 'Proyectar la Facultad de Ciencias Jurídicas a una posición de liderazgo en la Educación Superior a nivel internacional', 'Documento desarrollado, informes de participación', 'Docentes y estudiant', '2016-01-18', '2016-03-31'),
(184, 89, 'Elaborar un boletín informativo que contenga instituciones, fechas y requisitos para el desarrollo de pasantías', '2.13.1', 'Se cuenta con el apoyo de las unidades de la UNAH para proporcionar la información necesaria', 'Enriquecer la producción científica en la FCJ mediante el aprendizaje de buenas prácticas en otras universidades e instituciones', 'Boletín digital e impreso', 'Docentes y alumnos', '2016-01-18', '2016-03-31'),
(185, 90, 'Realizar un mapeo de redes nacionales de fomento a la investigación( entes gubernamentales, sectores productivos y otras universidades) con las que su pueden establecer vínculos e integración de la facultad ', '2.14.1', 'Se cuenta con el apoyo de las autoridades de la UNAH para la firma de convenios y existen redes de fomento a la investigación', 'Enriquecer la producción científica en la FCJ mediante el aprendizaje de buenas prácticas en otras universidades e instituciones', 'Listado redes y requisitos de ingreso', 'Docentes y alumnos', '2016-01-18', '2016-03-31'),
(186, 90, 'Establecer los contactos necesarios para la integración', '2.14.2', 'Se cuenta con el apoyo de las autoridades de la UNAH para la firma de convenios y existen redes de fomento a la investigación', 'Enriquecer la producción científica en la FCJ mediante el aprendizaje de buenas prácticas en otras universidades e instituciones', 'Oficios, cartas de aprobación', 'Docentes y alumnos', '2016-01-18', '2016-03-31'),
(187, 91, 'Realizar intercambios de experiencias para aplicar  buenas prácticas en procesos de certificación y acreditación  carreras logradas en la participación de redes internas y externas', '1.2.1', 'Los coordinadores de las comisiones de trabajo tienen conciencia de la  necesidad de articular esfuerzos para el cumplimiento de  los referentes mínimos de todos los factores para efectos de acreditación', 'Es necesario unificar criterios para el abordaje del desarrollo curricular en la aplicación del Modelo Educativo de la UNAH, sus enfoques y ejes integradores y funciones ( VUS, investigación y docencia)', 'Informes de resultados de los intercambios realizados', 'Estudiantes y docent', '2016-01-18', '2016-03-31'),
(188, 92, 'Identificar redes internacionales de apoyo a la investigación y plasmar en cuadro resumen', '2.15.1', 'Se cuenta con el apoyo de las autoridades de la UNAH para la firma de convenios y existen redes de fomento a la investigación', 'Enriquecer la producción científica en la FCJ mediante el aprendizaje de buenas prácticas en otras universidades e instituciones', 'Cuadro resumen', 'Docentes y alumnos', '2016-01-18', '2016-03-31'),
(189, 92, 'Establecer contacto con las redes para la integración realizando visitas programadas', '2.15.2', 'Se cuenta con el apoyo de las autoridades de la UNAH para la firma de convenios y existen redes de fomento a la investigación', 'Enriquecer la producción científica en la FCJ mediante el aprendizaje de buenas prácticas en otras universidades e instituciones', 'Informes trimestrales, convenios, cartas de intenciones', 'Docentes y alumnos', '2016-01-18', '2016-03-31'),
(190, 93, 'Desarrollar las investigaciones de acuerdo a las líneas definidas en las materias del conocimiento relacionadas a cada unidad académica', '6.4.1', 'Contar con docentes investigadores en la Facultad de Ciencias Jurídicas y se cuenta con fondos para la ejecución de las actividades', 'La Facultad de Ciencias Jurídicas debe producir y aportar a la sociedad hondureña el conocimiento jurídico que demanda', 'Listado de proyectos registrados en la DICU, Informes de investigaciones', 'Comunidad educativa(', '2016-01-18', '2016-03-31'),
(191, 93, 'Sostener reuniones de seguimiento y control de avances de las investigaciones en cada unidad académica', '6.4.2', 'Contar con docentes investigadores en la Facultad de Ciencias Jurídicas y se cuenta con fondos para la ejecución de las actividades', 'La Facultad de Ciencias Jurídicas debe producir y aportar a la sociedad hondureña el conocimiento jurídico que demanda', 'Listado de proyectos registrados en la DICU, Informes de investigaciones', 'Comunidad educativa(', '2016-01-18', '2016-03-31'),
(192, 91, 'Planificar, ejecutar y evaluar  acciones  consensuadas de  investigación, elaboración de documentos, planes, programas e instrumentos, en grupos de red  para el logro de referentes mínimos compartidos o bajo  la responsabilidad de dos o más comisiones y unidades académicas con propósitos de acreditación.   tomando en cuenta la participación  de las  siguientes unidades:  unidad de plan de mejora y autoevaluación de Vicerrectoría Académica; Unidad de Desarrollo Curricular, Coordinación de carrera, Jefaturas de departamentos de la Facultad de Ciencias Jurídicas , y demás unidades que correspondan.', '1.2.2', 'Los coordinadores de las comisiones de trabajo tienen conciencia de la  necesidad de articular esfuerzos para el cumplimiento de  los referentes mínimos de todos los factores para efectos de acreditación', 'Es necesario unificar criterios para el abordaje del desarrollo curricular en la aplicación del Modelo Educativo de la UNAH, sus enfoques y ejes integradores y funciones ( VUS, investigación y docencia)', 'Ayudas memoria de reuniones, documentos  aprobado', 'Estudiantes y docent', '2016-01-18', '2016-03-31'),
(193, 94, 'Identificar los proyectos de investigación que cumplen los requerimientos para publicación', '6.5.1', 'Se cuentan con proyectos de investigación que cumplen con los requerimientos de calidad necesarios para la publicación', 'La Facultad de Ciencias Jurídicas debe producir y publicar para conocimiento de la sociedad hondureña el conocimiento jurídico que demanda', 'Revistas, medios virtuales', 'Comunidad educativa(', '2016-01-18', '2016-03-31'),
(194, 94, 'Publicar los resultados de las investigaciones desarrolladas por las unidades académicas haciendo uso de las nueva tecnologías y revistas identificadas', '6.5.2', 'Se cuentan con proyectos de investigación que cumplen con los requerimientos de calidad necesarios para la publicación', 'La Facultad de Ciencias Jurídicas debe producir y publicar para conocimiento de la sociedad hondureña el conocimiento jurídico que demanda', 'Revistas, medios virtuales', 'Comunidad educativa(', '2016-01-18', '2016-03-31'),
(195, 95, 'Identificar los mejores proyectos de tesis desarrollados por los maestrandos en cada una de las carreras de posgrados de la Facultad de Ciencias Jurídicas para coordinar la publicación con el IIJ', '10.4.1', 'Se cuenta con la coordinación entre el IIJ y las Carreras de posgrados así como la aprobación de la DICYP', 'Integrar los posgrados y el IIJ con el propósito de  producir y publicar para conocimiento de la sociedad hondureña el conocimiento jurídico que demanda', 'Documentos de tesis en proceso de revisión en conjunto con el IIJ, informes de avances, publicaciones', 'Sociedad hondureña', '2016-01-18', '2016-03-31'),
(196, 96, 'Planificar las actividades estratégicas y operativas de la Facultad  de Ciencias Jurídicas : Departamentos, Carreras de grado y  postgrado, Instituto de Investigación y Consultorio Jurídico, a través de un taller', '13.2.1', 'Presupuesto económico y  compromiso de la unidades académicas para la construcción del plan operativo anual.', 'cumplimiento de políticas y efectividad en los resultados de gestión de las unidades de la facultad .', 'POA', 'Facultad de Ciencias', '2016-01-18', '2016-03-31'),
(197, 97, 'Monitoreo y seguimiento de actividades.', '13.3.1', 'Presupuesto económico y  compromiso de la unidades académicas para la construcción del plan operativo anual.', 'Desempeño y resultados obtenidos', 'Informe y actividades realizadas', 'Facultad de Ciencias', '2016-01-18', '2016-03-31'),
(198, 97, 'Recolectar/documentar evidencias de actividades realizadas y no realizadas', '13.3.2', 'Presupuesto económico y  compromiso de la unidades académicas para la construcción del plan operativo anual.', 'Desempeño y resultados obtenidos', 'Informe y actividades realizadas', 'Facultad de Ciencias', '2016-01-18', '2016-03-31'),
(199, 97, 'Elaborar informe de resultados  trimestral.', '13.3.3', 'Presupuesto económico y  compromiso de la unidades académicas para la construcción del plan operativo anual.', 'Desempeño y resultados obtenidos', 'Informe y actividades realizadas', 'Facultad de Ciencias', '2016-01-18', '2016-03-31'),
(200, 97, 'Realizar reuniones de coordinación, monitoreo y control con la Carrera de Derecho en UNAH VS', '13.3.4', 'Presupuesto económico y  compromiso de la unidades académicas para la construcción del plan operativo anual.', 'Desempeño y resultados obtenidos', 'Informe y actividades realizadas', 'Facultad de Ciencias', '2016-01-18', '2016-03-31'),
(201, 91, 'Iniciar y desarrollar procesos de validación de los avances en la ejecución del plan de mejora de las carreras de la Facultad de Ciencias Jurídicas con agencias de acreditación nacionales e internacionales  determinadas como la UNAH como el SHACES y agencias de acreditación de  CSUCA', '1.2.3', 'Se han identificado los temas afines para la discusión y el tratamiento de redes para el abordaje del desarrollo curricular en las carreras de la FCJ', 'Es necesario unificar criterios para el abordaje del desarrollo curricular en la aplicación del Modelo Educativo de la UNAH, sus enfoques y ejes integradores y funciones ( VUS, investigación y docencia)', 'Informes de reuniones de integración ejecutadas', 'Estudiantes y docent', '2016-01-18', '2016-03-31'),
(202, 98, 'Desarrollar un documento base en coordinación con la VRI para identificar los procesos de participación en redes académicas e investigativas de interés para la integración por parte de la Facultad de Ciencias Jurídicas', '14.5.1', 'Se cuenta con el apoyo de VRI y se cuenta con productividad investigativa y académica interna', 'Proyectar la Facultad de Ciencias Jurídicas a una posición de liderazgo en la Educación Superior a nivel internacional', 'Documento desarrollado, informes de participación', 'Docentes y estudiant', '2016-01-18', '2016-03-31'),
(203, 98, 'Integrar las unidades académicas a las redes de investigación y docencia identificadas', '14.5.2', 'Se cuenta con el apoyo de VRI y se cuenta con productividad investigativa y académica interna', 'Proyectar la Facultad de Ciencias Jurídicas a una posición de liderazgo en la Educación Superior a nivel internacional', 'Documento desarrollado, informes de participación', 'Docentes y estudiant', '2016-01-18', '2016-03-31'),
(204, 98, 'Desarrollar actividades de socialización de productos y experiencias obtenidas en las redes de investigación y docencia', '14.5.3', 'Se cuenta con el apoyo de VRI y se cuenta con productividad investigativa y académica interna', 'Proyectar la Facultad de Ciencias Jurídicas a una posición de liderazgo en la Educación Superior a nivel internacional', 'Documento desarrollado, informes de participación', 'Docentes y estudiant', '2016-01-18', '2016-03-31'),
(206, 100, 'Elaborar un informe de los grupos etarios atendidos en los diferentes proyectos de VUS desarrollados en las Carreras de la Facultad de Ciencias Jurídicas', '3.1.3', 'Se cuenta con el proyecto aprobado por parte de las autoridades de la FCJ y los recursos necesarios para su ejecución', 'Cumplir con una función básica y aportar a la solución de problemas nacionales', 'Reportes de grupos etarios atendidos', 'Sociedad hondureña', '2016-01-18', '2016-03-31'),
(207, 101, 'Elaborar un boletín que presente los logros en proyectos de Vinculación Universidad Sociedad desarrollados por las carreras y unidades de la Facultad de Ciencias Jurídicas', '3.6.2', 'Se cuenta con el perfil de proyecto aprobado por Decanatura y los recursos necesario', 'Dar a conocer los resultados y sistematizar las mejores experiencias de los proyectos de VUS de la Facultad de Ciencias Jurídicas', 'Boletín impreso', 'Comunidad universita', '2016-01-18', '2016-03-31'),
(208, 102, 'Identificar organizaciones de cooperación con las que el departamento puede establecer convenios para el desarrollo de proyectos', '3.7.1', 'Se cuenta  con la aprobación del proyecto por parte de las autoridades de la FCJ y con el apoyo de las instituciones ', 'Para el fortalecimiento de la VUS en la Facultad es fundamental el establecimiento de relaciones de cooperación con instituciones externas', 'Alianzas Establecidas (Convenios, Carta de Intenciones, Memorándum de entendimiento) ', 'Sociedad hondureña, ', '2016-01-18', '2016-03-31'),
(209, 102, 'Desarrollo de convenios con las organizaciones  identificadas para el desarrollo de forma conjunta de proyectos de VUS', '3.7.2', 'Se cuenta  con la aprobación del proyecto por parte de las autoridades de la FCJ y con el apoyo de las instituciones ', 'Para el fortalecimiento de la VUS en la Facultad es fundamental el establecimiento de relaciones de cooperación con instituciones externas', 'Alianzas Establecidas (Convenios, Carta de Intenciones, Memorándum de entendimiento) ', 'Sociedad hondureña, ', '2016-01-18', '2016-03-31');
INSERT INTO `actividades` (`id_actividad`, `id_indicador`, `descripcion`, `correlativo`, `supuesto`, `justificacion`, `medio_verificacion`, `poblacion_objetivo`, `fecha_inicio`, `fecha_fin`) VALUES
(210, 103, 'Participar en jornadas de intercambio de experiencias y presentación de resultados de proyectos de vinculación ', '3.8.1', 'Se cuentan con proyectos desarrollados en VUS y los jornadas para la presentación de resultados', 'Divulgar los resultados de proyectos exitosos en VUS e intercambio de buenas experiencias', 'Informes de encuentros realizados, fotografías, listados.', 'Sociedad hondureña', '2016-01-18', '2016-03-31'),
(211, 104, 'Desarrollar una jornada de capacitación en el desarrollo y gestión de proyectos de vinculación universidad sociedad dirigido a los docentes de las carreras de la FCJ', '3.9.1', 'Se cuenta con el apoyo de expertos en el tema', 'Fortalecer el desarrollo y gestión de proyectos de Vinculación Universidad  sociedad a través de la capacitación', 'Informes de jornadas de capacitación realizados, fotografías, listados.', 'Docentes y alumnos', '2016-01-18', '2016-03-31'),
(212, 105, 'Ejecutar el Plan Anual de Compras de la Facultad de Ciencias Jurídicas que contemplan las necesidades de recurso tecnológico en apoyo a la gestión académica y la docencia', '11.1.1', 'Se cuenta con los fondos de fuentes propios y de cooperación) y la aprobación de las máximas autoridades', 'Dotar de los recursos necesarios a las diferentes unidades académicas y de apoyo para brindar un servicio de calidad, eficiente y oportuno', 'Documento de Plan de Dotación, Aprobaciones por parte de Rectoría, números de inventario', 'Colaboradores docent', '2016-01-18', '2016-03-31'),
(213, 106, 'Gestionar la aprobación de fondos para ejecutar la remodelación de oficinas del Decanato de la Facultad de Ciencias Jurídicas', '11.2.1', 'Se cuenta con la aprobación de fondos necesarios y aprobación de autoridades del proyecto', 'Tener los espacios físicos dignos y adecuados para la gestión de las autoridades y colaboradores de la Facultad de Ciencias Jurídicas y ofrecer un mejor servicio a docentes y alumnos', 'Proyecto aprobado, fondos disponibles, informes de avances, fotografías', 'Colaboradores docent', '2016-01-18', '2016-03-31'),
(214, 106, 'De acuerdo a resultados de gestión de fondos ejecutar con apoyo de SEAPI las obras de remodelación del Decanato ', '11.2.2', 'Se cuenta con la aprobación de fondos necesarios y aprobación de autoridades del proyecto', 'Tener los espacios físicos dignos y adecuados para la gestión de las autoridades y colaboradores de la Facultad de Ciencias Jurídicas y ofrecer un mejor servicio a docentes y alumnos', 'Proyecto aprobado, fondos disponibles, informes de avances, fotografías', 'Colaboradores docent', '2016-01-18', '2016-03-31'),
(215, 106, 'Desarrollar la propuesta para el acondicionamiento de un auditorio en el edificio A2', '11.2.3', 'Se cuenta con la aprobación de fondos necesarios y aprobación de autoridades del proyecto', 'Contar con  espacio acondicionado para el desarrollo de actividades académicas en la Facultad Ciencias Jurídicas', 'Proyecto aprobado, fondos disponibles, informes de avances, fotografías', 'Docentes, alumnos', '2016-01-18', '2016-03-31'),
(216, 106, 'Realizar las gestiones de fondos para el desarrollo del proyecto de auditorio', '11.2.4', 'Se cuenta con la aprobación de fondos necesarios y aprobación de autoridades del proyecto.', 'Contar con  espacio acondicionado para el desarrollo de actividades académicas en la Facultad Ciencias Jurídicas.', 'Proyecto aprobado, fondos disponibles, informes de avances, fotografías', 'Docentes, alumnos', '2016-01-18', '2016-03-31'),
(217, 107, 'Desarrollar un mapeo de agencias y organismos de cooperación cuyas líneas de apoyo contemplen el desarrollo de infraestructura y plataforma tecnológica', '11.4.1', 'Se cuenta con el apoyo de las máximas autoridades para la firma de convenios, proyectos que presentar a la cooperación y un grupo gestor comprometido', 'Fortalecer el presupuesto de la Facultad para tener la viabilidad de realizar diferentes proyectos en la Facultad que den soporte a las funciones sustantivas y cumplimiento de objetivos', 'Convenios e intención de convenios firmados, proyectos aprobados', 'Docentes, alumnos', '2016-01-18', '2016-03-31'),
(218, 107, 'Presentar proyectos y solicitudes a cooperantes identificados', '11.4.2', 'Se cuenta con el apoyo de las máximas autoridades para la firma de convenios, proyectos que presentar a la cooperación y un grupo gestor comprometido', 'Fortalecer el presupuesto de la Facultad para tener la viabilidad de realizar diferentes proyectos en la Facultad que den soporte a las funciones sustantivas y cumplimiento de objetivos', 'Convenios e intención de convenios firmados, proyectos aprobados', 'Docentes, alumnos', '2016-01-18', '2016-03-31'),
(219, 107, 'Gestionar ante las unidades internas los convenios de cooperación', '11.4.3', 'Se cuenta con el apoyo de las máximas autoridades para la firma de convenios, proyectos que presentar a la cooperación y un grupo gestor comprometido', 'Fortalecer el presupuesto de la Facultad para tener la viabilidad de realizar diferentes proyectos en la Facultad que den soporte a las funciones sustantivas y cumplimiento de objetivos', 'Convenios e intención de convenios firmados, proyectos aprobados', 'Docentes, alumnos', '2016-01-18', '2016-03-31'),
(220, 0, 'Elaborar una programación o plan para dotar a los departamentos y carreras de las necesidades identificadas de equipo didáctico', '11.5.1', 'Se cuenta con los fondos de fuentes propios y de cooperación) ', 'Apoyar las actividades académicas y de docencia con los recursos necesarios para brindar educación de calidad ', 'Listado de necesidades, fuentes de presupuesto identificado, aprobaciones', 'Docentes, alumnos', '2016-01-18', '2016-03-31'),
(221, 108, 'Elaborar una programación o plan para dotar a los departamentos y carreras de las necesidades identificadas de equipo didáctico', '11.5.1', 'Se cuenta con los fondos de fuentes propios y de cooperación) ', 'Apoyar las actividades académicas y de docencia con los recursos necesarios para brindar educación de calidad ', 'Listado de necesidades, fuentes de presupuesto identificado, aprobaciones', 'Docentes, alumnos', '2016-01-18', '2016-03-31'),
(222, 108, 'Ejecutar la programación para  la  adquisición de equipo y necesidades de material didáctico', '11.5.2', 'Se cuenta con los fondos de fuentes propios y de cooperación) ', 'Apoyar las actividades académicas y de docencia con los recursos necesarios para brindar educación de calidad ', 'Listado de necesidades, fuentes de presupuesto identificado, aprobaciones', 'Docentes, alumnos', '2016-01-18', '2016-03-31'),
(223, 109, 'Desarrollar informes trimestrales de ejecución presupuestaria y su alineación al POA 2016', '11.6.1', 'Ejecución pertinente de acuerdo a necesidades reales', 'Logro de los objetivos planteados para el año y cumplimiento de la asignación de recursos ', 'Informes trimestrales', 'Docentes, alumnos', '2016-01-18', '2016-01-31'),
(224, 110, 'Definir el proceso de contratación o reclutamiento del personal a cargo de las asignaturas o espacios de aprendizaje ofertadas bajo la bimodalidad', '1.8.1', 'Se cuenta con la aprobación de las autoridades y los recursos económicos necesarios para su contratación', 'Para el logro y éxito del proyecto de bimodalidad y generar acceso a los sectores que lo demanden se necesita contar con el recurso humano suficiente y apropiado ', 'Proceso definido y aprobado', 'Estudiantes', '2016-01-18', '2016-03-31'),
(225, 110, 'Contratar o nombrar a los docentes que facilitaran las asignaturas o espacios de aprendizaje de la Carrera de Derecho para su desempeño en los plazos definidos', '1.8.2', 'Establecidas la necesidad de contratación, se cuenta con aspirantes calificados y recursos financieros para su aprobación', 'Para el logro y éxito del proyecto de bimodalidad y generar acceso a los sectores que lo demanden se necesita contar con el recurso humano suficiente y apropiado ', 'Contratos, informes de proceso de selección', 'Estudiantes', '2016-01-18', '2016-03-31'),
(226, 111, 'Elaborar  la propuesta y ejecutar el Diplomado en Derechos y Estudios Electorales en asocio con la Fundación Konrad Adenauer y TSE', '3.4.2', 'Se cuenta con la aprobación de las unidades y autoridades correspondientes y alianzas estratégicas para su desarrollo', 'Es necesario promover y fortalecer la formación en el tema de derechos y estudios electorales en la sociedad hondureña y sus instituciones', 'Propuesta de diplomado aprobado, listas de participación, diplomas', 'Propuesta de diploma', '2016-01-18', '2016-03-31'),
(227, 112, 'Desarrollar conferencias enfocadas a desarrollar  una cultura de ética y de derechos  humanos ', '4.6.1', 'Se cuenta con expertos  en ética profesional y derechos humanos disponibles ', 'Desarrollo de los ejes de ética y derechos humanos como política de la UNAH.', 'Certificados que acredite la participación, listas de asistencia, fotografías', 'Docentes y estudiant', '2016-01-18', '2016-03-31'),
(228, 113, 'Definir los procedimientos y mecanismos para la selección de graduados para integrar a la plaza docente de la Facultad de Ciencias Jurídicas, basado en las competencias necesarias para el puesto', '5.9.1', 'Se cuentan con plazas docentes para su integración y con egresados con las competencias necesarias', 'Integrar los egresados de excelencia académica y de mayores competencias al Plan de Relevo docente', 'Documentos de procedimientos definidos', 'Estudiantes egresado', '2016-01-18', '2016-03-31'),
(229, 114, 'Identificar y establecer los contactos pertinentes: internos y externos a la UNAH para la negociación de convenios y participación', '6.2.1', 'Se cuenta con el apoyo de las máximas autoridades de la UNAH para la suscripción de convenio', 'Contribuir a la solución de los problemas nacionales mediante la generación de conocimiento científico en el marco de la internacionalización de la carrera', 'Convenios firmados, Informes', 'Docentes, alumnos, s', '2016-01-18', '2016-03-31'),
(230, 114, 'Gestionar ante los unidades correspondientes de la UNAH la firma de convenios', '6.2.2', 'Se cuenta con el apoyo de las máximas autoridades de la UNAH para la suscripción de convenio', 'Contribuir a la solución de los problemas nacionales mediante la generación de conocimiento científico en el marco de la internacionalización de la carrera', 'Convenios firmados, Informes', 'Docentes, alumnos, s', '2016-01-18', '2016-03-31'),
(231, 115, 'Desarrollar el el Ciclo de Cine III Valores Democráticos en el marco de la semana del estudiante en al menos 5 sedes: CU, UNAH VS,La Ceiba, Comayagua y Choluteca en asocio con la Fundación Konrad Adenauer ', '7.3.2', 'Se cuenta con el apoyo de los centros regionales y aprobación del proyecto por las unidades competentes', 'Contribuir a la educación con énfasis en la construcción de ciudadanía en la comunidad universitaria de la UNAH a través de la educación en valores democráticos ', 'Listas de participación, fotografías, etc.', 'Alumnos y docentes', '2016-01-18', '2016-03-31'),
(232, 115, 'Ciclo de conferencias en temas de materia electoral , constitucional y derechos humanos en asocio con la Fundación Konrad Adenauer , a desarrollar en 3 centros universitarios: UNAH VS (2), CU(1) y CURLA (2) ', '7.3.3', 'Se cuenta con el apoyo de los centros regionales y aprobación del proyecto por las unidades competentes', 'Contribuir a la educación con énfasis en la construcción de ciudadanía en la comunidad universitaria de la UNAH a través de la educación en valores democráticos, derechos humanos y temas constitucionales', 'Proyectos aprobados, listas de participación, fotografías', 'Alumnos y docentes', '2016-01-18', '2016-03-31'),
(233, 116, 'Elaborar un plan de implementación de los diferentes módulos desarrollados en el Sistema de Apoyo a la Gestión Académica y Administrativa de la FCJ ( SAGAA/FCJ)', '11.7.1', 'Se cuenta con personal calificado para el desarrollo de los sistemas, aprobación de las unidades correspondientes y el equipo necesario', 'Eficientar los  procesos internos de la Facultad de Ciencias Jurídicas enfocados en la transparencia y rendición de cuentas', 'Informes de resultados, Plataformas desarrolladas y en funcionamiento', 'Docentes, alumnos', '2016-01-18', '2016-03-31'),
(234, 116, 'Ejecución del Plan de Implementación del SAGAA/FCJ', '11.7.2', 'Se cuenta con personal calificado para el desarrollo de los sistemas, aprobación de las unidades correspondientes y el equipo necesario', 'Eficientar los  procesos internos de la Facultad de Ciencias Jurídicas enfocados en la transparencia y rendición de cuentas', 'Informes de resultados, Plataformas desarrolladas y en funcionamiento', 'Docentes, alumnos', '2016-01-18', '2016-03-31'),
(235, 116, 'Gestionar ante la DEGT la integración del SAGAA/FCJ a los servidores y plataforma institucional', '11.7.3', 'Se cuenta con personal calificado para el desarrollo de los sistemas, aprobación de las unidades correspondientes y el equipo necesario', 'Eficientar los  procesos internos de la Facultad de Ciencias Jurídicas enfocados en la transparencia y rendición de cuentas', 'Informes de resultados, Plataformas desarrolladas y en funcionamiento', 'Docentes, alumnos', '2016-01-18', '2016-03-31'),
(236, 117, 'Dar seguimiento a las reuniones realizadas por la Junta Directiva de la FCJ', '13.1.1', 'Las asociaciones estudiantiles y  claustros docentes están debidamente constituidos', 'Cumplir con los requerimientos que establece el Reglamento de Juntas Directivas, Facultades y Centros Regionales', 'Informes de reuniones, Informes de monitoree y control', 'Facultad de Ciencias', '2016-01-18', '2016-03-31'),
(237, 118, 'Planificar las actividades estratégicas y operativas de la Facultad  de Ciencias Jurídicas : Departamentos, Carreras de grado y  postgrado, Instituto de Investigación y Consultorio Jurídico, a través de un taller', '13.2.1', 'Presupuesto económico y  compromiso de la unidades académicas para la construcción del plan operativo anual.', 'cumplimiento de políticas y efectividad en los resultados de gestión de las unidades de la facultad .', 'POA', 'Facultad de Ciencias', '2016-01-18', '2016-03-31'),
(238, 119, 'Monitoreo y seguimiento de actividades.', '13.3.1', 'Presupuesto económico y  compromiso de la unidades académicas para la construcción del plan operativo anual.', 'Desempeño y resultados obtenidos', 'Informe y actividades realizadas', 'Facultad de Ciencias', '2016-01-18', '2016-03-31'),
(239, 119, 'Recolectar/documentar evidencias de actividades realizadas y no realizadas', '13.3.2', 'Presupuesto económico y  compromiso de la unidades académicas para la construcción del plan operativo anual.', 'Desempeño y resultados obtenidos', 'Informe y actividades realizadas', 'Facultad de Ciencias', '2016-01-18', '2016-03-31'),
(240, 119, 'Elaborar informe de resultados  trimestral.', '13.3.3', 'Presupuesto económico y  compromiso de la unidades académicas para la construcción del plan operativo anual.', 'Desempeño y resultados obtenidos', 'Informe y actividades realizadas', 'Facultad de Ciencias', '2016-01-18', '2016-03-31'),
(241, 120, 'Aplicar encuestas u otras herramientas para medir el clima organizacional  en coordinación con la SEDI', '13.7.1', 'Se cuenta con el apoyo de las autoridades de la Facultad ', 'Mejorar el clima organizacional en la facultad para un mejor desempeño', 'Estrategias definidas, indicadores', 'Facultad de Ciencias', '2016-01-18', '2016-03-31'),
(242, 120, 'Definir las estrategias para el fortalecimiento del clima organizacional ', '13.7.2', 'Se cuenta con el apoyo de las autoridades de la Facultad ', 'Mejorar el clima organizacional en la facultad para un mejor desempeño', 'Estrategias definidas, indicadores', 'Facultad de Ciencias', '2016-01-18', '2016-03-31'),
(243, 121, 'Medir el avance en la mejora de los indicadores e índices mínimos en la aplicación del Plan de Mejoras', 'El Plan de', 'Mejora de índices para el logro de la acreditación', 'nformes trimestrales de índices e indicadores del Plan de Mejoras', 'Facultad de Ciencias Jurídicas', 'Asistente Técnico de', '2016-01-18', '2016-03-31'),
(244, 122, 'Participación en la competencia Internacional de Juicios Simulados en Derechos Humanos en American University Washington D.C. USA. (MOOTCOURTS)                              ', '14.3.2', 'Se cuenta con la aprobación de las autoridades universitarias y los recursos necesarios para su ejecución', 'mplementación de una política Universitaria de protección y divulgación de los derechos humanos.', 'Diploma de participación, programa desarrollado, informes de resultados', 'Docentes y estudiant', '2016-01-18', '2016-03-31'),
(245, 122, 'Participar en la competencia Regional de Juicios simulados sobre derechos humanos ', '14.3.3', 'Se cuenta con la aprobación de las autoridades universitarias y los recursos necesarios para su ejecución', 'Implementación de una política Universitaria de protección y divulgación de los derechos humanos.', 'Diploma de participación, programa desarrollado, informes de resultados', 'Docentes y estudiant', '2016-01-18', '2016-03-31'),
(246, 122, 'Desarrollar un Encuentro Académico en tema de Derechos Humanos con alumnos y docentes de universidades de la región centroamericana en asocio con la Fundación Konrad Adenauer', '14.3.6', 'Se cuenta con la aprobación de las autoridades universitarias y los recursos necesarios para su ejecución', 'Promover el estudio y la promoción de los Derechos Humanos generando propuestas de solución', 'Diploma de participación, programa desarrollado, informes de resultados', 'Docentes y estudiant', '2016-01-18', '2016-03-31'),
(247, 123, 'Elaborar un boletín y sesiones informativas sobre los programas de movilidad para personal administrativo por medio de  becas, intercambios, pasantías   con los que cuenta la UNAH en coordinación con la VRI', '14.4.1', 'Se cuentan con el apoyo de las autoridades y unidades, equipos comprometidos y los fondos necesarios para la participación', 'Fortalecer la gestión administrativa mediante la preparación de sus colaboradores a través de experiencias de intercambios y pasantías', 'Diploma de participación, programa desarrollado, informes de resultados', 'Colaboradores Admini', '2016-01-18', '2016-03-31'),
(248, 124, 'Seguimiento a reuniones mensuales de la Junta Directiva de la Facultad de Ciencias Jurídicas', '15.1.1', 'Las asociaciones estudiantiles y  claustros docentes están debidamente constituidos', 'Cumplir con los requerimientos que establece el Reglamento de Juntas Directivas, Facultades y Centros Regionales', 'Informes de reuniones, Informes de monitoree y control', 'Docentes y alumnos', '2016-01-18', '2016-03-31'),
(249, 125, 'Desarrollar la convocatoria para la delegación de los representantes docentes y estudiantiles a integrar el Comité Técnico de la Carrera y desarrollar la sesión de conformación del Comité Técnico', '15.2.1', 'Se cuenta con los delegados para la conformación del Comité Técnico', 'Cumplir con los requerimientos que establece el Reglamento de Juntas Directivas, Facultades y Centros Regionales', 'Ayudas memorias, bitácoras de reuniones realizadas', 'Docentes y alumnos', '2016-01-18', '2016-03-31'),
(250, 126, 'Definir los instrumentos de evaluación del cumplimiento y desempeño del personal docente y administrativo de acuerdo a la normativa universitaria', '15.5.1', 'Apoyo de las autoridades de la Facultad', 'Asegurar el cumplimiento  de la normativa universitaria', 'Evidencia del Cumplimiento de funciones académicas y administrativas de acuerdo a la normativa universitaria, por medio de informes y supervisiones\n', 'Facultad de Ciencias', '2016-01-18', '2016-03-31'),
(251, 126, 'Aplicación de los instrumentos de evaluación del cumplimiento y desempeño del personal docente y administrativo de acuerdo a la normativa universitaria', '15.5.2', 'Apoyo de las autoridades de la Facultad ', 'Asegurar el cumplimiento  de la normativa universitaria', 'Evidencia del Cumplimiento de funciones académicas y administrativas de acuerdo a la normativa universitaria, por medio de informes y supervisiones', 'Facultad de Ciencias', '2016-01-18', '2016-03-31'),
(252, 127, 'Desarrollar los encuentros entre las autoridades y la comunidad estudiantil', '15.6.1', 'Estudiantes y autoridades dispuestos para el desarrollo de los encuentros', 'Contribuir a la consolidación del ordenamiento jurídico de la UNAH', 'Encuentros realizados, listas de asistencia\n', 'Alumnos y docentes', '2016-01-18', '2016-03-31'),
(253, 128, 'Desarrollar los encuentros entre las autoridades y la comunidad docente', '15.7.1', 'Estudiantes y autoridades dispuestos para el desarrollo de los encuentros', 'Contribuir a la consolidación del ordenamiento jurídico de la UNAH', 'Encuentros realizados, listas de asistencia\n', 'Alumnos y docentes', '2016-01-18', '2016-03-31'),
(254, 129, 'Conformar comisiones para dictaminar y elaborar propuestas de actualización y reforma de la normativa del nivel', '15.8.1', 'Agilidad en los procesos y docentes comprometidos en la integración de comisiones', 'Contribuir a la consolidación del ordenamiento jurídico de la UNAH', 'Dictamen realizados, Informes de propuestas de actualización y reforma de la normativa del nivel', 'Facultad de Ciencias', '2016-01-18', '2016-03-31'),
(255, 129, ' Presentar los dictámenes de la normativa ', '15.8.2', 'Agilidad en los procesos y docentes comprometidos en la integración de comisiones', 'Contribuir a la consolidación del ordenamiento jurídico de la UNAH', 'Dictamen realizados, Informes de propuestas de actualización y reforma de la normativa del nivel', 'Facultad de Ciencias', '2016-01-18', '2016-03-31'),
(256, 130, 'Elaboración y presentación para aprobación de las propuestas de actualización y reforma de la normativa', '15.9.1', 'Agilidad en los procesos y docentes comprometidos en la integración de comisiones', 'Contribuir a la consolidación del ordenamiento jurídico de la UNAH', 'Actas de apropiación de acuerdos', 'Facultad de Ciencias', '2016-01-18', '2016-03-31'),
(257, 130, 'Socialización de los acuerdos, dictámenes y normativa aprobado', '15.9.2', 'Agilidad en los procesos y docentes comprometidos en la integración de comisiones', 'Contribuir a la consolidación del ordenamiento jurídico de la UNAH', 'Actas de apropiación de acuerdos', 'Facultad de Ciencias', '2016-01-18', '2016-03-31'),
(258, 131, 'Conformar la red centroamericana de decanos de las escuelas de derecho de las universidades de la región ', '15.10.1', 'Autoridades de otras facultades y carreras dispuesta a conformar las redes y se cuenta con los fondos necesarios', 'Promover la calidad educativa y el liderazgo de la Facultad de Ciencias Jurídicas de la UNAH en la educación superior del país', 'Informes de resultados', 'Comunidad Universita', '2016-01-18', '2016-03-31'),
(260, 133, 'actividad febrero', 'correlativo', 'supuesto febrero', 'justificacion febrero', 'medio febrero', 'febrero todos', '2016-02-11', '2016-03-24');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actividades_terminadas`
--

DROP TABLE IF EXISTS `actividades_terminadas`;
CREATE TABLE IF NOT EXISTS `actividades_terminadas` (
  `id_Actividades_Terminadas` int(11) NOT NULL auto_increment,
  `id_Actividad` int(11) NOT NULL,
  `No_Empleado` varchar(20) NOT NULL,
  `fecha` date NOT NULL,
  `estado` varchar(15) NOT NULL,
  `observaciones` text,
  PRIMARY KEY  (`id_Actividades_Terminadas`),
  KEY `id_Actividad` (`id_Actividad`),
  KEY `No_Empleado` (`No_Empleado`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Volcar la base de datos para la tabla `actividades_terminadas`
--

INSERT INTO `actividades_terminadas` (`id_Actividades_Terminadas`, `id_Actividad`, `No_Empleado`, `fecha`, `estado`, `observaciones`) VALUES
(1, 1, 'waltermelendez', '2015-11-18', 'REALIZADA', 'kjbfdjfoaohif');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alerta`
--

DROP TABLE IF EXISTS `alerta`;
CREATE TABLE IF NOT EXISTS `alerta` (
  `Id_Alerta` int(11) NOT NULL auto_increment,
  `NroFolioGenera` varchar(25) NOT NULL,
  `FechaCreacion` datetime NOT NULL,
  `Atendido` tinyint(1) NOT NULL,
  PRIMARY KEY  (`Id_Alerta`),
  KEY `fk_alerta_folios_idx` (`NroFolioGenera`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Volcar la base de datos para la tabla `alerta`
--


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `area`
--

DROP TABLE IF EXISTS `area`;
CREATE TABLE IF NOT EXISTS `area` (
  `id_Area` int(11) NOT NULL auto_increment,
  `nombre` text NOT NULL,
  `id_tipo_area` int(11) NOT NULL,
  `observacion` text NOT NULL,
  PRIMARY KEY  (`id_Area`),
  KEY `id_tipo_area` (`id_tipo_area`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=17 ;

--
-- Volcar la base de datos para la tabla `area`
--

INSERT INTO `area` (`id_Area`, `nombre`, `id_tipo_area`, `observacion`) VALUES
(1, 'DESARROLLO E INNOVACIÓN CURRICULAR', 0, ''),
(2, 'VINCULACIÓN UNIVERSIDAD SOCIEDAD', 0, ''),
(3, 'DOCENCIA Y PROFESORADO UNIVERSITARIO', 0, ''),
(4, 'INVESTIGACIÓN CIENTÍFICA ', 0, ''),
(5, 'ESTUDIANTES Y GRADUADOS', 0, ''),
(6, 'GESTIÓN DEL CONOCIMIENTO', 0, ''),
(7, 'LO ESENCIAL DE LA REFORMA UNIVERSITARIA', 0, ''),
(8, 'ASEGURAMIENTO DE LA CALIDAD Y MEJORAMIENTO AMBIENTAL', 0, ''),
(9, 'CULTURA DE INNOVACIÓN INSTITUCIONAL Y EDUCATIVA', 0, ''),
(10, 'POSTGRADOS', 0, ''),
(11, 'GESTIÓN ADMINISTRATIVA Y FINANCIERA EN APOYO AL DESARROLLO ACADÉMICO', 0, ''),
(12, 'GESTIÓN DEL TALENTO HUMANO ADMINISTRATIVO Y DOCENTE', 0, ''),
(13, 'GESTIÓN ACADÉMICA', 0, ''),
(14, 'INTERNACIONALIZACIÓN DE LA EDUCACIÓN SUPERIOR', 0, ''),
(15, 'GOBERNABILIDAD Y PROCESO DE GESTIÓN DESCENTRALIZADAS EN REDES', 0, ''),
(16, 'GESTIÓN DE TECNOLOGÍAS DE INFORMACIÓN Y COMUNICACIÓN (TIC)', 0, '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ca_acondicionamientos`
--

DROP TABLE IF EXISTS `ca_acondicionamientos`;
CREATE TABLE IF NOT EXISTS `ca_acondicionamientos` (
  `codigo` int(11) NOT NULL auto_increment,
  `nombre` varchar(50) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Volcar la base de datos para la tabla `ca_acondicionamientos`
--

INSERT INTO `ca_acondicionamientos` (`codigo`, `nombre`) VALUES
(1, 'Data show');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ca_areas`
--

DROP TABLE IF EXISTS `ca_areas`;
CREATE TABLE IF NOT EXISTS `ca_areas` (
  `codigo` int(11) NOT NULL auto_increment,
  `nombre` varchar(50) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Volcar la base de datos para la tabla `ca_areas`
--


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ca_aulas`
--

DROP TABLE IF EXISTS `ca_aulas`;
CREATE TABLE IF NOT EXISTS `ca_aulas` (
  `codigo` int(11) NOT NULL auto_increment,
  `cod_edificio` int(11) NOT NULL,
  `numero_aula` varchar(100) NOT NULL,
  PRIMARY KEY  (`codigo`),
  KEY `aulas_edificios_FK_idx` (`cod_edificio`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Volcar la base de datos para la tabla `ca_aulas`
--

INSERT INTO `ca_aulas` (`codigo`, `cod_edificio`, `numero_aula`) VALUES
(1, 1, '101'),
(2, 9, '201');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ca_aulas_instancias_acondicionamientos`
--

DROP TABLE IF EXISTS `ca_aulas_instancias_acondicionamientos`;
CREATE TABLE IF NOT EXISTS `ca_aulas_instancias_acondicionamientos` (
  `cod_aula` int(11) NOT NULL,
  `cod_instancia_acondicionamiento` int(11) NOT NULL,
  PRIMARY KEY  (`cod_aula`),
  KEY `a_i_a_instancias_acondicionamientos_FK_idx` (`cod_instancia_acondicionamiento`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcar la base de datos para la tabla `ca_aulas_instancias_acondicionamientos`
--


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ca_cargas_academicas`
--

DROP TABLE IF EXISTS `ca_cargas_academicas`;
CREATE TABLE IF NOT EXISTS `ca_cargas_academicas` (
  `codigo` int(11) NOT NULL auto_increment,
  `cod_periodo` int(11) default NULL,
  `no_empleado` varchar(20) default NULL,
  `dni_empleado` varchar(20) default NULL,
  `cod_estado` int(11) default NULL,
  `anio` year(4) NOT NULL,
  PRIMARY KEY  (`codigo`),
  KEY `cargas_academicas_periodos_FK_idx` (`cod_periodo`),
  KEY `cargas_academicas_empleados_FK_idx` (`no_empleado`,`dni_empleado`),
  KEY `cargas_academicas_estados_FK_idx` (`cod_estado`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Volcar la base de datos para la tabla `ca_cargas_academicas`
--


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ca_contratos`
--

DROP TABLE IF EXISTS `ca_contratos`;
CREATE TABLE IF NOT EXISTS `ca_contratos` (
  `codigo` int(11) NOT NULL auto_increment,
  `nombre` varchar(50) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Volcar la base de datos para la tabla `ca_contratos`
--


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ca_cursos`
--

DROP TABLE IF EXISTS `ca_cursos`;
CREATE TABLE IF NOT EXISTS `ca_cursos` (
  `codigo` int(11) NOT NULL auto_increment,
  `cupos` int(11) default NULL,
  `cod_carga` int(11) default NULL,
  `cod_seccion` int(11) default NULL,
  `cod_asignatura` int(11) default NULL,
  `cod_aula` int(11) default NULL,
  `no_empleado` varchar(20) default NULL,
  `dni_empleado` varchar(20) default NULL,
  PRIMARY KEY  (`codigo`),
  KEY `cursos_cargas_FK_idx` (`cod_carga`),
  KEY `cursos_secciones_FK_idx` (`cod_seccion`),
  KEY `cursos_asignaturas_FK_idx` (`cod_asignatura`),
  KEY `cursos_aulas_FK_idx` (`cod_aula`),
  KEY `cursos_empleados_FK_idx` (`no_empleado`,`dni_empleado`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Volcar la base de datos para la tabla `ca_cursos`
--


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ca_cursos_dias`
--

DROP TABLE IF EXISTS `ca_cursos_dias`;
CREATE TABLE IF NOT EXISTS `ca_cursos_dias` (
  `cod_curso` int(11) NOT NULL,
  `cod_dia` int(11) NOT NULL,
  PRIMARY KEY  (`cod_curso`,`cod_dia`),
  KEY `cursos_dias_dias_FK_idx` (`cod_dia`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcar la base de datos para la tabla `ca_cursos_dias`
--


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ca_dias`
--

DROP TABLE IF EXISTS `ca_dias`;
CREATE TABLE IF NOT EXISTS `ca_dias` (
  `codigo` int(11) NOT NULL auto_increment,
  `nombre` varchar(9) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Volcar la base de datos para la tabla `ca_dias`
--


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ca_empleados_contratos`
--

DROP TABLE IF EXISTS `ca_empleados_contratos`;
CREATE TABLE IF NOT EXISTS `ca_empleados_contratos` (
  `no_empleado` varchar(20) NOT NULL,
  `dni_empleado` varchar(20) NOT NULL,
  `cod_contrato` int(11) NOT NULL,
  PRIMARY KEY  (`no_empleado`,`dni_empleado`),
  KEY `e_c_contratos_FK_idx` (`cod_contrato`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcar la base de datos para la tabla `ca_empleados_contratos`
--


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ca_empleados_proyectos`
--

DROP TABLE IF EXISTS `ca_empleados_proyectos`;
CREATE TABLE IF NOT EXISTS `ca_empleados_proyectos` (
  `no_empleado` varchar(20) NOT NULL,
  `dni_empleado` varchar(20) NOT NULL,
  `cod_proyecto` int(11) NOT NULL,
  `cod_rol_proyecto` int(11) NOT NULL,
  PRIMARY KEY  (`no_empleado`,`dni_empleado`),
  KEY `d_e_p_proyectos_FK_idx` (`cod_proyecto`),
  KEY `d_e_p_roles_proyecto_FK_idx` (`cod_rol_proyecto`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcar la base de datos para la tabla `ca_empleados_proyectos`
--


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ca_estados_carga`
--

DROP TABLE IF EXISTS `ca_estados_carga`;
CREATE TABLE IF NOT EXISTS `ca_estados_carga` (
  `codigo` int(11) NOT NULL,
  `descripcion` varchar(50) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcar la base de datos para la tabla `ca_estados_carga`
--


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ca_facultades`
--

DROP TABLE IF EXISTS `ca_facultades`;
CREATE TABLE IF NOT EXISTS `ca_facultades` (
  `codigo` int(11) NOT NULL auto_increment,
  `nombre` varchar(50) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Volcar la base de datos para la tabla `ca_facultades`
--

INSERT INTO `ca_facultades` (`codigo`, `nombre`) VALUES
(2, 'Facultad de Ciencias Juridicas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ca_instancias_acondicionamientos`
--

DROP TABLE IF EXISTS `ca_instancias_acondicionamientos`;
CREATE TABLE IF NOT EXISTS `ca_instancias_acondicionamientos` (
  `codigo` int(11) NOT NULL auto_increment,
  `cod_acondicionamiento` int(11) default NULL,
  PRIMARY KEY  (`codigo`),
  KEY `instancias_acondicionamientos_acondicionamientos_FK_idx` (`cod_acondicionamiento`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Volcar la base de datos para la tabla `ca_instancias_acondicionamientos`
--


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ca_proyectos`
--

DROP TABLE IF EXISTS `ca_proyectos`;
CREATE TABLE IF NOT EXISTS `ca_proyectos` (
  `codigo` int(11) NOT NULL auto_increment,
  `nombre` varchar(50) default NULL,
  `cod_vinculacion` int(11) default NULL,
  `cod_area` int(11) default NULL,
  PRIMARY KEY  (`codigo`),
  KEY `proyectos_vinculaciones_FK_idx` (`cod_vinculacion`),
  KEY `proyectos_areas_FK_idx` (`cod_area`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Volcar la base de datos para la tabla `ca_proyectos`
--


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ca_roles_proyecto`
--

DROP TABLE IF EXISTS `ca_roles_proyecto`;
CREATE TABLE IF NOT EXISTS `ca_roles_proyecto` (
  `codigo` int(11) NOT NULL auto_increment,
  `nombre` varchar(50) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Volcar la base de datos para la tabla `ca_roles_proyecto`
--


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ca_secciones`
--

DROP TABLE IF EXISTS `ca_secciones`;
CREATE TABLE IF NOT EXISTS `ca_secciones` (
  `codigo` int(11) NOT NULL,
  `hora_inicio` time default NULL,
  `hora_fin` time default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcar la base de datos para la tabla `ca_secciones`
--


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ca_vinculaciones`
--

DROP TABLE IF EXISTS `ca_vinculaciones`;
CREATE TABLE IF NOT EXISTS `ca_vinculaciones` (
  `codigo` int(11) NOT NULL auto_increment,
  `nombre` varchar(50) default NULL,
  `cod_facultad` int(11) default NULL,
  PRIMARY KEY  (`codigo`),
  KEY `vinculaciones_facultades_FK_idx` (`cod_facultad`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Volcar la base de datos para la tabla `ca_vinculaciones`
--


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cargo`
--

DROP TABLE IF EXISTS `cargo`;
CREATE TABLE IF NOT EXISTS `cargo` (
  `ID_cargo` int(11) NOT NULL auto_increment,
  `Cargo` varchar(100) NOT NULL,
  PRIMARY KEY  (`ID_cargo`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Volcar la base de datos para la tabla `cargo`
--

INSERT INTO `cargo` (`ID_cargo`, `Cargo`) VALUES
(1, 'Decana'),
(2, 'Secretaria Docente II'),
(3, 'Secretaria Docente I'),
(4, 'Asistente Operativo II'),
(5, 'Administrador'),
(6, 'Asistente Administrativo'),
(7, 'Auxiliar de Oficina'),
(8, 'Asistente para el Desarrolo Estratégico'),
(9, 'Asistente de Soporte Técnico'),
(10, 'Docente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias_folios`
--

DROP TABLE IF EXISTS `categorias_folios`;
CREATE TABLE IF NOT EXISTS `categorias_folios` (
  `Id_categoria` int(11) NOT NULL auto_increment,
  `NombreCategoria` text NOT NULL,
  `DescripcionCategoria` text,
  PRIMARY KEY  (`Id_categoria`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Volcar la base de datos para la tabla `categorias_folios`
--

INSERT INTO `categorias_folios` (`Id_categoria`, `NombreCategoria`, `DescripcionCategoria`) VALUES
(1, 'Académico', 'n'),
(2, 'Administrativo', 'n'),
(3, 'Petición', 'n'),
(4, 'Agradecimiento', 'n'),
(5, 'Respuesta de Oficio', 'N'),
(6, 'Invitación', 'n');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clases`
--

DROP TABLE IF EXISTS `clases`;
CREATE TABLE IF NOT EXISTS `clases` (
  `ID_Clases` int(11) NOT NULL auto_increment,
  `Clase` text NOT NULL,
  PRIMARY KEY  (`ID_Clases`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=70 ;

--
-- Volcar la base de datos para la tabla `clases`
--

INSERT INTO `clases` (`ID_Clases`, `Clase`) VALUES
(1, 'SOCIOLOGÍA'),
(2, 'ESPANNOL GENERAL'),
(3, 'FILOSOFÍA'),
(4, 'HISTORIA DE HONDURAS'),
(5, 'INTRODUCCIÓN A LA ESTADÍSTICA SOCIAL'),
(6, 'OPTATIVA HUMANIDADES'),
(7, 'OPTATIVA CIENCIAS NATURALES'),
(8, 'MÉTODOS TÉCNICAS INVESTIGACIÓN E INFORMÁTICA  '),
(9, 'ÉTICA GENERAL'),
(10, 'LÓGICA JURÍDICA '),
(11, 'INTERPRETACIÓN JURÍDICA'),
(12, 'OPTATIVA LENGUAS EXTRANJERAS'),
(13, 'OPTATIVA ARTE O DEPORTE'),
(14, 'DERECHO ROMANO'),
(15, 'INTRODUCCIÓN AL ESTUDIO DE DERECHO'),
(16, 'TEORÍA GENERAL DEL ESTADO'),
(17, 'DERECHO DE FAMILIA '),
(18, 'TEORÍA GENERAL DEL PROCESO'),
(19, 'DERECHO PENAL I'),
(20, 'TEORÍA DE LA CONSTITUCIÓN'),
(21, 'DERECHO FORESTAL Y DE AGUAS'),
(22, 'DERECHO PRIVADO I'),
(23, 'DERECHO PROCESAL CIVIL I'),
(24, 'DERECHO PENAL II'),
(25, 'DERECHO NINNEZ, ADOLESCENTE,MUJER'),
(26, 'HISTORIA CONSTITUCIONAL E INSTITUCIÓN POLITICA '),
(27, 'DERECHO LABORAL I'),
(28, 'DERECHO PRIVADO II'),
(29, 'DERECHO PROCESAL CIVIL II'),
(30, 'CRIMINOLOGÍA'),
(31, 'DERECHO CONSTITUCIONAL'),
(32, 'DERECHO INTERNACIONAL PÚBLICO I'),
(33, 'DERECHO EJECUCIÓN PENAL'),
(34, 'DERECHO PRIVADO III'),
(35, 'DERECHO LABORAL II'),
(36, 'DERECHO INTERNACIONAL PÚBLICO II '),
(37, 'DERECHO ADMINISTRATIVO I'),
(38, 'DERECHO PRIVADO IV'),
(39, 'MEDICINA FORENSE'),
(40, 'DERECHO MERCANTIL I'),
(41, 'DERECHO AMBIENTAL'),
(42, 'DERECHO SEGURIDAD SOCIAL'),
(43, 'DERECHO ADMINISTRATIVO II'),
(44, 'DERECHO MERCANTIL II'),
(45, 'DERECHO AGRARIO'),
(46, 'DERECHO ADMINISTRATIVO ESPECIAL'),
(47, 'DERECHO DE INTEGRACIÓN'),
(48, 'DERECHO LABORAL ESPECIAL'),
(49, 'DERECHO HUMANO Y HUMANIRARIO'),
(50, 'DERECHO INTERNACIONAL PRIVADO'),
(51, 'FILOSOFÍA DERECHO'),
(52, 'DERECHO NOTARIADO Y REGISTRO INMOBILIARIO'),
(53, 'DERECHO MERCANTIL ESPECIAL'),
(54, 'PROPIEDAD INTELECTUAL'),
(55, 'DERECHO PROCESAL LABORAL '),
(56, 'DERECHO PROCESAL PENAL'),
(57, 'JUSTICIA ADMINISTRATIVA'),
(58, 'ÉTICA PROFESIONAL'),
(59, 'SEMINARIO DE INVESTIGACIÓN'),
(60, 'MÓDULO DE PRÁCTICA PROCESAL CIVIL'),
(61, 'MÓDULO DE PRACTICA PROCESAL LABORAL'),
(62, 'MÓDULO DE CRIMINALISTICA'),
(63, 'MÓDULO DE PRÁCTICA PROCESAL PENAL'),
(64, 'MÓDULO DE PRACTICA PROCESAL ADMINISTRATIVO'),
(65, 'MÓDULO DE MÉTODOS ALTERNATIVOS Y SOLUCIÓN DE CONFLICTOS '),
(66, 'MÓDULO DE PRÁCTICAS JUDICIAL INTERNACIONAL'),
(67, 'MÓDULO DERECHO NOTARIAL Y DERECHO REGISTRAL'),
(68, 'MÓDULO DE JUSTICIA CONSTITUCIONAL');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clases_has_experiencia_academica`
--

DROP TABLE IF EXISTS `clases_has_experiencia_academica`;
CREATE TABLE IF NOT EXISTS `clases_has_experiencia_academica` (
  `ID_Clases` int(11) NOT NULL,
  `ID_Experiencia_academica` int(11) NOT NULL,
  PRIMARY KEY  (`ID_Clases`,`ID_Experiencia_academica`),
  KEY `fk_Clases_has_Experiencia_academica_Experiencia_academica1_idx` (`ID_Experiencia_academica`),
  KEY `fk_Clases_has_Experiencia_academica_Clases1_idx` (`ID_Clases`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcar la base de datos para la tabla `clases_has_experiencia_academica`
--


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `costo_porcentaje_actividad_por_trimestre`
--

DROP TABLE IF EXISTS `costo_porcentaje_actividad_por_trimestre`;
CREATE TABLE IF NOT EXISTS `costo_porcentaje_actividad_por_trimestre` (
  `id_Costo_Porcentaje_Actividad_Por_Trimesrte` int(11) NOT NULL auto_increment,
  `id_Actividad` int(11) NOT NULL,
  `costo` int(11) NOT NULL,
  `porcentaje` int(11) NOT NULL,
  `observacion` text,
  `trimestre` int(11) NOT NULL,
  PRIMARY KEY  (`id_Costo_Porcentaje_Actividad_Por_Trimesrte`),
  KEY `id_Actividad` (`id_Actividad`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Volcar la base de datos para la tabla `costo_porcentaje_actividad_por_trimestre`
--

INSERT INTO `costo_porcentaje_actividad_por_trimestre` (`id_Costo_Porcentaje_Actividad_Por_Trimesrte`, `id_Actividad`, `costo`, `porcentaje`, `observacion`, `trimestre`) VALUES
(1, 1, 1250, 25, 'hjbg', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamento_laboral`
--

DROP TABLE IF EXISTS `departamento_laboral`;
CREATE TABLE IF NOT EXISTS `departamento_laboral` (
  `Id_departamento_laboral` int(11) NOT NULL auto_increment,
  `nombre_departamento` varchar(30) NOT NULL,
  PRIMARY KEY  (`Id_departamento_laboral`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Volcar la base de datos para la tabla `departamento_laboral`
--

INSERT INTO `departamento_laboral` (`Id_departamento_laboral`, `nombre_departamento`) VALUES
(1, 'Decanatura'),
(2, 'Administración'),
(3, 'Coordinación'),
(4, 'Laboratorio Docente'),
(5, 'Laboratorio Estudiantes'),
(6, 'Docencia');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `edificios`
--

DROP TABLE IF EXISTS `edificios`;
CREATE TABLE IF NOT EXISTS `edificios` (
  `Edificio_ID` int(11) NOT NULL auto_increment,
  `descripcion` text,
  PRIMARY KEY  (`Edificio_ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Volcar la base de datos para la tabla `edificios`
--

INSERT INTO `edificios` (`Edificio_ID`, `descripcion`) VALUES
(9, 'A2'),
(10, 'C2'),
(11, 'Consultorio Jurídico Gratuito');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

DROP TABLE IF EXISTS `empleado`;
CREATE TABLE IF NOT EXISTS `empleado` (
  `No_Empleado` varchar(20) NOT NULL,
  `N_identidad` varchar(20) NOT NULL,
  `Id_departamento` int(11) NOT NULL,
  `Fecha_ingreso` date NOT NULL,
  `fecha_salida` date default NULL,
  `Observacion` text,
  `estado_empleado` tinyint(1) default NULL,
  PRIMARY KEY  (`No_Empleado`,`N_identidad`),
  UNIQUE KEY `No_Empleado_2` (`No_Empleado`),
  KEY `fk_Empleado_Persona1_idx` (`N_identidad`),
  KEY `fk_empleado_dep_idx` (`Id_departamento`),
  KEY `No_Empleado` (`No_Empleado`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcar la base de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`No_Empleado`, `N_identidad`, `Id_departamento`, `Fecha_ingreso`, `fecha_salida`, `Observacion`, `estado_empleado`) VALUES
('6558', '0801-1965-00177', 1, '2015-11-16', NULL, '', 1),
('11538', '1211-1980-00001', 1, '2015-11-16', NULL, '', 1),
('8708', '0801-1972-10136', 1, '2015-11-16', NULL, '', 1),
('5548', '0801-1959-03859', 1, '2015-11-16', '2015-11-16', '', 0),
('3089', '0801-1961-08415', 1, '2015-11-16', NULL, '', 1),
('14', '0202-1963-00018', 1, '2015-11-16', NULL, '', 1),
('13071', '0801-1978-12387', 3, '2015-11-16', NULL, '', 1),
('11022', '0709-1990-00100', 2, '2015-11-16', NULL, '', 1),
('7908', '0801-1969-02793', 2, '2015-11-16', NULL, '', 1),
('11910', '0801-1988-16746', 5, '2015-11-16', NULL, '', 1),
('12969', '0801-1985-18347', 4, '2015-11-16', NULL, '', 1),
('12968', '0801-1991-06974', 4, '2015-11-16', NULL, '', 1),
('5538', '0801-1959-03858', 1, '2015-11-16', NULL, '', 1),
('2109', '0601-1993-01279', 6, '2015-11-26', NULL, 'fas', 1),
('6587', '0501-1963-01649', 6, '2015-01-01', NULL, '', 1),
('3942', '0602-1971-00111', 6, '2015-01-01', NULL, '', 1),
('8500', '1702-1984-00609', 1, '2015-01-01', NULL, '', 1),
('6490', '0301-1980-02196', 6, '2015-01-01', NULL, '', 1),
('7350', '0801-1957-00110', 6, '2015-01-01', NULL, '', 1),
('6647', '0709-1968-00153', 6, '2015-01-01', NULL, '', 1),
('7107', '1703-1958-00137', 6, '2015-01-01', NULL, '', 1),
('6458', '0801-1979-07612', 6, '2015-01-01', NULL, '', 1),
('6064', '0801-1964-06575', 6, '2015-01-01', NULL, '', 1),
('5989', '0107-1957-00530', 6, '2015-01-01', NULL, '', 1),
('1998', '1701-1982-01261', 1, '2015-01-01', NULL, '', 1),
('2499', '0801-1987-05252', 6, '2015-01-01', NULL, '', 1),
('3073', '1501-1984-00585', 6, '2015-01-01', NULL, '', 1),
('5105', '1401-1976-00148', 6, '2015-01-01', NULL, '', 1),
('1252', '1703-1945-00065', 6, '2015-01-01', NULL, '', 1),
('11630', '0000-0000-00009', 6, '2015-01-01', NULL, '', 1),
('1123', '0801-1961-07060', 6, '2015-01-01', NULL, '', 1),
('1874', '0801-1954-04789', 6, '2015-01-01', NULL, '', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado_has_cargo`
--

DROP TABLE IF EXISTS `empleado_has_cargo`;
CREATE TABLE IF NOT EXISTS `empleado_has_cargo` (
  `No_Empleado` varchar(20) NOT NULL,
  `ID_cargo` int(11) NOT NULL,
  `Fecha_ingreso_cargo` date NOT NULL,
  `Fecha_salida_cargo` date default NULL,
  `recibirNotificacion` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`No_Empleado`,`ID_cargo`),
  KEY `fk_Empleado_has_Cargo_Cargo1_idx` (`ID_cargo`),
  KEY `fk_Empleado_has_Cargo_Empleado1_idx` (`No_Empleado`),
  KEY `No_Empleado` (`No_Empleado`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcar la base de datos para la tabla `empleado_has_cargo`
--

INSERT INTO `empleado_has_cargo` (`No_Empleado`, `ID_cargo`, `Fecha_ingreso_cargo`, `Fecha_salida_cargo`, `recibirNotificacion`) VALUES
('6558', 1, '2015-11-16', NULL, 0),
('11538', 8, '2015-11-16', NULL, 1),
('8708', 4, '2015-11-16', NULL, 0),
('5548', 1, '2015-11-16', '2015-11-16', 0),
('5548', 2, '2015-11-16', NULL, 0),
('3089', 2, '2015-11-16', NULL, 0),
('14', 3, '2015-11-16', NULL, 0),
('13071', 4, '2015-11-16', NULL, 0),
('11022', 5, '2015-11-16', NULL, 1),
('7908', 6, '2015-11-16', NULL, 0),
('11910', 9, '2015-11-16', NULL, 0),
('12969', 9, '2015-11-16', NULL, 0),
('12968', 9, '2015-11-16', NULL, 0),
('5538', 2, '2015-11-16', NULL, 0),
('2109', 10, '2015-11-26', NULL, 1),
('6587', 10, '2015-01-01', NULL, 0),
('3942', 10, '2015-01-01', NULL, 0),
('8500', 1, '2015-01-01', NULL, 0),
('6490', 10, '2015-01-01', NULL, 0),
('7350', 10, '2015-01-01', NULL, 0),
('6647', 10, '2015-01-01', NULL, 0),
('7107', 10, '2015-01-01', NULL, 0),
('6458', 10, '2015-01-01', NULL, 1),
('6064', 10, '2015-01-01', NULL, 0),
('5989', 10, '2015-01-01', NULL, 1),
('1998', 10, '2015-01-01', NULL, 0),
('2499', 10, '2015-01-01', NULL, 0),
('3073', 10, '2015-01-01', NULL, 0),
('5105', 10, '2015-01-01', NULL, 0),
('1252', 10, '2015-01-01', NULL, 0),
('11630', 10, '2015-01-01', NULL, 0),
('1123', 10, '2015-01-01', NULL, 1),
('1874', 10, '2015-01-01', NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_seguimiento`
--

DROP TABLE IF EXISTS `estado_seguimiento`;
CREATE TABLE IF NOT EXISTS `estado_seguimiento` (
  `Id_Estado_Seguimiento` tinyint(4) NOT NULL auto_increment,
  `DescripcionEstadoSeguimiento` text NOT NULL,
  PRIMARY KEY  (`Id_Estado_Seguimiento`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Volcar la base de datos para la tabla `estado_seguimiento`
--

INSERT INTO `estado_seguimiento` (`Id_Estado_Seguimiento`, `DescripcionEstadoSeguimiento`) VALUES
(1, 'En proceso'),
(2, 'Finalizado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudios_academico`
--

DROP TABLE IF EXISTS `estudios_academico`;
CREATE TABLE IF NOT EXISTS `estudios_academico` (
  `ID_Estudios_academico` int(11) NOT NULL auto_increment,
  `Nombre_titulo` varchar(100) NOT NULL,
  `ID_Tipo_estudio` int(11) NOT NULL,
  `N_identidad` varchar(20) NOT NULL,
  `Id_universidad` int(11) default NULL,
  PRIMARY KEY  (`ID_Estudios_academico`),
  KEY `fk_Estudios_academico_Tipo_estudio1_idx` (`ID_Tipo_estudio`),
  KEY `fk_Estudios_academico_Persona1_idx` (`N_identidad`),
  KEY `fk_estudio_universidad_idx` (`Id_universidad`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Volcar la base de datos para la tabla `estudios_academico`
--

INSERT INTO `estudios_academico` (`ID_Estudios_academico`, `Nombre_titulo`, `ID_Tipo_estudio`, `N_identidad`, `Id_universidad`) VALUES
(1, 'LICENCIATURA EN INFORMÁTICA ADMINISTRATIVA', 4, '0801-1991-06974', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `experiencia_academica`
--

DROP TABLE IF EXISTS `experiencia_academica`;
CREATE TABLE IF NOT EXISTS `experiencia_academica` (
  `ID_Experiencia_academica` int(11) NOT NULL auto_increment,
  `Institucion` varchar(45) NOT NULL,
  `Tiempo` int(3) NOT NULL,
  `N_identidad` varchar(20) NOT NULL,
  PRIMARY KEY  (`ID_Experiencia_academica`),
  KEY `fk_Experiencia_academica_Persona1_idx` (`N_identidad`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Volcar la base de datos para la tabla `experiencia_academica`
--


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `experiencia_laboral`
--

DROP TABLE IF EXISTS `experiencia_laboral`;
CREATE TABLE IF NOT EXISTS `experiencia_laboral` (
  `ID_Experiencia_laboral` int(11) NOT NULL auto_increment,
  `Nombre_empresa` varchar(45) NOT NULL,
  `Tiempo` int(3) NOT NULL,
  `N_identidad` varchar(20) NOT NULL,
  PRIMARY KEY  (`ID_Experiencia_laboral`),
  KEY `fk_Experiencia_laboral_Persona1_idx` (`N_identidad`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Volcar la base de datos para la tabla `experiencia_laboral`
--


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `experiencia_laboral_has_cargo`
--

DROP TABLE IF EXISTS `experiencia_laboral_has_cargo`;
CREATE TABLE IF NOT EXISTS `experiencia_laboral_has_cargo` (
  `ID_Experiencia_laboral` int(11) NOT NULL,
  `ID_cargo` int(11) NOT NULL,
  PRIMARY KEY  (`ID_Experiencia_laboral`,`ID_cargo`),
  KEY `fk_Experiencia_laboral_has_Cargo_Cargo1_idx` (`ID_cargo`),
  KEY `fk_Experiencia_laboral_has_Cargo_Experiencia_laboral1_idx` (`ID_Experiencia_laboral`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcar la base de datos para la tabla `experiencia_laboral_has_cargo`
--


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `folios`
--

DROP TABLE IF EXISTS `folios`;
CREATE TABLE IF NOT EXISTS `folios` (
  `NroFolio` varchar(25) NOT NULL,
  `NroFolioRespuesta` varchar(25) default NULL,
  `FechaCreacion` date NOT NULL,
  `FechaEntrada` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `PersonaReferente` text NOT NULL,
  `UnidadAcademica` int(11) default NULL,
  `Organizacion` int(11) default NULL,
  `Categoria` int(11) NOT NULL,
  `DescripcionAsunto` text,
  `TipoFolio` tinyint(1) NOT NULL,
  `UbicacionFisica` int(5) NOT NULL,
  `Prioridad` tinyint(4) NOT NULL,
  PRIMARY KEY  (`NroFolio`),
  KEY `fk_folios_unidad_academica_unidadAcademica_idx` (`UnidadAcademica`),
  KEY `fk_folios_organizacion_organizacion_idx` (`Organizacion`),
  KEY `fk_folios_tblTipoPrioridad_idx` (`Prioridad`),
  KEY `fk_folios_ubicacion_archivofisico_ubicacionFisica_idx` (`UbicacionFisica`),
  KEY `fk_folio_folioRespuesta_idx` (`NroFolioRespuesta`),
  KEY `fk_folios_categoria_idx` (`Categoria`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcar la base de datos para la tabla `folios`
--

INSERT INTO `folios` (`NroFolio`, `NroFolioRespuesta`, `FechaCreacion`, `FechaEntrada`, `PersonaReferente`, `UnidadAcademica`, `Organizacion`, `Categoria`, `DescripcionAsunto`, `TipoFolio`, `UbicacionFisica`, `Prioridad`) VALUES
('5', NULL, '2015-11-16', '2015-11-17 12:20:30', 'Ing.María G. Núñez S.  Depto. Ing. Industrial', 3, NULL, 1, 'e', 0, 10, 1),
('OFICIO Nº 001', NULL, '2015-11-16', '2015-11-16 15:05:08', 'Secretaria', 3, NULL, 1, 'lista de graduados 24-11-2015', 1, 1, 1),
('Nota: ', NULL, '2015-11-16', '2015-11-16 15:57:47', 'Miembros Consejo Local Carrera Docente', 4, NULL, 1, 'Listado de profeisonales seleccionados en el Concurso CP-SEDP-001-201|5', 0, 3, 1),
('Oficio No.1372 Inv. Cient', NULL, '2015-11-17', '2015-11-17 12:17:01', 'Leticia Salomón', 5, NULL, 1, 'Respuesta a oficios de la Decanatura sobre acciones de la UNAH en Derechos Humanos', 0, 3, 1),
('Nota Zahira Núñez', NULL, '2015-11-17', '2015-11-18 14:29:47', 'Sahira Núñez', 4, NULL, 1, 'Solicitud de traslado al Departamento de Derecho Privado', 0, 11, 1),
('Oficio No.093-MDH', NULL, '2015-11-17', '2015-11-17 15:06:08', 'Msc. Alda Mejía de Kawas', 4, NULL, 1, 'Solicitud de apoyo por parte de Francis E. Tercero para enviar vía correo electrónico Instrumento de Recolección de Información .', 0, 10, 2),
('Oficio No.3271-D.G.T.H./S', NULL, '2015-11-16', '2015-11-17 15:12:02', 'Jacinta Ruiz', 6, NULL, 2, 'Respuesta sobre contratación de la Licenciada Suany Yaniny Rodríguez Aguilar (denegada).', 0, 10, 2),
('Nota de fecha 17-nov-2015', NULL, '2015-11-17', '2015-11-17 15:18:19', 'Alumnos Fausto Cálix y Blanca Castillo ', 7, NULL, 6, 'Nota solicitando autorización e invitando a la Decana al Homenaje a los abogados/as víctimas de violencia el miércoles 18 de noviembre a las 5:30 p.m. en la plazoleta de la Facultad C.J.', 0, 10, 1),
('Nota de fecha 16/nov/2015', NULL, '2015-11-16', '2015-11-17 15:23:54', 'Rigoberto Mejía Oliva', 7, NULL, 3, 'Solicitud del Director de Docencia Académica de la Universidad de Defensa de Honduras para que la Abogada Nancy Cubas pueda realizar su práctica profesional en esta Facultad.', 0, 10, 2),
('Nota 16/nov./2015', NULL, '2015-11-16', '2015-11-17 15:26:50', 'Rigoberto Mejía Oliva', 7, NULL, 2, 'Solicitud de la Universidad de Defensa de Honduras para que la abogada Patricia Elizabeth Rico Váquez realice su práctica profesional en esta Facultad.', 0, 10, 2),
('Of.FACES-SC-059', NULL, '2015-11-17', '2015-11-17 16:23:18', 'Nohemy Rivera Gutierrez', 6, NULL, 1, 'Respuesta a Oficio FCJ-598-2015. Se envía información de ampliación de los derechos humanos de la Facultad de Ciencias Espaciales.', 0, 10, 2),
('RU-NO.1083-2015', NULL, '2015-11-18', '2015-11-18 16:27:05', 'Msc.Julieta Castellanos', 6, NULL, 6, 'Invitación a conferencias por parte del Congreso Nacional.', 0, 10, 2),
('Invitación', NULL, '2015-11-18', '2015-11-18 16:29:37', 'Dirección de Innovación Educativa', 6, NULL, 1, 'Invitación  a inauguración de la VI Jornada de Innovación Educativa. Miercoles 2 de diciembre 2015. 9:00 a.m. Auditorio Dr. Jesús Aguilar Paz. Facultad Química y Farmacia.', 0, 10, 2),
('SEDI OFICIO NO.636', NULL, '2015-11-17', '2015-11-18 16:36:32', 'KAREN MENDOZA DE SANTOS', 6, NULL, 2, 'Conocer avances logros y retos en actividades para el año 2015.', 0, 10, 2),
('CC. Oficio CCD-101-2015', NULL, '2015-11-17', '2015-11-18 16:39:47', 'Diana Valladares', 6, NULL, 1, 'Solicitando a Suyapa Rivera reserva del aula 202 A2 para módulos', 0, 10, 2),
('CC Oficio CC-100-2015', NULL, '2015-11-17', '2015-11-18 16:42:01', 'Diana Valladares', 4, NULL, 1, 'Solicitando a Suyapa Andino designar un profesional con especialidad en portafolio para brindar capacitación.', 0, 10, 2),
('CC Oficio CCD-102-2015', NULL, '2015-11-17', '2015-11-18 16:43:50', 'Diana Valladares', 4, NULL, 1, 'Solicitando a Iris Xiomara Corrales designar a Berthy Chirinos para impartir taller sobre Modelo Educativo.', 0, 10, 2),
('Nota: 14-nov-2015', NULL, '2015-11-14', '2015-11-19 16:05:22', 'Hector Martín Cerrato', 4, NULL, 1, 'Nota informando de participación en el XIV Foro iberoamericano de Derecho Administrativo', 0, 10, 2),
('Oficio 1232 SEDP', NULL, '2015-11-11', '2015-11-19 16:09:20', 'Jacinta Ruiz Bonilla', 6, NULL, 2, 'Aceptación de renuncia de Reynaldo Ordóñez Fonseca', 0, 10, 2),
('Oficio SCU-162-2015', NULL, '2015-11-16', '2015-11-20 15:52:43', 'BELINDA FLORES DE MENDOZA CU', 6, NULL, 2, 'Oficio dirigido a Anibal Ivans Cerritos Moncada y José Benicio Mejía Manueles', 0, 10, 2),
('Oficio SCU-161-2015', NULL, '2015-11-16', '2015-11-20 15:55:26', 'BELINDA FLORES DE MENDOZA', 6, NULL, 2, 'Oficio dirigido al alumno Mauricio Leonel Membreño Andino', 0, 10, 2),
('Oficio 1336-D-E.L./S.E.D.', NULL, '2015-11-12', '2015-11-20 15:58:18', 'Jacinta Ruiz Bonilla', 6, NULL, 2, 'No autorización de vacaciones del Dr. OdirFernández', 0, 10, 2),
('DIRCOM Oficio No.641', NULL, '2015-11-18', '2015-11-20 16:00:44', 'Armando Sarmiento', 6, NULL, 2, 'Oficio Dirección de Comunicación Estratégica sobre diseño de productos institucionales.', 0, 10, 2),
('SEDI Oficio No.640', NULL, '2015-11-18', '2015-11-20 16:04:45', 'Ing. Marcio Alejandro Aguero', 6, NULL, 2, 'Solicitando información en materia de regalías', 0, 10, 2),
('Oficio VOAE 819-2015', NULL, '2015-11-19', '2015-11-20 16:07:19', 'Ayax Irías Coello', 6, NULL, 2, 'Solicitando datos de docentes que conformarán el Comité de Vida Estudiantil de la Facultad.', 0, 10, 2),
('Oficio No.312 DCJG-FCJ', NULL, '2015-11-19', '2015-11-20 16:15:57', 'Erlinda E. Flores Flores para vo. bo. de la Decana', 6, NULL, 2, 'Oficio solicitando autorización de vacaciones para Ismelda Aricia Sánchez', 0, 10, 2),
('Nabil Kawas: INVITACION', NULL, '2015-11-20', '2015-11-20 16:21:08', 'Nabil Kawas', 6, NULL, 6, 'Invitación a socialización del proyecto "Escenarios de Cambio Climático a través del uso de modelos regionales de clima"', 0, 10, 2),
('Nota 20 de nov. 2015', NULL, '2015-11-20', '2015-11-24 11:39:14', 'Diana Valladares', 4, NULL, 2, 'Solicitud de vacaciones', 0, 10, 2),
('Nota 25-nov-2015 FUUD-Der', NULL, '2015-11-25', '2015-11-25 15:52:01', 'Solicitud de apoyo para convocar a asamblea de estudiantes', 7, NULL, 3, 'Solicitando apoyo a la Decana para convocar a asamblea de estudiantes', 0, 10, 1),
('CDM-107', NULL, '2015-11-25', '2015-11-25 15:55:40', 'Fernán Núñez Pineda', 4, NULL, 1, 'Dando respuesta a Oficio FCJ-656-2015', 0, 10, 2),
('Oficio SFCJ-172', NULL, '2015-11-24', '2015-11-25 16:09:54', 'Jorge Alberto Matute Ochoa', 4, NULL, 2, 'Solicitando vacaciones ', 0, 10, 2),
('Oficio JDU-UNAH-No.364', NULL, '2015-11-24', '2015-11-25 16:12:46', 'Aleyda Romero Escobar', 7, NULL, 2, 'Comunicando visita al Consultorio Jurídico para el miércoles 2 de diciembre 2015 3:00 p.m.', 0, 10, 2),
('2 libros/inv. Ciencias Es', NULL, '2015-11-25', '2015-11-25 16:15:34', 'Facultad de Ciencias Espaciales', 6, NULL, 1, '2 libros de Ciencias Espaciales e invitación para conferencia el día 27 de noviembre 2015.', 0, 10, 1),
('Oficio No.663-FCJ', NULL, '2015-11-25', '2015-11-25 16:17:55', 'Bessy Margoth Nazar', 4, NULL, 2, 'Pidiendo cambio de fechas para goce de tiempo compensatorio Lic. Carlos Luis Burgos', 1, 10, 2),
('CCD-102-2015', NULL, '2015-12-04', '2015-12-04 08:12:04', 'DRA. RUTILIA CALDERON', 8, NULL, 3, 'Petición de Estudiante, egresado de la Carrera de Licenciatura en Finanzas y aspira estudiar Derecho como una segunda Carrera.', 1, 8, 2),
('IIJ-069-2015', NULL, '2015-12-08', '2015-12-09 16:10:44', 'Javier López Padilla', 6, NULL, 5, 'Informe Trimestral de actividades durante IV trimestral conforme al Plan Operativo Anual', 0, 10, 2),
('666-hhh', NULL, '2015-12-09', '2015-12-09 23:15:10', 'Hector Llanos', 3, NULL, 1, 'este es un folio de prueba', 0, 1, 2),
('$mensaje="No se ha proces', NULL, '2015-12-16', '2015-12-10 01:05:36', '$mensaje="No se ha procesado su peticion, comuniquese con el administrador del sistema ..."; 		 //    $codMensaje =0;', 4, NULL, 2, '$mensaje="No se ha procesado su peticion, comuniquese con el administrador del sistema ...";\n		 //    $codMensaje =0;', 0, 2, 2),
('ddd', NULL, '2015-12-17', '2015-12-10 01:07:59', 'ddd', 3, NULL, 2, 'ddd', 0, 3, 1),
('sss', NULL, '2015-12-10', '2015-12-10 01:08:59', 'sss', 3, NULL, 2, 'sss', 1, 2, 1),
('001-2016', NULL, '2015-12-28', '2016-01-07 16:15:31', 'DRA. OLGA MARINA PÉREZ CANALES', 4, NULL, 2, 'SOLICITA APROBACIÓN DE PERMISO SIN GOCE DE SUELDO POR UN AÑO (2016), A PARTIR DEL MES DE ENERO, PARA PODER ATENDER SITUACIÓN PERSONAL URGENTE FUERA DEL PAÍS.', 0, 1, 1),
('002-2016', NULL, '2016-01-06', '2016-01-11 13:05:07', 'EMMA VIRGINIA RIVERA MEJÍA', 6, NULL, 2, 'Solicita el Expediente de Reclamo Administrativo presentado por la Abg. IRMA CELMIRA OLIVA RODRÍGUEZ, para dar el trámite correspondiente', 0, 2, 1),
('003-2016', NULL, '2015-12-07', '2016-01-11 13:08:05', 'JACINTA RUIZ BONILLA', 6, NULL, 5, 'DA RESPUESTA A OFICIO FCJ-660 DEL 27 DE NOVEIMBRE DE 2015, REFERENTE A VACACIONES SOLICITADAS POR LA COORDINADORA DE CARRERA, ABG. DIANA VALLADARES', 0, 4, 2),
('Oficio No.088-2016', NULL, '2016-01-15', '2016-01-18 14:45:37', 'Doctora Rutilia Calderon', 8, NULL, 5, 'Caso del estudiante Eduardo Enrique Fuentes Calix', 0, 4, 1),
('Oficio No. VRA-089-2016', NULL, '2016-01-15', '2016-01-18 14:50:14', 'Doctora Rutilia Calderon', 8, NULL, 5, 'En atención a la solicitud presentada por la Lic. Elvia Rosa Elvir Martìnez', 0, 4, 1),
('Circular VRA-No.001-2016', NULL, '2016-01-15', '2016-01-18 15:07:35', 'Doctora Rutilia Calderon', 8, NULL, 5, 'Dando cumplimiento a lo dispuesto en el Acuerdo No. 2414-253-2011 del Consejo de Educación Superior y a las Normas \nAcadémicas de la UNAH.', 0, 4, 2),
('CCD-150-2016', NULL, '2016-02-05', '2016-02-05 17:24:24', 'DECANA  BESSY NAZAR', 4, NULL, 3, 'Solicitud de la carga individualizada y listado de los docentes que ocupan las diferentes comisiones.', 0, 8, 1),
('0001', NULL, '2016-02-11', '2016-02-11 18:39:40', 'ELIZABETH T.', 4, NULL, 1, 'ESTA ES UNA PRUEBA DEL SISTEMA', 1, 7, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grupo_o_comite`
--

DROP TABLE IF EXISTS `grupo_o_comite`;
CREATE TABLE IF NOT EXISTS `grupo_o_comite` (
  `ID_Grupo_o_comite` int(11) NOT NULL auto_increment,
  `Nombre_Grupo_o_comite` varchar(45) NOT NULL,
  PRIMARY KEY  (`ID_Grupo_o_comite`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

--
-- Volcar la base de datos para la tabla `grupo_o_comite`
--

INSERT INTO `grupo_o_comite` (`ID_Grupo_o_comite`, `Nombre_Grupo_o_comite`) VALUES
(1, 'Asistentes de Soporte Técnico'),
(2, 'CORDINACIÓN DE CARRERA'),
(3, 'DESARROLLO E INNOVACIÓN CURRICULAR'),
(4, 'CONSULTORIO JURÍDICO GRATUITO '),
(5, 'SECRETARIA ACADEMICA'),
(6, 'POSGRADOS'),
(7, 'UNIDAD DE INVESTIGACIÓN'),
(8, 'INSTITUTO DE INVESTIGACIÓN JURIDICA'),
(9, 'UNIDAD VINCULACIÓN UNIVERSIDAD SOCIEDAD  '),
(10, 'ADMINISTRACIÓN '),
(11, 'DECANATO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grupo_o_comite_has_empleado`
--

DROP TABLE IF EXISTS `grupo_o_comite_has_empleado`;
CREATE TABLE IF NOT EXISTS `grupo_o_comite_has_empleado` (
  `ID_Grupo_o_comite` int(11) NOT NULL,
  `No_Empleado` varchar(20) NOT NULL,
  PRIMARY KEY  (`ID_Grupo_o_comite`,`No_Empleado`),
  KEY `fk_Grupo_o_comite_has_Empleado_Empleado1_idx` (`No_Empleado`),
  KEY `fk_Grupo_o_comite_has_Empleado_Grupo_o_comite1_idx` (`ID_Grupo_o_comite`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcar la base de datos para la tabla `grupo_o_comite_has_empleado`
--

INSERT INTO `grupo_o_comite_has_empleado` (`ID_Grupo_o_comite`, `No_Empleado`) VALUES
(1, '11538'),
(2, '1123');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `idioma`
--

DROP TABLE IF EXISTS `idioma`;
CREATE TABLE IF NOT EXISTS `idioma` (
  `ID_Idioma` int(11) NOT NULL auto_increment,
  `Idioma` varchar(80) default NULL,
  PRIMARY KEY  (`ID_Idioma`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

--
-- Volcar la base de datos para la tabla `idioma`
--

INSERT INTO `idioma` (`ID_Idioma`, `Idioma`) VALUES
(2, 'Español'),
(3, 'Ingles'),
(4, 'Frances'),
(5, 'Chino Mandarin'),
(6, 'Italiano'),
(7, 'Japones'),
(8, 'Aleman'),
(9, 'Portugues'),
(10, 'Arabe'),
(11, 'Bengali'),
(12, 'Indonecio'),
(13, 'Coreano'),
(14, 'Turco'),
(15, 'Vietnamita');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `idioma_has_persona`
--

DROP TABLE IF EXISTS `idioma_has_persona`;
CREATE TABLE IF NOT EXISTS `idioma_has_persona` (
  `ID_Idioma` int(11) NOT NULL,
  `N_identidad` varchar(20) NOT NULL,
  `Nivel` varchar(45) default NULL,
  `Id` int(11) NOT NULL auto_increment,
  PRIMARY KEY  (`Id`),
  KEY `fk_Idioma_has_Persona_Persona1_idx` (`N_identidad`),
  KEY `fk_Idioma_has_Persona_Idioma_idx` (`ID_Idioma`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Volcar la base de datos para la tabla `idioma_has_persona`
--

INSERT INTO `idioma_has_persona` (`ID_Idioma`, `N_identidad`, `Nivel`, `Id`) VALUES
(2, '0801-1991-06974', '99', 1),
(3, '0801-1991-06974', '60', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `indicadores`
--

DROP TABLE IF EXISTS `indicadores`;
CREATE TABLE IF NOT EXISTS `indicadores` (
  `id_Indicadores` int(11) NOT NULL auto_increment,
  `id_ObjetivosInsitucionales` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `descripcion` text,
  PRIMARY KEY  (`id_Indicadores`),
  KEY `id_ObjetivosInsitucionales` (`id_ObjetivosInsitucionales`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=134 ;

--
-- Volcar la base de datos para la tabla `indicadores`
--

INSERT INTO `indicadores` (`id_Indicadores`, `id_ObjetivosInsitucionales`, `nombre`, `descripcion`) VALUES
(1, 1, '1.1 Plan de estudios reformado', '1.1 Plan de estudios reformado implementado en 100%  '),
(2, 2, '1.1 Plan de estudios reformado', '1.1 Plan de estudios reformado implementado en 100%  '),
(3, 2, '1.3 Implementado el Plan de Me', ' 1.3 Implementado el Plan de Mejoras de la Carrera de Derecho'),
(4, 2, ' 1.4 Establecido el plan de ev', ' 1.4 Establecido el plan de evaluación y certificación de la Carrera de Derecho por los pares externos de acreditación. '),
(5, 3, '3.1 Número de grupos etarios a', '3.1 Número de grupos etarios atendidos por la Facultad de Ciencias Jurídicas con proyectos de aprendizaje de vinculación Universidad Sociedad ( por lo menos 10 por año)'),
(6, 1, '1.2 Número de redes internas y', '1.2 Número de redes internas y externas de los sistemas que promueven la certificación y acreditación de carreras en los que participan las comisiones y unidades de la Facultad de Ciencias Jurídicas'),
(7, 1, '1.3 Implementado el Plan de Me', '1.3 Implementado el Plan de Mejoras de la Carrera de Derecho'),
(8, 4, '4.1 100% del programa de desar', '4.1 100% del programa de desarrollo profesional docente ejecutado'),
(9, 1, ' 1.4 Establecido el plan de ev', ' 1.4 Establecido el plan de evaluación y certificación de la Carrera de Derecho por los pares externos de acreditación. '),
(11, 1, '1.5 Un mínimo de 3 carreras pr', '1.5 Un mínimo de 3 carreras propuestas como nueva oferta diseñadas en la facultad de Ciencias Jurídicas '),
(12, 4, '4.2 Tres evaluaciones al año d', '4.2 Tres evaluaciones al año de los indicadores de logro de referentes mínimos de acreditación y certificación docente'),
(13, 6, '4.6 Número de espacios académi', '4.6 Número de espacios académicos ( conferencias, conversatorios, círculos de trabajo, redes) desarrollados.'),
(14, 7, '8.3 100 % de los docentes cert', '8.3 100 % de los docentes certificados y acreditados por la UNAH'),
(15, 8, '8.4 100% de los docentes conoc', '8.4 100% de los docentes conocerán y aplicarán las políticas de calidad académica de la Facultad UNAH'),
(16, 4, '4.3 Plan de relevo docente des', '4.3 Plan de relevo docente desarrollado y en aplicación'),
(17, 4, '4.4Número de círculos de estud', '4.4Número de círculos de estudio desarrollados'),
(18, 4, '4.5 Número de clases demostrat', '4.5 Número de clases demostrativas para observar la aplicación de las estrategias didácticas de acuerdo al modelo'),
(19, 4, '4.6 Número de espacios académi', '4.6 Número de espacios académicos ( conferencias, conversatorios, círculos de trabajo, redes) desarrollados.'),
(20, 9, '9.1 Numero de docentes de la F', '9.1 Numero de docentes de la FCJ que participan en los Programas de Formación de Innovación Educativa.'),
(21, 9, '9.2Programa interno de la FCJ ', '9.2Programa interno de la FCJ desarrollado para la aplicación del Modelo de Innovación Institucional  y Educativa de la UNAH '),
(22, 9, '9.3 Número de proyectos de Inn', '9.3 Número de proyectos de Innovación Educativa desarrollados en la FCJ'),
(23, 10, '11.2 Aplicado el Plan Interno ', '11.2 Aplicado el Plan Interno de Desarrollo Físico en la Facultad de Ciencias Jurídicas'),
(24, 12, '12.1 Ejecutado el Plan Permane', '12.1 Ejecutado el Plan Permanente de Desarrollo del Talento Humano'),
(25, 11, '7.3 Cinco eventos realizados p', '7.3 Cinco eventos realizados para fortalecer la identidad nacional , ciudadanía y abordar los problemas nacionales'),
(28, 13, '14.2 Proceso de acreditación c', '14.2 Proceso de acreditación completado al final del período.'),
(29, 14, '9.1 Numero de docentes de la F', '9.1 Numero de docentes de la FCJ que participan en los Programas de Formación de Innovación Educativa.'),
(27, 13, '14.1 50% de aplicación de inst', '14.1 50% de aplicación de instrumentos de armonización académica asumidos por la UNAH en el marco de la internacionalización de educación superior'),
(30, 14, '9.2 Programa interno de la FCJ', '9.2 Programa interno de la FCJ desarrollado para la aplicación del Modelo de Innovación Institucional  y Educativa de la UNAH '),
(31, 14, '9.3 Número de proyectos de Inn', '9.3 Número de proyectos de Innovación Educativa desarrollados en la FCJ'),
(32, 15, '12.1 Ejecutado el Plan Permane', '12.1 Ejecutado el Plan Permanente de Desarrollo del Talento Humano'),
(33, 16, '15.2  100% de los órganos de g', '15.2  100% de los órganos de gobierno académico conformados.'),
(34, 17, '5.1 Unidad de Estudiantes crea', '5.1 Unidad de Estudiantes creada'),
(35, 18, '5.6 Egresados de la Facultad d', '5.6 Egresados de la Facultad de Ciencias Jurídicas monitoreados por el sistema de seguimiento'),
(36, 18, '5.7', '5.7'),
(37, 18, '5.8 Egresados de FCJ que parti', '5.8 Egresados de FCJ que participan en los programas de postgrados'),
(38, 19, '6.2 Desarrollo de al menos una', '6.2 Desarrollo de al menos una negociación de convenios y participación en redes por la FCJ'),
(39, 20, '8.2 100% de personal  administ', '8.2 100% de personal  administrativo que adoptan una cultura de calidad a través de la incorporación del Sistema de Gestión.  capacitaciones en la calidad en la gestión administrativa'),
(40, 21, '8.4 100% de los docentes conoc', '8.4 100% de los docentes conocerán y aplicarán las políticas de calidad académica de la Facultad UNAH'),
(41, 22, '11.4  Porcentaje de proyectos ', '11.4  Porcentaje de proyectos realizados con fondos de cooperación '),
(42, 17, ' 5.3 Número alumnos en riesgo ', ' 5.3 Número alumnos en riesgo académico atendidos a través de asesorías '),
(43, 23, '13.2 100% de las unidades de l', '13.2 100% de las unidades de la Facultad de Ciencias Jurídicas presentan su planificación operativa anual'),
(44, 23, '13.3 100% de las unidades de l', '13.3 100% de las unidades de la Facultad de Ciencias Jurídicas presenta su Informe Trimestral de Seguimiento de Planificación Operativo Anual'),
(45, 24, '15.5 100% de cumplimiento por ', '15.5 100% de cumplimiento por parte del personal docente y administrativo en la función académica y administrativa de acuerdo a la normativa universitaria'),
(46, 24, '15.6 Realizados al menos cuatr', '15.6 Realizados al menos cuatro encuentros académicos anuales entre autoridades y comunidad estudiantil\n'),
(49, 25, '15.8 100% de comisiones de  di', '15.8 100% de comisiones de  dictámenes y propuesta de actualización y reformas de la normativa del nivel conformadas     '),
(48, 24, '15.7Realizados al menos dos en', '15.7Realizados al menos dos encuentros entre autoridades de la Facultad de CCJJ y la comunidad docente'),
(50, 25, '15.9 100% de Acuerdos ,dictáme', '15.9 100% de Acuerdos ,dictámenes y normativa armonizada y aprobados.'),
(51, 17, '5.4 Número de actividades soci', '5.4 Número de actividades socioculturales, deportivas y de intercambio estudiantil en el área de las Ciencias Jurídicas desarrolladas'),
(52, 26, '5.5 Unidad de Egresados creada', '5.5 Unidad de Egresados creada'),
(53, 27, '8.1 100% de personal docente  ', '8.1 100% de personal docente  que adoptan una cultura de calidad a través de la incorporación del Sistema de Gestión. '),
(55, 28, '8.4 100% de los docentes conoc', '8.4 100% de los docentes conocerán y aplicarán las políticas de calidad académica de la Facultad UNAH'),
(56, 28, '8.7100% de la carrera y las ma', '8.7100% de la carrera y las maestrías de la  Facultad de Ciencias Jurídicas mejoran indicadores de calidad de acuerdo a su plan de mejora.'),
(57, 29, '3.2 Número de casos resueltos ', '3.2 Número de casos resueltos por alumnos practicantes de la FCJ '),
(58, 29, '3.3 Incremento del Número de c', '3.3 Incremento del Número de casos atendidos por practicantes'),
(59, 30, '7.4 Número de procesos de gene', '7.4 Número de procesos de generación de estrategias e iniciativas para la sostenibilidad de proyectos ciudadanía en los que participan las unidades de la Facultad de Ciencias Jurídicas'),
(60, 31, '13.2 100% de las unidades de l', '13.2 100% de las unidades de la Facultad de Ciencias Jurídicas presentan su planificación operativa anual'),
(61, 32, '2.1 Unidad de Investigación co', '2.1 Unidad de Investigación conformadas en la Carreras de la FCJ'),
(62, 32, '2.9 La facultad participa en p', '2.9 La facultad participa en por lo menos 4 eventos de publicación de investigaciones'),
(63, 33, '7.4 Número de procesos de gene', '7.4 Número de procesos de generación de estrategias e iniciativas para la sostenibilidad de proyectos ciudadanía en los que participan las unidades de la Facultad de Ciencias Jurídicas'),
(64, 34, '10.1 Nuevas carreras aprobadas', '10.1 Nuevas carreras aprobadas y en funcionamiento a nivel de posgrado en la Facultad de Ciencias Jurídicas'),
(65, 31, '13.3 100% de las unidades de l', '13.3 100% de las unidades de la Facultad de Ciencias Jurídicas presenta su Informe Trimestral de Seguimiento de Planificación Operativo Anual'),
(66, 34, '10.2 Apertura de nuevas promoc', '10.2 Apertura de nuevas promociones en las carreras de posgrados activas y reactivadas'),
(67, 34, '10.3 Posgrados de la Facultad ', '10.3 Posgrados de la Facultad de Ciencias Jurídicas en proceso de implementación de sus planes de mejora con el propósito de lograr la acreditación'),
(68, 34, '10.4 Número de proyectos de in', '10.4 Número de proyectos de investigación desarrollados por los posgrados'),
(69, 34, '10.5 Número de participaciones', '10.5 Número de participaciones en congresos científicos'),
(70, 34, '10.6 Publicación de artículos ', '10.6 Publicación de artículos científicas en revistas científicas'),
(71, 34, '10.7 Numero de proyectos de vi', '10.7 Numero de proyectos de vinculación universidad sociedad impulsados y desarrollados por las carreras de posgrados de la Facultad de Ciencias Jurídicas'),
(72, 34, '10.8 Numero de proyectos de mo', '10.8 Numero de proyectos de movilidad estudiantil '),
(73, 34, '10.9 Numero de proyectos de mo', '10.9 Numero de proyectos de movilidad e intercambio docente '),
(74, 35, '2.1 Unidad de Investigación co', '2.1 Unidad de Investigación conformadas en la Carreras de la FCJ'),
(75, 36, '2.1 Unidad de Investigación co', '2.1 Unidad de Investigación conformadas en la Carreras de la FCJ'),
(76, 36, '2.2 Desarrollo de al menos un ', '2.2 Desarrollo de al menos un proyecto de investigación al año por departamento'),
(77, 36, '2.4 Acreditación de los proyec', '2.4 Acreditación de los proyectos de investigación '),
(78, 36, '2.5 Número de becas de investi', '2.5 Número de becas de investigación otorgados a docentes  de la Facultad de Ciencias Jurídicas'),
(79, 36, '2.7 Los proyectos de investiga', '2.7 Los proyectos de investigación son registrados en una base de datos única y sistematizados para su fácil acceso y consulta.'),
(80, 35, '2.5 Número de becas de investi', '2.5 Número de becas de investigación otorgados a docentes  de la Facultad de Ciencias Jurídicas'),
(81, 35, '2.6 Laboratorio de Investigaci', '2.6 Laboratorio de Investigación Forense instalado y en funcionamiento'),
(82, 36, '2.8 Al menos 7 investigaciones', '2.8 Al menos 7 investigaciones publicadas al año'),
(83, 36, '2.9 La facultad participa en p', '2.9 La facultad participa en por lo menos 4 eventos de publicación de investigaciones'),
(84, 36, '2.10 Número de revistas cientí', '2.10 Número de revistas científicas identificadas y contactadas con propósito de establecimiento de convenios'),
(85, 36, '2.11 El 100% docentes de la ca', '2.11 El 100% docentes de la carrera de Derecho han recibido un curso de apoyo a la IC o un diplomado en Investigación Científica'),
(86, 37, '6.4 Número de investigaciones ', '6.4 Número de investigaciones realizadas produzcan conocimiento actualizado y válido en el campo de las Ciencias Jurídicas'),
(87, 38, '14.5Número de redes de investi', '14.5Número de redes de investigación  y docencia integradas por las unidades académicas'),
(88, 36, '2.12 Número de organismos de c', '2.12 Número de organismos de cooperación nacional e internacional identificados con intención de una relación con convenio'),
(89, 36, '2.13 Número de pasantías inter', '2.13 Número de pasantías internacionales realizadas. '),
(90, 36, '2.14 Número de redes nacionale', '2.14 Número de redes nacionales de apoyo a la investigación en la que se participa'),
(91, 39, '1.2 Número de redes internas y', '1.2 Número de redes internas y externas de los sistemas que promueven la certificación y acreditación de carreras en los que participan las comisiones y unidades de la Facultad de Ciencias Jurídicas'),
(92, 36, '2.15 Número de redes internaci', '2.15 Número de redes internacionales de apoyo a la investigación en la que se participa'),
(93, 40, '6.4 Número de investigaciones ', '6.4 Número de investigaciones realizadas produzcan conocimiento actualizado y válido en el campo de las Ciencias Jurídicas'),
(94, 40, '6.5 Número de publicaciones re', '6.5 Número de publicaciones realizadas del conocimiento sistematizado de las investigaciones realizadas'),
(95, 41, '10.4 Número de proyectos de in', '10.4 Número de proyectos de investigación desarrollados por los posgrados'),
(96, 42, '13.2 100% de las unidades de l', '13.2 100% de las unidades de la Facultad de Ciencias Jurídicas presentan su planificación operativa anual'),
(97, 42, '13.3 100% de las unidades de l', '13.3 100% de las unidades de la Facultad de Ciencias Jurídicas presenta su Informe Trimestral de Seguimiento de Planificación Operativo Anual'),
(98, 43, '14.5Número de redes de investi', '14.5Número de redes de investigación  y docencia integradas por las unidades académicas'),
(101, 45, '3.6 Al menos una actividad anu', '3.6 Al menos una actividad anual de divulgación por cada carrera o unidad académica involucrada en el proceso de vinculación.  '),
(100, 45, '3.1 Número de grupos etarios a', '3.1 Número de grupos etarios atendidos por la Facultad de Ciencias Jurídicas con proyectos de aprendizaje de vinculación Universidad Sociedad ( por lo menos 10 por año)'),
(102, 45, '3.7  No. convenios de cooperac', '3.7  No. convenios de cooperación.'),
(103, 45, '3.8 Dos jornadas de intercambi', '3.8 Dos jornadas de intercambio de experiencias de procesos de vinculación, sistematizados y documentados para propiciar un encuentro regional.'),
(104, 45, '3.9 Número jornadas de capacit', '3.9 Número jornadas de capacitación en gestión redes y ejecución de proyectos de vinculación en red  con las diferentes unidades de la FCJ y la UNAH'),
(105, 46, '11.1Aplicado el Plan de Dotaci', '11.1Aplicado el Plan de Dotación de Recurso Tecnológico en la Facultad de Ciencias Jurídicas'),
(106, 46, '1.2 Aplicado el Plan Interno d', '1.2 Aplicado el Plan Interno de Desarrollo Físico en la Facultad de Ciencias Jurídicas'),
(107, 46, '11.4  Porcentaje de proyectos ', '11.4  Porcentaje de proyectos realizados con fondos de cooperación '),
(108, 46, '11.5 Equipo y material didácti', '11.5 Equipo y material didáctico adquirido '),
(109, 47, '11.6 100% de ejecución en pert', '11.6 100% de ejecución en pertinencia del presupuesto institucional asignado '),
(110, 48, '1.8 100% de desarrollo de la e', '1.8 100% de desarrollo de la estructura tecnológica y recursos humanos  necesarios'),
(111, 49, '3.4 Al menos un programa Educa', '3.4 Al menos un programa Educación No Formal en las unidades académicas con sus respectivas contrapartes.'),
(112, 50, '4.6 Número de espacios académi', '4.6 Número de espacios académicos ( conferencias, conversatorios, círculos de trabajo, redes) desarrollados.'),
(113, 51, '5.9 Graduados de la FCJ inclui', '5.9 Graduados de la FCJ incluidos en el Programa de Relevo Docente'),
(114, 52, '6.2 Desarrollo de al menos una', '6.2 Desarrollo de al menos una negociación de convenios y participación en redes por la FCJ'),
(115, 53, '7.3 Cinco eventos realizados p', '7.3 Cinco eventos realizados para fortalecer la identidad nacional , ciudadanía y abordar los problemas nacionales'),
(116, 54, '11.7 Sistema establecido y fun', '11.7 Sistema establecido y funcionando'),
(117, 55, '13.1 100% de los órganos de go', '13.1 100% de los órganos de gobierno de la Facultad de Ciencias Jurídicas establecidos y funcionando'),
(118, 55, '13.2 100% de las unidades de l', '13.2 100% de las unidades de la Facultad de Ciencias Jurídicas presentan su planificación operativa anual'),
(119, 55, '13.3 100% de las unidades de l', '13.3 100% de las unidades de la Facultad de Ciencias Jurídicas presenta su Informe Trimestral de Seguimiento de Planificación Operativo Anual'),
(120, 55, '13.7 Estrategias para el trata', '13.7 Estrategias para el tratamiento de clima organizacional definidas y aplicadas.    '),
(121, 56, '14.2 Proceso de acreditación c', '14.2 Proceso de acreditación completado al final del período.'),
(122, 56, '14.3 Número de alumnos y docen', '14.3 Número de alumnos y docentes que se benefician de oportunidades de estudio e intercambios académicos al año.                                                                                               '),
(123, 56, '14.4Número de personal adminis', '14.4Número de personal administrativo y de apoyo que se benefician de oportunidades de estudio e intercambios académicos en el año'),
(124, 57, '15.1 100% de fortalecimiento e', '15.1 100% de fortalecimiento en los órganos de dirección de la Facultad de CCJJ\n'),
(125, 57, '15.2 100% de los órganos de go', '15.2 100% de los órganos de gobierno académico conformados.'),
(126, 57, '15.5 100% de cumplimiento por ', '15.5 100% de cumplimiento por parte del personal docente y administrativo en la función académica y administrativa de acuerdo a la normativa universitaria\n'),
(127, 57, '15.6 Realizados al menos cuatr', '15.6 Realizados al menos cuatro encuentros académicos anuales entre autoridades y comunidad estudiantil\n'),
(128, 57, '15.7Realizados al menos dos en', '15.7Realizados al menos dos encuentros entre autoridades de la Facultad de CCJJ y la comunidad docente'),
(129, 58, '15.8 100% de comisiones de  di', '15.8 100% de comisiones de  dictámenes y propuesta de actualización y reformas de la normativa del nivel conformadas                                '),
(130, 58, '15.9 100% de Acuerdos ,dictáme', '15.9 100% de Acuerdos ,dictámenes y normativa armonizada y aprobados.'),
(131, 58, '15.10 Conformadas en un 100% l', '15.10 Conformadas en un 100% las redes de facultades y carreras de ciencias jurídicas  a nivel nacional y regional.'),
(133, 60, 'indicador febrero', 'na');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `motivos`
--

DROP TABLE IF EXISTS `motivos`;
CREATE TABLE IF NOT EXISTS `motivos` (
  `Motivo_ID` int(11) NOT NULL auto_increment,
  `descripcion` text,
  PRIMARY KEY  (`Motivo_ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Volcar la base de datos para la tabla `motivos`
--

INSERT INTO `motivos` (`Motivo_ID`, `descripcion`) VALUES
(6, 'Salud'),
(7, 'Familiares'),
(8, 'Laborales');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificaciones_folios`
--

DROP TABLE IF EXISTS `notificaciones_folios`;
CREATE TABLE IF NOT EXISTS `notificaciones_folios` (
  `Id_Notificacion` int(11) NOT NULL auto_increment,
  `NroFolio` varchar(25) NOT NULL,
  `IdEmisor` int(15) NOT NULL,
  `Titulo` text NOT NULL,
  `Cuerpo` text NOT NULL,
  `FechaCreacion` datetime NOT NULL,
  `IdUbicacionNotificacion` int(11) NOT NULL,
  `Estado` tinyint(4) NOT NULL,
  PRIMARY KEY  (`Id_Notificacion`,`IdEmisor`),
  KEY `fk_notificaciones_folios_folios_idx` (`NroFolio`),
  KEY `fk_usuario_notificaciones_idx` (`IdEmisor`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Volcar la base de datos para la tabla `notificaciones_folios`
--

INSERT INTO `notificaciones_folios` (`Id_Notificacion`, `NroFolio`, `IdEmisor`, `Titulo`, `Cuerpo`, `FechaCreacion`, `IdUbicacionNotificacion`, `Estado`) VALUES
(1, 'Of.FACES-SC-059', 2, 'Preguntar', 'Ingeniero dar segumiento', '2015-11-17 16:57:14', 2, 1),
(2, 'Of.FACES-SC-059', 2, 'Preguntar', 'Ingeniero dar segumiento', '2015-11-17 16:57:14', 2, 1),
(3, 'CCD-102-2015', 1, 'PROBANDO', 'probando', '2015-12-06 00:00:00', 1, 0),
(4, 'Oficio No.663-FCJ', 1, 'probando2', 'PROBANDO2', '2015-12-06 00:00:00', 1, 0),
(5, 'CCD-102-2015', 1, 'PROBANDO', 'probando', '2015-12-06 00:00:00', 1, 0),
(6, '2 libros/inv. Ciencias Es', 2, 'Delegación de representación evento.', 'Delegar representación en la Ab. Gloria Alvarado.', '2015-12-07 08:59:14', 2, 1),
(7, '2 libros/inv. Ciencias Es', 2, 'Delegación de representación evento.', 'Delegar representación en la Ab. Gloria Alvarado.', '2015-12-07 08:59:14', 2, 1),
(8, '$mensaje=', 12, 'prueba', 'Notificación de prueba a varios destinos', '2015-12-11 12:06:44', 2, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `objetivos_institucionales`
--

DROP TABLE IF EXISTS `objetivos_institucionales`;
CREATE TABLE IF NOT EXISTS `objetivos_institucionales` (
  `id_Objetivo` int(11) NOT NULL auto_increment,
  `definicion` text NOT NULL,
  `area_Estrategica` text NOT NULL,
  `resultados_Esperados` text NOT NULL,
  `id_Area` int(11) NOT NULL,
  `id_Poa` int(11) NOT NULL,
  PRIMARY KEY  (`id_Objetivo`),
  KEY `id_Area` (`id_Area`),
  KEY `id_Poa` (`id_Poa`),
  KEY `id_Area_2` (`id_Area`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=61 ;

--
-- Volcar la base de datos para la tabla `objetivos_institucionales`
--

INSERT INTO `objetivos_institucionales` (`id_Objetivo`, `definicion`, `area_Estrategica`, `resultados_Esperados`, `id_Area`, `id_Poa`) VALUES
(1, '   1.  Impulsar un proceso de desarrollo curricular siguiendo los lineamientos del Modelo Educativo de la UNAH en consonancia con las nuevas tendencias y diversidad educativa (formal, no formal y continua); se diseñaran currículos innovadores (abiertos, flexibles e incluyentes) acordes a estándares internacionales y que contaran con referentes axiológicos que orienten la selección de contenidos y la coherencia entre estos.', '   Mejoramiento de la Calidad Educativa. ', '   Certificada y acreditada las Carreras de la Facultad de Ciencias Jurídicas de acuerdo al sistema nacional y regional.\n\n2. La carrera de Derecho ofrece y cuenta con ofertas innovadoras dentro de sus planes de estudio formal y no formal para satisfacer y atraer la demanda.', 1, 1),
(2, 'Certificada y acreditada las Carreras de la Facultad de Ciencias Jurídicas de acuerdo al sistema nacional y regional legalmente reconocido por la UNAH y el nivel de Educación Superior', 'Mejoramiento de la Calidad Educativa. ', 'Certificada y acreditada las Carreras de la Facultad de Ciencias Jurídicas de acuerdo al sistema nacional y regional', 1, 2),
(3, 'Crear en la comunidad universitaria una cultura de compromiso social, a través de la construcción de redes y ámbitos de inserción con la sociedad hondureña, para construir vías de comunicación y de acción efectivas entre distintas comunidades y la Universidad, para construir participativamente valores, conocimientos y espacios de  mutuo aprendizaje.', 'Área Estratégica no. 2   Servicio Social y gestión del riesgo', 'Organizaciones, instituciones, comunidades y empresas que representan a la sociedad hondureña son beneficiarios de los proyectos de aprendizaje de vinculación Universidad-Sociedad que ejecutan los estudiantes de las carreras de la Facultad de Ciencias Jurídicas', 2, 2),
(4, '  Empoderar y formar de manera permanente al profesorado universitario en prácticas académicas innovadoras, alineadas con los objetivos académicos, estratégicos y del  Modelo Educativo de la Universidad, con el propósito que construyan las múltiples competencias para su transformación académica y la de los estudiantes (actualización, innovación, culturización) con valores y ética, en el plano docente, humanístico y disciplinar.', '  Fortalecimiento de las competencias docentes para la educación superior que faciliten el aprendizaje y mejoren la eficiencia terminal.', '  1) Docentes de la FCJ alcanzan  el conocimiento pedagógico por medio de las capacitaciones teórico / prácticas. \n\n2) Equipos de trabajo docente desarrollándose en el marco de una cultura de ética y de derechos humamos en los espacios de aprendizaje.\n\n3) Equipos de trabajo docente integradas en redes para el desarrollo de una cultura de ética y de derechos humanos en la Facultad de Ciencias Jurídicas. ', 3, 2),
(7, '1. Mejora continua y acreditación de la calidad de la UNAH, sus servicios y funciones sustantivas de docencia, investigación y vinculación universidad-sociedad. y programas;  evidenciada en la rendición de cuentas a la sociedad hondureña y en la atención oportuna efectiva y pertinente a las demandas auténticas de ésta. ', 'Mejoramiento de la Calidad y la Pertinencia.', 'Consolidada en todas las Unidades Académicas , el Sistema de Gestión de la Calidad educativa, con procesos permanentes  y sostenibles de autoevaluación y acreditación institucional', 8, 1),
(6, 'Empoderar y formar de manera permanente al profesorado universitario en prácticas académicas innovadoras, alineadas con los objetivos académicos, estratégicos y del  Modelo Educativo de la Universidad, con el propósito que construyan las múltiples competencias para su transformación académica y la de los estudiantes (actualización, innovación, culturización) con valores y ética, en el plano docente, humanístico y disciplinar.', 'Fortalecimiento de las competencias docentes para la educación superior que faciliten el aprendizaje y mejoren la eficiencia terminal.', 'Equipos de trabajo docente integradas en redes para el desarrollo de una cultura de ética y de derechos humanos en la Facultad de Ciencias Jurídicas', 3, 1),
(8, '2. Promover un sistema de aseguramiento de la calidad en la UNAH, con participación de todas las Unidades Académicas, Administrativas, Financieras y Logísticas.', 'Fortalecimiento de  la Planificación, Monitoria y Evaluación de la Gestión Académica.', 'Consolidadas las políticas de calidad académica de la Facultad de Ciencias Jurídicas', 8, 1),
(9, '1. Fortalecer la cultura de la Innovación Institucional y Educativa e implementar el modelo de innovación educativa de la UNAH, que integre el currículo, las metodologías, las estrategias de enseñanza y aprendizaje, los materiales y recursos didácticos, el uso educativo de las TIC, la relación con el entorno, la profesionalización docente, y la profesionalización de la dirección y conducción de la UNAH.', 'Aplicación del modelo de innovación educativa que integre como ámbitos de innovación educativa: el currículo, las metodologías, las estrategias de enseñanza y aprendizaje, los materiales y recursos didácticos, el uso educativo de las TIC, la relación con el entorno, la profesionalización docente y directiva.', 'La facultad de Ciencias Jurídicas  aplica el Modelo de Innovación Institucional y Educativa en sus carreras', 9, 1),
(10, 'Lograr un desarrollo institucional acorde con los ingresos económicos, de modo que se asegure su viabilidad futura, focalizado en el mejoramiento de la situación económico-financiera de la UNAH y su desarrollo a través de la generación de ingresos y del aumento a la productividad. Para ello se busca mejorar la eficiencia de los recursos e insumos, el crecimiento y mantenimiento de la infraestructura de acuerdo a las necesidades de la calidad y las perspectivas de expansión en un ambiente de calidad, acogedor, diverso y pluralista con una infraestructura de calidad, estéticamente atractiva e inserta en un entorno natural y cultural privilegiado que favorezca el trabajo académico y la convivencia social.', ' La infraestructura de las sedes universitarias en termino de aulas, salones, talleres, laboratorios, oficinas u otros, son suficientes y adecuados para el logro de los objetivos institucionales.', '  Los espacios físicos en el edificio de la Facultad de Ciencias Jurídicas son adecuados y suficientes para el desarrollo de todas las funciones académicas y administrativas y cuenta con acceso a la plataforma electrónica de la UNAH de forma eficiente y las aulas cuentan con la tecnología y mobiliario necesario. ', 11, 1),
(11, '2) Garantizar una educación integral, que incorpore la gestión académica del conocimiento, de cultura para el desarrollo, como parte de la dinámica institucional, y del perfil profesional, orientado al fortalecimiento de la ciudadano. ', '2. CIUDADANÍA: Expansión del perfil profesional con elementos de  ciudadanía educativa.', 'Fortalecido e incorporado en el currículo de la Carrera de Derecho y en el perfil profesional de los estudiantes la preocupación por los derechos humanos y la cultura', 7, 2),
(12, 'Promover de manera planificada el permanente desarrollo del talento  humano docente y administrativo de la UNAH en todo el ciclo vital, productivo y laboral: captación, selección, inducción, desempeño, despliegue de capacidades y potencialidades, capacitación, formación, distribución, egreso. y vínculo social e institucional; asegurando el relevo  en nuevos campos del conocimiento científico, técnico y humanístico.\n', 'Fortalecimiento Institucional mediante el desarrollo Docente y Personal Administrativo responde a las necesidades académicas y a lo establecido en la normativa institucional', 'Generar las condiciones necesarias para el ingreso, permanencia, formación integral del personal docente y administrativo y el relevo generacional tomando en consideración las necesidades institucionales y de los colaboradores de la Facultad de Ciencias Jurídicas, para consolidar servicios de calidad educativa favoreciendo la imagen de la UNAH.', 12, 1),
(13, 'Promover una política institucional de relaciones internacionales para ubicar a la UNAH en una posición de liderazgo en la educación superior.', 'a) Gestionar y promover movilidades internacionales en pro de la academia, la investigación y la cultura, con prioridad en el apoyo a los temas de Relevo Docente y mejora en las capacidades internas de las distintas unidades académicas de la UNAH.', '1. Carreras de la Facultad de Ciencias Jurídicas armonizadas académicamente con las tendencias de educación superior\n2. Carrera de Derecho acreditada nacional e internacionalmente', 14, 1),
(14, ' 1. Fortalecer la cultura de la Innovación Institucional y Educativa e implementar el modelo de innovación educativa de la UNAH, que integre el currículo, las metodologías, las estrategias de enseñanza y aprendizaje, los materiales y recursos didácticos, el uso educativo de las TIC, la relación con el entorno, la profesionalización docente, y la profesionalización de la dirección y conducción de la UNAH.', ' Aplicación del modelo de innovación educativa que integre como ámbitos de innovación educativa: el currículo, las metodologías, las estrategias de enseñanza y aprendizaje, los materiales y recursos didácticos, el uso educativo de las TIC, la relación con el entorno, la profesionalización docente y directiva.', 'La facultad de Ciencias Jurídicas  aplica el Modelo de Innovación Institucional y Educativa en sus carreras', 9, 2),
(15, 'Promover de manera planificada el permanente desarrollo del talento  humano docente y administrativo de la UNAH en todo el ciclo vital, productivo y laboral: captación, selección, inducción, desempeño, despliegue de capacidades y potencialidades, capacitación, formación, distribución, egreso. y vínculo social e institucional; asegurando el relevo  en nuevos campos del conocimiento científico, técnico y humanístico.', 'Fortalecimiento Institucional mediante el desarrollo Docente y Personal Administrativo responde a las necesidades académicas y a lo establecido en la normativa institucional', 'Consolidado un Plan Permanente de Desarrollo del Talento Humano en la Facultad de Ciencias Jurídicas', 12, 2),
(16, 'Fortalecer y consolidar el gobierno universitario, basando sus acciones y decisiones en los principios de Democracia, Respeto, Responsabilidad, Subsidiaridad, Transparencia y Rendición de cuentas.', 'a) Lograr que la UNAH lleve a cabo en forma sostenida y permanente, un ejercicio pleno y responsable del principio de autonomía, que le permita participar activamente en la transformación de la sociedad hondureña.', 'Fortalecida la estabilidad y consolidada la gobernabilidad.', 15, 2),
(17, 'Propiciar cambios en la calidad de vida y formación académica de los estudiantes universitarios; articulando procesos de orientación, asesoría, salud, cultura, deporte, estímulos académicos y atención diferenciada e inclusiva, con el fin de lograr el desarrollo estudiantil para el logro de su excelencia académica y profesional.', 'Brindar atención a los estudiantes universitarios de forma integral en su dimensión psico-pedagógica y social, que involucre aspectos interpersonales-afectivos, mediación de conflictos, orientación, asesoría, rendimiento académico, inducción vocacional y laboral. ', '1) Creada la Unidad de Estudiantes en la Facultad de Ciencias Jurídicas.\n\n2)  Disminuido el riesgo académico en los estudiantes de la Facultad de Ciencias Jurídicas.\n\n3) Generados los espacios de intercambio estudiantil, actividades socioculturales y deportivas para lograr la formación integral de los estudiantes de la Facultad de Ciencias Jurídicas.', 5, 2),
(18, 'Focalizar la inserción de los graduados universitarios en los mercados de trabajo, con miras al cambio, haciendo énfasis en el emprendedurismo, su seguimiento y actualización educativa profesional, con estudios de postgrado que sean pertinentes a las necesidades que enfrenta el país, al desarrollo de la ciencia y la tecnología y, a  la   actualización continua de los graduados.', 'Mejoramiento de la Calidad, la Pertinencia y la equidad.', 'Establecer mecanismos que faciliten  la inserción laboral de los graduados de la Facultad de Ciencias Jurídicas  en respuesta a las necesidades del mercado laboral y de país ', 5, 3),
(19, 'Gestionar y promover el conocimiento científico y social para contribuir a la superación de los principales problemas del país, para satisfacer las necesidades prioritarias y desplegar las potencialidades para el desarrollo humano sostenible a nivel local, nacional y regional a través de la movilidad y el intercambio, el uso de las TICs y funcionamiento de redes, entre otros.', 'a) Fortalecimiento y consolidación del proceso de organización y desarrollo de las redes educativas regionales de la UNAH, y de los planes estratégicos y tácticos para continuar con la reforma integral de los centros regionales de la UNAH.', 'Las unidades académicas participan en redes,  a través de la generación y promoción de la gestión del conocimiento. ', 6, 3),
(20, '1. Mejora continua y acreditación de la calidad de la UNAH, sus servicios y funciones sustantivas de docencia, investigación y vinculación universidad-sociedad. y programas;  evidenciada en la rendición de cuentas a la sociedad hondureña y en la atención oportuna efectiva y pertinente a las demandas auténticas de ésta. ', 'Mejoramiento de la Calidad y la Pertinencia.', 'Consolidada en todas las Unidades Académicas , el Sistema de Gestión de la Calidad educativa, con procesos permanentes  y sostenibles de autoevaluación y acreditación institucional.', 8, 3),
(21, '2. Promover un sistema de aseguramiento de la calidad en la UNAH, con participación de todas las Unidades Académicas, Administrativas, Financieras y Logísticas.', 'Fortalecimiento de  la Planificación, Monitoria y Evaluación de la Gestión Académica.', 'Consolidadas las políticas de calidad académica de la Facultad de Ciencias Jurídicas\n', 8, 3),
(22, 'Lograr un desarrollo institucional acorde con los ingresos económicos, de modo que se asegure su viabilidad futura, focalizado en el mejoramiento de la situación económico-financiera de la UNAH y su desarrollo a través de la generación de ingresos y del aumento a la productividad. Para ello se busca mejorar la eficiencia de los recursos e insumos, el crecimiento y mantenimiento de la infraestructura de acuerdo a las necesidades de la calidad y las perspectivas de expansión en un ambiente de calidad, acogedor, diverso y pluralista con una infraestructura de calidad, estéticamente atractiva e inserta en un entorno natural y cultural privilegiado que favorezca el trabajo académico y la convivencia social.', 'La infraestructura de las sedes universitarias en termino de aulas, salones, talleres, laboratorios, oficinas u otros, son suficientes y adecuados para el logro de los objetivos institucionales.', 'Desarrollo de proyectos ejecutados en la Facultad de Ciencias Jurídicas con financiamiento de cooperación externa', 11, 3),
(23, 'Contar con una gestión académica de calidad y pertinente a la complejidad de la UNAH, ágil, moderna y flexible que permita un apoyo efectivo al desarrollo de las funciones fundamentales de la Universidad y del proceso educativo; por medio de la formulación y aplicación a través de un sistema automatizado de políticas, normas y procedimientos académicos ; que orienta la planificación, organización, integración y control de los servicios de soporte a la docencia, investigación, vinculación universidad-sociedad, gestión del conocimiento, y la monitoria y evaluación de dichas funciones, con un enfoque de gestión basada en resultados y evaluación de alcances.', 'Mejoramiento de la Calidad, la Pertinencia y la Equidad.', 'Se desarrolla un tratamiento sistemático y continuo de las dimensiones de la gestión académica en la vida funcional de la Facultad de Ciencias Jurídicas', 13, 3),
(24, ' Fortalecer y consolidar el gobierno universitario, basando sus acciones y decisiones en los principios de Democracia, Respeto, Responsabilidad, Subsidiaridad, Transparencia y Rendición de cuentas.', ' a) Lograr que la UNAH lleve a cabo en forma sostenida y permanente, un ejercicio pleno y responsable del principio de autonomía, que le permita participar activamente en la transformación de la sociedad hondureña.', '1. Consolidada la gobernabilidad por los procesos de reforma y gestión por parte de las autoridades a efecto de rescatar la confianza, el respeto y el reconocimiento de la comunidad hondureña e internacional\n2. Realizadas las acciones de gestión que fortalezcan la vinculación de las autoridades universitarias con los docentes, los estudiantes y en general los trabajadores de la institución.\n\n', 15, 3),
(25, 'Fortalecer y consolidar las responsabilidades de la UNAH en el papel de organizar, dirigir y desarrollar la educación superior del país.', 'b) Fortalecer la atribución que la Constitución de la República le otorga a la UNAH de organizar, dirigir y desarrollar la educación superior y profesional.', 'Sistema de educación superior regularizado en términos de calidad y pertinencia.', 15, 3),
(26, 'Focalizar la inserción de los graduados universitarios en los mercados de trabajo, con miras al cambio, haciendo énfasis en el emprendedurismo, su seguimiento y actualización educativa profesional, con estudios de postgrado que sean pertinentes a las necesidades que enfrenta el país, al desarrollo de la ciencia y la tecnología y, a  la   actualización continua de los graduados.', 'Mejoramiento de la Calidad, la Pertinencia y la equidad.', 'Establecido un Programa Integral  para la Empleabilidad y Formación continua de los egresados', 5, 2),
(27, '1. Mejora continua y acreditación de la calidad de la UNAH, sus servicios y funciones sustantivas de docencia, investigación y vinculación universidad-sociedad. y programas;  evidenciada en la rendición de cuentas a la sociedad hondureña y en la atención oportuna efectiva y pertinente a las demandas auténticas de ésta. ', 'Mejoramiento de la Calidad y la Pertinencia.', 'Consolidada en todas las Unidades Académicas , el Sistema de Gestión de la Calidad educativa, con procesos permanentes  y sostenibles de autoevaluación y acreditación institucional.', 8, 2),
(28, '2. Promover un sistema de aseguramiento de la calidad en la UNAH, con participación de todas las Unidades Académicas, Administrativas, Financieras y Logísticas.', 'Fortalecimiento de  la Planificación, Monitoria y Evaluación de la Gestión Académica.', 'Consolidadas las políticas de calidad académica de la Facultad de Ciencias Jurídicas', 8, 2),
(29, 'Crear en la comunidad universitaria una cultura de compromiso social, a través de la construcción de redes y ámbitos de inserción con la sociedad hondureña, para construir vías de comunicación y de acción efectivas entre distintas comunidades y la Universidad, para construir participativamente valores, conocimientos y espacios de  mutuo aprendizaje.', 'Área Estratégica no. 2   Servicio Social y gestión del riesgo', '1) Práctica supervisada y la Práctica Jurídica Forense obligatoria  de la carrera de Derecho  y otras  carreras contribuyen  a la sociedad en la resolución de  casos concretos  según problemática abordada.\n\n2) Servicios y beneficios de los programas de vinculación Universidad-Sociedad son promovidos en las diferentes facultades y medios de comunicación .', 2, 4),
(30, ' 2) Garantizar una educación integral, que incorpore la gestión académica del conocimiento, de cultura para el desarrollo, como parte de la dinámica institucional, y del perfil profesional, orientado al fortalecimiento de la ciudadano. ', ' 2. CIUDADANÍA: Expansión del perfil profesional con elementos de  ciudadanía educativa.', 'Fortalecido e incorporado en el currículo de la Carrera de Derecho y en el perfil profesional de los estudiantes la preocupación por los derechos humanos y la cultura', 7, 4),
(31, 'Contar con una gestión académica de calidad y pertinente a la complejidad de la UNAH, ágil, moderna y flexible que permita un apoyo efectivo al desarrollo de las funciones fundamentales de la Universidad y del proceso educativo; por medio de la formulación y aplicación a través de un sistema automatizado de políticas, normas y procedimientos académicos ; que orienta la planificación, organización, integración y control de los servicios de soporte a la docencia, investigación, vinculación universidad-sociedad, gestión del conocimiento, y la monitoria y evaluación de dichas funciones, con un enfoque de gestión basada en resultados y evaluación de alcances.', 'Mejoramiento de la Calidad, la Pertinencia y la Equidad.', 'Se desarrolla un tratamiento sistemático y continuo de las dimensiones de la gestión académica en la vida funcional de la Facultad de Ciencias Jurídicas', 13, 4),
(32, 'Consolidar el sistema de investigación científica y tecnológica de la UNAH, para posicionarse en una situación de liderazgo nacional y regional, tanto del conocimiento como de sus aplicaciones, desarrollando una investigación de impacto nacional y con reconocimiento internacional, ampliamente integrada a la docencia, especialmente al postgrado y vinculada a la solución de problemas, promoviendo sustantivamente el desarrollo del país.', 'a) Desarrollar mecanismos de fomento de la investigación, con acciones de promoción de actividades para reconocer, estimular y fortalecer la investigación científica, el desarrollo tecnológico y la innovación, en el marco de las prioridades de investigación.', 'La Facultad de Ciencias Jurídicas cuenta con un sistema de investigación  jurídica que es un referente académico en las propuestas de solución a problemáticas nacionales', 4, 5),
(33, '2) Garantizar una educación integral, que incorpore la gestión académica del conocimiento, de cultura para el desarrollo, como parte de la dinámica institucional, y del perfil profesional, orientado al fortalecimiento de la ciudadano. ', '2. CIUDADANÍA: Expansión del perfil profesional con elementos de  ciudadanía educativa.', 'Fortalecido e incorporado en el currículo de la Carrera de Derecho y en el perfil profesional de los estudiantes la preocupación por los derechos humanos y la cultura', 7, 5),
(34, 'Posicionar a la UNAH como una institución líder en la formación de posgrados a nivel nacional, generando una oferta de posgrados de estricta pertinencia con las necesidades de conocimiento que los distintos sectores de la sociedad hondureña requieren, lo que unido a la calidad de los programas y a su capacidad de actualización, están en consonancia con los desafíos de crecimiento y desarrollo del país y la región.', 'A) Las facultades y centros regionales se insertan en el eje de Los posgrados, la UNAH y el país; diseñando, posgrados que el país, la ciencia y la propia universidad necesitan, contribuyendo de esa  manera al desarrollo económico, político y social de nuestro país.', '1. Ampliada la oferta de nuevas carreras de posgrados en la Facultad de Ciencias Jurídicas que satisfacen la demanda de la sociedad hondureña y contribuyan al desarrollo económico, político y social de nuestro país.\n2. Carreras de posgrados de la Facultad de Ciencias Jurídicas Acreditadas\n3. Integradas las diferentes carreras de posgrados de la Facultad de Ciencias Jurídicas en la producción, publicación y divulgación del conocimiento jurídico generando mediante la investigación científica\n4. Desarrollada la vinculación de la Facultad de Ciencias Jurídicas con la sociedad hondureña a través de los proyectos de vus impulsados por las carreras de posgrados, contribuyendo de esa manera al desarrollo del país\n5. Integrados los docentes y estudiantes de las carreras de posgrados de la Facultad de Ciencias Jurídicas a los proceso de regionalización e internacionalización de la educación', 10, 5),
(35, 'Consolidar el sistema de investigación científica y tecnológica de la UNAH, para posicionarse en una situación de liderazgo nacional y regional, tanto del conocimiento como de sus aplicaciones, desarrollando una investigación de impacto nacional y con reconocimiento internacional, ampliamente integrada a la docencia, especialmente al postgrado y vinculada a la solución de problemas, promoviendo sustantivamente el desarrollo del país.', 'a) Desarrollar mecanismos de fomento de la investigación, con acciones de promoción de actividades para reconocer, estimular y fortalecer la investigación científica, el desarrollo tecnológico y la innovación, en el marco de las prioridades de investigación.', '1) La Facultad de Ciencias Jurídicas cuenta con un sistema de investigación  jurídica que es un referente académico en las propuestas de solución a problemáticas nacionales.\n\n2) En funcionamiento el Laboratorio de Investigación Forense en la Facultad de Ciencias Jurídicas.', 4, 6),
(36, 'Consolidar el sistema de investigación científica y tecnológica de la UNAH, para posicionarse en una situación de liderazgo nacional y regional, tanto del conocimiento como de sus aplicaciones, desarrollando una investigación de impacto nacional y con reconocimiento internacional, ampliamente integrada a la docencia, especialmente al postgrado y vinculada a la solución de problemas, promoviendo sustantivamente el desarrollo del país.', 'a) Desarrollar mecanismos de fomento de la investigación, con acciones de promoción de actividades para reconocer, estimular y fortalecer la investigación científica, el desarrollo tecnológico y la innovación, en el marco de las prioridades de investigación.', '1. La Facultad de Ciencias Jurídicas cuenta con un sistema de investigación  jurídica que es un referente académico en las propuestas de solución a problemáticas nacionales\n2. Los usuarios tienen acceso a los proyectos de investigación realizados en la FCJ mediante una base de datos organizada\n3. La FCJ es reconocida por la publicación de los resultados de las investigaciones realizadas en medios nacionales e internacionales, y en  (foros, conversatorios, simposios, talleres) nacionales e internacionales\n4.La Facultad de Ciencias Jurídicas cuenta con un sistema de investigación  jurídica que es un referente académico en las propuestas de solución a problemáticas nacionales\n5. Fortalecido e incentivado el quehacer de la investigación en la facultad \n', 4, 7),
(37, 'Gestionar y promover el conocimiento científico y social para contribuir a la superación de los principales problemas del país, para satisfacer las necesidades prioritarias y desplegar las potencialidades para el desarrollo humano sostenible a nivel local, nacional y regional a través de la movilidad y el intercambio, el uso de las TICs y funcionamiento de redes, entre otros.', 'a) Fortalecimiento y consolidación del proceso de organización y desarrollo de las redes educativas regionales de la UNAH, y de los planes estratégicos y tácticos para continuar con la reforma integral de los centros regionales de la UNAH.', 'Generado conocimiento científico actualizado y valido en la Facultad de Ciencias Jurídicas que aporta soluciones a las problemáticas del país', 6, 6),
(38, 'Promover una política institucional de relaciones internacionales para ubicar a la UNAH en una posición de liderazgo en la educación superior.', 'b) Fortalecer la capacidad institucional en elaboración, presentación y negociación de iniciativas de cooperación para potenciar la labor docente, la investigación científica, las actividades de apoyo de la UNAH a la sociedad, la formación integral de los estudiantes y docentes, la infraestructura y la cooperación al desarrollo.', 'Unidades académicas integradas en redes de investigación y docencia nacionales e internacionales', 14, 6),
(39, '1.  Impulsar un proceso de desarrollo curricular siguiendo los lineamientos del Modelo Educativo de la UNAH en consonancia con las nuevas tendencias y diversidad educativa (formal, no formal y continua); se diseñaran currículos innovadores (abiertos, flexibles e incluyentes) acordes a estándares internacionales y que contaran con referentes axiológicos que orienten la selección de contenidos y la coherencia entre estos.', 'Mejoramiento de la Calidad Educativa. ', 'Certificada y acreditada las Carreras de la Facultad de Ciencias Jurídicas de acuerdo al sistema nacional y regional', 1, 8),
(40, 'Gestionar y promover el conocimiento científico y social para contribuir a la superación de los principales problemas del país, para satisfacer las necesidades prioritarias y desplegar las potencialidades para el desarrollo humano sostenible a nivel local, nacional y regional a través de la movilidad y el intercambio, el uso de las TICs y funcionamiento de redes, entre otros.', 'a) Fortalecimiento y consolidación del proceso de organización y desarrollo de las redes educativas regionales de la UNAH, y de los planes estratégicos y tácticos para continuar con la reforma integral de los centros regionales de la UNAH.', 'Generado conocimiento científico actualizado y valido en la Facultad de Ciencias Jurídicas que aporta soluciones a las problemáticas del país', 4, 7),
(41, 'Posicionar a la UNAH como una institución líder en la formación de posgrados a nivel nacional, generando una oferta de posgrados de estricta pertinencia con las necesidades de conocimiento que los distintos sectores de la sociedad hondureña requieren, lo que unido a la calidad de los programas y a su capacidad de actualización, están en consonancia con los desafíos de crecimiento y desarrollo del país y la región.', 'D) Las facultades y centros regionales se insertan en el eje de Investigación, desarrollo e innovación; integrando la función de investigación en sus diferentes posgrados y que estos aprovechen el programa de investigación que oferta la UNAH (becas, capacitaciones, revistas, congresos)  y la estructura de investigación de la UNAH (institutos, grupos, observatorios) todo ello en alineamiento con las prioridades de investigación de la UNAH y de las facultades y centros regionales.', 'Integradas las diferentes carreras de posgrados de la Facultad de Ciencias Jurídicas en la producción, publicación y divulgación del conocimiento jurídico generando mediante la investigación científica', 10, 7),
(42, 'Contar con una gestión académica de calidad y pertinente a la complejidad de la UNAH, ágil, moderna y flexible que permita un apoyo efectivo al desarrollo de las funciones fundamentales de la Universidad y del proceso educativo; por medio de la formulación y aplicación a través de un sistema automatizado de políticas, normas y procedimientos académicos ; que orienta la planificación, organización, integración y control de los servicios de soporte a la docencia, investigación, vinculación universidad-sociedad, gestión del conocimiento, y la monitoria y evaluación de dichas funciones, con un enfoque de gestión basada en resultados y evaluación de alcances.', 'Mejoramiento de la Calidad, la Pertinencia y la Equidad.', 'Se desarrolla un tratamiento sistemático y continuo de las dimensiones de la gestión académica en la vida funcional de la Facultad de Ciencias Jurídicas', 13, 7),
(43, 'Promover una política institucional de relaciones internacionales para ubicar a la UNAH en una posición de liderazgo en la educación superior.', 'b) Fortalecer la capacidad institucional en elaboración, presentación y negociación de iniciativas de cooperación para potenciar la labor docente, la investigación científica, las actividades de apoyo de la UNAH a la sociedad, la formación integral de los estudiantes y docentes, la infraestructura y la cooperación al desarrollo.', 'Unidades académicas integradas en redes de investigación y docencia nacionales e internacionales', 14, 7),
(45, 'Crear en la comunidad universitaria una cultura de compromiso social, a través de la construcción de redes y ámbitos de inserción con la sociedad hondureña, para construir vías de comunicación y de acción efectivas entre distintas comunidades y la Universidad, para construir participativamente valores, conocimientos y espacios de  mutuo aprendizaje.', 'Área Estratégica no. 2   Servicio Social y gestión del riesgo', '1) Organizaciones, instituciones, comunidades y empresas que representan a la sociedad hondureña son beneficiarios de los proyectos de aprendizaje de vinculación Universidad-Sociedad que ejecutan los estudiantes de las carreras de la Facultad de Ciencias Jurídicas.\n\n2) Carreras realizan actividades para divulgar los proyectos de vinculación (en el marco de las Semanas Departamentales), sistematizando y divulgando las experiencias obtenidas en los proyectos del Servicio Comunitario.\n\n3) Iniciativas de convenios suscritos entre la UNAH e instancias de la sociedad civil, el Estado, los gobiernos locales, el sector productivo y de cooperación.\n\n4) La Facultad de Ciencias Jurídicas participa y promueve el intercambio de experiencias y buenas prácticas en el quehacer de vinculación Universidad-Sociedad entre otras facultades de la UNAH y Centros Regionales.', 2, 8),
(46, 'Lograr un desarrollo institucional acorde con los ingresos económicos, de modo que se asegure su viabilidad futura, focalizado en el mejoramiento de la situación económico-financiera de la UNAH y su desarrollo a través de la generación de ingresos y del aumento a la productividad. Para ello se busca mejorar la eficiencia de los recursos e insumos, el crecimiento y mantenimiento de la infraestructura de acuerdo a las necesidades de la calidad y las perspectivas de expansión en un ambiente de calidad, acogedor, diverso y pluralista con una infraestructura de calidad, estéticamente atractiva e inserta en un entorno natural y cultural privilegiado que favorezca el trabajo académico y la convivencia social.', 'La infraestructura de las sedes universitarias en termino de aulas, salones, talleres, laboratorios, oficinas u otros, son suficientes y adecuados para el logro de los objetivos institucionales.', '1)  Los espacios físicos en el edificio de la Facultad de Ciencias Jurídicas son adecuados y suficientes para el desarrollo de todas las funciones académicas y administrativas y cuenta con acceso a la plataforma electrónica de la UNAH de forma eficiente y las aulas cuentan con la tecnología y mobiliario necesario. \n\n2) Desarrollo de proyectos ejecutados en la Facultad de Ciencias Jurídicas con financiamiento de cooperación externa.\n\n3) Satisfechas las necesidades de material didáctico en las carreras y departamentos académicos que facilitan el proceso del desarrollo educativo.', 11, 9),
(47, 'nnovar, crear y mejorar la gestión administrativa-financiera, en función de la actividad académica y de los diferentes insumos y recursos institucionales, y aquellos que se generen por las diferentes unidades, aplicando procesos administrativos y principios de eficiencia, eficacia, oportunidad, transparencia y rendición de cuentas en todos los actos de la UNAH.', 'La unidad académica cuenta con un presupuesto que le permite realizar adecuadamente las funciones de docencia, investigación, vinculación y gestión académica programadas por la carrera.', 'Ejecutado el presupuesto asignado a la Facultad de Ciencias Jurídicas, con pertinencia ', 11, 9),
(48, '2) Consolidar la aplicación de la política de bimodalidad en la UNAH.', 'Mejoramiento de la Calidad Educativa. ', 'La Facultad de Ciencias Jurídicas ofrece asignaturas bajo la política de bimodalidad para generar acceso y equidad en los hondureños', 1, 10),
(49, 'Crear en la comunidad universitaria una cultura de compromiso social, a través de la construcción de redes y ámbitos de inserción con la sociedad hondureña, para construir vías de comunicación y de acción efectivas entre distintas comunidades y la Universidad, para construir participativamente valores, conocimientos y espacios de  mutuo aprendizaje.', 'Área estratégica no. 3 Educación No Formal', 'Integrados los programas y planes para la implementación de los servicios de educación no formal a nivel de diplomados, cursos libres, talleres, seminarios, conferencias, con las unidades académicas y en alianza con otros actores de la sociedad.', 0, 10),
(50, 'Empoderar y formar de manera permanente al profesorado universitario en prácticas académicas innovadoras, alineadas con los objetivos académicos, estratégicos y del  Modelo Educativo de la Universidad, con el propósito que construyan las múltiples competencias para su transformación académica y la de los estudiantes (actualización, innovación, culturización) con valores y ética, en el plano docente, humanístico y disciplinar.', 'Fortalecimiento de las competencias docentes para la educación superior que faciliten el aprendizaje y mejoren la eficiencia terminal.', 'Equipos de trabajo docente integradas en redes para el desarrollo de una cultura de ética y de derechos humanos en la Facultad de Ciencias Jurídicas', 3, 10),
(51, 'Velar y promover de manera efectiva, la inclusión de los Graduados Universitarios calificados para el relevo docente ( entre otros, reorientado y fortaleciendo a través de un nuevo Reglamento, a los Instructores).', 'Fortalecimiento de la Calidad.', 'Graduados de la Facultad de Ciencias Jurídicas incluidos en el Relevo Docente', 5, 10),
(52, 'Gestionar y promover el conocimiento científico y social para contribuir a la superación de los principales problemas del país, para satisfacer las necesidades prioritarias y desplegar las potencialidades para el desarrollo humano sostenible a nivel local, nacional y regional a través de la movilidad y el intercambio, el uso de las TICs y funcionamiento de redes, entre otros.', 'a) Fortalecimiento y consolidación del proceso de organización y desarrollo de las redes educativas regionales de la UNAH, y de los planes estratégicos y tácticos para continuar con la reforma integral de los centros regionales de la UNAH.', 'Las unidades académicas participan en redes,  a través de la generación y promoción de la gestión del conocimiento. ', 6, 10),
(53, '2) Garantizar una educación integral, que incorpore la gestión académica del conocimiento, de cultura para el desarrollo, como parte de la dinámica institucional, y del perfil profesional, orientado al fortalecimiento de la ciudadano. ', '2. CIUDADANÍA: Expansión del perfil profesional con elementos de  ciudadanía educativa.', 'Fortalecido e incorporado en el currículo de la Carrera de Derecho y en el perfil profesional de los estudiantes la preocupación por los derechos humanos y la cultura', 7, 10),
(54, ' Innovar, crear y mejorar la gestión administrativa-financiera, en función de la actividad académica y de los diferentes insumos y recursos institucionales, y aquellos que se generen por las diferentes unidades, aplicando procesos administrativos y principios de eficiencia, eficacia, oportunidad, transparencia y rendición de cuentas en todos los actos de la UNAH.', ' La institución cuenta con la normativa interna e institucional para garantizar la buena organización, el buen funcionamiento y el cumplimiento de las normas y procedimientos.', 'Implementado el sistema tecnificado para el control y uso eficiente de los recursos en la facultad de Ciencias Jurídicas', 11, 10),
(55, 'Contar con una gestión académica de calidad y pertinente a la complejidad de la UNAH, ágil, moderna y flexible que permita un apoyo efectivo al desarrollo de las funciones fundamentales de la Universidad y del proceso educativo; por medio de la formulación y aplicación a través de un sistema automatizado de políticas, normas y procedimientos académicos ; que orienta la planificación, organización, integración y control de los servicios de soporte a la docencia, investigación, vinculación universidad-sociedad, gestión del conocimiento, y la monitoria y evaluación de dichas funciones, con un enfoque de gestión basada en resultados y evaluación de alcances.', 'Mejoramiento de la Calidad, la Pertinencia y la Equidad.', '1) Se desarrolla un tratamiento sistemático y continuo de las dimensiones de la gestión académica en la vida funcional de la Facultad de Ciencias Jurídicas.\n\n2) Definidas las estrategias para el tratamiento del clima organizacional.', 13, 10),
(56, 'Promover una política institucional de relaciones internacionales para ubicar a la UNAH en una posición de liderazgo en la educación superior.', 'a) Gestionar y promover movilidades internacionales en pro de la academia, la investigación y la cultura, con prioridad en el apoyo a los temas de Relevo Docente y mejora en las capacidades internas de las distintas unidades académicas de la UNAH.', '1) Carrera de Derecho acreditada nacional e internacionalmente.\n\n2) Docentes, alumnos y personal administrativo y de apoyo beneficiados con estudios e intercambio académicos en el extranjero.', 14, 10),
(57, 'Fortalecer y consolidar el gobierno universitario, basando sus acciones y decisiones en los principios de Democracia, Respeto, Responsabilidad, Subsidiaridad, Transparencia y Rendición de cuentas.', 'a) Lograr que la UNAH lleve a cabo en forma sostenida y permanente, un ejercicio pleno y responsable del principio de autonomía, que le permita participar activamente en la transformación de la sociedad hondureña.', '1) Fortalecida la estabilidad y consolidada la gobernabilidad..\n\n2) Consolidada la gobernabilidad por los procesos de reforma y gestión por parte de las autoridades a efecto de rescatar la confianza, el respeto y el reconocimiento de la comunidad hondureña e internacional.\n\n3) Realizadas las acciones de gestión que fortalezcan la vinculación de las autoridades universitarias con los docentes, los estudiantes y en general los trabajadores de la institución.', 15, 10),
(58, 'Fortalecer y consolidar las responsabilidades de la UNAH en el papel de organizar, dirigir y desarrollar la educación superior del país.', 'b) Fortalecer la atribución que la Constitución de la República le otorga a la UNAH de organizar, dirigir y desarrollar la educación superior y profesional.', 'Sistema de educación superior regularizado en términos de calidad y pertinencia.', 15, 10),
(60, 'objetivo febrero', 'area estrategica febrero', 'febrero', 1, 12);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `organizacion`
--

DROP TABLE IF EXISTS `organizacion`;
CREATE TABLE IF NOT EXISTS `organizacion` (
  `Id_Organizacion` int(11) NOT NULL auto_increment,
  `NombreOrganizacion` text NOT NULL,
  `Ubicacion` text NOT NULL,
  PRIMARY KEY  (`Id_Organizacion`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Volcar la base de datos para la tabla `organizacion`
--


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pais`
--

DROP TABLE IF EXISTS `pais`;
CREATE TABLE IF NOT EXISTS `pais` (
  `Id_pais` int(11) NOT NULL auto_increment,
  `Nombre_pais` text NOT NULL,
  PRIMARY KEY  (`Id_pais`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=216 ;

--
-- Volcar la base de datos para la tabla `pais`
--

INSERT INTO `pais` (`Id_pais`, `Nombre_pais`) VALUES
(1, 'Afganistán'),
(2, 'Albania'),
(3, 'Alemania'),
(4, 'Andorra'),
(5, 'Angola'),
(6, 'Antigua y Barbuda'),
(7, 'Antillas Holandesas'),
(8, 'Arabia Saudí'),
(9, 'Argelia'),
(10, 'Argentina'),
(11, 'Armenia'),
(12, 'Aruba'),
(13, 'Australia'),
(14, 'Austria'),
(15, 'Azerbaiyán'),
(16, 'Bahamas'),
(17, 'Bahrein'),
(18, 'Bangladesh'),
(19, 'Barbados'),
(20, 'Bélgica'),
(21, 'Belice'),
(22, 'Benín'),
(23, 'Bermudas'),
(24, 'Bielorrusia'),
(25, 'Bolivia'),
(26, 'Botswana'),
(27, 'Bosnia'),
(28, 'Brasil'),
(29, 'Brunei'),
(30, 'Bulgaria'),
(31, 'Burkina Faso'),
(32, 'Burundi'),
(33, 'Bután'),
(34, 'Cabo Verde'),
(35, 'Camboya'),
(36, 'Camerún'),
(37, 'Canadá'),
(38, 'Catar'),
(39, 'Chad'),
(40, 'Chile'),
(41, 'China'),
(42, 'Chipre'),
(43, 'Colombia'),
(44, 'Comoras'),
(45, 'Congo'),
(46, 'Corea del Norte'),
(47, 'Corea del Sur'),
(48, 'Costa de Marfil'),
(49, 'Costa Rica'),
(50, 'Croacia'),
(51, 'Cuba'),
(52, 'Dinamarca'),
(53, 'Dominica'),
(54, 'Dubai'),
(55, 'Ecuador'),
(56, 'Egipto'),
(57, 'El Salvador'),
(58, 'Emiratos Árabes Unidos'),
(59, 'Eritrea'),
(60, 'Eslovaquia'),
(61, 'Eslovenia'),
(62, 'España'),
(63, 'Estados Unidos de América'),
(64, 'Estonia'),
(65, 'Etiopía'),
(66, 'Fiyi'),
(67, 'Filipinas'),
(68, 'Finlandia'),
(69, 'Francia'),
(70, 'Gabón'),
(71, 'Gambia'),
(72, 'Georgia'),
(73, 'Ghana'),
(74, 'Grecia'),
(75, 'Guam'),
(76, 'Guatemala'),
(77, 'Guayana Francesa'),
(78, 'Guinea-Bissau'),
(79, 'Guinea Ecuatorial'),
(80, 'Guinea'),
(81, 'Guyana'),
(82, 'Granada'),
(83, 'Haití'),
(84, 'Honduras'),
(85, 'Hong Kong'),
(86, 'Hungría'),
(87, 'Holanda'),
(88, 'India'),
(89, 'Indonesia'),
(90, 'Irak'),
(91, 'Irán'),
(92, 'Irlanda'),
(93, 'Islandia'),
(94, 'Islas Caimán'),
(95, 'Islas Marshall'),
(96, 'Islas Pitcairn'),
(97, 'Islas Salomón'),
(98, 'Israel'),
(99, 'Italia'),
(100, 'Jamaica'),
(101, 'Japón'),
(102, 'Jordania'),
(103, 'Kazajstán'),
(104, 'Kenia'),
(105, 'Kirguistán'),
(106, 'Kiribati'),
(107, 'Kósovo'),
(108, 'Kuwait'),
(109, 'Laos'),
(110, 'Lesotho'),
(111, 'Letonia'),
(112, 'Líbano'),
(113, 'Liberia'),
(114, 'Libia'),
(115, 'Liechtenstein'),
(116, 'Lituania'),
(117, 'Luxemburgo'),
(118, 'Macedonia'),
(119, 'Madagascar'),
(120, 'Malasia'),
(121, 'Malawi'),
(122, 'Maldivas'),
(123, 'Malí'),
(124, 'Malta'),
(125, 'Marianas del Norte'),
(126, 'Marruecos'),
(127, 'Mauricio'),
(128, 'Mauritania'),
(129, 'México'),
(130, 'Micronesia'),
(131, 'Mónaco'),
(132, 'Moldavia'),
(133, 'Mongolia'),
(134, 'Montenegro'),
(135, 'Mozambique'),
(136, 'Myanmar (antes Birmania)'),
(137, 'Namibia'),
(138, 'Nauru'),
(139, 'Nepal'),
(140, 'Nicaragua'),
(141, 'Níger'),
(142, 'Nigeria'),
(143, 'Noruega'),
(144, 'Nueva Zelanda'),
(145, 'Omán'),
(146, 'Orden de Malta'),
(147, 'Países Bajos'),
(148, 'Pakistán'),
(149, 'Palestina'),
(150, 'Palau'),
(151, 'Panamá'),
(152, 'Papúa Nueva Guinea'),
(153, 'Paraguay'),
(154, 'Perú'),
(155, 'Polonia'),
(156, 'Portugal'),
(157, 'Puerto Rico'),
(158, 'Reino Unido'),
(159, 'República Centroafricana'),
(160, 'República Checa'),
(161, 'República del Congo'),
(162, 'República Democrática del Congo (antiguo Zaire)'),
(163, 'República Dominicana'),
(164, 'Ruanda'),
(165, 'Rumania'),
(166, 'Rusia'),
(167, 'Sáhara Occidental'),
(168, 'Samoa Americana'),
(169, 'Samoa'),
(170, 'San Cristóbal y Nieves'),
(171, 'San Marino'),
(172, 'Santa Lucía'),
(173, 'Santo Tomé y Príncipe'),
(174, 'San Vicente y las Granadinas'),
(175, 'Senegal'),
(176, 'Serbia'),
(177, 'Seychelles'),
(178, 'Sierra Leona'),
(179, 'Singapur'),
(180, 'Siria'),
(181, 'Somalia'),
(182, 'Sri Lanka (antes Ceilán)'),
(183, 'Sudáfrica'),
(184, 'Sudán'),
(185, 'Suecia'),
(186, 'Suiza'),
(187, 'Suazilandia'),
(188, 'Tailandia'),
(189, 'Taiwán o Formosa (República Nacionalista China)'),
(190, 'Tanzania'),
(191, 'Tayikistán'),
(192, 'Tíbet (actualmente bajo soberanía China)'),
(193, 'Timor Oriental (antiguamente ocupado por Indonesia)'),
(194, 'Togo'),
(195, 'Tonga'),
(196, 'Trinidad y Tobago'),
(197, 'Túnez'),
(198, 'Turkmenistán'),
(199, 'Turquía'),
(200, 'Tuvalu'),
(201, 'Ucrania'),
(202, 'Uganda'),
(203, 'Uruguay'),
(204, 'Uzbequistán'),
(205, 'Vanuatu'),
(206, 'Vaticano'),
(207, 'Venezuela'),
(208, 'Vietnam'),
(209, 'Wallis y Futuna'),
(210, 'Yemen'),
(211, 'Yibuti'),
(212, 'Zambia'),
(213, 'Zaire'),
(214, 'Zimbabue');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permisos`
--

DROP TABLE IF EXISTS `permisos`;
CREATE TABLE IF NOT EXISTS `permisos` (
  `id_Permisos` int(11) NOT NULL auto_increment,
  `id_departamento` int(11) NOT NULL,
  `No_Empleado` varchar(20) NOT NULL,
  `id_motivo` int(11) NOT NULL,
  `dias_permiso` int(11) NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_finalizacion` time NOT NULL,
  `fecha` datetime NOT NULL,
  `fecha_solicitud` date NOT NULL,
  `estado` varchar(15) default NULL,
  `observacion` varchar(200) default NULL,
  `revisado_por` varchar(15) default NULL,
  `id_Edificio_Registro` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `revisarPor` varchar(20) default NULL,
  `id_tipo_permiso` int(11) NOT NULL,
  PRIMARY KEY  (`id_Permisos`),
  KEY `fk_motivo_idx` (`id_motivo`),
  KEY `fk_empleado_idx` (`No_Empleado`),
  KEY `fk_edificio_registro_idx` (`id_Edificio_Registro`),
  KEY `fk_revisado_idx` (`revisado_por`),
  KEY `fk_departamento_idx` (`id_departamento`),
  KEY `fk_usuario_idx` (`id_usuario`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=18 ;

--
-- Volcar la base de datos para la tabla `permisos`
--

INSERT INTO `permisos` (`id_Permisos`, `id_departamento`, `No_Empleado`, `id_motivo`, `dias_permiso`, `hora_inicio`, `hora_finalizacion`, `fecha`, `fecha_solicitud`, `estado`, `observacion`, `revisado_por`, `id_Edificio_Registro`, `id_usuario`, `revisarPor`, `id_tipo_permiso`) VALUES
(14, 4, '12968', 8, 1, '07:00:00', '14:30:00', '2015-12-11 00:00:00', '2015-12-11', 'Finalizado', NULL, '6558', 9, 12, '11538', 3),
(15, 4, '12968', 6, 5, '07:00:00', '14:30:00', '2016-10-17 00:00:00', '2016-02-11', 'Aprobado', NULL, '6558', 9, 12, '', 1),
(16, 4, '12968', 8, 1, '07:00:00', '15:00:00', '2016-02-11 00:00:00', '2016-02-11', 'Espera', NULL, NULL, 9, 12, '11538', 1),
(17, 4, '12968', 7, 1, '07:00:00', '15:00:00', '2016-02-12 00:00:00', '2016-02-11', 'Espera', NULL, NULL, 9, 12, '11538', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

DROP TABLE IF EXISTS `persona`;
CREATE TABLE IF NOT EXISTS `persona` (
  `N_identidad` varchar(20) NOT NULL,
  `Primer_nombre` varchar(20) NOT NULL,
  `Segundo_nombre` varchar(20) default NULL,
  `Primer_apellido` varchar(45) NOT NULL,
  `Segundo_apellido` varchar(20) default NULL,
  `Fecha_nacimiento` date NOT NULL,
  `Sexo` varchar(1) default NULL,
  `Direccion` varchar(300) NOT NULL,
  `Correo_electronico` varchar(40) default NULL,
  `Estado_Civil` varchar(15) default NULL,
  `Nacionalidad` varchar(20) NOT NULL,
  `foto_perfil` varchar(60) NOT NULL,
  PRIMARY KEY  (`N_identidad`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcar la base de datos para la tabla `persona`
--

INSERT INTO `persona` (`N_identidad`, `Primer_nombre`, `Segundo_nombre`, `Primer_apellido`, `Segundo_apellido`, `Fecha_nacimiento`, `Sexo`, `Direccion`, `Correo_electronico`, `Estado_Civil`, `Nacionalidad`, `foto_perfil`) VALUES
('0801-1965-00177', 'Bessy', 'Margot', 'Nazar', 'Herrera', '1965-01-04', 'F', '', 'bmnazarh@hotmail.com', 'Soltero', 'hondureña', ''),
('1211-1980-00001', 'Walter', 'Levi', 'Meléndez', 'Perdomo', '1980-01-01', 'M', '', 'walter.melendez@unah.edu.hn', 'Casado', 'hondureña', ''),
('0801-1972-10136', 'Ana', 'Lourdes', 'Moncada', 'Torres', '1972-08-24', 'F', '', 'analourdes@yahoo.com', 'Casado', 'hondureña', ''),
('0801-1959-03859', 'Gloria', 'Isabel', 'Oseguera', 'Lopez', '1959-09-21', 'F', '', 'gloriaoseguera@yahoo.com', 'Soltero', 'hondureña', ''),
('0801-1961-08415', 'MARIA ', 'ROSINDA', 'MARADIAGA ', 'RUIZ', '1961-09-24', 'F', '', 'rosindamaradiaga@yahoo.com', 'Soltero', 'hondureña', ''),
('0202-1963-00018', 'Santos', 'Liduvina', 'Maldonado', 'Puerto', '1963-09-12', 'F', '', 'lidumaldonado@yahoo.es', 'Casado', 'hondureña', ''),
('0801-1978-12387', 'Monica', 'Esmeralda', 'Dormes', 'Ramirez', '1978-07-12', 'F', '', 'esmeraldadormes772@gmail.com', 'soltero', 'hondureña', ''),
('0709-1990-00100', 'Carlos', 'Luis', 'Burgos', 'Ochoa', '1990-07-17', 'F', '', 'carlos_beckl@hotmail.com', 'Soltero', 'hondureña', ''),
('0801-1969-02793', 'Jhonny', 'Alexis', 'Membreño', 'x', '1969-06-02', 'M', '', 'jhonny.membreno@unah.edu.hn', 'Soltero', 'hondureña', ''),
('0801-1991-06974', 'Elizabeth', '', 'Tercero', 'Calix', '1991-03-31', 'F', '', 'francis.tercero@unah.edu.hn', 'soltero', 'hondureña', ''),
('0801-1988-16746', 'Evelin', 'Rocio', 'Canaca', 'Arriola', '1988-09-06', 'F', '', 'ecanaca@unah.edu.hn', 'Soltero', 'hondureña', ''),
('0801-1985-18347', 'Jorge', 'Luis', 'Aguilar', 'Flores', '1985-09-15', 'M', '', 'jorge.aguilar@unah.edu.hn', 'Soltero', 'hondureña', ''),
('0801-1959-03858', 'Gloria', 'Isabel', 'Oseguera', 'Lopez', '1959-09-21', 'F', '', 'gloriaoseguera@yahoo.com', 'Soltero', 'hondureña', ''),
('0601-1993-01279', 'Alex', 'Dario', 'Flores', 'Aplicano', '1992-11-26', 'M', 'Hato', 'aflores@iconhn.com', 'Soltero', 'Hondureño', ''),
('0602-1971-00111', 'Jorge', 'Alberto', 'Herrera', 'Flores', '2015-01-01', 'M', '', 'jorge@unah.com', 'soltero', 'HONDUREÑA', ''),
('0501-1963-01649', 'Guillermo', 'Arturo', 'Caballero', 'Castro', '2015-01-01', 'M', 'EL HATILLO, KM 9 , CALLE LOS PINOS, 150 MTS DE LA CALLE PRINCIPAL', 'guillermo@unah.com', 'soltero', 'Hondureña', ''),
('1702-1984-00609', 'Jorge', 'Belarmino', 'Reyes', 'Reyes', '2015-01-01', 'M', 'COL. EL ALAMAO BLOQUE H, CASA N° 3449', 'belarminoreyes@hotmail.com', 'soltero', 'HONDUREÑA', ''),
('0301-1980-02196', 'Sergio', 'Alejandro', 'Mejía', 'Umaña', '2015-01-01', 'M', 'COL. PRADOS UNIVERSITARIOS', 'sergio@unah.hn', 'Soltero', 'Hondureña', ''),
('0801-1957-00110', 'Juan', 'Carlos', 'Pérez ', 'Cadalso', '2015-01-01', 'M', 'COL. LOMAS DEL GUIJARRO SUR, CALLE MADRID, CASA \nN° 4186', 'jcpcadalso@gmail.com', 'soltero', 'Hondureña', ''),
('0709-1968-00153', 'Ana', 'Dolores ', 'Chávez', 'Doblado', '2015-01-01', 'F', 'VILLA COLONIAL CIRCUITO CERRADO, CASA N°32 AL LADO DE PRADOS UNIVERSITARIOS', 'anadchd68@gmial.com', 'Casado', 'Hondureña', ''),
('1703-1958-00137', 'Suyapa', 'Petrona', 'Thumann', 'Conde', '2015-01-01', 'F', 'COL.ALTOS DE MIRAMONTES, DIAGONAL FRISCO, CASA#2901', 'suyapathumann@hotmail.com', 'soltero', 'Hondureña', ''),
('0801-1964-06575', 'Erlinda', 'Esperanza', 'Flores', 'Flores', '1964-12-21', 'F', 'COL. VILLA OLIMPICA, SECTOR N°3, BLOQUE #3, CASA #5306', 'eresflo@yahoo.com', 'Casado', 'Hondureña', ''),
('0107-1957-00530', 'Alda', 'Lizzette', 'Mejía', 'Velasquez', '2015-01-01', 'F', 'LOMA LINDA SUR, F-16 #2829', 'kawas.alda@gmail.com', 'soltero', 'Hondureña', ''),
('1701-1982-01261', 'Gloria', 'Caridad', 'Alvarado ', 'Castro', '2015-01-01', 'F', 'COL. EL ALAMO BLOQUE "F", CASA N° 934', 'gloria@unah.hn', 'Soltero', 'Hondureña', ''),
('0801-1987-05252', 'Odir', 'Aaron', 'Fernández', 'Flores', '2015-10-01', 'M', 'RES. BOSQUE DEL TABLON BLOQUE #7, CASA #4', 'odiraaron2001@yahoo.com', 'Soltero', 'Hondureña', ''),
('1501-1984-00585', 'Angel', 'Edmundo ', 'Orellana', 'Mercado', '2015-01-01', 'M', '', 'edmundo@unah.hn', 'soltero', 'Hondureña', ''),
('1401-1976-00148', 'Gaudy', 'Alejandra', 'Bustillo', 'Martinez', '2015-01-01', 'M', 'COL. BELLA ORIENTE, BLOQUE A', 'gaudy.bustillo@gmail.com', 'soltero', 'Hondureña', ''),
('1703-1945-00065', 'Fernan', 'Nuñez', 'Pineda', 'O', '2015-01-01', 'M', 'COL. RIO GRANDE SUR, BLOQUE F-1, CASA N°8002', 'miverdad45@yahoo.es', 'Casado', 'Hondureña', ''),
('0000-0000-00009', 'José', 'Rogelio ', 'Penagos', 'Fajardo', '2015-01-01', 'M', 'JACALEPA, FINCAS DE TLAPALAN, TEGUCIGALPA', 'penagos@unah.hn', 'casado', 'Hondureña', ''),
('0801-1954-04789', 'Jorge', 'Alberto', 'Matute', 'Ochoa', '2015-01-01', 'M', '', 'matute@unah.hn', 'soltero', 'Hondureña', ''),
('0801-1979-07612', 'Javier', 'David', 'Lopez', 'Padilla', '2015-01-01', 'M', 's', 'javier@unah.hn', 'Soltero', 'Hondureña', ''),
('0801-1961-07060', 'Diana', 'Sobeida', 'Valladares', 'Marquez', '2015-01-01', 'F', '', 'diana@unah.hn', 'Soltero', 'Hondureña', ''),
('0703-1991-02848', 'ALEJANDRA', 'MARÍA', 'DÍAZ', 'MEJÍA', '1991-07-31', 'F', 'N/D', 'kafarm1@gmail.com', 'Soltero', 'HONDUREÑO', ''),
('0703-1991-01279', 'Alex', 'Eulises', 'Flores', 'Pineda', '1992-09-21', 'M', 'Hato', 'hllanos75@gmail.com', 'Soltero', 'Hondureño', ''),
('0703-1991-00911', 'Hector', 'N/D', 'Llanos', 'N/D', '2015-12-15', 'M', '', 'hllanosr75@gmail.com', 'Soltero', 'Honduras', ''),
('0107-1964-00758', 'ADRIÁN', 'RENÉ', 'FLORES', 'MARCELINO', '1964-05-17', 'M', '', 'adrianrenef@yahoo.com', 'Soltero', 'HONDUREÑO', ''),
('0801-1988-16527', 'ALBIN', 'LESTER', 'VELÁSQUEZ', 'CANALES', '1988-09-04', 'M', 'N/D', 'albinlester@yahoo.com', 'Soltero', 'HONDUREÑO', ''),
('0801-1993-08892', 'ALEJANDRO', 'JOSÉ', 'PINEDA', 'RODRÍGUEZ', '1992-12-29', 'M', 'N/D', 'ale_pin29@hotmail.com', 'Soltero', 'HONDUREÑO', ''),
('0801-1976-12903', 'ALEX', 'GEOVANNI', 'NAVAS ', 'ALVAREZ', '1976-11-15', 'M', 'N/D', 'navasalex@hotmail.com', 'Soltero', 'HONDUREÑO', ''),
('0801-1987-14954', 'ALEX ', 'RICARDO', 'MORALES ', 'SILVA', '1987-08-25', 'M', 'N/D', 'abogadomoralessilva@gmail.com', 'Soltero', 'HONDUREÑO', ''),
('0826-1991-00215', 'ALEXA', 'JAMALÍ', 'ESPINAL', 'MEZA', '1991-08-10', 'F', 'N/D', 'alexa_espinal1991@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1991-03431', 'ALLAN', 'EDGARDO', 'CORRALES', 'CARRASCO', '1991-11-17', 'M', 'N/D', 'acorralesc@yahoo.com', 'Soltero', 'HONDUREÑO', ''),
('0801-1991-09840', 'ALLAN', 'MAURICIO', 'HERNÁNDEZ', 'RODRÍGUEZ', '1991-05-13', 'M', 'N/D', 'allan21_hernandez@hotmail.com', 'Soltero', 'HONDUREÑO', ''),
('0801-1969-07472', 'ALMA ', 'ELIUT ', 'PONCE', 'TERCERO', '0000-00-00', 'F', 'N/D', 'estram_alma@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1976-02179', 'ANA', 'CAROLINA', 'SILVA', 'PINEDA', '0000-00-00', 'F', 'N/D', 'acarolinasilva76@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0611-1978-00092', 'ANA', 'CECILIA ', 'FLORES', 'ELVIR', '0000-00-00', 'F', 'N/D', 'floresa840@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('1201-1991-00568', 'ANA ', 'GABRIELA ', 'AGUILERA ', 'ARAUJO', '1991-08-29', 'F', 'N/D', 'gabi_araujo29@hotmail.es', 'Soltero', 'HONDUREÑA', ''),
('0801-1991-20952', 'ANA ', 'GABRIELA', 'ALMENDARES', 'MAYORGA', '1991-09-03', 'F', '', 'ggaby_almendares@yahoo.es', 'Soltero', 'HONDUREÑA', ''),
('0826-1990-00247', 'ANA', 'LEONOR', 'PALMA ', 'RODRÍGUEZ', '1990-09-24', 'F', 'N/D', 'anrypalma@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('1707-1990-00473', 'ANA', 'ROSA', 'GARCIA', 'CANALES', '1990-07-19', 'F', 'N/D', 'anarosa.g@hotmail.es', 'Soltero', 'HONDUREÑA', ''),
('0801-1969-01524', 'ANARDA', 'LUCIA DEL CARMEN', 'LEONI', 'JIMÉNEZ', '1969-02-04', 'F', 'N/D', 'anardaleoni@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1992-21136', 'ANDREA', 'NICOL', 'ERAZO', 'DELGADO', '1992-10-07', 'F', 'N/D', 'andreaerazo792@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('0607-1983-00483', 'ÁNGEL', 'ANTONIO', 'GUZMÁN', 'CASTRO', '1983-05-24', 'M', 'N/D', 'a_castroz1@hot.com', 'Soltero', 'HONDUREÑA', ''),
('1201-1991-00180', 'ÁNGELA', 'MINELY', 'MARTÍNEZ', 'MEDINA', '1990-10-03', 'F', 'N/D', 'minelly.martinez@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('1508-1992-00289', 'ANNA', 'GABRIELLA', 'CARDONA', 'PADILLA', '1992-05-03', 'F', 'N/D', 'gabyffe@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0704-1989-01096', 'BANIA', 'NABELY', 'BUCARDO', 'PASTOR', '1989-06-25', 'F', 'N/D', 'bnbp2589@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1993-02922', 'BANY', 'MARÍA', 'FÚNEZ', 'ORDÓÑEZ', '1993-01-02', 'F', 'N/D', 'banyma_10@yahoo.es', 'Soltero', 'HONDUREÑA', ''),
('0801-1992-00587', 'BARINIA', 'ROSARIO', 'DÍAZ', 'FÚNES', '1991-12-17', 'F', 'N/D', 'barinia.diaz@unah.hn', 'Soltero', 'HONDUREÑA', ''),
('0318-1990-01175', 'BENJAMÍN', 'OMAR', 'BENITEZ', 'JEREZANO', '1990-07-06', 'M', 'N/D', 'bnjja@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('1519-1993-00016', 'BESSY', 'SAMANTHA', 'SEVILLA', 'MIRALDA', '1992-09-04', 'F', 'N/D', 'bessysevilla504@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0604-1982-00109', 'BLANCA', 'GRISELDA', 'HERRERA', 'CÁCERES', '1982-12-18', 'F', 'N/D', 'herreracaceres@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('1001-1993-00368', 'BRAYAN', 'LEONEL', 'AGUILAR', 'MORALES', '1993-02-28', 'M', 'N/D', 'aguilarmorales93@hotmail.es', 'Soltero', 'HONDUREÑA', ''),
('0801-1991-05576', 'BREYSI ', 'YOLISETH', 'BELTRÁN', 'REYES', '1991-02-06', 'F', 'N/D', 'breysi.beltran@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1976-04001', 'CARLOS', 'ALBERTO', 'BONILLA', 'GALEAS', '1976-08-20', 'M', 'N/D', 'bonilla1976@hotmail.es', 'Soltero', 'HONDUREÑA', ''),
('0801-1958-07367', 'CARLOS', 'MANUEL', 'RÍOS', 'N/D', '1958-07-22', 'M', 'N/D', 'rioscarlosmanuel@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('1806-1990-00561', 'CARLOS', 'ROBERTO', 'CRUZ', 'SERRANO', '1990-05-13', 'M', 'N/D', 'carlos.cruz1@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0703-1991-01757', 'CARMEN', 'SUYAPA', 'ASPRA', 'MARTÍNEZ', '1991-04-04', 'F', 'N/D', 'carmen.aspra@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('1207-1982-00019', 'CAROL', 'IMELDA', 'AMAYA', 'BONILLA', '1982-02-25', 'F', 'N/D', 'caraluna0015@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1978-01136', 'CÉSAR', 'IVÁN', 'DÍAZ', 'N/D', '1978-01-28', 'M', 'N/D', 'cesardiaz35@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1987-05231', 'CHRISTOPHER', 'N/D', 'MARADIAGA', 'ARDÓN', '1987-03-10', 'M', 'N/D', 'christophermaradiagaardon@yahoo.es', 'Soltero', 'HONDUREÑA', ''),
('0801-1991-14156', 'CINTHIA', 'LORENA', 'VALLADARES', 'CRUZ', '1991-07-19', 'F', 'N/D', 'elmeliberta_9119@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0805-1985-00294', 'CINTHIA', 'MIREYA', 'DÍAZ', 'BARAHONA', '1985-06-23', 'F', 'N/D', 'nd@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1982-09229', 'CINTHIA', 'VANESSA', 'HERNÁNDEZ', 'ESPINOZA', '1982-11-13', 'F', 'N/D', 'cinthiahernandezespinoza@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('1501-1993-03877', 'CINTHYA', 'MERCEDES', 'HERNÁNDEZ', 'MUÑOZ', '1993-08-21', 'F', 'N/D', 'cinhndz@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0601-1990-02144', 'CLAUDIA', 'PATRICIA', 'MARADIAGA', 'ARIAS', '1990-06-27', 'F', 'N/D', 'claudiapma@live.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1991-11985', 'CRISTOPHER', 'ANTONIO', 'ZELAYA', 'MENDOZA', '1991-06-01', 'M', 'N/D', 'kiisazm@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1994-00660', 'DANIEL', 'ALEXANDER', 'ORTÍZ', 'N/D', '1993-12-16', 'M', 'N/D', 'daniel_alexander93@hotmail.es', 'Soltero', 'HONDUREÑA', ''),
('0301-1991-02655', 'DANIEL', 'ARTURO', 'PADILLA', 'NÚÑEZ', '1990-12-18', 'M', 'N/D', 'padilladaniel920@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('0101-1991-02420', 'DANIEL', 'N/D', 'ESCOBAR', 'GARÍN', '1991-05-22', 'M', 'N/D', 'daniel.garin17@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1977-00361', 'DARWYN', 'EDUARDO', 'FIALLOS', 'PONCE', '1977-10-22', 'M', 'N/D', 'darwinefiallos@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1993-01558', 'DAVID', 'ARMANDO', 'URTECHO', 'LÓPEZ', '1993-01-04', 'M', 'N/D', 'david.armando.urtecho@gmailcom', 'Soltero', 'HONDUREÑA', ''),
('1503-1993-01018', 'DELMY', 'ALEJANDRA', 'RIVERA', 'COREA', '1992-11-13', 'F', 'N/D', 'delmyrivera1993@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1992-15583', 'DENIS', 'ARIEL', 'DÍAZ', 'CERRATO', '1992-08-07', 'M', 'N/D', 'abogdiaz92@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1991-19754', 'DIANA', 'MARÍA', 'FUENTES', 'MUNGUÍA', '1991-10-09', 'F', 'N/D', 'diana_mfuentes@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1975-22988', 'DICIA', 'MAGDIEL', 'CERRATO', 'LEAL', '1975-12-18', 'F', 'N/D', 'dcerrato@tecniseguros.com', 'Soltero', 'HONDUREÑA', ''),
('1511-1959-00089', 'DIGNA', 'EMÉRITA', 'FUENTES', 'ÁVILA', '1959-05-02', 'F', 'N/D', 'kellmarq@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('1007-1983-00313', 'DILCIA', 'YANETH', 'CASTILLO', 'SEREN', '1983-06-29', 'F', 'N/D', 'dilcia_2018@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0822-1985-00305', 'DIMAS', 'NOE', 'MONCADA', 'NAVAS', '1985-11-11', 'M', 'N/D', 'dimasnoemoncadanavas@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1990-22215', 'DINORA', 'MARÍA', 'ROMERO', 'GARCÍA', '1990-11-07', 'F', 'N/D', 'dinoraker@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1990-14788', 'DORIS', 'GABRIELA', 'REYES', 'ARGUETA', '1990-07-19', 'F', 'N/D', 'gdreyesargueta@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1967-05372', 'DORIS', 'IVETH', 'DURÓN', 'RODRÍGUEZ', '1967-10-21', 'F', 'N/D', 'ND@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1980-12749', 'DORIS', 'MARGARITA', 'GARCÍA', 'DOMÍNGUEZ', '1980-08-31', 'F', 'N/D', 'doris161021@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('1503-1993-00704', 'DOUGLAS', 'ENRIQUE', 'SUAREZ', 'HERNÁNDEZ', '1993-03-11', 'M', 'N/D', 'douglas_suarez_2006@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('1310-1990-00053', 'DUNIA', 'XIOMARA', 'MURCIA', 'IGLESIAS', '1990-02-07', 'F', 'N/D', 'duniaxiomara@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0601-1978-02416', 'EDIS', 'MARIANELY', 'QUIROZ', 'GONZÁLES', '1978-10-11', 'F', 'N/D', 'edisquiroz@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('1201-1953-00047', 'EDUARDO', 'RENATO', 'SUAZO', 'CÁLIX', '1953-03-10', 'M', 'N/D', 'ND@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('1503-1968-00059', 'EDVIN', 'ROBERTO', 'ACOSTA', 'FIGUEROA', '1968-01-10', 'M', 'N/D', 'ND@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0702-1991-00199', 'ENA', 'RUBÍ', 'RAMÍREZ', 'SUAREZ', '1991-09-17', 'F', 'N/D', 'enarubyr@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0705-1977-00029', 'ERICA', 'YADIRA', 'MENDEZ', 'MENDOZA', '1977-02-11', 'F', 'N/D', 'nd@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0501-1973-09295', 'EVELYN', 'LIZBETH', 'CERRATO', 'LEAL', '1973-12-23', 'F', 'N/D', 'cerrato_evelyn@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0411-1991-00167', 'FANI', 'MELIZA', 'SERRANO', 'AVALO', '1991-06-21', 'F', 'N/D', 'fany_cerrano04@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0501-1973-05537', 'FANNY', 'SORAYA', 'BARAHONA', 'CORDÓN', '1973-08-26', 'F', 'N/D', 'sorayacordon@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1990-17641', 'FLOR', 'ANGÉLICA', 'ALMENDARES', 'SANTOS', '1990-08-29', 'F', 'N/D', 'flor.angelica1@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('1208-1992-00101', 'FLOR', 'DE MARÍA', 'DOMÍNGUEZ', 'MARQUÉZ', '1991-10-25', 'F', 'N/D', 'flor12dominguez@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1991-06078', 'FLOR', 'SARAÍ', 'CRUZ', 'MATAMOROS', '1990-04-03', 'F', 'N/D', 'scrumats@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('1501-1989-01146', 'FRANCISCO', 'LUIS', 'ACOSTA', 'RUÍZ', '1989-04-02', 'M', 'N/D', 'franacostaruiz@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1990-11492', 'FREDDY', 'JUNIOR', 'TORRES', 'SÁNCHEZ', '1989-08-10', 'M', 'N/D', 'juniortorres42@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1967-05937', 'GABRIEL', 'HUMBERTO', 'ELVIR', 'PAVÓN', '1967-11-28', 'M', 'N/D', 'gabrielelvir@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1991-24747', 'GABRIELA', 'MELISSA', 'TOBÓN', 'APLÍCANO', '1991-10-22', 'F', 'N/D', 'tobongabriela@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1993-03083', 'GABRIELA', 'NICOLE', 'MOLINA', 'LOZANO', '1992-12-15', 'F', 'N/D', 'gnicole_0092@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1991-19039', 'GEIDY', 'JOHANA', 'RAMOS', 'RÍOS', '1991-09-29', 'F', 'N/D', 'johanarias93@yahoo.es', 'Soltero', 'HONDUREÑA', ''),
('0703-1992-04401', 'GERARDO', 'ALBERTO', 'MARTÍNEZ', 'RODRÍGUEZ', '1992-02-11', 'M', 'N/D', 'gerardo_mr92@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1986-10887', 'GERARDO', 'VERLAN', 'CASTRO', 'NAVARRO', '1986-05-06', 'M', 'N/D', 'gcastro@poderjudicial.gob.hn', 'Soltero', 'HONDUREÑA', ''),
('1601-1971-00224', 'GERSON', 'AQUILES', 'CASTEJÓN', 'ALMENDARES', '1971-03-07', 'M', 'N/D', 'nd@yahoo.com', 'Soltero', 'ND', ''),
('0801-1994-07145', 'GINA', 'LARISSA', 'REYES', 'VÁSQUEZ', '1994-04-06', 'F', 'N/D', 'greyesvasquez@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1991-11506', 'GINA', 'LIZETH', 'RODRIGUEZ', 'FONSECA', '1991-06-07', 'F', 'N/D', 'ginarodriguez1991@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('1809-1953-00185', 'GLORIA', 'ELIA', 'HERNANDEZ', 'MARTINEZ', '1953-12-02', 'F', 'N/D', 'elia-53@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1966-09237', 'GLORIA', 'MARINA', 'SÁNCHEZ', 'CÁLIX', '1966-09-20', 'F', 'N/D', 'gloriasanchez92076@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1966-08396', 'GLORIA', 'SUYAPA', 'BÁRCENAS', 'VALLADARES', '1966-07-11', 'F', 'N/D', 'suyapabarcenas@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1994-00789', 'GRACIELA', 'FERNANDA', 'MARTÍNEZ', 'MARTÍNEZ', '1993-12-23', 'F', 'N/D', 'graciela_fer17@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1990-15523', 'GUILLERMO', 'ALEJANDRO', 'OSORTO', 'DUBÓN', '1990-08-13', 'M', 'N/D', 'gaod90.5@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1956-00332', 'HAYDEE', 'N/D', 'CERRATO', 'MARTÍNEZ', '1956-01-19', 'F', 'N/D', 'nd@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0611-1983-00842', 'HÉCTOR', 'ALCIDES', 'ORDÓÑEZ', 'CANALES', '1983-08-16', 'M', 'N/D', 'hectoralcides2008@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1964-06649', 'HÉCTOR', 'ENRIQUE', 'GONZÁLEZ', 'PAVÓN', '1964-01-19', 'M', 'N/D', 'nd@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1989-13308', 'HEINRICH', 'ARNOLDO', 'LÓPEZ', 'HERNÁNDEZ', '1989-05-10', 'M', 'N/D', 'halhlight@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1954-03188', 'HENRY', 'N/D', 'ARÉVALO', 'ZÚNIGA', '1954-07-17', 'M', 'N/D', 'nd@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1991-11603', 'HENRY', 'JOSUÉ ', 'MENDIETA', 'VARGAS', '1991-06-12', 'M', 'N/D', 'henrymen_612@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('1709-1990-00426', 'HERLON', 'ANTONIO', 'FLORES', 'MONTALVÁN', '1990-05-10', 'M', '', 'herlonantonio@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('1708-1974-00122', 'HERNÁN', 'N/D', 'VÁSQUEZ', 'PADILLA', '1974-04-30', 'M', 'N/D', 'nd@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1977-12263', 'HILDA', 'MARGARITA', 'SILVA', 'MENCÍA', '1977-09-01', 'F', 'N/D', 'hildasilva20@yahoo.es', 'Soltero', 'HONDUREÑA', ''),
('0703-1988-02624', 'HULDA', 'LIDENY', 'GAITÁN', 'ORDÓÑEZ', '1988-06-20', 'F', 'N/D', 'hulda.gaitan@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1987-09326', 'IRIS', 'ALEJANDRA', 'CHAVARRÍA', 'LAGOS', '1987-04-24', 'F', 'N/D', 'irishuwi@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1979-04263', 'ISIS', 'ANDIRA', 'ELVIR', 'LAÍNEZ', '1978-12-07', 'F', 'N/D', 'isis_elvir@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1990-21356', 'ISIS', 'GABRIELA', 'LÓPEZ', 'OSEGUERA', '1990-09-11', 'F', 'N/D', 'oseguera_gaby@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1985-09994', 'ISIS', 'VALERY', 'RAMÍREZ', 'MALDONADO', '1985-05-31', 'F', 'N/D', 'nd@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1983-15889', 'JACKELINE', 'MARCELA', 'CANALES', 'REYES', '1983-05-29', 'F', 'N/D', 'jackycanales@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('0101-1991-00807', 'JACOBO', 'JOSÉ', 'FONSECA', 'GUZMÁN', '1990-07-27', 'M', 'N/D', 'jjfonseca71@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1958-03532', 'JAIME', 'OMAR', 'COELLO', 'VALLADARES', '1958-05-24', 'M', 'N/D', 'nd@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1967-09794', 'JAVIER', 'ARTURO', 'CHÁVEZ', 'RAMOS', '1967-10-30', 'M', '', 'javierchavez_ramos@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('1007-1984-00763', 'JESÚS', 'N/D', 'GONZÁLES', 'MIRANDA', '1966-01-03', 'M', 'N/D', 'jesusarambu75@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('1516-1991-00194', 'JAVIER', 'DARÍO', 'TORRES', 'SOLÍS', '1991-11-08', 'M', 'N/D', 'dario_solis13@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0612-1977-00023', 'JAYME', 'ROBERTO', 'GARCÍA', 'GARCÍA', '1977-02-13', 'M', 'N/D', 'jroberto-garcia1@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1991-05729', 'JENNIFER', 'ELIZABETH', 'BONILLA', 'RODRÍGUEZ', '1991-03-11', 'F', 'N/D', 'jennybon03hn@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0209-1988-00380', 'JÉSER', 'ASAEL', 'CUEVA', 'MELÉNDEZ', '1987-12-24', 'M', 'N/D', 'jcueva@live.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1990-13324', 'JESSENIA', 'ELIZABETH', 'RODRÍGUEZ', 'LÓPEZ', '1990-05-01', 'F', 'N/D', 'rodriguezjessenia17@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('0313-1991-00244', 'JESSICA', 'XIOMARA', 'MEJÍA', 'BONILLA', '1991-07-22', 'F', 'N/D', 'xioma_2008@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('1701-1991-01282', 'JESTEN', 'JOSUÉ', 'SILVA', 'RODRÍGUEZ', '1990-09-16', 'M', 'N/D', 'silva.jesten@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1977-01499', 'JESÚS', 'ALEXIS', 'VILLANUEVA', 'ALVARADO', '1977-02-05', 'M', 'N/D', 'jvillanueva@poderjudicial.gob.hn', 'Soltero', 'HONDUREÑA', ''),
('0801-1991-02693', 'JHOSELYN', 'MARIEL', 'ARAUJO', 'FLORES', '1991-01-26', 'F', 'N/D', 'jhosaraujo_91@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0806-1968-00346', 'JOEL', 'OTONIEL', 'GONZALEZ', 'MALDONADO', '1968-12-11', 'M', 'N/D', 'gonza126863@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0703-1976-03695', 'JONABELLY', 'VANESSA', 'ALVARADO', 'AMADOR', '1976-11-08', 'F', 'N/D', 'vanessaalvarado8@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('1401-1984-01285', 'JORGE', 'ALBERTO', 'GUERRA', 'LÓPEZ', '1961-08-05', 'M', 'N/D', 'nd@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('1502-1981-00595', 'JORGE', 'ARTURO', 'MATUTE', 'ORTÍZ', '1981-12-01', 'M', 'N/D', 'jarturomatute19@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1981-04526', 'JORGE', 'FIDEL', 'CANACA', 'OYUELA', '1981-06-16', 'M', 'N/D', 'nd@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0301-1992-02454', 'JOSÉ', 'FRANCISCO', 'FLORES', 'FLORES', '1992-06-01', 'M', 'N/D', 'francisco.flores21@yahoo.es', 'Soltero', 'HONDUREÑA', ''),
('0801-1987-05407', 'JOSÉ', 'HELIODORO', 'ZAMORA', 'VALLADARES', '1987-01-24', 'M', 'N/D', 'oxykid@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1990-10397', 'JOSÉ', 'JOAQUÍN', 'CASTRO', 'DUBÓN', '1990-05-17', 'M', 'N/D', 'joaquin_castrod2001@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1967-06317', 'JOSÉ', 'MARCIAL', 'MÉNDEZ', 'SOTO', '1967-12-12', 'M', 'N/D', 'jmmendezs@yahoo.es', 'Soltero', 'HONDUREÑA', ''),
('0209-1985-02706', 'JOSÉ', 'MIGUEL', 'JUAREZ', 'HERRERA', '1985-10-02', 'M', 'N/D', 'josmi_09@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1992-22033', 'JOSÉ', 'RAÚL', 'DÍAZ', 'MARTÍNEZ', '1992-10-18', 'M', 'N/D', 'joserauldiazmartinez@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0823-1992-00034', 'JOSELYN', 'PATRICIA', 'NÚÑEZ', 'NELSON', '1992-02-07', 'F', 'N/D', 'joselyn07nunez@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0301-1992-02168', 'JOSSELYN', 'NOHEMY', 'ESPAÑA', 'DONAIRE', '1992-08-27', 'F', 'N/D', 'josselyn200631@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1984-05287', 'JOSUÉ', 'EMMANUEL', 'CARBAJAL', 'MEZA', '1984-05-21', 'M', 'N/D', 'jecm_carbajal@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('1518-1980-00051', 'KARLA', 'PATRICIA', 'RUÍZ', 'RODRÍGUEZ', '1980-03-22', 'F', 'N/D', 'karlaruiz22@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0827-1993-00069', 'KATHERINE', 'STEPHANÍA', 'CORRALES', 'GUERRERO', '1993-03-12', 'F', 'N/D', 'kathcheck@ymail.com', 'Soltero', 'HONDUREÑA', ''),
('0824-1991-00586', 'KENSY', 'RAMONA', 'ESCOBAR', 'BANEGAS', '1991-06-20', 'F', 'N/D', 'kensy_banegas77@hotmail.es', 'Soltero', 'HONDUREÑA', ''),
('1503-1986-01320', 'KERLA', 'GABRIELA', 'VALDEZ', 'FUNEZ', '1986-07-07', 'F', 'N/D', 'gabyvaldez86@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0306-1990-00442', 'LADY', 'LIZ', 'WATTERS', 'ROMERO', '1990-07-10', 'F', 'N/D', 'lizwatters10@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0101-1992-02147', 'LARSEN', 'ALEXANDER', 'LANZA', 'RODRÍGUEZ', '1992-02-21', 'M', 'N/D', 'larsenlanza@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1983-12823', 'LEONARDO', 'MAURICIO', 'RAMOS', 'FLORES', '1983-09-18', 'M', 'N/D', 'leonardo_ramosf@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1991-20572', 'LEONEL', 'ENRIQUE', 'GODOY', 'LEZAMA', '1991-08-14', 'M', 'N/D', 'leolezama_91@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1978-11576', 'LESI', 'MARGOTH', 'SIERRA', 'HERNÁNDEZ', '1978-05-02', 'F', 'N/D', 'lessyh29@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('1704-1978-00259', 'LIGIA', 'XIOMARA', 'ARIAS', 'ZELAYA', '1967-11-01', 'F', 'N/D', 'alvarengaluis874@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1990-18042', 'LILIAN', 'IRINA', 'FÚNEZ', 'PORTILLO', '1990-08-29', 'F', 'N/D', 'lilianstaar_0029@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1989-05245', 'LOURDES', 'DESSIREE', 'ENAMORADO', 'SANDOVAL', '1989-03-15', 'F', 'N/D', 'lourdesdessiree@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1983-02321', 'LOURDES', 'ELENA', 'BARRIENTOS', 'SAHURI', '1983-03-28', 'F', 'N/D', 'lula.barrientos@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1983-04671', 'LOURDES', 'MARIELA', 'CARBAJAL', 'MONTES', '1983-05-28', 'F', 'N/D', 'cinthiahernandezespinoza@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1981-01946', 'LUCY', 'MARILIA', 'MAYORGA', 'SALGADO', '1981-03-11', 'F', 'N/D', 'lucymayorga29@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('0816-1990-00590', 'LUIS', 'ALFREDO', 'BACA', 'MARTÍNEZ', '1990-09-22', 'M', 'N/D', 'luis.baca@rocketmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1960-00244', 'LUIS', 'ALONSO', 'CASTRO', 'ZÚNIGA', '1960-01-10', 'M', 'N/D', 'luisc200448@yahoo.es', 'Soltero', 'HONDUREÑA', ''),
('1201-1990-00248', 'LUIS', 'ANDRÉS', 'CÁCERES', 'CASTILLO', '1990-04-04', 'M', 'N/D', 'luis7caceres@yahoo.es', 'Soltero', 'HONDUREÑA', ''),
('0703-1992-03640', 'LUIS', 'JOSÉ', 'BARAHONA', 'BLANCO', '1992-08-29', 'M', 'N/D', 'luisjo.barahona@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1992-18213', 'LUIS', 'OVIDIO', 'CHINCHILLA', 'FUENTES', '1992-09-20', 'M', 'N/D', 'luisovidio45@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1994-19454', 'LUIS', 'YAIR', 'MARTÍNEZ', 'PORTILLO', '1994-05-04', 'M', 'N/D', 'luisyair@outlook.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1980-04486', 'LURVIN', 'GISSELA', 'AGUILAR', 'BULNES', '1980-06-21', 'F', 'N/D', 'lurvinaguilarb@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('1703-1993-00011', 'MANUEL', 'ANTONIO', 'QUIROZ', 'RODRÍGUEZ', '1992-02-25', 'M', 'N/D', 'cristiano_manu7l@yahoo.es', 'Soltero', 'HONDUREÑA', ''),
('0801-1990-01987', 'MANUEL', 'DE JESÚS', 'RAMOS', 'MENCÍA', '1989-06-27', 'M', 'N/D', 'manuel_j2010@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0603-1988-00587', 'MANUEL', 'ROLANDO', 'MÉNDEZ', 'MARTÍNEZ', '1988-05-11', 'M', 'N/D', 'mendezmartinezmanuel@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1994-01053', 'MARCELA', 'IVETTE', 'CHINCHILLA', 'CALDERÓN', '1994-01-03', 'F', '', 'marcechinchilla_03@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0601-1964-01002', 'MARCELINO', 'N/D', 'GARCÍA', 'N/D', '1964-07-17', 'M', 'N/D', 'mgarciaunah@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('1807-1978-02092', 'MARCIO', 'SAID', 'CÁRCAMO', 'POSAS', '1978-10-28', 'M', 'N/D', 'nd@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0703-1980-04229', 'MARCO', 'ANTONIO', 'FLORES', 'GARCÍA', '1980-11-01', 'M', '', 'marco_flores1980@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1985-00939', 'MARELYN', 'STEFAY', 'GONZALEZ', 'SALGADO', '1985-01-03', 'F', 'N/D', 'nd@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1989-10181', 'MARÍA', 'ALEJANDRA', 'GÓMEZ', 'CÁRCAMO', '1989-05-28', 'F', 'N/D', 'alegomez0707@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1977-06393', 'MARÍA', 'DOLORES', 'ARAMBÚ', 'MEDINA', '1977-04-08', 'M', 'N/D', 'mariloli_arambu@yahoo.es', 'Soltero', 'HONDUREÑA', ''),
('0801-1979-15300', 'MARÍA', 'ELENA', 'GARCÍA', 'ZAPATA', '1979-10-12', 'F', 'N/D', 'marielegarciaz@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('0501-1969-08032', 'MARIO', 'GUILLERMO', 'MEJÍA', 'VARGAS', '1969-10-18', 'M', 'N/D', 'mariovargas2218@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1991-15154', 'MARIO', 'LEONEL', 'GARCÍA', 'RODRÍGUEZ', '1991-07-26', 'M', 'N/D', 'mlgr26@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1988-17857', 'MARLON', 'RICARDO', 'SÁNCHEZ', 'PINEDA', '1988-10-01', 'M', 'N/D', 'tatum.sanchez20@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('1522-1993-00189', 'MARY', 'JOHANA', 'SARMIENTO', 'BARDALES', '1982-01-30', 'F', 'N/D', 'jhn_bardales@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0803-1992-00658', 'MARYORY', 'LILIBETH', 'RAUDALES', 'LÓPEZ', '1972-09-12', 'F', 'N/D', 'lili_raudales@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1964-05715', 'MAURICIA', 'LIZZETTE', 'ALVARADO', 'BARRIENTOS', '1964-10-18', 'F', 'N/D', 'lili_raudales@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1990-01528', 'MAYI', 'GABRIELA', 'RODRÍGUEZ', 'RAMOS', '1989-12-15', 'F', 'N/D', 'mayirodrig@hotmail.es', 'Soltero', 'HONDUREÑA', ''),
('0801-1991-25625', 'MELVIN', 'GUSTAVO', 'ZEPEDA', 'SOLÍS', '1991-12-02', 'F', 'N/D', 'mzepeda1555@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0601-1992-10221', 'MELY', 'LIZZETH', 'ZELAYA', 'PÉREZ', '1991-09-04', 'F', 'N/D', 'lizzeth_living4ever@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1989-21350', 'MERCEDES', 'ESMERALDA', 'DUARTE', 'ANARIBA', '1989-09-12', 'F', 'N/D', 'anaribamercedes@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1990-14740', 'MERCY', 'PAOLA', 'ELVIR', 'ELVIR', '1990-04-17', 'F', 'N/D', 'mercyelvir17@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('0825-1985-00182', 'MERLIN', 'JOSEFINA', 'VÁSQUEZ', 'MARTÍNEZ', '1985-12-03', 'F', 'N/D', 'mervas_3@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0611-1975-00874', 'MIGUEL', 'ÁNGEL', 'FÚNEZ', 'CASTRO', '1975-12-04', 'M', 'N/D', 'miguelandrefunez@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1994-10322', 'MIRIAM', 'SARAHÍ', 'RAMÍREZ', 'PORTILLO', '1994-01-08', 'F', 'N/D', 'sarahiramiirez@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1991-23837', 'MÓNICA', 'LIZZETH', 'SÁNCHEZ', 'SUAZO', '1981-09-08', 'F', 'N/D', 'monica_04@live.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1992-06802', 'NADIA', 'STEFANÍA', 'MEJÍA', 'AMAYA', '1992-03-24', 'F', 'N/D', 'nadiamejia87@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1982-01930', 'NANCY', 'YAMILETH', 'MEDINA ', 'MATUTE', '1982-03-05', 'F', 'N/D', 'nanyame2002@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1975-08862', 'NELSON', 'DAVID', 'GUZMAN', 'SALGADO', '1975-03-07', 'M', 'N/D', 'abreu79@yahoo.es', 'Soltero', 'HONDUREÑA', ''),
('0801-1992-22851', 'NIDIA', 'MELISSA', 'BONILLA', 'ESPINAL', '1992-11-24', 'F', 'N/D', 'nm_bonilla@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('1701-1994-00415', 'NIDIA', 'SARAHÍ', 'BERRÍOS', 'MARTINEZ', '1994-12-11', 'F', 'N/D', 'nsarahibm11@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1991-00638', 'NORMA', 'SARAÍ', 'SEIDEL', 'ROMERO', '1990-12-23', 'F', 'N/D', 'seidel_sarai@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1992-22089', 'OSCAR', 'JOSÉ', 'GUILLÉN', 'DOMÍNGUEZ', '1992-10-15', 'M', 'N/D', 'o_guillen92@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('1013-1983-00101', 'OSCAR', 'ORLANDO', 'PINEDA', 'SÁNCHEZ', '1983-07-28', 'M', 'N/D', 'oscarorlandopinedalopez@yahoo.es', 'Soltero', 'HONDUREÑA', ''),
('0801-1977-12230', 'OSCAR', 'SALVADOR', 'ARITA', 'AGUILAR', '1977-08-31', 'M', 'N/D', 'nd@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1993-18899', 'PABLO', 'NERUDA', 'OSEGUERA', 'O REILLY', '1993-09-16', 'M', 'N/D', 'pablo.oseguera@unah.hn', 'Soltero', 'HONDUREÑA', ''),
('1501-1964-00486', 'PATRICIA', 'ANDREA', 'BUSTILLO', 'MUNGUÍA', '1964-06-14', 'F', 'N/D', 'patybustillo@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0803-1948-00394', 'PEDRO', 'N/D', 'CRUZ', 'CÁCERES', '1948-09-16', 'M', 'N/D', 'pedrocruzcaceres@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('1501-1966-00482', 'RAMÓN', 'POLICARPO', 'MÉNDEZ', 'LÓPEZ', '1966-04-25', 'M', 'N/D', 'rpmendezlopez@yahoo.es', 'Soltero', 'HONDUREÑA', ''),
('0801-1991-19007', 'RANDY', 'ROBERTO', 'ESTRADA', 'SOLER', '1991-09-22', 'M', 'N/D', 'rrestrada777@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0601-1973-01687', 'REGINA', 'LIZZETH', 'IZAGUIRRE', 'N/D', '1973-09-03', 'F', 'N/D', 'nd@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0702-1991-00111', 'REYNA', 'ISABEL', 'VALLECILLO', 'VALLECILLO', '1991-05-04', 'F', 'N/D', 'vallecilloelvin@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('1701-1994-01266', 'RINA', 'BEATRÍZ', 'GARCÍA', 'LÓPEZ', '1984-09-08', 'F', 'N/D', 'rina_gl94@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1992-19639', 'RODRIGO', 'DANIEL', 'FLORES', 'ELVIR', '1992-09-26', 'M', 'N/D', 'rflores26992@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('1208-1987-00754', 'RONEY', 'EDULFO', 'LAÍNEZ', 'FIALLOS', '1987-03-03', 'M', 'N/D', 'roneylainez7@yahoo.es', 'Soltero', 'HONDUREÑA', ''),
('0801-1971-10812', 'RONY', 'ALBERTO', 'SIERRA', 'VALLADARES', '1971-10-03', 'M', 'N/D', 'ronysierra1972@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('0301-1990-00206', 'ROSA', 'CRISTINA', 'ESCOBAR', 'SUAZO', '1990-01-11', 'F', 'N/D', 'cristinaescobar940@yahoo.es', 'Soltero', 'HONDUREÑA', ''),
('0801-1960-03413', 'ROSA', 'LOURDES', 'VÁSQUEZ', 'N/D', '1960-07-27', 'F', 'N/D', 'nd@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('1501-1993-03904', 'ROSA', 'MARÍA', 'TURCIOS', 'MERCADAL', '1993-09-06', 'F', 'N/D', 'rmerkdal93@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1993-03148', 'RUDY', 'CAROLINA', 'ZAVALA', 'ZAVALA', '1993-01-27', 'F', 'N/D', 'z.rudycarolina@yahoo.es', 'Soltero', 'HONDUREÑA', ''),
('0313-1993-00221', 'SADY', 'CASILDO', 'RUBI', 'VARELA', '1993-04-15', 'M', 'N/D', 'sadyr2010@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1977-08430', 'SANDRA', 'LIZETH', 'VARELA', 'CARRASCO', '1977-07-07', 'F', 'N/D', 'mayne7@yahoo.es', 'Soltero', 'HONDUREÑA', ''),
('0801-1903-33333', 'SANTOS', 'ÁNGELA', 'CRUZ', 'VARELA', '1903-03-03', 'F', 'N/D', 'nd@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0610-1976-00532', 'SANTOS', 'MÁXIMO', 'ALVAREZ', 'CRUZ', '1976-12-05', 'M', 'N/D', 'santosalvarez2648@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1992-20394', 'SARA', 'CECILIA', 'MADRID', 'LEZAMA', '1992-10-17', 'F', 'N/D', 'saramalez@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('1413-1992-00057', 'SARAÍ', 'ELIZABETH', 'CALLES', 'CHACÓN', '1992-01-26', 'F', 'N/D', 'eli_chacon26@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('1503-1991-01828', 'SINDY', 'GABRIELA', 'ORDÓÑEZ', 'VELÁSQUEZ', '1991-08-27', 'F', 'N/D', 'sindy_olanchana2009@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('1518-1989-00156', 'SINDY', 'PAMELA', 'TURCIOS', 'GARCÍA', '1989-06-13', 'F', 'N/D', 'sindypamela_turciosgarcia@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1985-13024', 'SLOAN', 'GRICEL', 'MARTÍNEZ', 'VARGAS', '1985-05-12', 'F', 'N/D', 'gricelvargas@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('1501-1988-02489', 'SONIA', 'AZUCENA', 'ESCOBAR', 'RODRÍGUEZ', '1988-10-09', 'F', 'N/D', 'azucena_escobar88@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1979-17807', 'SONIA', 'MARIBEL', 'ANDINO', 'MARTÍNEZ', '1960-12-12', 'F', 'N/D', 'sonia.andino12@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1973-06908', 'SULAY', 'GABRIELA', 'CARRANZA', 'CORTÉS', '1973-12-21', 'F', 'N/D', 'gabycarranza73@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('1101-1986-00359', 'TANIA', 'ESILDA', 'ABBOTT', 'BODDEN', '1986-11-14', 'F', 'N/D', 'taniaspecial@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1990-20436', 'VANESSA', 'MARÍA', 'FERRERA', 'CÁCERES', '1990-09-30', 'F', 'N/D', 'vane_2790@yahoo.es', 'Soltero', 'HONDUREÑA', ''),
('0801-1987-21974', 'VICTORIA', 'ALEJANDRA', 'VILLANUEVA', 'GONZÁLEZ', '1987-12-15', 'F', '', 'edues06@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1982-05590', 'VILMA', 'ARACELY', 'ROMERO', 'CORTÉS', '1982-07-18', 'F', 'N/D', 'vazc18@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1982-07427', 'WALDO', 'BLADIMIR', 'CASTELLANOS', 'MEJÍA', '1982-09-28', 'M', 'N/D', 'bladimircastell@yahoo.es', 'Soltero', 'HONDUREÑA', ''),
('1510-1991-00208', 'WENDY', 'KIABETH ', 'FIGUEROA', 'ISASI', '1991-08-11', 'F', 'N/D', 'kiaisasi_91@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1984-16206', 'WENDY', 'XIOMARA', 'AVILA', 'TURCIOS', '1984-10-14', 'F', 'N/D', 'jyx5a_28_84@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1993-01547', 'WENNGY', 'GABRIELA', 'AYALA', 'RIVERA', '1993-01-15', 'F', 'N/D', 'wenngy_@hotmail.es', 'Soltero', 'HONDUREÑA', ''),
('0801-1972-05103', 'WILFREDO', 'N/D', 'RUBIO', 'BARAHONA', '1972-09-21', 'M', 'N/D', 'wil.rubio@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1978-05079', 'XIMENA', 'GABRIELA ', 'TREJO', 'ROMERO', '1978-02-22', 'F', 'N/D', 'gabrielatrejo22@yahoo.es', 'Soltero', 'HONDUREÑA', ''),
('0801-1979-10807', 'YAMILETH', 'ANGÉLICA', 'VÁSQUEZ', 'GÓMEZ', '1979-02-13', 'F', 'N/D', 'vasquezgomezangelicayamileth@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0822-1975-00047', 'YECENIA', 'N/D', 'VÁSQUEZ', 'CABRERA', '1975-04-15', 'F', 'N/D', 'yecenia1649@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('1501-1981-02595', 'YESSICA', 'NINOSKA', 'MATUTE', 'N/D', '1981-03-11', 'F', '', 'relly_estrada@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1982-12183', 'YEYMI', 'ESTHER', 'ORDÓÑEZ', 'LÓPEZ', '1982-05-13', 'F', 'N/D', 'yordonez@poderjudicial.gob.hn', 'Soltero', 'HONDUREÑA', ''),
('0801-1991-03491', 'YEYMI', 'YALENI', 'OLIVA', 'MEJÍA', '1990-11-24', 'F', 'N/D', 'yaleni24@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0715-1989-01068', 'YOJANA', 'LIZETH', 'VELÁSQUEZ', 'ARTICA', '1989-08-28', 'F', 'N/D', 'yojana_esponja@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0803-1960-00095', 'YOLANDA', 'SUYAPA', 'BANEGAS', 'ARCHAGA', '1960-02-12', 'F', 'N/D', 'ysbaarch2011@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1988-10878', 'ZIMRAM', 'NOE', 'DÍAZ', 'LUPIAN', '1988-05-21', 'M', 'N/D', 'zdlupian10@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-0000-00000', 'ANÍBAL', 'IVANS', 'CERRITOS', 'MONCADA', '1900-01-08', 'M', 'N/D', 'nd@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('1503-1980-01992', 'ERICA', 'MILAGRO', 'MUÑOZ', 'FIGUEROA', '1980-12-12', 'F', 'N/D', 'ericka_m81@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('1312-1974-00146', 'ABRAHAM', 'N/D', 'ALVARENGA', 'URBINA', '1900-01-01', 'M', 'N/D', 'nd@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1963-01704', 'ABRAHAM', 'N/D', 'FIGUEROA', 'TERCERO', '1963-01-01', 'M', 'N/D', 'patriotaf3@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1992-16442', 'AÍDA', 'CAROLINA', 'SIERRA', 'TORRES', '1900-01-01', 'F', 'N/D', 'karolina1775@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0309-1990-00014', 'ALDO', 'ADONIS', 'CARDONA', 'MARTÍNEZ', '1990-01-01', 'M', 'N/D', 'aldocardona2011@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0501-1993-00152', 'ALEJANDRA', 'MARÍA', 'RIVERA', 'RODRÍGUEZ', '1900-01-01', 'F', 'N/D', 'ale-rivera-r@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1959-03814', 'ALEX', 'LEONEL', 'NAVAS', 'N/D', '1900-01-01', 'F', 'N/D', 'nd@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1991-19110', 'ALISSON', 'MITCHELL', 'CABRERA', 'GAMEZ', '1900-01-01', 'F', 'N/D', 'nd@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1993-04902', 'ALLAN', 'EDUARDO', 'ARTICA', 'SALINAS', '1900-01-01', 'M', 'N/D', 'allanartica@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1991-09695', 'ALLAN', 'FERNANDO', 'ALVARENGA', 'GRADIS', '1900-01-01', 'M', 'N/D', 'alvarenga_allan91@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1992-04969', 'ALLAN', 'SAMAEL', 'CRUZ', 'HERNÁNDEZ', '1900-01-01', 'M', 'N/D', 'asch.cruz@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1968-01777', 'AMINDA', 'SUYAPA', 'MANZANARES', 'CERRATO', '1900-01-01', 'F', 'N/D', 'mamindasuyapa@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1991-20992', 'AMY', 'ELIZABETH', 'ESCALANTE', 'RODRÍGUEZ', '1900-01-01', 'F', 'N/D', 'amyliz_1309@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1978-00051', 'ANA', 'ELIZABETH', 'REYES', 'CARRASCO', '1900-01-01', 'F', 'N/D', 'aereyes@poderjudicial.gob.hn', 'Soltero', 'HONDUREÑA', ''),
('0801-1988-15506', 'ANA', 'GABRIELA', 'MEJÍA', 'CORRALES', '1900-01-01', 'F', 'N/D', 'anamejia_88@yahoo.es', 'Soltero', 'HONDUREÑA', ''),
('0801-1993-20450', 'ANA', 'RUBÍ', 'PÉREZ', 'COLINDRES', '1900-01-01', 'F', 'N/D', 'ana-rubi1993@hotmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1989-23436', 'ANDREA', 'STEFANÍA', 'LAGOS', 'HERRERA', '1900-01-01', 'F', 'N/D', 'andylagos_h10@hotmail.es', 'Soltero', 'HONDUREÑA', ''),
('0311-1987-00215', 'ARLE', 'DESSENIA', 'ORTÍZ', 'CANALES', '1900-01-01', 'F', 'N/D', 'arleortiz@yahoo.es', 'Soltero', 'HONDUREÑA', ''),
('1312-1989-00085', 'ARMANDO', 'N/D', 'AGUIRRE', 'PORTILLO', '1900-01-01', 'F', 'N/D', 'armandoaguirre98@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('1701-1990-00063', 'AROLD', 'IVERSON', 'MEJÍA', 'MONTES', '1900-01-01', 'F', 'N/D', 'aiverson_i3@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1991-18102', 'BESSY', 'YAMILETH', 'ORTÍZ', 'RAMOS', '1900-01-01', 'F', 'N/D', 'o.bessy@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0301-1990-00485', 'BESY', 'ROCILLO', 'MOLINA', 'SILVA', '1900-01-01', 'F', 'N/D', 'besyrocioms@yahoo.es', 'Soltero', 'HONDUREÑA', ''),
('0806-1962-00063', 'BETTY', 'ARACELY', 'CASTRO', 'N/D', '1900-01-01', 'F', 'N/D', 'bcastro3003@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1978-03326', 'BILLY', 'DANIEL', 'PÉREZ', 'IRÍAS', '1900-01-01', 'M', 'N/D', 'nd@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0801-1974-11622', 'CAMILA', 'MERCEDES', 'ZANNA', 'SEGURA', '1900-01-01', 'F', 'N/D', 'camezase@yahoo.es', 'Soltero', 'HONDUREÑA', ''),
('0501-1974-07945', 'CARLA', 'TERESA', 'BERTRAND', 'MONTOYA', '1900-01-01', 'F', 'N/D', 'carlateresabertrand@yahoo.com.mx', 'Soltero', 'HONDUREÑA', ''),
('0801-1973-02463', 'CARLOS', 'ALBERTO', 'MEDINA', 'HERNANDEZ', '1900-01-01', 'M', 'N/D', 'carlosalberto73.medina@yahoo.com', 'Soltero', 'HONDUREÑA', ''),
('0715-1991-00645', 'CARLOS', 'ALEXIS', 'MATAMOROS', 'SÁNCHEZ', '1900-01-01', 'M', 'N/D', 'cmatamorosjn@gmail.com', 'Soltero', 'HONDUREÑA', ''),
('0815-1990-00184', 'CARLOS', 'EDUARDO', 'ÁVILA', 'FUNEZ', '1900-01-01', 'M', 'N/D', 'avilacarlos360@gmail.com', 'Soltero', 'HONDUREÑA', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `poa`
--

DROP TABLE IF EXISTS `poa`;
CREATE TABLE IF NOT EXISTS `poa` (
  `id_Poa` int(11) NOT NULL auto_increment,
  `nombre` varchar(100) NOT NULL,
  `fecha_de_Inicio` date NOT NULL,
  `fecha_Fin` date NOT NULL,
  `descripcion` text NOT NULL,
  PRIMARY KEY  (`id_Poa`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Volcar la base de datos para la tabla `poa`
--

INSERT INTO `poa` (`id_Poa`, `nombre`, `fecha_de_Inicio`, `fecha_Fin`, `descripcion`) VALUES
(1, 'DESARROLLO CURRICULAR', '2016-01-01', '2016-12-20', ''),
(2, 'CORDINACIÓN DE CARRERA', '2016-01-01', '2016-12-18', ''),
(3, 'SECRETARIA ACADEMICA', '2016-01-01', '2016-12-20', ''),
(4, 'CONSULTORIO JURÍDICO GRATUITO', '2016-01-01', '2016-12-20', ''),
(5, 'POSGRADOS', '2016-01-01', '2016-12-20', ''),
(6, 'UNIDAD DE INVESTIGACIÓN', '2016-01-01', '2016-12-20', ''),
(7, 'INSTITUTO DE INVESTIGACIÓN JURIDICA', '2016-01-01', '2016-12-31', ''),
(8, 'UNIDAD VINCULACIÓN UNIVERSIDAD', '2016-01-01', '2016-12-20', ''),
(9, 'ADMINISTRACIÓN', '2016-01-18', '2016-12-20', ''),
(10, 'DECANATO', '2016-01-18', '2016-12-20', ''),
(12, 'ejemplo febrero 2016', '2016-02-11', '2017-02-11', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prioridad`
--

DROP TABLE IF EXISTS `prioridad`;
CREATE TABLE IF NOT EXISTS `prioridad` (
  `Id_Prioridad` tinyint(4) NOT NULL,
  `DescripcionPrioridad` text NOT NULL,
  PRIMARY KEY  (`Id_Prioridad`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcar la base de datos para la tabla `prioridad`
--

INSERT INTO `prioridad` (`Id_Prioridad`, `DescripcionPrioridad`) VALUES
(1, 'URGENTE'),
(2, 'Trámite Normal');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prioridad_folio`
--

DROP TABLE IF EXISTS `prioridad_folio`;
CREATE TABLE IF NOT EXISTS `prioridad_folio` (
  `Id_PrioridadFolio` int(11) NOT NULL auto_increment,
  `IdFolio` varchar(25) NOT NULL,
  `Id_Prioridad` tinyint(4) NOT NULL,
  `FechaEstablecida` date NOT NULL,
  PRIMARY KEY  (`Id_PrioridadFolio`),
  KEY `fk_prioridad_folio_folios_idx` (`IdFolio`),
  KEY `fk_prioridad_folio_prioridad_idx` (`Id_Prioridad`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=35 ;

--
-- Volcar la base de datos para la tabla `prioridad_folio`
--

INSERT INTO `prioridad_folio` (`Id_PrioridadFolio`, `IdFolio`, `Id_Prioridad`, `FechaEstablecida`) VALUES
(1, '5', 1, '2015-11-16'),
(2, 'OFICIO Nº 001', 1, '2015-11-16'),
(3, 'Nota: ', 1, '2015-11-16'),
(4, 'Oficio No.1372 Inv. Cient', 1, '2015-11-17'),
(5, 'Nota Zahira Núñez', 1, '2015-11-17'),
(6, 'Oficio No.093-MDH', 2, '2015-11-17'),
(7, 'Oficio No.3271-D.G.T.H./S', 2, '2015-11-17'),
(8, 'Nota de fecha 17-nov-2015', 1, '2015-11-17'),
(9, 'Nota de fecha 16/nov/2015', 2, '2015-11-17'),
(10, 'Nota 16/nov./2015', 2, '2015-11-17'),
(11, 'Of.FACES-SC-059', 2, '2015-11-17'),
(12, 'RU-NO.1083-2015', 2, '2015-11-18'),
(13, 'Invitación', 2, '2015-11-18'),
(14, 'SEDI OFICIO NO.636', 2, '2015-11-18'),
(15, 'CC. Oficio CCD-101-2015', 2, '2015-11-18'),
(16, 'CC Oficio CC-100-2015', 2, '2015-11-18'),
(17, 'CC Oficio CCD-102-2015', 2, '2015-11-18'),
(18, 'Nota: 14-nov-2015', 2, '2015-11-19'),
(19, 'Oficio 1232 SEDP', 2, '2015-11-19'),
(20, 'Oficio SCU-162-2015', 2, '2015-11-20'),
(21, 'Oficio SCU-161-2015', 2, '2015-11-20'),
(22, 'Oficio 1336-D-E.L./S.E.D.', 2, '2015-11-20'),
(23, 'DIRCOM Oficio No.641', 2, '2015-11-20'),
(24, 'SEDI Oficio No.640', 2, '2015-11-20'),
(25, 'Oficio VOAE 819-2015', 2, '2015-11-20'),
(26, 'Oficio No.312 DCJG-FCJ', 2, '2015-11-20'),
(27, 'Nabil Kawas: INVITACION', 2, '2015-11-20'),
(28, 'Nota 20 de nov. 2015', 2, '2015-11-24'),
(29, 'Nota 25-nov-2015 FUUD-Der', 1, '2015-11-25'),
(30, 'CDM-107', 2, '2015-11-25'),
(31, 'Oficio SFCJ-172', 2, '2015-11-25'),
(32, 'Oficio JDU-UNAH-No.364', 2, '2015-11-25'),
(33, '2 libros/inv. Ciencias Es', 1, '2015-11-25'),
(34, 'Oficio No.663-FCJ', 2, '2015-11-25');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `responsables_por_actividad`
--

DROP TABLE IF EXISTS `responsables_por_actividad`;
CREATE TABLE IF NOT EXISTS `responsables_por_actividad` (
  `id_Responsable_por_Actividad` int(11) NOT NULL auto_increment,
  `id_Actividad` int(11) NOT NULL,
  `id_Responsable` int(11) NOT NULL,
  `fecha_Asignacion` date NOT NULL,
  `observacion` text,
  PRIMARY KEY  (`id_Responsable_por_Actividad`),
  KEY `id_Actividad` (`id_Actividad`,`id_Responsable`),
  KEY `id_Responsable` (`id_Responsable`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=239 ;

--
-- Volcar la base de datos para la tabla `responsables_por_actividad`
--

INSERT INTO `responsables_por_actividad` (`id_Responsable_por_Actividad`, `id_Actividad`, `id_Responsable`, `fecha_Asignacion`, `observacion`) VALUES
(1, 1, 1, '2015-11-18', ''),
(2, 2, 2, '2016-01-11', ''),
(3, 3, 2, '2016-01-11', ''),
(4, 4, 2, '2016-01-11', ''),
(5, 5, 2, '2016-01-11', ''),
(6, 6, 2, '2016-01-11', ''),
(7, 7, 2, '2016-01-11', ''),
(8, 8, 2, '2016-01-11', ''),
(9, 35, 2, '2016-01-12', ''),
(10, 41, 2, '2016-01-12', ''),
(11, 52, 2, '2016-01-12', ''),
(12, 53, 2, '2016-01-12', ''),
(13, 54, 2, '2016-01-12', ''),
(14, 55, 2, '2016-01-12', ''),
(15, 56, 2, '2016-01-12', ''),
(16, 57, 2, '2016-01-12', ''),
(17, 66, 2, '2016-01-12', ''),
(18, 70, 2, '2016-01-12', ''),
(19, 72, 2, '2016-01-12', ''),
(20, 73, 2, '2016-01-12', ''),
(21, 74, 2, '2016-01-12', ''),
(22, 75, 2, '2016-01-12', ''),
(23, 76, 2, '2016-01-12', ''),
(24, 77, 2, '2016-01-12', ''),
(25, 77, 2, '2016-01-12', ''),
(26, 78, 2, '2016-01-12', ''),
(27, 79, 2, '2016-01-12', ''),
(28, 80, 2, '2016-01-12', ''),
(29, 81, 2, '2016-01-12', ''),
(30, 94, 2, '2016-01-13', ''),
(31, 94, 2, '2016-01-13', ''),
(32, 109, 2, '2016-01-13', ''),
(33, 11, 3, '2016-01-13', ''),
(34, 12, 0, '2016-01-13', ''),
(35, 12, 3, '2016-01-13', ''),
(36, 13, 3, '2016-01-13', ''),
(37, 14, 3, '2016-01-13', ''),
(38, 15, 3, '2016-01-13', ''),
(39, 16, 3, '2016-01-13', ''),
(40, 17, 3, '2016-01-13', ''),
(41, 18, 3, '2016-01-13', ''),
(42, 19, 0, '2016-01-13', ''),
(43, 19, 3, '2016-01-13', ''),
(44, 20, 3, '2016-01-13', ''),
(45, 21, 3, '2016-01-13', ''),
(46, 36, 3, '2016-01-13', ''),
(47, 37, 3, '2016-01-13', ''),
(48, 38, 3, '2016-01-13', ''),
(49, 39, 3, '2016-01-13', ''),
(50, 40, 3, '2016-01-13', ''),
(51, 42, 3, '2016-01-13', ''),
(52, 43, 3, '2016-01-13', ''),
(53, 44, 3, '2016-01-13', ''),
(54, 45, 3, '2016-01-13', ''),
(55, 46, 3, '2016-01-13', ''),
(56, 47, 3, '2016-01-13', ''),
(57, 48, 3, '2016-01-13', ''),
(58, 110, 2, '2016-01-13', ''),
(59, 111, 2, '2016-01-13', ''),
(60, 49, 3, '2016-01-13', ''),
(61, 112, 2, '2016-01-13', ''),
(62, 113, 2, '2016-01-13', ''),
(63, 50, 3, '2016-01-13', ''),
(64, 51, 3, '2016-01-13', ''),
(65, 58, 3, '2016-01-13', ''),
(66, 59, 3, '2016-01-13', ''),
(67, 60, 3, '2016-01-13', ''),
(68, 61, 3, '2016-01-13', ''),
(69, 62, 3, '2016-01-13', ''),
(70, 63, 3, '2016-01-13', ''),
(71, 64, 3, '2016-01-13', ''),
(72, 115, 2, '2016-01-13', ''),
(73, 65, 3, '2016-01-13', ''),
(74, 67, 3, '2016-01-13', ''),
(75, 116, 4, '2016-01-13', ''),
(76, 68, 3, '2016-01-13', ''),
(77, 69, 3, '2016-01-13', ''),
(78, 117, 4, '2016-01-13', ''),
(79, 71, 3, '2016-01-13', ''),
(80, 118, 4, '2016-01-13', ''),
(81, 82, 5, '2016-01-13', ''),
(82, 119, 4, '2016-01-13', ''),
(83, 83, 5, '2016-01-13', ''),
(84, 84, 5, '2016-01-13', ''),
(85, 85, 5, '2016-01-13', ''),
(86, 86, 5, '2016-01-13', ''),
(87, 87, 5, '2016-01-13', ''),
(88, 88, 5, '2016-01-13', ''),
(89, 89, 5, '2016-01-13', ''),
(90, 91, 5, '2016-01-13', ''),
(91, 92, 5, '2016-01-13', ''),
(92, 93, 5, '2016-01-13', ''),
(93, 95, 5, '2016-01-13', ''),
(94, 96, 5, '2016-01-13', ''),
(95, 97, 5, '2016-01-13', ''),
(96, 98, 5, '2016-01-13', ''),
(97, 99, 5, '2016-01-13', ''),
(98, 100, 5, '2016-01-13', ''),
(99, 101, 5, '2016-01-13', ''),
(100, 120, 4, '2016-01-13', ''),
(101, 102, 5, '2016-01-13', ''),
(102, 104, 5, '2016-01-13', ''),
(103, 105, 5, '2016-01-13', ''),
(104, 106, 5, '2016-01-13', ''),
(105, 107, 5, '2016-01-13', ''),
(106, 108, 5, '2016-01-13', ''),
(107, 121, 6, '2016-01-13', ''),
(108, 121, 6, '2016-01-13', ''),
(109, 122, 6, '2016-01-13', ''),
(110, 123, 6, '2016-01-13', ''),
(111, 124, 6, '2016-01-13', ''),
(112, 125, 4, '2016-01-13', ''),
(113, 126, 6, '2016-01-13', ''),
(114, 127, 6, '2016-01-13', ''),
(115, 128, 6, '2016-01-13', ''),
(116, 129, 6, '2016-01-13', ''),
(117, 130, 4, '2016-01-13', ''),
(118, 131, 4, '2016-01-13', ''),
(119, 132, 4, '2016-01-13', ''),
(120, 133, 6, '2016-01-13', ''),
(121, 134, 6, '2016-01-13', ''),
(122, 138, 4, '2016-01-13', ''),
(123, 135, 6, '2016-01-13', ''),
(124, 136, 6, '2016-01-13', ''),
(125, 137, 6, '2016-01-13', ''),
(126, 139, 6, '2016-01-13', ''),
(127, 140, 6, '2016-01-13', ''),
(128, 141, 6, '2016-01-13', ''),
(129, 142, 6, '2016-01-13', ''),
(130, 143, 6, '2016-01-13', ''),
(131, 144, 6, '2016-01-13', ''),
(132, 145, 6, '2016-01-13', ''),
(133, 146, 6, '2016-01-13', ''),
(134, 147, 6, '2016-01-13', ''),
(135, 148, 6, '2016-01-13', ''),
(136, 149, 6, '2016-01-13', ''),
(137, 150, 6, '2016-01-13', ''),
(138, 151, 6, '2016-01-13', ''),
(139, 152, 6, '2016-01-13', ''),
(140, 154, 8, '2016-01-13', ''),
(141, 155, 8, '2016-01-13', ''),
(142, 156, 8, '2016-01-13', ''),
(143, 157, 8, '2016-01-13', ''),
(144, 158, 8, '2016-01-13', ''),
(145, 161, 7, '2016-01-13', ''),
(146, 163, 7, '2016-01-13', ''),
(147, 164, 7, '2016-01-13', ''),
(148, 162, 8, '2016-01-13', ''),
(149, 165, 7, '2016-01-13', ''),
(150, 166, 8, '2016-01-13', ''),
(151, 167, 8, '2016-01-13', ''),
(152, 168, 7, '2016-01-13', ''),
(153, 169, 8, '2016-01-13', ''),
(154, 170, 8, '2016-01-13', ''),
(155, 171, 7, '2016-01-13', ''),
(156, 172, 8, '2016-01-13', ''),
(157, 173, 7, '2016-01-13', ''),
(158, 176, 7, '2016-01-13', ''),
(159, 175, 8, '2016-01-13', ''),
(160, 174, 8, '2016-01-13', ''),
(161, 177, 7, '2016-01-13', ''),
(162, 182, 7, '2016-01-13', ''),
(163, 178, 8, '2016-01-13', ''),
(164, 183, 7, '2016-01-13', ''),
(165, 179, 9, '2016-01-13', ''),
(166, 180, 8, '2016-01-13', ''),
(167, 184, 9, '2016-01-13', ''),
(168, 184, 8, '2016-01-13', ''),
(169, 185, 8, '2016-01-13', ''),
(170, 187, 3, '2016-01-13', ''),
(171, 186, 8, '2016-01-13', ''),
(172, 187, 9, '2016-01-13', ''),
(173, 188, 8, '2016-01-13', ''),
(174, 189, 8, '2016-01-13', ''),
(175, 190, 8, '2016-01-13', ''),
(176, 191, 8, '2016-01-13', ''),
(177, 193, 8, '2016-01-14', ''),
(178, 194, 8, '2016-01-14', ''),
(179, 195, 8, '2016-01-14', ''),
(180, 197, 8, '2016-01-14', ''),
(181, 198, 8, '2016-01-14', ''),
(182, 199, 8, '2016-01-14', ''),
(183, 198, 8, '2016-01-14', ''),
(184, 200, 8, '2016-01-14', ''),
(185, 192, 9, '2016-01-14', ''),
(186, 201, 9, '2016-01-14', ''),
(187, 202, 8, '2016-01-14', ''),
(188, 203, 8, '2016-01-14', ''),
(189, 204, 8, '2016-01-14', ''),
(190, 205, 9, '2016-01-14', ''),
(191, 206, 9, '2016-01-14', ''),
(192, 207, 9, '2016-01-14', ''),
(193, 208, 9, '2016-01-14', ''),
(194, 210, 9, '2016-01-14', ''),
(195, 211, 9, '2016-01-14', ''),
(196, 212, 10, '2016-01-15', ''),
(197, 213, 10, '2016-01-15', ''),
(198, 214, 10, '2016-01-15', ''),
(199, 215, 10, '2016-01-15', ''),
(200, 216, 10, '2016-01-15', ''),
(201, 218, 10, '2016-01-15', ''),
(202, 219, 10, '2016-01-15', ''),
(203, 221, 10, '2016-01-15', ''),
(204, 222, 10, '2016-01-15', ''),
(205, 223, 10, '2016-01-15', ''),
(206, 224, 11, '2016-01-15', ''),
(207, 225, 11, '2016-01-15', ''),
(208, 226, 11, '2016-01-15', ''),
(209, 227, 11, '2016-01-15', ''),
(210, 228, 11, '2016-01-15', ''),
(211, 229, 11, '2016-01-15', ''),
(212, 230, 11, '2016-01-15', ''),
(213, 231, 11, '2016-01-15', ''),
(214, 232, 11, '2016-01-15', ''),
(215, 233, 11, '2016-01-15', ''),
(216, 234, 11, '2016-01-15', ''),
(217, 235, 11, '2016-01-15', ''),
(218, 236, 11, '2016-01-15', ''),
(219, 237, 11, '2016-01-15', ''),
(220, 238, 11, '2016-01-15', ''),
(221, 239, 11, '2016-01-15', ''),
(222, 240, 11, '2016-01-15', ''),
(223, 241, 11, '2016-01-15', ''),
(224, 242, 11, '2016-01-15', ''),
(225, 243, 11, '2016-01-18', ''),
(226, 244, 11, '2016-01-18', ''),
(227, 245, 11, '2016-01-18', ''),
(228, 246, 11, '2016-01-18', ''),
(229, 247, 11, '2016-01-18', ''),
(230, 248, 11, '2016-01-18', ''),
(231, 249, 11, '2016-01-18', ''),
(232, 250, 11, '2016-01-18', ''),
(233, 253, 11, '2016-01-18', ''),
(234, 254, 11, '2016-01-18', ''),
(235, 255, 11, '2016-01-18', ''),
(236, 256, 11, '2016-01-18', ''),
(237, 258, 11, '2016-01-18', ''),
(238, 260, 1, '2016-02-11', 'na');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `Id_Rol` tinyint(4) NOT NULL,
  `Descripcion` text NOT NULL,
  PRIMARY KEY  (`Id_Rol`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcar la base de datos para la tabla `roles`
--

INSERT INTO `roles` (`Id_Rol`, `Descripcion`) VALUES
(10, 'Usuario Básico'),
(20, 'Docente'),
(29, 'Asistente Jefatura'),
(30, 'Jefe Departamento'),
(40, 'Secretaria General'),
(45, 'Secretaria Decana'),
(50, 'Decano'),
(100, 'root');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sa_ciudades`
--

DROP TABLE IF EXISTS `sa_ciudades`;
CREATE TABLE IF NOT EXISTS `sa_ciudades` (
  `codigo` int(11) NOT NULL auto_increment,
  `nombre` varchar(50) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=20 ;

--
-- Volcar la base de datos para la tabla `sa_ciudades`
--

INSERT INTO `sa_ciudades` (`codigo`, `nombre`) VALUES
(2, 'ISLAS DE LA BAHÍA'),
(3, 'COLÓN'),
(4, 'ATLÁNTIDA'),
(5, 'CORTÉS'),
(6, 'SANTA BÁRBARA'),
(7, 'COPÁN'),
(8, 'GRACIAS A DIOS'),
(9, 'OCOTEPEQUE'),
(10, 'LEMPIRA'),
(11, 'YORO'),
(12, 'INTIBUCÁ'),
(13, 'COMAYAGUA'),
(14, 'LA PAZ'),
(15, 'OLANCHO'),
(16, 'FRANCISCO MORAZÁN'),
(17, 'VALLE'),
(18, 'CHOLUTECA'),
(19, 'EL PARAÍSO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sa_estados_solicitud`
--

DROP TABLE IF EXISTS `sa_estados_solicitud`;
CREATE TABLE IF NOT EXISTS `sa_estados_solicitud` (
  `codigo` int(11) NOT NULL auto_increment,
  `descripcion` varchar(50) NOT NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Volcar la base de datos para la tabla `sa_estados_solicitud`
--

INSERT INTO `sa_estados_solicitud` (`codigo`, `descripcion`) VALUES
(1, 'Activo'),
(2, 'Inactivo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sa_estudiantes`
--

DROP TABLE IF EXISTS `sa_estudiantes`;
CREATE TABLE IF NOT EXISTS `sa_estudiantes` (
  `dni` varchar(20) NOT NULL,
  `no_cuenta` varchar(11) NOT NULL,
  `anios_inicio_estudio` varchar(11) NOT NULL,
  `indice_academico` decimal(10,0) NOT NULL,
  `fecha_registro` date NOT NULL,
  `uv_acumulados` int(11) NOT NULL,
  `cantcodad_solicitudes` int(11) default NULL,
  `cod_plan_estudio` int(11) NOT NULL,
  `cod_ciudad_origen` int(11) NOT NULL,
  `cod_orientacion` int(11) NOT NULL,
  `cod_residencia_actual` int(11) NOT NULL,
  `anios_final_estudio` varchar(11) NOT NULL,
  `grupo_etnico` varchar(100) default NULL,
  `carrera_anterior` varchar(100) default NULL,
  `aniosDerecho1` int(11) default NULL,
  `aniosDerecho2` int(11) default NULL,
  PRIMARY KEY  (`dni`),
  UNIQUE KEY `no_cuenta_estudiantes_UC` (`no_cuenta`),
  KEY `estudiante_plan_FK_idx` (`cod_plan_estudio`),
  KEY `estudiante_ciudad_FK_idx` (`cod_ciudad_origen`),
  KEY `estudiante_orientacion_FK_idx` (`cod_orientacion`),
  KEY `estudiantes_lugar_origen_FK_idx` (`cod_residencia_actual`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcar la base de datos para la tabla `sa_estudiantes`
--

INSERT INTO `sa_estudiantes` (`dni`, `no_cuenta`, `anios_inicio_estudio`, `indice_academico`, `fecha_registro`, `uv_acumulados`, `cantcodad_solicitudes`, `cod_plan_estudio`, `cod_ciudad_origen`, `cod_orientacion`, `cod_residencia_actual`, `anios_final_estudio`, `grupo_etnico`, `carrera_anterior`, `aniosDerecho1`, `aniosDerecho2`) VALUES
('0107-1964-00758', '8210375', '1982', 74, '2015-11-30', 188, NULL, 2, 4, 1, 16, '2015', ' GARÍFUNA', 'CIENCIAS POLICIALES', 0, 0),
('0801-1988-16527', '20081010747', '0', 0, '2015-12-01', 180, NULL, 1, 16, 6, 16, '0', ' ND', 'CONTADURÍA PÚBLICA Y FINANZAS', NULL, NULL),
('0703-1991-02848', '20091000057', '2010', 79, '2015-12-04', 274, NULL, 1, 19, 6, 16, '2015', '', '', 2009, 2015),
('0801-1993-08892', '20111012526', '0', 0, '2016-01-07', 1, NULL, 1, 16, 6, 16, '0', ' MESTIZO', '', 0, 0),
('0801-1976-12903', '9611340', '1996', 74, '2016-01-07', 1, NULL, 2, 16, 1, 16, '2015', ' ', '', 1996, 2015),
('0801-1987-14954', '20061003527', '2009', 77, '2016-01-07', 262, NULL, 1, 16, 6, 16, '2015', ' ', '', 2009, 2015),
('0826-1991-00215', '20101002886', '0', 0, '2016-01-07', 1, NULL, 1, 16, 6, 16, '0', ' MESTIZO', '', 0, 0),
('0801-1991-03431', '20091012240', '0', 0, '2016-01-07', 1, NULL, 1, 16, 6, 16, '0', ' ', '', 0, 0),
('0801-1991-09840', '20101005716', '2010', 0, '2016-01-07', 1, NULL, 1, 16, 6, 16, '2015', ' ', '', 2010, 2015),
('0801-1969-07472', '9213923', '1992', 67, '2016-01-09', 214, NULL, 2, 16, 1, 16, '2015', ' MESTIZO', '', 1992, 2015),
('0801-1976-02179', '20011005565', '2001', 75, '2016-01-09', 214, NULL, 2, 16, 1, 16, '2015', 'MESTIZO', '', 2001, 2015),
('0611-1978-00092', '20031003837', '2003', 70, '2016-01-09', 195, NULL, 2, 18, 1, 16, '2013', '', '', 2003, 2013),
('1201-1991-00568', '20091001817', '2009', 81, '2016-01-11', 267, NULL, 1, 14, 1, 16, '2015', ' ', '', 2009, 2015),
('0801-1991-20952', '20101011081', '0', 0, '2016-01-11', 1, NULL, 1, 16, 6, 16, '0', 'CAUCASICO ', 'QUIMICA Y FARMACIA', 0, 0),
('0826-1990-00247', '20091011063', '2010', 85, '2016-01-11', 264, NULL, 1, 16, 6, 16, '2015', ' ', 'PERIODISMO', 2009, 2015),
('1707-1990-00473', '20102300209', '2010', 80, '2016-01-11', 264, NULL, 1, 17, 6, 16, '2015', ' ', '', 2010, 2015),
('0801-1969-01524', '20051004662', '0', 0, '2016-01-11', 1, NULL, 1, 16, 6, 16, '0', ' MESTIZO', 'PERIODISMO', 0, 0),
('0801-1992-21136', '20101010138', '2010', 84, '2016-01-11', 261, NULL, 1, 16, 6, 16, '2015', ' ', '', 2010, 2015),
('0607-1983-00483', '20022003173', '2002', 71, '2016-01-11', 207, NULL, 2, 18, 1, 16, '2015', ' ', '', 2002, 2015),
('1201-1991-00180', '20081900616', '0', 0, '2016-01-11', 1, NULL, 1, 14, 6, 16, '0', ' MESTIZO', 'ADMINISTRACIÓN DE EMPRESAS', 0, 0),
('1508-1992-00289', '20101010513', '2010', 80, '2016-01-11', 261, NULL, 1, 13, 6, 16, '2015', ' ', '', 2010, 2015),
('0704-1989-01096', '20081002246', '2008', 85, '2016-01-11', 264, NULL, 1, 19, 6, 16, '2015', ' ', '', 2008, 2015),
('0801-1993-02922', '20101000555', '2011', 79, '2016-01-11', 271, NULL, 1, 16, 6, 16, '2015', ' ', '', 2011, 2015),
('0801-1992-00587', '20091004384', '0', 0, '2016-01-11', 1, NULL, 1, 16, 6, 16, '0', ' ', '', 0, 0),
('0318-1990-01175', '20081000709', '2008', 79, '2016-01-11', 290, NULL, 1, 13, 6, 16, '2015', ' ', '', 2008, 2015),
('1519-1993-00016', '20101005916', '2010', 87, '2016-01-11', 261, NULL, 1, 15, 6, 16, '2015', ' ', '', 2010, 2015),
('0604-1982-00109', '20021002381', '2003', 69, '2016-01-11', 196, NULL, 2, 18, 1, 16, '2014', ' ', '', 2003, 2014),
('1001-1993-00368', '20101000999', '0', 0, '2016-01-11', 1, NULL, 1, 12, 6, 16, '0', ' ', 'LETRAS', 0, 0),
('0801-1991-05576', '20101011057', '0', 0, '2016-01-11', 1, NULL, 1, 16, 6, 16, '0', ' ', '', 0, 0),
('0801-1976-04001', '9612216', '1996', 72, '2016-01-11', 196, NULL, 2, 16, 1, 16, '2015', ' MESTIZO', '', 1996, 2015),
('0801-1958-07367', '20061000244', '2006', 74, '2016-01-11', 273, NULL, 1, 16, 6, 16, '2015', ' ', '', 2006, 2015),
('1806-1990-00561', '20102001968', '2010', 77, '2016-01-11', 238, NULL, 1, 11, 6, 16, '2015', ' ', '', 2010, 2015),
('0703-1991-01757', '20081902127', '0', 0, '2016-01-11', 1, NULL, 1, 16, 6, 16, '0', ' ', '', 0, 0),
('1207-1982-00019', '20021006349', '2002', 69, '2016-01-11', 201, NULL, 2, 14, 1, 16, '2015', ' ', '', 2002, 2015),
('0801-1978-01136', '9712223', '1997', 70, '2016-01-11', 192, NULL, 2, 16, 1, 16, '2015', ' ', '', 1997, 2015),
('0801-1987-05231', '20101011060', '0', 0, '2016-01-11', 1, NULL, 1, 16, 6, 16, '0', ' MESTIZO', 'MUSICA', 0, 0),
('0801-1991-14156', '20101000016', '2010', 86, '2016-01-11', 261, NULL, 1, 16, 6, 16, '2015', ' ', '', 2010, 2015),
('0805-1985-00294', '20021004454', '2002', 71, '2016-01-11', 211, NULL, 2, 2, 1, 2, '2007', ' ', '', 2002, 2007),
('0801-1982-09229', '20011006611', '2001', 85, '2016-01-11', 272, NULL, 1, 16, 6, 16, '2015', ' ', '', 2001, 2015),
('1501-1993-03877', '20111005603', '0', 0, '2016-01-11', 1, NULL, 1, 15, 6, 16, '0', ' ', '', 0, 0),
('0601-1990-02144', '20081011135', '0', 0, '2016-01-11', 1, NULL, 1, 18, 6, 16, '0', ' MESTIZO', 'PERIODISMO', 0, 0),
('0801-1991-11985', '20091001930', '0', 0, '2016-01-11', 1, NULL, 1, 16, 6, 16, '0', ' MESTIZO', 'ADMINISTRACION DE EMPRESAS', 0, 0),
('0801-1994-00660', '20111004373', '0', 0, '2016-01-11', 1, NULL, 1, 16, 6, 16, '0', ' MESTIZO', '', 0, 0),
('0301-1991-02655', '20070003436', '0', 0, '2016-01-11', 1, NULL, 1, 13, 6, 16, '0', ' MESTIZO', '', 0, 0),
('0101-1991-02420', '20101003932', '0', 0, '2016-01-11', 1, NULL, 1, 4, 6, 13, '0', ' ', '', 0, 0),
('0801-1977-00361', '20091012815', '2009', 80, '2016-01-11', 261, NULL, 1, 16, 6, 16, '2015', ' ', '', 2009, 2015),
('0801-1993-01558', '20101010043', '2010', 86, '2016-01-11', 275, NULL, 1, 16, 6, 16, '2015', ' ', '', 2010, 2015),
('1503-1993-01018', '20101000557', '2010', 89, '2016-01-11', 262, NULL, 1, 15, 6, 16, '2015', ' ', '', 2010, 2015),
('0801-1992-15583', '20111003036', '0', 0, '2016-01-11', 1, NULL, 1, 16, 6, 16, '0', ' MESTIZO', 'COMERCIO INTERNACIONAL', 0, 0),
('0801-1991-19754', '20091013086', '2009', 80, '2016-01-11', 269, NULL, 1, 16, 6, 16, '2015', ' ', '', 2009, 2015),
('0801-1975-22988', '9512327', '1995', 69, '2016-01-11', 196, NULL, 1, 16, 3, 16, '2007', ' ', '', 1995, 2007),
('1511-1959-00089', '9812883', '1998', 70, '2016-01-11', 190, NULL, 2, 15, 1, 16, '2015', ' ', '', 1998, 2015),
('1007-1983-00313', '20041300035', '0', 0, '2016-01-11', 1, NULL, 1, 12, 6, 16, '0', ' LENCA', 'PEDAGOGIA', 0, 0),
('0822-1985-00305', '20101000750', '2010', 79, '2016-01-11', 261, NULL, 1, 16, 6, 16, '2015', ' ', '', 2010, 2015),
('0801-1990-22215', '20081003692', '2008', 71, '2016-01-11', 273, NULL, 1, 16, 6, 16, '2015', ' ', '', 2008, 2015),
('0801-1990-14788', '20101000973', '2011', 0, '2016-01-11', 1, NULL, 1, 16, 6, 16, '0', ' MESTIZO', 'QUIMICA Y FARMACIA', 2010, 0),
('0801-1967-05372', '8712161', '1987', 71, '2016-01-11', 198, NULL, 2, 16, 5, 16, '2015', ' ', '', 1987, 2015),
('0801-1980-12749', '20021001610', '0', 0, '2016-01-11', 1, NULL, 1, 16, 6, 16, '0', ' MESTIZO', '', 0, 0),
('1503-1993-00704', '20101010501', '0', 0, '2016-01-11', 1, NULL, 1, 15, 6, 16, '0', ' MESTIZO', '', 0, 0),
('1310-1990-00053', '20092100082', '2009', 80, '2016-01-11', 273, NULL, 1, 10, 6, 16, '2015', ' ', '', 2009, 2015),
('0601-1978-02416', '9910192', '1999', 70, '2016-01-11', 203, NULL, 2, 18, 1, 16, '2015', ' ', '', 1999, 2015),
('1201-1953-00047', '7411364', '1985', 72, '2016-01-12', 216, NULL, 2, 14, 1, 13, '2010', ' ', 'ADMINISTRACIÓN PUBLICA', 1974, 2010),
('1503-1968-00059', '8814305', '2008', 74, '2016-01-12', 274, NULL, 1, 2, 6, 16, '2013', ' ', '', 1988, 2013),
('0702-1991-00199', '20091001289', '2009', 85, '2016-01-12', 277, NULL, 1, 19, 6, 16, '2015', ' ', '', 2009, 2015),
('0705-1977-00029', '9714667', '1997', 67, '2016-01-12', 199, NULL, 2, 19, 2, 16, '2014', ' ', '', 1997, 2014),
('0501-1973-09295', '9312271', '1999', 70, '2016-01-12', 217, NULL, 2, 5, 1, 16, '2007', ' ', '', 1993, 2007),
('0411-1991-00167', '20091002032', '2009', 80, '2016-01-12', 269, NULL, 1, 7, 6, 16, '2015', ' ', '', 2009, 2015),
('0501-1973-05537', '9315666', '1993', 72, '2016-01-12', 209, NULL, 2, 2, 1, 16, '2014', ' ', '', 1993, 2014),
('0801-1990-17641', '20091002764', '2009', 81, '2016-01-12', 267, NULL, 1, 16, 6, 16, '2015', ' ', '', 2009, 2015),
('1208-1992-00101', '20101000862', '0', 0, '2016-01-12', 1, NULL, 1, 14, 6, 16, '0', ' LENCA', '', 0, 0),
('0801-1991-06078', '20070004578', '2007', 76, '2016-01-12', 266, NULL, 1, 16, 6, 16, '2015', ' ', '', 2007, 2015),
('1501-1989-01146', '20070001864', '0', 0, '2016-01-12', 1, NULL, 1, 15, 6, 16, '0', ' MESTIZO', '', 0, 0),
('0801-1990-11492', '20111013681', '0', 0, '2016-01-12', 1, NULL, 1, 16, 6, 16, '0', ' ', '', 0, 0),
('0801-1967-05937', '9816956', '1998', 67, '2016-01-12', 191, NULL, 2, 16, 1, 16, '2015', ' ', '', 1998, 2015),
('0801-1991-24747', '20091011454', '2009', 80, '2016-01-12', 261, NULL, 1, 16, 6, 16, '2015', ' ', '', 2009, 2015),
('0801-1993-03083', '20111003529', '0', 0, '2016-01-12', 1, NULL, 1, 16, 6, 16, '0', ' MESTIZO', '', 0, 0),
('0801-1991-19039', '20101000635', '0', 0, '2016-01-13', 1, NULL, 1, 16, 6, 16, '0', ' MESTIZO', '', 0, 0),
('0703-1992-04401', '20091002103', '0', 0, '2016-01-13', 1, NULL, 1, 19, 6, 16, '0', ' MESTIZO', '', 0, 0),
('0801-1986-10887', '20091012201', '2009', 78, '2016-01-13', 261, NULL, 1, 16, 6, 16, '2015', ' ', '', 2009, 2015),
('1601-1971-00224', '9213531', '1993', 66, '2016-01-13', 194, NULL, 2, 2, 2, 2, '2013', ' ND', '', 1993, 2013),
('0801-1994-07145', '20101010107', '2010', 90, '2016-01-13', 269, NULL, 1, 16, 1, 16, '2015', ' ', '', 2010, 2015),
('0801-1991-11506', '20101010582', '0', 0, '2016-01-13', 1, NULL, 1, 16, 6, 16, '0', ' MESTIZO', '', 0, 0),
('1809-1953-00185', '7919490', '1995', 69, '2016-01-13', 219, NULL, 2, 11, 5, 16, '2010', ' ', 'MEDICINA', 1980, 2010),
('0801-1966-09237', '20021005066', '2002', 67, '2016-01-13', 204, NULL, 2, 16, 2, 16, '2014', ' ', '', 2002, 2014),
('0801-1966-08396', '9812918', '1998', 67, '2016-01-13', 193, NULL, 2, 16, 2, 16, '2015', ' ', '', 1998, 2015),
('0801-1994-00789', '20111004376', '0', 0, '2016-01-13', 1, NULL, 1, 16, 6, 16, '0', ' ', '', 0, 0),
('0801-1990-15523', '20091001021', '0', 0, '2016-01-13', 1, NULL, 1, 16, 6, 16, '0', ' MESTIZO', '', 0, 0),
('0801-1956-00332', '7610402', '1976', 69, '2016-01-13', 189, NULL, 2, 16, 2, 16, '2010', ' ', '', 1976, 2010),
('0611-1983-00842', '20070002261', '0', 0, '2016-01-13', 1, NULL, 1, 18, 6, 16, '0', ' MESTIZO', '', 0, 0),
('0801-1964-06649', '8413433', '1984', 70, '2016-01-13', 200, NULL, 2, 2, 1, 2, '2007', ' ', '', 1984, 2007),
('0801-1989-13308', '20070007185', '0', 0, '2016-01-13', 1, NULL, 1, 16, 6, 16, '0', ' MESTIZO', 'ODONTOLOGIA', 0, 0),
('0801-1954-03188', '14223', '2010', 76, '2016-01-13', 278, NULL, 1, 16, 6, 16, '2014', ' ', '', 1973, 2014),
('0801-1991-11603', '20101003606', '0', 0, '2016-01-13', 1, NULL, 1, 16, 6, 16, '0', ' MESTIZO', '', 0, 0),
('1709-1990-00426', '20091102013', '2009', 82, '2016-01-13', 268, NULL, 1, 17, 6, 16, '2015', ' MESTIZO', '', 2009, 2015),
('1708-1974-00122', '9910565', '1999', 69, '2016-01-13', 202, NULL, 2, 17, 2, 16, '2014', ' ', '', 1999, 2014),
('0801-1977-12263', '9812645', '1998', 72, '2016-01-13', 198, NULL, 2, 16, 1, 16, '2014', ' MESTIZO', '', 1998, 2014),
('0703-1988-02624', '20091012034', '2009', 81, '2016-01-13', 261, NULL, 1, 19, 6, 16, '2015', ' ', '', 2009, 2015),
('0801-1987-09326', '20051008272', '2005', 71, '2016-01-13', 265, NULL, 1, 16, 6, 16, '2015', ' ', '', 2005, 2015),
('0801-1979-04263', '9512008', '1995', 74, '2016-01-13', 197, NULL, 2, 16, 3, 16, '2015', ' MESTIZO', '', 1995, 2015),
('0801-1990-21356', '20101003366', '2010', 81, '2016-01-13', 261, NULL, 1, 16, 6, 16, '2015', ' ', '', 2010, 2015),
('0801-1985-09994', '20061007178', '2010', 77, '2016-01-13', 270, NULL, 1, 16, 6, 16, '2015', ' ', 'PERIODISMO', 2006, 2015),
('0801-1983-15889', '20081005680', '0', 0, '2016-01-13', 1, NULL, 1, 16, 6, 16, '0', ' MESTIZO', '', 0, 0),
('0101-1991-00807', '20091001132', '2009', 79, '2016-01-13', 267, NULL, 1, 4, 6, 16, '2015', ' ', '', 2009, 2015),
('0801-1958-03532', '20021002513', '2002', 74, '2016-01-13', 189, NULL, 2, 16, 1, 16, '2015', ' ', '', 2002, 2015),
('0801-1967-09794', '9213983', '2001', 76, '2016-01-13', 214, NULL, 2, 16, 1, 16, '2015', ' MESTIZO', 'ADMINISTRACION DE EMPRESAS', 1992, 2015),
('1516-1991-00194', '20101001128', '0', 0, '2016-01-13', 1, NULL, 1, 16, 6, 16, '0', ' ', '', 0, 0),
('0612-1977-00023', '9710718', '1997', 76, '2016-01-13', 197, NULL, 2, 16, 4, 16, '2015', ' ', '', 1997, 2015),
('0801-1991-05729', '20101006592', '2010', 87, '2016-01-13', 261, NULL, 1, 16, 6, 16, '2015', ' ', '', 2010, 2015),
('0209-1988-00380', '20092001469', '2010', 83, '2016-01-13', 274, NULL, 1, 3, 6, 16, '2015', ' ', 'PSICOLOGIA', 2009, 2015),
('0801-1990-13324', '20091011478', '0', 0, '2016-01-13', 1, NULL, 1, 16, 6, 16, '0', ' MESTIZO', 'PERIODISMO', 0, 0),
('0313-1991-00244', '20101900148', '0', 0, '2016-01-13', 1, NULL, 1, 13, 6, 13, '0', ' ', '', 0, 0),
('1701-1991-01282', '20091005338', '2009', 76, '2016-01-13', 265, NULL, 1, 17, 6, 16, '2015', ' ', '', 2009, 2015),
('0801-1977-01499', '9614280', '1996', 72, '2016-01-13', 191, NULL, 2, 16, 1, 16, '2015', ' ', '', 1996, 2015),
('1007-1984-00763', '20101000377', '0', 0, '2016-01-13', 1, NULL, 1, 12, 6, 16, '0', ' MESTIZO', 'PERIODISMO', 0, 0),
('0801-1991-02693', '20091010619', '0', 0, '2016-01-13', 1, NULL, 1, 16, 6, 16, '0', ' ', '', 0, 0),
('0806-1968-00346', '9412735', '1994', 69, '2016-01-13', 203, NULL, 2, 16, 5, 16, '2015', ' ', '', 1994, 2015),
('0703-1976-03695', '9512754', '2003', 74, '2016-01-13', 199, NULL, 2, 16, 5, 16, '2014', ' ', '', 1995, 2014),
('1401-1984-01285', '20021009794', '2002', 67, '2016-01-13', 192, NULL, 2, 2, 2, 2, '2014', ' ', '', 2002, 2014),
('1502-1981-00595', '20021008995', '0', 0, '2016-01-13', 1, NULL, 1, 15, 6, 16, '0', ' ', '', 0, 0),
('0801-1981-04526', '20031004198', '2003', 0, '2016-01-13', 1, NULL, 1, 16, 6, 16, '2015', ' ', '', 2003, 2015),
('0301-1992-02454', '20101900178', '0', 0, '2016-01-13', 1, NULL, 1, 13, 6, 16, '0', 'MESTIZO', 'COMERCIO INTERNACIONAL', 0, 0),
('0801-1987-05407', '20051010028', '2006', 74, '2016-01-13', 242, NULL, 1, 16, 6, 16, '2014', 'CAUCÁSICO', '', 2006, 2014),
('0801-1990-10397', '20091010447', '0', 0, '2016-01-13', 1, NULL, 1, 16, 6, 16, '0', 'MESTIZO', '', 0, 0),
('0801-1967-06317', '8711395', '2006', 81, '2016-01-13', 275, NULL, 1, 16, 6, 16, '2015', ' ', '', 1987, 2015),
('0209-1985-02706', '20070002559', '0', 0, '2016-01-13', 1, NULL, 1, 3, 6, 16, '0', 'MESTIZO', 'MEDICINA - PSICOLOGÍA', 0, 0),
('0801-1992-22033', '20102000356', '0', 0, '2016-01-13', 1, NULL, 1, 16, 6, 16, '0', ' ', '', 0, 0),
('0823-1992-00034', '20101010693', '0', 0, '2016-01-14', 1, NULL, 1, 16, 6, 16, '0', ' ', '', 0, 0),
('0301-1992-02168', '20101003014', '2010', 85, '2016-01-14', 269, NULL, 1, 13, 6, 13, '2015', ' ', '', 2010, 2015),
('0801-1984-05287', '20031001033', '2003', 70, '2016-01-14', 273, NULL, 1, 16, 6, 16, '2015', ' ', '', 2003, 2015),
('1518-1980-00051', '9916734', '1999', 69, '2016-01-14', 196, NULL, 2, 15, 1, 16, '2015', ' ', '', 1999, 2015),
('0827-1993-00069', '20101000534', '0', 0, '2016-01-14', 1, NULL, 1, 16, 6, 16, '0', ' MESTIZO', '', 0, 0),
('0824-1991-00586', '20091001017', '0', 0, '2016-01-14', 1, NULL, 1, 16, 6, 16, '0', ' MESTIZO', 'ARQUITECTURA', 0, 0),
('1503-1986-01320', '20111200054', '0', 0, '2016-01-14', 1, NULL, 1, 15, 6, 16, '0', ' ', '', 0, 0),
('0306-1990-00442', '20081000670', '0', 0, '2016-01-14', 1, NULL, 1, 13, 6, 16, '0', ' ', '', 0, 0),
('0101-1992-02147', '20111000035', '0', 0, '2016-01-14', 1, NULL, 1, 4, 6, 16, '0', ' ', '', 0, 0),
('0801-1983-12823', '20021003640', '2002', 72, '2016-01-14', 202, NULL, 2, 16, 1, 16, '2011', ' MESTIZO', '', 2002, 2011),
('0801-1991-20572', '20091003620', '0', 0, '2016-01-14', 1, NULL, 1, 16, 6, 16, '0', ' MESTIZO', 'PERIODISMO', 0, 0),
('0801-1978-11576', '9611857', '1996', 69, '2016-01-14', 191, NULL, 2, 16, 1, 16, '2015', ' ', '', 1996, 2015),
('1704-1978-00259', '9416115', '2000', 71, '2016-01-14', 199, NULL, 2, 2, 2, 16, '2015', ' ', '', 1994, 2015),
('0801-1990-18042', '20091011956', '2010', 84, '2016-01-14', 267, NULL, 1, 16, 6, 16, '2015', ' ', 'PERIODISMO', 2009, 2015),
('0801-1989-05245', '20081000518', '2008', 77, '2016-01-14', 264, NULL, 1, 16, 6, 16, '2015', ' ', '', 2008, 2015),
('0801-1983-02321', '20011002310', '2001', 73, '2016-01-14', 197, NULL, 2, 16, 1, 16, '2008', 'MESTIZO', '', 2001, 2001),
('0801-1983-04671', '20011002296', '2009', 88, '2016-01-14', 282, NULL, 1, 16, 1, 16, '2015', ' ', 'PERIODISMO', 2001, 2015),
('0801-1981-01946', '20021005420', '2002', 71, '2016-01-14', 199, NULL, 2, 16, 1, 16, '2014', ' ', '', 2002, 2014),
('0816-1990-00590', '20091012574', '2009', 79, '2016-01-14', 261, NULL, 1, 16, 6, 16, '2015', ' ', '', 2009, 2015),
('0801-1960-00244', '8216279', '2001', 67, '2016-01-14', 195, NULL, 2, 16, 1, 16, '2015', 'MESTIZO', 'ADMINISTRACIÓN PUBLICA', 1982, 2015),
('1201-1990-00248', '20091005100', '0', 0, '2016-01-14', 1, NULL, 1, 13, 6, 14, '0', 'MESTIZO', '', 0, 0),
('0703-1992-03640', '20111000835', '0', 0, '2016-01-14', 1, NULL, 1, 19, 6, 16, '0', 'MESTIZO', '', 0, 0),
('0801-1992-18213', '20101001460', '2010', 88, '2016-01-14', 265, NULL, 1, 16, 6, 16, '2015', 'MESTIZO', '', 2010, 2015),
('0801-1994-19454', '20101000412', '2010', 75, '2016-01-14', 261, NULL, 1, 16, 6, 16, '2015', '', '', 2010, 2015),
('0801-1980-04486', '9910464', '2001', 74, '2016-01-14', 201, NULL, 2, 16, 1, 16, '2015', ' ', '', 2001, 2015),
('1703-1993-00011', '20101006479', '0', 0, '2016-01-14', 1, NULL, 1, 16, 6, 16, '0', 'MESTIZO', '', 0, 0),
('0801-1990-01987', '20101010816', '0', 0, '2016-01-14', 1, NULL, 1, 16, 6, 16, '0', ' ', 'ADMINISTRACIÓN DE EMPRESAS', 0, 0),
('0603-1988-00587', '20061008267', '2006', 84, '2016-01-14', 272, NULL, 1, 17, 6, 16, '2015', ' ', '', 2006, 2015),
('0801-1994-01053', '20111004384', '0', 0, '2016-01-14', 1, NULL, 1, 16, 6, 16, '0', 'MESTIZO', '', 0, 0),
('0601-1964-01002', '8312435', '2011', 81, '2016-01-14', 275, NULL, 1, 18, 6, 16, '2015', 'MESTIZO', 'MEDICINA', 1983, 2015),
('1807-1978-02092', '9614014', '1996', 70, '2016-01-14', 202, NULL, 2, 2, 5, 2, '2008', ' ', '', 1996, 2008),
('0703-1980-04229', '20001002523', '2000', 70, '2016-01-14', 197, NULL, 2, 19, 1, 16, '2013', 'MESTIZO', '', 2000, 2013),
('0801-1985-00939', '20031003742', '2003', 71, '2016-01-14', 190, NULL, 2, 2, 1, 2, '2013', ' ', '', 2003, 2013),
('0801-1989-10181', '20091000588', '0', 0, '2016-01-14', 1, NULL, 1, 16, 6, 16, '0', ' ', '', 0, 0),
('0801-1977-06393', '20011003833', '2001', 72, '2016-01-14', 206, NULL, 2, 16, 1, 16, '2014', ' ', '', 2001, 2014),
('0801-1979-15300', '9913338', '2000', 70, '2016-01-14', 197, NULL, 2, 2, 2, 2, '2015', ' ', '', 2000, 2015),
('0501-1969-08032', '9180051', '1991', 73, '2016-01-14', 198, NULL, 2, 2, 1, 2, '2014', ' ', '', 1991, 2014),
('0801-1991-15154', '20091012638', '2009', 75, '2016-01-14', 254, NULL, 1, 16, 6, 16, '2015', ' ', '', 2009, 2015),
('0801-1988-17857', '20091003530', '2009', 81, '2016-01-14', 267, NULL, 1, 16, 6, 16, '2015', ' ', '', 2009, 2015),
('1522-1993-00189', '20011000983', '2001', 75, '2016-01-15', 271, NULL, 1, 15, 6, 16, '2015', ' ', '', 2001, 2015),
('0803-1992-00658', '20101002160', '2010', 83, '2016-01-15', 270, NULL, 1, 16, 6, 16, '2015', ' ', '', 2010, 2015),
('0801-1964-05715', '8510723', '2010', 83, '2016-01-15', 270, NULL, 1, 16, 6, 16, '2015', ' ', '', 2006, 2014),
('0801-1990-01528', '20091001585', '0', 0, '2016-01-15', 1, NULL, 1, 16, 6, 16, '0', ' ', '', 0, 0),
('0801-1991-25625', '20101004307', '0', 0, '2016-01-15', 1, NULL, 1, 16, 6, 16, '0', ' ', '', 0, 0),
('0601-1992-10221', '20091005268', '2009', 75, '2016-01-15', 261, NULL, 1, 18, 6, 16, '2015', ' ', '', 2009, 2015),
('0801-1989-21350', '20091004478', '0', 0, '2016-01-15', 1, NULL, 1, 16, 6, 16, '0', ' ', '', 0, 0),
('0801-1990-14740', '20081012268', '2008', 77, '2016-01-15', 261, NULL, 1, 16, 6, 16, '2015', ' ', '', 2008, 2015),
('0825-1985-00182', '20051004074', '2005', 70, '2016-01-15', 265, NULL, 1, 16, 6, 16, '2013', ' ', '', 2005, 2013),
('0611-1975-00874', '20070006650', '0', 0, '2016-01-15', 1, NULL, 1, 18, 6, 16, '0', ' MESTIZO', 'PERIODISMO', 0, 0),
('0801-1994-10322', '20111004586', '0', 0, '2016-01-15', 1, NULL, 1, 16, 6, 16, '0', ' MESTIZO', '', 0, 0),
('0801-1991-23837', '20101001089', '2010', 79, '2016-01-15', 261, NULL, 1, 16, 6, 16, '2015', ' ', '', 2010, 2015),
('0801-1992-06802', '20101001364', '2010', 86, '2016-01-15', 261, NULL, 1, 16, 6, 16, '2015', ' ', '', 2010, 2015),
('0801-1982-01930', '20051002941', '0', 0, '2016-01-15', 1, NULL, 1, 16, 6, 16, '0', ' MESTIZO', 'ADMINISTRACIÓN DE EMPRESAS', 0, 0),
('0801-1975-08862', '20031003332', '2003', 69, '2016-01-15', 200, NULL, 2, 16, 1, 16, '2015', ' MESTIZO', '', 2003, 2015),
('0801-1992-22851', '20101004459', '2010', 76, '2016-01-15', 268, NULL, 1, 16, 6, 16, '2015', ' ', '', 2009, 2015),
('1701-1994-00415', '20111005965', '0', 0, '2016-01-15', 1, NULL, 1, 17, 6, 16, '0', ' MESTIZO', '', 0, 0),
('0801-1991-00638', '20091011247', '2009', 75, '2016-01-15', 261, NULL, 1, 16, 6, 16, '2015', ' ', '', 2009, 2015),
('0801-1992-22089', '20101010019', '2010', 90, '2016-01-15', 261, NULL, 1, 16, 6, 16, '2015', ' ', '', 2010, 2015),
('1013-1983-00101', '20031003301', '2003', 70, '2016-01-15', 200, NULL, 2, 12, 5, 12, '2015', ' LENCA', '', 2003, 2015),
('0801-1977-12230', '9611239', '1996', 72, '2016-01-15', 195, NULL, 2, 2, 4, 2, '2015', ' ', '', 1996, 2015),
('0801-1993-18899', '20111004158', '0', 0, '2016-01-15', 1, NULL, 1, 16, 6, 16, '0', ' MESTIZO', '', 0, 0),
('1501-1964-00486', '8940382', '1989', 67, '2016-01-15', 214, NULL, 2, 15, 1, 16, '2014', ' ', '', 1989, 2014),
('0803-1948-00394', '9710619', '1997', 70, '2016-01-15', 211, NULL, 2, 16, 1, 16, '2015', ' ', '', 1997, 2015),
('1501-1966-00482', '20021600183', '2003', 77, '2016-01-15', 267, NULL, 1, 15, 6, 16, '2015', ' ', '', 2003, 2015),
('0801-1991-19007', '20091012957', '2009', 84, '2016-01-15', 268, NULL, 1, 16, 6, 16, '2015', ' ', '', 2009, 2015),
('0601-1973-01687', '20021007697', '2002', 68, '2016-01-15', 198, NULL, 2, 2, 1, 2, '2014', ' ', '', 2002, 2014),
('0702-1991-00111', '20092500104', '2010', 82, '2016-01-15', 279, NULL, 1, 19, 6, 16, '2015', ' MESTIZO', 'ENFERMERIA', 2009, 2015),
('1701-1994-01266', '20111005971', '0', 0, '2016-01-15', 1, NULL, 1, 17, 6, 16, '0', ' MESTIZO', '', 0, 0),
('0801-1992-19639', '20091010776', '2009', 76, '2016-01-15', 261, NULL, 1, 2, 6, 2, '2015', ' ', '', 2009, 2015),
('1208-1987-00754', '20091002915', '0', 0, '2016-01-15', 1, NULL, 1, 14, 6, 16, '0', ' LENCA', 'LENGUAS EXTRANJERAS', 0, 0),
('0801-1971-10812', '9415447', '2003', 69, '2016-01-15', 191, NULL, 2, 16, 1, 16, '2015', ' ', '', 1994, 2015),
('0301-1990-00206', '20091900361', '2009', 80, '2016-01-15', 268, NULL, 1, 13, 6, 16, '2015', ' ', '', 2009, 2015),
('0801-1960-03413', '8813233', '1988', 68, '2016-01-15', 214, NULL, 2, 2, 1, 2, '2014', ' ', '', 1988, 2014),
('1501-1993-03904', '20101001389', '2010', 84, '2016-01-15', 261, NULL, 1, 15, 6, 16, '2015', ' MESTIZO', '', 2010, 2015),
('0801-1993-03148', '20091011346', '2010', 81, '2016-01-15', 264, NULL, 1, 16, 6, 16, '2015', ' ', '', 2010, 2015),
('0313-1993-00221', '20101900101', '0', 0, '2016-01-15', 1, NULL, 1, 13, 6, 16, '0', ' MESTIZO', '', 0, 0),
('0801-1977-08430', '20081012506', '2009', 81, '2016-01-15', 261, NULL, 1, 16, 6, 16, '2014', ' ', '', 2009, 2014),
('0801-1903-33333', '20011001538', '0', 69, '2016-01-15', 194, NULL, 2, 2, 1, 2, '0', ' ', '', 0, 0),
('0610-1976-00532', '20081006669', '0', 0, '2016-01-15', 1, NULL, 1, 18, 6, 16, '0', ' ', '', 0, 0),
('0801-1992-20394', '20101001606', '2010', 82, '2016-01-15', 261, NULL, 1, 16, 6, 16, '2015', ' ', '', 2010, 2015),
('1413-1992-00057', '20101000900', '0', 0, '2016-01-15', 1, NULL, 1, 9, 6, 16, '0', ' MESTIZO', '', 0, 0),
('1503-1991-01828', '20091002286', '2009', 83, '2016-01-15', 274, NULL, 1, 15, 6, 16, '2015', ' ', '', 2009, 2015),
('1518-1989-00156', '20081011761', '2008', 76, '2016-01-15', 261, NULL, 1, 15, 6, 16, '2015', ' ', '', 2008, 2015),
('0801-1985-13024', '20061000091', '2007', 78, '2016-01-15', 264, NULL, 1, 16, 6, 16, '2015', ' ', '', 2007, 2015),
('1501-1988-02489', '20081012365', '2009', 87, '2016-01-15', 272, NULL, 1, 15, 6, 16, '2015', ' ', 'COMERCIO INTERNACIONAL', 2009, 2015),
('0801-1979-17807', '8016710', '1980', 68, '2016-01-15', 208, NULL, 2, 16, 4, 16, '2014', ' ', '', 1980, 2014),
('0801-1973-06908', '9511420', '0', 0, '2016-01-15', 1, NULL, 1, 16, 6, 16, '0', ' MESTIZO', 'INFORMATICA ADMINISTRATIVA', 0, 0),
('1101-1986-00359', '20070007934', '2007', 74, '2016-01-15', 276, NULL, 1, 2, 6, 2, '2014', ' NEGRO', '', 2007, 2014),
('0801-1990-20436', '20091011986', '2009', 0, '2016-01-15', 1, NULL, 1, 16, 6, 16, '0', ' MESTIZO', 'PERIODISMO', 2010, 0),
('0801-1987-21974', '20051000232', '2010', 82, '2016-01-15', 287, NULL, 1, 16, 6, 16, '2015', ' ', 'PERIODISMO', 2005, 2015),
('0801-1982-05590', '20021009333', '2003', 71, '2016-01-15', 196, NULL, 2, 16, 1, 16, '2015', ' MESTIZO', '', 2003, 2015),
('0801-1982-07427', '20061006415', '2006', 74, '2016-01-15', 265, NULL, 1, 16, 6, 16, '2015', ' MESTIZO', '', 2006, 2015),
('1510-1991-00208', '20101005272', '0', 0, '2016-01-15', 1, NULL, 1, 15, 6, 16, '0', ' MESTIZO', '', 0, 0),
('0801-1984-16206', '20031003880', '2003', 67, '2016-01-15', 194, NULL, 2, 2, 1, 2, '2014', ' ', '', 2003, 2014),
('0801-1993-01547', '20101000012', '0', 0, '2016-01-15', 1, NULL, 1, 16, 6, 16, '0', ' ', '', 0, 0),
('0801-1972-05103', '9311129', '1993', 72, '2016-01-15', 204, NULL, 2, 16, 5, 16, '2013', ' ', '', 1993, 2013),
('0801-1978-05079', '9813790', '1998', 69, '2016-01-15', 185, NULL, 2, 16, 1, 16, '2015', ' ', '', 1998, 2015),
('0801-1979-10807', '20001002512', '2000', 70, '2016-01-15', 194, NULL, 2, 2, 1, 2, '2015', ' ', '', 2000, 2015),
('0822-1975-00047', '20051001649', '0', 0, '2016-01-15', 1, NULL, 1, 16, 6, 16, '0', ' LENCA', 'PERIODISMO', 0, 0),
('1501-1981-02595', '20042003689', '2010', 78, '2016-01-15', 264, NULL, 1, 15, 6, 16, '2015', ' ', 'PERIODISMO', 2005, 2015),
('0801-1982-12183', '20061003093', '2008', 73, '2016-01-15', 266, NULL, 1, 16, 6, 16, '2015', ' ', 'PERIODISMO', 2006, 2015),
('0801-1991-03491', '20081005786', '0', 0, '2016-01-15', 1, NULL, 1, 16, 6, 16, '0', ' MESTIZO', 'TRABAJO SOCIAL', 0, 0),
('0715-1989-01068', '20081006231', '0', 0, '2016-01-15', 1, NULL, 1, 19, 6, 16, '0', ' MESTIZO', '', 0, 0),
('0803-1960-00095', '8118625', '1981', 68, '2016-01-15', 206, NULL, 2, 2, 1, 2, '2015', ' ', '', 1981, 2015),
('0801-1988-10878', '20070010286', '2007', 76, '2016-01-15', 261, NULL, 1, 11, 6, 16, '2015', ' ', '', 2007, 2015),
('0801-0000-00000', '9614286', '0', 0, '2016-01-19', 1, NULL, 2, 2, 1, 2, '0', ' ', '', 0, 0),
('1503-1980-01992', '20000100001', '2000', 71, '2016-01-19', 207, NULL, 2, 15, 1, 16, '2015', ' ', '', 2000, 2015),
('1312-1974-00146', '100920', '2011', 89, '2016-01-23', 78, NULL, 1, 2, 1, 2, '0', ' ', 'especialista en derecho penal y procesal', 0, 0),
('0801-1963-01704', '8280015', '1982', 83, '2016-01-23', 207, NULL, 2, 16, 1, 16, '2014', ' ', '', 1982, 2014),
('0801-1992-16442', '20091011373', '2009', 77, '2016-01-23', 270, NULL, 1, 2, 6, 2, '2014', ' ', '', 2009, 2014),
('0309-1990-00014', '20091012389', '0', 0, '2016-02-09', 1, NULL, 1, 2, 6, 2, '0', ' ', '', 0, 0),
('0501-1993-00152', '20101002787', '0', 0, '2016-02-09', 1, NULL, 1, 2, 6, 2, '0', ' ', '', 0, 0),
('0801-1959-03814', '8710662', '0', 78, '2016-02-09', 190, NULL, 2, 2, 1, 2, '0', ' ', '', 1987, 2007),
('0801-1991-19110', '20101000235', '0', 0, '2016-02-09', 1, NULL, 1, 2, 6, 2, '0', ' ', '', 0, 0),
('0801-1993-04902', '20101000146', '0', 0, '2016-02-10', 1, NULL, 1, 2, 6, 2, '0', ' ', '', 0, 0),
('0801-1991-09695', '20091011787', '0', 0, '2016-02-10', 1, NULL, 1, 2, 6, 2, '0', ' ', '', 0, 0),
('0801-1992-04969', '20081012279', '0', 78, '2016-02-10', 272, NULL, 1, 2, 6, 2, '0', ' ', '', 2008, 2014),
('0801-1968-01777', '20070015031', '2007', 75, '2016-02-10', 274, NULL, 1, 2, 6, 2, '2014', ' ', '', 2007, 2014),
('0801-1991-20992', '20101000712', '0', 0, '2016-02-10', 1, NULL, 1, 2, 6, 2, '0', ' ', '', 0, 0),
('0801-1978-00051', '20051008169', '0', 75, '2016-02-10', 261, NULL, 1, 2, 6, 2, '0', ' ', '', 2005, 2014),
('0801-1988-15506', '20091000970', '0', 72, '2016-02-10', 267, NULL, 1, 2, 6, 2, '0', ' ', '', 2009, 2014),
('0801-1993-20450', '20101010189', '0', 0, '2016-02-10', 1, NULL, 1, 2, 6, 2, '0', ' ', '', 0, 0),
('0801-1989-23436', '20070002577', '0', 70, '2016-02-10', 262, NULL, 1, 2, 6, 2, '0', ' ', '', 2007, 2014),
('0311-1987-00215', '20061005948', '0', 80, '2016-02-10', 277, NULL, 1, 2, 6, 2, '0', ' ', '', 2006, 2014),
('1312-1989-00085', '20081000475', '0', 74, '2016-02-10', 269, NULL, 1, 2, 6, 2, '0', ' ', '', 2008, 2014),
('1701-1990-00063', '20091002694', '0', 0, '2016-02-10', 1, NULL, 1, 2, 6, 2, '0', ' ', '', 0, 0),
('0801-1991-18102', '20091002861', '0', 75, '2016-02-11', 261, NULL, 1, 2, 6, 2, '0', ' ', '', 2009, 2014),
('0301-1990-00485', '20091902228', '0', 0, '2016-02-11', 1, NULL, 1, 2, 6, 2, '0', ' ', '', 0, 0),
('0806-1962-00063', '8217360', '0', 0, '2016-02-11', 1, NULL, 1, 2, 6, 2, '0', ' ', '', 0, 0),
('0801-1978-03326', '9910153', '0', 0, '2016-02-11', 1, NULL, 2, 2, 1, 2, '0', ' ', '', 1999, 0),
('0801-1974-11622', '9310585', '1993', 71, '2016-02-11', 205, NULL, 2, 2, 5, 2, '2007', ' ', '', 1993, 2007),
('0501-1974-07945', '8020091', '0', 68, '2016-02-11', 204, NULL, 2, 2, 4, 2, '0', ' ', '', 1980, 2009),
('0801-1973-02463', '9414399', '0', 70, '2016-02-11', 191, NULL, 2, 2, 1, 2, '0', ' ', '', 1995, 2015),
('0715-1991-00645', '20091003984', '0', 0, '2016-02-11', 1, NULL, 1, 2, 6, 2, '0', ' ', '', 0, 0),
('0815-1990-00184', '20081005872', '0', 73, '2016-02-11', 278, NULL, 1, 2, 6, 2, '0', ' ', '', 2008, 2014);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sa_estudiantes_correos`
--

DROP TABLE IF EXISTS `sa_estudiantes_correos`;
CREATE TABLE IF NOT EXISTS `sa_estudiantes_correos` (
  `dni_estudiante` varchar(20) NOT NULL,
  `correo` varchar(50) NOT NULL,
  PRIMARY KEY  (`dni_estudiante`,`correo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcar la base de datos para la tabla `sa_estudiantes_correos`
--

INSERT INTO `sa_estudiantes_correos` (`dni_estudiante`, `correo`) VALUES
('0101-1991-00807', 'jjfonseca71@hotmail.com'),
('0101-1991-02420', 'daniel.garin17@gmail.com'),
('0101-1992-02147', 'larsenlanza@hotmail.com'),
('0107-1964-00758', 'adrianrenef@yahoo.com'),
('0209-1985-02706', 'josmi_09@hotmail.com'),
('0209-1988-00380', 'jcueva@live.com'),
('0301-1990-00206', 'cristinaescobar940@yahoo.es'),
('0301-1990-00485', 'besyrocioms@yahoo.es'),
('0301-1991-02655', 'padilladaniel920@gmail.com'),
('0301-1992-02168', 'josselyn200631@gmail.com'),
('0301-1992-02454', 'francisco.flores21@yahoo.es'),
('0306-1990-00442', 'lizwatters10@yahoo.com'),
('0309-1990-00014', 'aldocardona2011@yahoo.com'),
('0311-1987-00215', 'arleortiz@yahoo.es'),
('0313-1991-00244', 'xioma_2008@yahoo.com'),
('0313-1993-00221', 'sadyr2010@yahoo.com'),
('0318-1990-01175', 'bnjja@yahoo.com'),
('0411-1991-00167', 'fany_cerrano04@hotmail.com'),
('0501-1969-08032', 'mariovargas2218@gmail.com'),
('0501-1973-05537', 'sorayacordon@yahoo.com'),
('0501-1973-09295', 'cerrato_evelyn@yahoo.com'),
('0501-1974-07945', 'carlateresabertrand@yahoo.com.mx'),
('0501-1993-00152', 'ale-rivera-r@hotmail.com'),
('0601-1964-01002', 'mgarciaunah@gmail.com'),
('0601-1973-01687', 'nd@yahoo.com'),
('0601-1978-02416', 'edisquiroz@hotmail.com'),
('0601-1990-02144', 'claudiapma@live.com'),
('0601-1992-10221', 'lizzeth_living4ever@hotmail.com'),
('0603-1988-00587', 'mendezmartinezmanuel@yahoo.com'),
('0604-1982-00109', 'herreracaceres@gmail.com'),
('0607-1983-00483', 'a_castroz1@hot.com'),
('0610-1976-00532', 'santosalvarez2648@yahoo.com'),
('0611-1975-00874', 'miguelandrefunez@yahoo.com'),
('0611-1978-00092', 'floresa840@yahoo.com'),
('0611-1983-00842', 'hectoralcides2008@gmail.com'),
('0612-1977-00023', 'jroberto-garcia1@hotmail.com'),
('0702-1991-00111', 'vallecilloelvin@gmail.com'),
('0702-1991-00199', 'enarubyr@yahoo.com'),
('0703-1976-03695', 'vanessaalvarado8@hotmail.com'),
('0703-1980-04229', 'marco_flores1980@hotmail.com'),
('0703-1988-02624', 'hulda.gaitan@gmail.com'),
('0703-1991-00911', 'hllanosr75@gmail.com'),
('0703-1991-01279', 'hllanos75@gmail.com'),
('0703-1991-01757', 'carmen.aspra@gmail.com'),
('0703-1991-02848', 'kafarm1@gmail.com'),
('0703-1992-03640', 'luisjo.barahona@gmail.com'),
('0703-1992-04401', 'gerardo_mr92@hotmail.com'),
('0704-1989-01096', 'bnbp2589@hotmail.com'),
('0705-1977-00029', 'nd@yahoo.com'),
('0715-1989-01068', 'yojana_esponja@yahoo.com'),
('0715-1991-00645', 'cmatamorosjn@gmail.com'),
('0801-0000-00000', 'nd@yahoo.com'),
('0801-1903-33333', 'nd@yahoo.com'),
('0801-1954-03188', 'nd@yahoo.com'),
('0801-1956-00332', 'nd@yahoo.com'),
('0801-1958-03532', 'nd@yahoo.com'),
('0801-1958-07367', 'rioscarlosmanuel@hotmail.com'),
('0801-1959-03814', 'nd@yahoo.com'),
('0801-1960-00244', 'luisc200448@yahoo.es'),
('0801-1960-03413', 'nd@yahoo.com'),
('0801-1963-01704', 'patriotaf3@gmail.com'),
('0801-1964-05715', 'lili_raudales@yahoo.com'),
('0801-1964-06649', 'nd@yahoo.com'),
('0801-1966-08396', 'suyapabarcenas@yahoo.com'),
('0801-1966-09237', 'gloriasanchez92076@yahoo.com'),
('0801-1967-05372', 'ND@yahoo.com'),
('0801-1967-05937', 'gabrielelvir@yahoo.com'),
('0801-1967-06317', 'jmmendezs@yahoo.es'),
('0801-1967-09794', 'javierchavez_ramos@hotmail.com'),
('0801-1968-01777', 'mamindasuyapa@yahoo.com'),
('0801-1969-01524', 'anardaleoni@yahoo.com'),
('0801-1969-07472', 'estram_alma@hotmail.com'),
('0801-1971-10812', 'ronysierra1972@gmail.com'),
('0801-1972-05103', 'wil.rubio@gmail.com'),
('0801-1973-02463', 'carlosalberto73.medina@yahoo.com'),
('0801-1973-06908', 'gabycarranza73@yahoo.com'),
('0801-1974-11622', 'camezase@yahoo.es'),
('0801-1975-08862', 'abreu79@yahoo.es'),
('0801-1975-22988', 'dcerrato@tecniseguros.com'),
('0801-1976-02179', 'acarolinasilva76@yahoo.com'),
('0801-1976-04001', 'bonilla1976@hotmail.es'),
('0801-1976-12903', 'navasalex@hotmail.com'),
('0801-1977-00361', 'darwinefiallos@gmail.com'),
('0801-1977-01499', 'jvillanueva@poderjudicial.gob.hn'),
('0801-1977-06393', 'mariloli_arambu@yahoo.es'),
('0801-1977-08430', 'mayne7@yahoo.es'),
('0801-1977-12230', 'nd@yahoo.com'),
('0801-1977-12263', 'hildasilva20@yahoo.es'),
('0801-1978-00051', 'aereyes@poderjudicial.gob.hn'),
('0801-1978-01136', 'cesardiaz35@yahoo.com'),
('0801-1978-03326', 'nd@yahoo.com'),
('0801-1978-05079', 'gabrielatrejo22@yahoo.es'),
('0801-1978-11576', 'lessyh29@hotmail.com'),
('0801-1979-04263', 'isis_elvir@yahoo.com'),
('0801-1979-10807', 'vasquezgomezangelicayamileth@yahoo.com'),
('0801-1979-15300', 'marielegarciaz@gmail.com'),
('0801-1979-17807', 'sonia.andino12@yahoo.com'),
('0801-1980-04486', 'lurvinaguilarb@yahoo.com'),
('0801-1980-12749', 'doris161021@yahoo.com'),
('0801-1981-01946', 'lucymayorga29@gmail.com'),
('0801-1981-04526', 'nd@yahoo.com'),
('0801-1982-01930', 'nanyame2002@yahoo.com'),
('0801-1982-05590', 'vazc18@hotmail.com'),
('0801-1982-07427', 'bladimircastell@yahoo.es'),
('0801-1982-09229', 'cinthiahernandezespinoza@gmail.com'),
('0801-1982-12183', 'yordonez@poderjudicial.gob.hn'),
('0801-1983-02321', 'lula.barrientos@hotmail.com'),
('0801-1983-04671', 'cinthiahernandezespinoza@gmail.com'),
('0801-1983-12823', 'leonardo_ramosf@hotmail.com'),
('0801-1983-15889', 'jackycanales@gmail.com'),
('0801-1984-05287', 'jecm_carbajal@yahoo.com'),
('0801-1984-16206', 'jyx5a_28_84@yahoo.com'),
('0801-1985-00939', 'nd@yahoo.com'),
('0801-1985-09994', 'nd@yahoo.com'),
('0801-1985-13024', 'gricelvargas@hotmail.com'),
('0801-1986-10887', 'gcastro@poderjudicial.gob.hn'),
('0801-1987-05231', 'christophermaradiagaardon@yahoo.es'),
('0801-1987-05407', 'oxykid@hotmail.com'),
('0801-1987-09326', 'irishuwi@hotmail.com'),
('0801-1987-14954', 'abogadomoralessilva@gmail.com'),
('0801-1987-21974', 'edues06@gmail.com'),
('0801-1988-10878', 'zdlupian10@yahoo.com'),
('0801-1988-15506', 'anamejia_88@yahoo.es'),
('0801-1988-16527', 'albinlester@yahoo.com'),
('0801-1988-17857', 'tatum.sanchez20@gmail.com'),
('0801-1989-05245', 'lourdesdessiree@yahoo.com'),
('0801-1989-10181', 'alegomez0707@gmail.com'),
('0801-1989-13308', 'halhlight@gmail.com'),
('0801-1989-21350', 'anaribamercedes@yahoo.com'),
('0801-1989-23436', 'andylagos_h10@hotmail.es'),
('0801-1990-01528', 'mayirodrig@hotmail.es'),
('0801-1990-01987', 'manuel_j2010@yahoo.com'),
('0801-1990-10397', 'joaquin_castrod2001@hotmail.com'),
('0801-1990-11492', 'juniortorres42@hotmail.com'),
('0801-1990-13324', 'rodriguezjessenia17@gmail.com'),
('0801-1990-14740', 'mercyelvir17@gmail.com'),
('0801-1990-14788', 'gdreyesargueta@hotmail.com'),
('0801-1990-15523', 'gaod90.5@gmail.com'),
('0801-1990-17641', 'flor.angelica1@hotmail.com'),
('0801-1990-18042', 'lilianstaar_0029@yahoo.com'),
('0801-1990-20436', 'vane_2790@yahoo.es'),
('0801-1990-21356', 'oseguera_gaby@hotmail.com'),
('0801-1990-22215', 'dinoraker@yahoo.com'),
('0801-1991-00638', 'seidel_sarai@hotmail.com'),
('0801-1991-02693', 'jhosaraujo_91@hotmail.com'),
('0801-1991-03431', 'acorralesc@yahoo.com'),
('0801-1991-03491', 'yaleni24@yahoo.com'),
('0801-1991-05576', 'breysi.beltran@yahoo.com'),
('0801-1991-05729', 'jennybon03hn@yahoo.com'),
('0801-1991-06078', 'scrumats@gmail.com'),
('0801-1991-09695', 'alvarenga_allan91@hotmail.com'),
('0801-1991-09840', 'allan21_hernandez@hotmail.com'),
('0801-1991-11506', 'ginarodriguez1991@yahoo.com'),
('0801-1991-11603', 'henrymen_612@hotmail.com'),
('0801-1991-11985', 'kiisazm@hotmail.com'),
('0801-1991-14156', 'elmeliberta_9119@hotmail.com'),
('0801-1991-15154', 'mlgr26@hotmail.com'),
('0801-1991-18102', 'o.bessy@yahoo.com'),
('0801-1991-19007', 'rrestrada777@hotmail.com'),
('0801-1991-19039', 'johanarias93@yahoo.es'),
('0801-1991-19110', 'nd@yahoo.com'),
('0801-1991-19754', 'diana_mfuentes@hotmail.com'),
('0801-1991-20572', 'leolezama_91@hotmail.com'),
('0801-1991-20952', 'ggaby_almendares@yahoo.es'),
('0801-1991-20992', 'amyliz_1309@hotmail.com'),
('0801-1991-23837', 'monica_04@live.com'),
('0801-1991-24747', 'tobongabriela@gmail.com'),
('0801-1991-25625', 'mzepeda1555@hotmail.com'),
('0801-1992-00587', 'barinia.diaz@unah.hn'),
('0801-1992-04969', 'asch.cruz@gmail.com'),
('0801-1992-06802', 'nadiamejia87@gmail.com'),
('0801-1992-15583', 'abogdiaz92@gmail.com'),
('0801-1992-16442', 'karolina1775@hotmail.com'),
('0801-1992-18213', 'luisovidio45@hotmail.com'),
('0801-1992-19639', 'rflores26992@gmail.com'),
('0801-1992-20394', 'saramalez@hotmail.com'),
('0801-1992-21136', 'andreaerazo792@gmail.com'),
('0801-1992-22033', 'joserauldiazmartinez@yahoo.com'),
('0801-1992-22089', 'o_guillen92@hotmail.com'),
('0801-1992-22851', 'nm_bonilla@hotmail.com'),
('0801-1993-01547', 'wenngy_@hotmail.es'),
('0801-1993-01558', 'david.armando.urtecho@gmailcom'),
('0801-1993-02922', 'banyma_10@yahoo.es'),
('0801-1993-03083', 'gnicole_0092@hotmail.com'),
('0801-1993-03148', 'z.rudycarolina@yahoo.es'),
('0801-1993-04902', 'allanartica@hotmail.com'),
('0801-1993-08892', 'ale_pin29@hotmail.com'),
('0801-1993-18899', 'pablo.oseguera@unah.hn'),
('0801-1993-20450', 'ana-rubi1993@hotmail.com'),
('0801-1994-00660', 'daniel_alexander93@hotmail.es'),
('0801-1994-00789', 'graciela_fer17@hotmail.com'),
('0801-1994-01053', 'marcechinchilla_03@hotmail.com'),
('0801-1994-07145', 'greyesvasquez@hotmail.com'),
('0801-1994-10322', 'sarahiramiirez@gmail.com'),
('0801-1994-19454', 'luisyair@outlook.com'),
('0803-1948-00394', 'pedrocruzcaceres@hotmail.com'),
('0803-1960-00095', 'ysbaarch2011@yahoo.com'),
('0803-1992-00658', 'lili_raudales@yahoo.com'),
('0805-1985-00294', 'nd@yahoo.com'),
('0806-1962-00063', 'bcastro3003@gmail.com'),
('0806-1968-00346', 'gonza126863@yahoo.com'),
('0815-1990-00184', 'avilacarlos360@gmail.com'),
('0816-1990-00590', 'luis.baca@rocketmail.com'),
('0822-1975-00047', 'yecenia1649@gmail.com'),
('0822-1985-00305', 'dimasnoemoncadanavas@yahoo.com'),
('0823-1992-00034', 'joselyn07nunez@yahoo.com'),
('0824-1991-00586', 'kensy_banegas77@hotmail.es'),
('0825-1985-00182', 'mervas_3@yahoo.com'),
('0826-1990-00247', 'anrypalma@yahoo.com'),
('0826-1991-00215', 'alexa_espinal1991@hotmail.com'),
('0827-1993-00069', 'kathcheck@ymail.com'),
('1001-1993-00368', 'aguilarmorales93@hotmail.es'),
('1007-1983-00313', 'dilcia_2018@yahoo.com'),
('1007-1984-00763', 'jesusarambu75@hotmail.com'),
('1013-1983-00101', 'oscarorlandopinedalopez@yahoo.es'),
('1101-1986-00359', 'taniaspecial@yahoo.com'),
('1201-1953-00047', 'ND@yahoo.com'),
('1201-1990-00248', 'luis7caceres@yahoo.es'),
('1201-1991-00180', 'minelly.martinez@yahoo.com'),
('1201-1991-00568', 'gabi_araujo29@hotmail.es'),
('1207-1982-00019', 'caraluna0015@gmail.com'),
('1208-1987-00754', 'roneylainez7@yahoo.es'),
('1208-1992-00101', 'flor12dominguez@gmail.com'),
('1310-1990-00053', 'duniaxiomara@hotmail.com'),
('1312-1974-00146', 'nd@yahoo.com'),
('1312-1989-00085', 'armandoaguirre98@yahoo.com'),
('1401-1984-01285', 'nd@yahoo.com'),
('1413-1992-00057', 'eli_chacon26@hotmail.com'),
('1501-1964-00486', 'patybustillo@yahoo.com'),
('1501-1966-00482', 'rpmendezlopez@yahoo.es'),
('1501-1981-02595', 'relly_estrada@hotmail.com'),
('1501-1988-02489', 'azucena_escobar88@hotmail.com'),
('1501-1989-01146', 'franacostaruiz@yahoo.com'),
('1501-1993-03877', 'cinhndz@hotmail.com'),
('1501-1993-03904', 'rmerkdal93@yahoo.com'),
('1502-1981-00595', 'jarturomatute19@yahoo.com'),
('1503-1968-00059', 'ND@yahoo.com'),
('1503-1980-01992', 'ericka_m81@hotmail.com'),
('1503-1986-01320', 'gabyvaldez86@hotmail.com'),
('1503-1991-01828', 'sindy_olanchana2009@yahoo.com'),
('1503-1993-00704', 'douglas_suarez_2006@yahoo.com'),
('1503-1993-01018', 'delmyrivera1993@yahoo.com'),
('1508-1992-00289', 'gabyffe@hotmail.com'),
('1510-1991-00208', 'kiaisasi_91@yahoo.com'),
('1511-1959-00089', 'kellmarq@yahoo.com'),
('1516-1991-00194', 'dario_solis13@hotmail.com'),
('1518-1980-00051', 'karlaruiz22@hotmail.com'),
('1518-1989-00156', 'sindypamela_turciosgarcia@yahoo.com'),
('1519-1993-00016', 'bessysevilla504@yahoo.com'),
('1522-1993-00189', 'jhn_bardales@hotmail.com'),
('1601-1971-00224', 'nd@yahoo.com'),
('1701-1990-00063', 'aiverson_i3@yahoo.com'),
('1701-1991-01282', 'silva.jesten@hotmail.com'),
('1701-1994-00415', 'nsarahibm11@gmail.com'),
('1701-1994-01266', 'rina_gl94@hotmail.com'),
('1703-1993-00011', 'cristiano_manu7l@yahoo.es'),
('1704-1978-00259', 'alvarengaluis874@gmail.com'),
('1707-1990-00473', 'anarosa.g@hotmail.es'),
('1708-1974-00122', 'nd@yahoo.com'),
('1709-1990-00426', 'herlonantonio@hotmail.com'),
('1806-1990-00561', 'carlos.cruz1@yahoo.com'),
('1807-1978-02092', 'nd@yahoo.com'),
('1809-1953-00185', 'elia-53@hotmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sa_estudiantes_menciones_honorificas`
--

DROP TABLE IF EXISTS `sa_estudiantes_menciones_honorificas`;
CREATE TABLE IF NOT EXISTS `sa_estudiantes_menciones_honorificas` (
  `dni_estudiante` varchar(20) NOT NULL,
  `cod_mencion` int(11) NOT NULL,
  PRIMARY KEY  (`dni_estudiante`,`cod_mencion`),
  KEY `estudiante_mencion_mencion_FK_idx` (`cod_mencion`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcar la base de datos para la tabla `sa_estudiantes_menciones_honorificas`
--

INSERT INTO `sa_estudiantes_menciones_honorificas` (`dni_estudiante`, `cod_mencion`) VALUES
('0101-1991-00807', 5),
('0101-1991-02420', 5),
('0101-1992-02147', 5),
('0107-1964-00758', 5),
('0209-1985-02706', 5),
('0209-1988-00380', 1),
('0301-1990-00206', 1),
('0301-1990-00485', 5),
('0301-1991-02655', 5),
('0301-1992-02168', 1),
('0301-1992-02454', 5),
('0306-1990-00442', 5),
('0309-1990-00014', 5),
('0311-1987-00215', 5),
('0313-1991-00244', 5),
('0313-1993-00221', 5),
('0318-1990-01175', 5),
('0411-1991-00167', 1),
('0501-1969-08032', 5),
('0501-1973-05537', 5),
('0501-1973-09295', 5),
('0501-1974-07945', 5),
('0501-1993-00152', 5),
('0601-1964-01002', 1),
('0601-1973-01687', 5),
('0601-1978-02416', 5),
('0601-1990-02144', 5),
('0601-1992-10221', 5),
('0603-1988-00587', 1),
('0604-1982-00109', 5),
('0607-1983-00483', 5),
('0610-1976-00532', 5),
('0611-1975-00874', 5),
('0611-1978-00092', 5),
('0611-1983-00842', 5),
('0612-1977-00023', 5),
('0702-1991-00111', 1),
('0702-1991-00199', 1),
('0703-1976-03695', 5),
('0703-1980-04229', 5),
('0703-1988-02624', 1),
('0703-1991-00911', 3),
('0703-1991-01279', 1),
('0703-1991-01757', 5),
('0703-1991-02848', 5),
('0703-1992-03640', 5),
('0703-1992-04401', 5),
('0704-1989-01096', 1),
('0705-1977-00029', 5),
('0715-1989-01068', 5),
('0715-1991-00645', 5),
('0801-0000-00000', 5),
('0801-1903-33333', 5),
('0801-1954-03188', 5),
('0801-1956-00332', 5),
('0801-1958-03532', 5),
('0801-1958-07367', 5),
('0801-1959-03814', 5),
('0801-1960-00244', 5),
('0801-1960-03413', 5),
('0801-1963-01704', 1),
('0801-1964-05715', 1),
('0801-1964-06649', 5),
('0801-1966-08396', 5),
('0801-1966-09237', 5),
('0801-1967-05372', 5),
('0801-1967-05937', 5),
('0801-1967-06317', 1),
('0801-1967-09794', 5),
('0801-1968-01777', 5),
('0801-1969-01524', 5),
('0801-1969-07472', 5),
('0801-1971-10812', 5),
('0801-1972-05103', 1),
('0801-1973-02463', 5),
('0801-1973-06908', 5),
('0801-1974-11622', 5),
('0801-1975-08862', 5),
('0801-1975-22988', 5),
('0801-1976-02179', 5),
('0801-1976-04001', 5),
('0801-1976-12903', 5),
('0801-1977-00361', 1),
('0801-1977-01499', 5),
('0801-1977-06393', 5),
('0801-1977-08430', 1),
('0801-1977-12230', 5),
('0801-1977-12263', 5),
('0801-1978-00051', 5),
('0801-1978-01136', 5),
('0801-1978-03326', 5),
('0801-1978-05079', 5),
('0801-1978-11576', 5),
('0801-1979-04263', 5),
('0801-1979-10807', 5),
('0801-1979-15300', 5),
('0801-1979-17807', 5),
('0801-1980-04486', 5),
('0801-1980-12749', 5),
('0801-1981-01946', 5),
('0801-1981-04526', 5),
('0801-1982-01930', 5),
('0801-1982-05590', 5),
('0801-1982-07427', 5),
('0801-1982-09229', 1),
('0801-1982-12183', 5),
('0801-1983-02321', 5),
('0801-1983-04671', 1),
('0801-1983-12823', 5),
('0801-1983-15889', 5),
('0801-1984-05287', 5),
('0801-1984-16206', 5),
('0801-1985-00939', 5),
('0801-1985-09994', 5),
('0801-1985-13024', 5),
('0801-1986-10887', 5),
('0801-1987-05231', 5),
('0801-1987-05407', 5),
('0801-1987-09326', 5),
('0801-1987-14954', 5),
('0801-1987-21974', 1),
('0801-1988-10878', 5),
('0801-1988-15506', 5),
('0801-1988-16527', 5),
('0801-1988-17857', 1),
('0801-1989-05245', 5),
('0801-1989-10181', 5),
('0801-1989-13308', 5),
('0801-1989-21350', 5),
('0801-1989-23436', 5),
('0801-1990-01528', 5),
('0801-1990-01987', 5),
('0801-1990-10397', 5),
('0801-1990-11492', 5),
('0801-1990-13324', 5),
('0801-1990-14740', 5),
('0801-1990-14788', 5),
('0801-1990-15523', 5),
('0801-1990-17641', 1),
('0801-1990-18042', 1),
('0801-1990-20436', 5),
('0801-1990-21356', 1),
('0801-1990-22215', 5),
('0801-1991-00638', 5),
('0801-1991-02693', 5),
('0801-1991-03431', 5),
('0801-1991-03491', 5),
('0801-1991-05576', 5),
('0801-1991-05729', 1),
('0801-1991-06078', 5),
('0801-1991-09695', 5),
('0801-1991-09840', 5),
('0801-1991-11506', 5),
('0801-1991-11603', 5),
('0801-1991-11985', 5),
('0801-1991-14156', 1),
('0801-1991-15154', 5),
('0801-1991-18102', 5),
('0801-1991-19007', 1),
('0801-1991-19039', 5),
('0801-1991-19110', 5),
('0801-1991-19754', 1),
('0801-1991-20572', 5),
('0801-1991-20952', 5),
('0801-1991-20992', 5),
('0801-1991-23837', 5),
('0801-1991-24747', 1),
('0801-1991-25625', 5),
('0801-1992-00587', 5),
('0801-1992-04969', 5),
('0801-1992-06802', 1),
('0801-1992-15583', 5),
('0801-1992-16442', 5),
('0801-1992-18213', 1),
('0801-1992-19639', 5),
('0801-1992-20394', 1),
('0801-1992-21136', 1),
('0801-1992-22033', 5),
('0801-1992-22089', 3),
('0801-1992-22851', 5),
('0801-1993-01547', 5),
('0801-1993-01558', 1),
('0801-1993-02922', 5),
('0801-1993-03083', 5),
('0801-1993-03148', 1),
('0801-1993-04902', 5),
('0801-1993-08892', 5),
('0801-1993-18899', 5),
('0801-1993-20450', 5),
('0801-1994-00660', 5),
('0801-1994-00789', 5),
('0801-1994-01053', 5),
('0801-1994-07145', 3),
('0801-1994-10322', 5),
('0801-1994-19454', 5),
('0803-1948-00394', 5),
('0803-1960-00095', 5),
('0803-1992-00658', 1),
('0805-1985-00294', 5),
('0806-1962-00063', 5),
('0806-1968-00346', 5),
('0815-1990-00184', 5),
('0816-1990-00590', 5),
('0822-1975-00047', 5),
('0822-1985-00305', 5),
('0823-1992-00034', 5),
('0824-1991-00586', 5),
('0825-1985-00182', 5),
('0826-1990-00247', 1),
('0826-1991-00215', 5),
('0827-1993-00069', 5),
('1001-1993-00368', 5),
('1007-1983-00313', 5),
('1007-1984-00763', 5),
('1013-1983-00101', 5),
('1101-1986-00359', 5),
('1201-1953-00047', 5),
('1201-1990-00248', 5),
('1201-1991-00180', 5),
('1201-1991-00568', 1),
('1207-1982-00019', 5),
('1208-1987-00754', 5),
('1208-1992-00101', 5),
('1310-1990-00053', 1),
('1312-1974-00146', 1),
('1312-1989-00085', 5),
('1401-1984-01285', 5),
('1413-1992-00057', 5),
('1501-1964-00486', 5),
('1501-1966-00482', 5),
('1501-1981-02595', 5),
('1501-1988-02489', 1),
('1501-1989-01146', 5),
('1501-1993-03877', 5),
('1501-1993-03904', 1),
('1502-1981-00595', 5),
('1503-1968-00059', 5),
('1503-1980-01992', 5),
('1503-1986-01320', 5),
('1503-1991-01828', 1),
('1503-1993-00704', 5),
('1503-1993-01018', 1),
('1508-1992-00289', 1),
('1510-1991-00208', 5),
('1511-1959-00089', 5),
('1516-1991-00194', 5),
('1518-1980-00051', 5),
('1518-1989-00156', 5),
('1519-1993-00016', 1),
('1522-1993-00189', 5),
('1601-1971-00224', 5),
('1701-1990-00063', 5),
('1701-1991-01282', 5),
('1701-1994-00415', 5),
('1701-1994-01266', 5),
('1703-1993-00011', 5),
('1704-1978-00259', 5),
('1707-1990-00473', 1),
('1708-1974-00122', 5),
('1709-1990-00426', 1),
('1806-1990-00561', 5),
('1807-1978-02092', 5),
('1809-1953-00185', 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sa_estudiantes_tipos_estudiantes`
--

DROP TABLE IF EXISTS `sa_estudiantes_tipos_estudiantes`;
CREATE TABLE IF NOT EXISTS `sa_estudiantes_tipos_estudiantes` (
  `codigo_tipo_estudiante` int(11) NOT NULL,
  `dni_estudiante` varchar(20) NOT NULL,
  `fecha_registro` datetime NOT NULL,
  PRIMARY KEY  (`codigo_tipo_estudiante`,`dni_estudiante`),
  KEY `sa_estudiantes_tipos_estudiantes_estudiantes_idx` (`dni_estudiante`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcar la base de datos para la tabla `sa_estudiantes_tipos_estudiantes`
--

INSERT INTO `sa_estudiantes_tipos_estudiantes` (`codigo_tipo_estudiante`, `dni_estudiante`, `fecha_registro`) VALUES
(1, '0703-1991-00911', '2015-11-27 01:42:54'),
(1, '0703-1991-01279', '2015-11-27 22:10:58'),
(1, '0107-1964-00758', '2015-11-30 19:21:58'),
(1, '0801-1988-16527', '2015-12-01 17:05:06'),
(1, '0703-1991-02848', '2015-12-04 16:33:30'),
(1, '0801-1993-08892', '2016-01-07 11:35:23'),
(1, '0801-1976-12903', '2016-01-07 16:25:52'),
(1, '0801-1987-14954', '2016-01-07 18:12:26'),
(1, '0826-1991-00215', '2016-01-07 18:17:01'),
(1, '0801-1991-03431', '2016-01-07 18:21:15'),
(1, '0801-1991-09840', '2016-01-07 18:25:41'),
(1, '0801-1969-07472', '2016-01-09 15:47:14'),
(1, '0801-1976-02179', '2016-01-09 16:19:39'),
(1, '0611-1978-00092', '2016-01-09 16:31:33'),
(1, '1201-1991-00568', '2016-01-11 12:17:56'),
(1, '0801-1991-20952', '2016-01-11 12:28:17'),
(1, '0826-1990-00247', '2016-01-11 12:38:16'),
(1, '1707-1990-00473', '2016-01-11 12:44:54'),
(1, '0801-1969-01524', '2016-01-11 12:55:11'),
(1, '0801-1992-21136', '2016-01-11 13:03:12'),
(1, '0607-1983-00483', '2016-01-11 13:08:47'),
(1, '1201-1991-00180', '2016-01-11 13:14:51'),
(1, '1508-1992-00289', '2016-01-11 13:35:57'),
(1, '0704-1989-01096', '2016-01-11 13:41:21'),
(1, '0801-1993-02922', '2016-01-11 13:47:19'),
(1, '0801-1992-00587', '2016-01-11 16:52:10'),
(1, '0318-1990-01175', '2016-01-11 16:59:01'),
(1, '1519-1993-00016', '2016-01-11 17:04:35'),
(1, '0604-1982-00109', '2016-01-11 17:10:57'),
(1, '1001-1993-00368', '2016-01-11 17:16:37'),
(1, '0801-1991-05576', '2016-01-11 17:21:42'),
(1, '0801-1976-04001', '2016-01-11 17:28:33'),
(1, '0801-1958-07367', '2016-01-11 17:33:57'),
(1, '1806-1990-00561', '2016-01-11 17:40:24'),
(1, '0703-1991-01757', '2016-01-11 17:51:10'),
(1, '1207-1982-00019', '2016-01-11 17:55:13'),
(1, '0801-1978-01136', '2016-01-11 20:20:58'),
(1, '0801-1987-05231', '2016-01-11 20:26:22'),
(1, '0801-1991-14156', '2016-01-11 20:42:49'),
(1, '0805-1985-00294', '2016-01-11 20:50:46'),
(1, '0801-1982-09229', '2016-01-11 20:59:25'),
(1, '1501-1993-03877', '2016-01-11 21:04:27'),
(1, '0601-1990-02144', '2016-01-11 21:08:56'),
(1, '0801-1991-11985', '2016-01-11 21:15:17'),
(1, '0801-1994-00660', '2016-01-11 21:19:51'),
(1, '0301-1991-02655', '2016-01-11 21:23:57'),
(1, '0101-1991-02420', '2016-01-11 21:28:27'),
(1, '0801-1977-00361', '2016-01-11 21:43:13'),
(1, '0801-1993-01558', '2016-01-11 21:50:01'),
(1, '1503-1993-01018', '2016-01-11 21:54:26'),
(1, '0801-1992-15583', '2016-01-11 21:58:43'),
(1, '0801-1991-19754', '2016-01-11 22:07:31'),
(1, '0801-1975-22988', '2016-01-11 22:12:47'),
(1, '1511-1959-00089', '2016-01-11 22:17:55'),
(1, '1007-1983-00313', '2016-01-11 22:22:57'),
(1, '0822-1985-00305', '2016-01-11 22:28:09'),
(1, '0801-1990-22215', '2016-01-11 22:32:18'),
(1, '0801-1990-14788', '2016-01-11 22:39:03'),
(1, '0801-1967-05372', '2016-01-11 22:45:22'),
(1, '0801-1980-12749', '2016-01-11 22:49:47'),
(1, '1503-1993-00704', '2016-01-11 22:54:32'),
(1, '1310-1990-00053', '2016-01-11 22:59:21'),
(1, '0601-1978-02416', '2016-01-11 23:04:07'),
(1, '1201-1953-00047', '2016-01-12 09:18:52'),
(1, '1503-1968-00059', '2016-01-12 09:25:44'),
(1, '0702-1991-00199', '2016-01-12 09:30:19'),
(1, '0705-1977-00029', '2016-01-12 09:53:51'),
(1, '0501-1973-09295', '2016-01-12 10:10:51'),
(1, '0411-1991-00167', '2016-01-12 10:19:21'),
(1, '0501-1973-05537', '2016-01-12 13:11:52'),
(1, '0801-1990-17641', '2016-01-12 13:25:45'),
(1, '1208-1992-00101', '2016-01-12 13:29:32'),
(1, '0801-1991-06078', '2016-01-12 13:33:56'),
(1, '1501-1989-01146', '2016-01-12 13:37:20'),
(1, '0801-1990-11492', '2016-01-12 13:40:58'),
(1, '0801-1967-05937', '2016-01-12 13:46:02'),
(1, '0801-1991-24747', '2016-01-12 13:51:13'),
(1, '0801-1993-03083', '2016-01-12 13:55:09'),
(1, '0801-1991-19039', '2016-01-13 08:52:16'),
(1, '0703-1992-04401', '2016-01-13 08:58:50'),
(1, '0801-1986-10887', '2016-01-13 09:05:53'),
(1, '1601-1971-00224', '2016-01-13 09:16:26'),
(1, '0801-1994-07145', '2016-01-13 09:21:01'),
(1, '0801-1991-11506', '2016-01-13 09:27:25'),
(1, '1809-1953-00185', '2016-01-13 09:32:56'),
(1, '0801-1966-09237', '2016-01-13 09:37:43'),
(1, '0801-1966-08396', '2016-01-13 09:41:52'),
(1, '0801-1994-00789', '2016-01-13 09:45:50'),
(1, '0801-1990-15523', '2016-01-13 09:50:30'),
(1, '0801-1956-00332', '2016-01-13 09:55:10'),
(1, '0611-1983-00842', '2016-01-13 10:00:29'),
(1, '0801-1964-06649', '2016-01-13 11:08:46'),
(1, '0801-1989-13308', '2016-01-13 11:15:31'),
(1, '0801-1954-03188', '2016-01-13 11:21:19'),
(1, '0801-1991-11603', '2016-01-13 11:26:46'),
(1, '1709-1990-00426', '2016-01-13 11:33:16'),
(1, '1708-1974-00122', '2016-01-13 11:38:24'),
(1, '0801-1977-12263', '2016-01-13 11:42:57'),
(1, '0703-1988-02624', '2016-01-13 11:54:09'),
(1, '0801-1987-09326', '2016-01-13 11:58:31'),
(1, '0801-1979-04263', '2016-01-13 12:07:03'),
(1, '0801-1990-21356', '2016-01-13 12:11:07'),
(1, '0801-1985-09994', '2016-01-13 12:15:37'),
(1, '0801-1983-15889', '2016-01-13 12:19:09'),
(1, '0101-1991-00807', '2016-01-13 12:23:02'),
(1, '0801-1958-03532', '2016-01-13 12:27:32'),
(1, '0801-1967-09794', '2016-01-13 12:32:34'),
(1, '1516-1991-00194', '2016-01-13 12:36:42'),
(1, '0612-1977-00023', '2016-01-13 12:41:13'),
(1, '0801-1991-05729', '2016-01-13 12:45:12'),
(1, '0209-1988-00380', '2016-01-13 12:51:44'),
(1, '0801-1990-13324', '2016-01-13 12:55:57'),
(1, '0313-1991-00244', '2016-01-13 13:01:23'),
(1, '1701-1991-01282', '2016-01-13 13:05:18'),
(1, '0801-1977-01499', '2016-01-13 13:09:23'),
(1, '1007-1984-00763', '2016-01-13 13:32:43'),
(1, '0801-1991-02693', '2016-01-13 13:36:20'),
(1, '0806-1968-00346', '2016-01-13 13:41:54'),
(1, '0703-1976-03695', '2016-01-13 13:47:41'),
(1, '1401-1984-01285', '2016-01-13 13:52:52'),
(1, '1502-1981-00595', '2016-01-13 14:43:56'),
(1, '0801-1981-04526', '2016-01-13 14:50:39'),
(1, '0301-1992-02454', '2016-01-13 14:57:24'),
(1, '0801-1987-05407', '2016-01-13 15:03:37'),
(1, '0801-1990-10397', '2016-01-13 15:12:01'),
(1, '0801-1967-06317', '2016-01-13 15:17:44'),
(1, '0209-1985-02706', '2016-01-13 15:25:32'),
(1, '0801-1992-22033', '2016-01-13 15:29:36'),
(1, '0823-1992-00034', '2016-01-14 08:36:08'),
(1, '0301-1992-02168', '2016-01-14 08:40:06'),
(1, '0801-1984-05287', '2016-01-14 08:43:59'),
(1, '1518-1980-00051', '2016-01-14 08:57:06'),
(1, '0827-1993-00069', '2016-01-14 09:05:39'),
(1, '0824-1991-00586', '2016-01-14 09:14:46'),
(1, '1503-1986-01320', '2016-01-14 09:37:17'),
(1, '0306-1990-00442', '2016-01-14 09:41:10'),
(1, '0101-1992-02147', '2016-01-14 09:45:49'),
(1, '0801-1983-12823', '2016-01-14 09:51:29'),
(1, '0801-1991-20572', '2016-01-14 09:56:03'),
(1, '0801-1978-11576', '2016-01-14 10:01:00'),
(1, '1704-1978-00259', '2016-01-14 12:00:15'),
(1, '0801-1990-18042', '2016-01-14 16:25:03'),
(1, '0801-1989-05245', '2016-01-14 16:48:24'),
(1, '0801-1983-02321', '2016-01-14 16:53:22'),
(1, '0801-1983-04671', '2016-01-14 16:56:56'),
(1, '0801-1981-01946', '2016-01-14 17:01:52'),
(1, '0816-1990-00590', '2016-01-14 17:06:17'),
(1, '0801-1960-00244', '2016-01-14 17:10:57'),
(1, '1201-1990-00248', '2016-01-14 17:15:12'),
(1, '0703-1992-03640', '2016-01-14 17:19:07'),
(1, '0801-1992-18213', '2016-01-14 17:23:18'),
(1, '0801-1994-19454', '2016-01-14 17:26:34'),
(1, '0801-1980-04486', '2016-01-14 17:30:14'),
(1, '1703-1993-00011', '2016-01-14 17:33:14'),
(1, '0801-1990-01987', '2016-01-14 17:37:29'),
(1, '0603-1988-00587', '2016-01-14 17:41:00'),
(1, '0801-1994-01053', '2016-01-14 17:44:59'),
(1, '0601-1964-01002', '2016-01-14 17:49:50'),
(1, '1807-1978-02092', '2016-01-14 17:58:29'),
(1, '0703-1980-04229', '2016-01-14 18:03:12'),
(1, '0801-1985-00939', '2016-01-14 18:07:09'),
(1, '0801-1989-10181', '2016-01-14 18:13:43'),
(1, '0801-1977-06393', '2016-01-14 18:26:19'),
(1, '0801-1979-15300', '2016-01-14 18:31:40'),
(1, '0501-1969-08032', '2016-01-14 18:35:37'),
(1, '0801-1991-15154', '2016-01-14 18:40:27'),
(1, '0801-1988-17857', '2016-01-14 18:46:48'),
(1, '1522-1993-00189', '2016-01-15 08:54:51'),
(1, '0803-1992-00658', '2016-01-15 08:58:37'),
(1, '0801-1964-05715', '2016-01-15 09:03:34'),
(1, '0801-1990-01528', '2016-01-15 09:11:51'),
(1, '0801-1991-25625', '2016-01-15 09:22:47'),
(1, '0601-1992-10221', '2016-01-15 09:27:34'),
(1, '0801-1989-21350', '2016-01-15 09:31:19'),
(1, '0801-1990-14740', '2016-01-15 09:36:37'),
(1, '0825-1985-00182', '2016-01-15 09:40:48'),
(1, '0611-1975-00874', '2016-01-15 09:47:00'),
(1, '0801-1994-10322', '2016-01-15 09:55:54'),
(1, '0801-1991-23837', '2016-01-15 10:03:18'),
(1, '0801-1992-06802', '2016-01-15 10:12:47'),
(1, '0801-1982-01930', '2016-01-15 11:41:47'),
(1, '0801-1975-08862', '2016-01-15 11:46:08'),
(1, '0801-1992-22851', '2016-01-15 11:50:20'),
(1, '1701-1994-00415', '2016-01-15 12:03:48'),
(1, '0801-1991-00638', '2016-01-15 12:08:15'),
(1, '0801-1992-22089', '2016-01-15 12:13:28'),
(1, '1013-1983-00101', '2016-01-15 12:18:23'),
(1, '0801-1977-12230', '2016-01-15 12:22:51'),
(1, '0801-1993-18899', '2016-01-15 12:26:53'),
(1, '1501-1964-00486', '2016-01-15 12:32:35'),
(1, '0803-1948-00394', '2016-01-15 12:36:30'),
(1, '1501-1966-00482', '2016-01-15 12:41:02'),
(1, '0801-1991-19007', '2016-01-15 12:45:09'),
(1, '0601-1973-01687', '2016-01-15 12:51:11'),
(1, '0702-1991-00111', '2016-01-15 12:55:41'),
(1, '1701-1994-01266', '2016-01-15 12:59:27'),
(1, '0801-1992-19639', '2016-01-15 13:03:09'),
(1, '1208-1987-00754', '2016-01-15 14:53:36'),
(1, '0801-1971-10812', '2016-01-15 15:01:32'),
(1, '0301-1990-00206', '2016-01-15 15:05:18'),
(1, '0801-1960-03413', '2016-01-15 15:10:35'),
(1, '1501-1993-03904', '2016-01-15 15:16:38'),
(1, '0801-1993-03148', '2016-01-15 15:20:35'),
(1, '0313-1993-00221', '2016-01-15 15:24:16'),
(1, '0801-1977-08430', '2016-01-15 15:28:37'),
(1, '0801-1903-33333', '2016-01-15 15:32:42'),
(1, '0610-1976-00532', '2016-01-15 15:36:54'),
(1, '0801-1992-20394', '2016-01-15 15:40:46'),
(1, '1413-1992-00057', '2016-01-15 15:44:20'),
(1, '1503-1991-01828', '2016-01-15 15:48:37'),
(1, '1518-1989-00156', '2016-01-15 16:01:38'),
(1, '0801-1985-13024', '2016-01-15 16:05:32'),
(1, '1501-1988-02489', '2016-01-15 16:09:42'),
(1, '0801-1979-17807', '2016-01-15 16:13:51'),
(1, '0801-1973-06908', '2016-01-15 16:17:47'),
(1, '1101-1986-00359', '2016-01-15 16:23:41'),
(1, '0801-1990-20436', '2016-01-15 16:27:58'),
(1, '0801-1987-21974', '2016-01-15 16:54:02'),
(1, '0801-1982-05590', '2016-01-15 17:01:13'),
(1, '0801-1982-07427', '2016-01-15 17:05:45'),
(1, '1510-1991-00208', '2016-01-15 17:09:40'),
(1, '0801-1984-16206', '2016-01-15 17:14:20'),
(1, '0801-1993-01547', '2016-01-15 17:18:36'),
(1, '0801-1972-05103', '2016-01-15 17:22:56'),
(1, '0801-1978-05079', '2016-01-15 17:31:28'),
(1, '0801-1979-10807', '2016-01-15 17:49:32'),
(1, '0822-1975-00047', '2016-01-15 17:53:06'),
(1, '1501-1981-02595', '2016-01-15 17:57:46'),
(1, '0801-1982-12183', '2016-01-15 18:03:28'),
(1, '0801-1991-03491', '2016-01-15 18:07:06'),
(1, '0715-1989-01068', '2016-01-15 18:11:17'),
(1, '0803-1960-00095', '2016-01-15 18:15:28'),
(1, '0801-1988-10878', '2016-01-15 18:19:22'),
(1, '0801-0000-00000', '2016-01-19 08:47:59'),
(1, '1503-1980-01992', '2016-01-19 08:55:29'),
(2, '1312-1974-00146', '2016-01-23 15:08:09'),
(1, '0801-1963-01704', '2016-01-23 15:20:26'),
(1, '0801-1992-16442', '2016-01-23 15:31:53'),
(1, '0309-1990-00014', '2016-02-09 13:26:44'),
(1, '0501-1993-00152', '2016-02-09 13:39:27'),
(1, '0801-1959-03814', '2016-02-09 13:46:54'),
(1, '0801-1991-19110', '2016-02-09 13:55:14'),
(1, '0801-1993-04902', '2016-02-10 18:04:55'),
(1, '0801-1991-09695', '2016-02-10 18:07:58'),
(1, '0801-1992-04969', '2016-02-10 18:12:06'),
(1, '0801-1968-01777', '2016-02-10 18:23:24'),
(1, '0801-1991-20992', '2016-02-10 18:26:36'),
(1, '0801-1978-00051', '2016-02-10 18:34:46'),
(1, '0801-1988-15506', '2016-02-10 18:42:17'),
(1, '0801-1993-20450', '2016-02-10 18:45:25'),
(1, '0801-1989-23436', '2016-02-10 19:24:27'),
(1, '0311-1987-00215', '2016-02-10 19:40:57'),
(1, '1312-1989-00085', '2016-02-10 19:44:36'),
(1, '1701-1990-00063', '2016-02-10 19:47:22'),
(1, '0801-1991-18102', '2016-02-11 10:21:48'),
(1, '0301-1990-00485', '2016-02-11 10:24:33'),
(1, '0806-1962-00063', '2016-02-11 10:26:58'),
(1, '0801-1978-03326', '2016-02-11 10:31:16'),
(1, '0801-1974-11622', '2016-02-11 10:35:27'),
(1, '0501-1974-07945', '2016-02-11 10:39:10'),
(1, '0801-1973-02463', '2016-02-11 10:44:50'),
(1, '0715-1991-00645', '2016-02-11 10:51:10'),
(1, '0815-1990-00184', '2016-02-11 11:00:47');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sa_examenes_himno`
--

DROP TABLE IF EXISTS `sa_examenes_himno`;
CREATE TABLE IF NOT EXISTS `sa_examenes_himno` (
  `cod_solicitud` int(11) NOT NULL,
  `fecha_solicitud` date NOT NULL,
  `nota_himno` decimal(10,0) default NULL,
  `fecha_examen_himno` date default NULL,
  PRIMARY KEY  (`cod_solicitud`,`fecha_solicitud`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcar la base de datos para la tabla `sa_examenes_himno`
--

INSERT INTO `sa_examenes_himno` (`cod_solicitud`, `fecha_solicitud`, `nota_himno`, `fecha_examen_himno`) VALUES
(3, '2015-12-02', 100, '0000-00-00'),
(4, '2015-12-02', 85, '0000-00-00'),
(5, '2015-12-03', NULL, '0000-00-00'),
(6, '2015-12-06', 99, '0000-00-00'),
(11, '2015-12-09', NULL, '2015-12-10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sa_menciones_honorificas`
--

DROP TABLE IF EXISTS `sa_menciones_honorificas`;
CREATE TABLE IF NOT EXISTS `sa_menciones_honorificas` (
  `codigo` int(11) NOT NULL auto_increment,
  `descripcion` varchar(50) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Volcar la base de datos para la tabla `sa_menciones_honorificas`
--

INSERT INTO `sa_menciones_honorificas` (`codigo`, `descripcion`) VALUES
(1, 'CUM LAUDE'),
(4, 'SUMMA CUM LAUDE'),
(3, 'MAGNA CUM LAUDE'),
(5, 'N/A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sa_orientaciones`
--

DROP TABLE IF EXISTS `sa_orientaciones`;
CREATE TABLE IF NOT EXISTS `sa_orientaciones` (
  `codigo` int(11) NOT NULL auto_increment,
  `descripcion` varchar(50) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Volcar la base de datos para la tabla `sa_orientaciones`
--

INSERT INTO `sa_orientaciones` (`codigo`, `descripcion`) VALUES
(1, 'PENAL'),
(2, 'LABORAL'),
(3, 'ADMINISTRATIVA'),
(4, 'INTERNACIONAL'),
(5, 'MERCANTIL'),
(6, 'N/A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sa_periodos`
--

DROP TABLE IF EXISTS `sa_periodos`;
CREATE TABLE IF NOT EXISTS `sa_periodos` (
  `codigo` int(11) NOT NULL,
  `nombre` varchar(20) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcar la base de datos para la tabla `sa_periodos`
--

INSERT INTO `sa_periodos` (`codigo`, `nombre`) VALUES
(1, 'Primer Periodo'),
(2, 'Segundo Periodo'),
(3, 'Tercer Periodo'),
(4, 'N/A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sa_planes_estudio`
--

DROP TABLE IF EXISTS `sa_planes_estudio`;
CREATE TABLE IF NOT EXISTS `sa_planes_estudio` (
  `codigo` int(11) NOT NULL auto_increment,
  `nombre` varchar(50) default NULL,
  `uv` int(11) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Volcar la base de datos para la tabla `sa_planes_estudio`
--

INSERT INTO `sa_planes_estudio` (`codigo`, `nombre`, `uv`) VALUES
(1, 'PLAN 2003', NULL),
(2, 'PLAN 1978', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sa_solicitudes`
--

DROP TABLE IF EXISTS `sa_solicitudes`;
CREATE TABLE IF NOT EXISTS `sa_solicitudes` (
  `codigo` int(11) NOT NULL auto_increment,
  `fecha_solicitud` date NOT NULL,
  `observaciones` varchar(50) default NULL,
  `dni_estudiante` varchar(20) NOT NULL,
  `cod_periodo` int(11) NOT NULL,
  `cod_estado` int(11) NOT NULL,
  `cod_tipo_solicitud` int(11) NOT NULL,
  `cod_solicitud_padre` int(11) default NULL,
  `fecha_solicitud_padre` date default NULL,
  `fecha_exportacion` date NOT NULL,
  PRIMARY KEY  (`codigo`,`fecha_solicitud`),
  KEY `solicitud_estudiante_FK_idx` (`dni_estudiante`),
  KEY `solicitud_periodo_FK_idx` (`cod_periodo`),
  KEY `solicitud_estados_solicitud_FK_idx` (`cod_estado`),
  KEY `solicitud_tipo_solicitud_FK_idx` (`cod_tipo_solicitud`),
  KEY `solicitud_solicitud_FK_idx` (`cod_solicitud_padre`,`fecha_solicitud_padre`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

--
-- Volcar la base de datos para la tabla `sa_solicitudes`
--

INSERT INTO `sa_solicitudes` (`codigo`, `fecha_solicitud`, `observaciones`, `dni_estudiante`, `cod_periodo`, `cod_estado`, `cod_tipo_solicitud`, `cod_solicitud_padre`, `fecha_solicitud_padre`, `fecha_exportacion`) VALUES
(9, '2015-12-08', NULL, '0107-1964-00758', 1, 1, 123492, NULL, NULL, '2015-12-08'),
(8, '2015-12-08', NULL, '0107-1964-00758', 1, 1, 123489, NULL, NULL, '2015-12-01'),
(7, '2015-12-07', NULL, '0801-1988-16527', 3, 2, 123488, NULL, NULL, '2015-12-08'),
(6, '2015-12-06', NULL, '0107-1964-00758', 1, 2, 123490, NULL, NULL, '2015-12-22'),
(10, '2015-12-08', NULL, '0107-1964-00758', 1, 1, 123491, NULL, NULL, '0000-00-00'),
(11, '2015-12-09', NULL, '0107-1964-00758', 1, 1, 123490, 6, NULL, '0000-00-00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sa_tipos_estudiante`
--

DROP TABLE IF EXISTS `sa_tipos_estudiante`;
CREATE TABLE IF NOT EXISTS `sa_tipos_estudiante` (
  `codigo` int(11) NOT NULL auto_increment,
  `descripcion` varchar(50) NOT NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Volcar la base de datos para la tabla `sa_tipos_estudiante`
--

INSERT INTO `sa_tipos_estudiante` (`codigo`, `descripcion`) VALUES
(1, 'Pregrado'),
(2, 'Postgrado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sa_tipos_solicitud`
--

DROP TABLE IF EXISTS `sa_tipos_solicitud`;
CREATE TABLE IF NOT EXISTS `sa_tipos_solicitud` (
  `codigo` int(11) NOT NULL auto_increment,
  `nombre` varchar(50) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=123495 ;

--
-- Volcar la base de datos para la tabla `sa_tipos_solicitud`
--

INSERT INTO `sa_tipos_solicitud` (`codigo`, `nombre`) VALUES
(123489, 'Constancia de Egresado'),
(123488, 'Constancia de Conducta'),
(123490, 'Constancia de Himno'),
(123491, 'Certificación para PPS'),
(123492, 'Constancia de Ultimo Año'),
(123493, 'asdfasdf'),
(123494, 'ggg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sa_tipos_solicitud_tipos_alumnos`
--

DROP TABLE IF EXISTS `sa_tipos_solicitud_tipos_alumnos`;
CREATE TABLE IF NOT EXISTS `sa_tipos_solicitud_tipos_alumnos` (
  `cod_tipo_solicitud` int(11) NOT NULL,
  `cod_tipo_alumno` int(11) NOT NULL,
  PRIMARY KEY  (`cod_tipo_solicitud`,`cod_tipo_alumno`),
  KEY `tipo_alumno_tipo_solicitud_t_a_FK_idx` (`cod_tipo_alumno`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcar la base de datos para la tabla `sa_tipos_solicitud_tipos_alumnos`
--

INSERT INTO `sa_tipos_solicitud_tipos_alumnos` (`cod_tipo_solicitud`, `cod_tipo_alumno`) VALUES
(4, 1),
(123488, 1),
(123489, 1),
(123490, 1),
(123491, 1),
(123492, 1),
(123493, 1),
(123494, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seguimiento`
--

DROP TABLE IF EXISTS `seguimiento`;
CREATE TABLE IF NOT EXISTS `seguimiento` (
  `Id_Seguimiento` int(11) NOT NULL auto_increment,
  `NroFolio` varchar(25) NOT NULL,
  `UsuarioAsignado` int(11) default NULL,
  `Notas` text NOT NULL,
  `Prioridad` tinyint(4) NOT NULL,
  `FechaInicio` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `FechaFinal` date default NULL,
  `EstadoSeguimiento` tinyint(4) NOT NULL,
  PRIMARY KEY  (`Id_Seguimiento`),
  KEY `fk_seguimiento_folios_idx` (`NroFolio`),
  KEY `fk_seguimiento_usuarioAsignado_idx` (`UsuarioAsignado`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=49 ;

--
-- Volcar la base de datos para la tabla `seguimiento`
--

INSERT INTO `seguimiento` (`Id_Seguimiento`, `NroFolio`, `UsuarioAsignado`, `Notas`, `Prioridad`, `FechaInicio`, `FechaFinal`, `EstadoSeguimiento`) VALUES
(1, '5', 13, 'En proceso', 1, '2015-11-16 14:42:46', NULL, 1),
(2, 'OFICIO Nº 001', 13, 'En proceso', 1, '2015-11-16 15:05:08', NULL, 1),
(3, 'Nota: ', 2, 'El día de hoy lunes 16 de noviembre 2015 a esta nota quedo en el escritorio de la señora Decana.', 1, '2015-11-16 15:57:05', NULL, 1),
(4, 'Oficio No.1372 Inv. Cient', 2, 'Adjuntar a folder de Plan Nacional de Derechos Humanos. Generar una copia para el Ing. Melendez.', 1, '2015-11-17 17:41:03', NULL, 1),
(5, 'Nota Zahira Núñez', 2, 'Finalizado', 1, '2015-11-20 10:41:50', '2015-11-20', 0),
(12, 'RU-NO.1083-2015', 2, 'Ubicado en el escritorio de la Decana el 18 de noviembre 2015.', 2, '2015-11-18 16:27:05', NULL, 1),
(6, 'Oficio No.093-MDH', 2, 'Se autoriza apoyo,hacer nota que comunique a la Lic. Tercero y se copie la Ing. Melendez.', 2, '2015-11-17 17:34:26', NULL, 1),
(7, 'Oficio No.3271-D.G.T.H./S', 2, 'Girar copia a la administración sobre respuesta.', 2, '2015-11-17 17:32:39', NULL, 1),
(8, 'Nota de fecha 17-nov-2015', 2, 'Notificada, hacer nota de autorizacion del evento.', 1, '2015-11-17 17:03:55', NULL, 1),
(13, 'Invitación', 2, 'Ubicada en el escritorio de la Decana el 18 de noviembre de 2015.', 2, '2015-11-18 16:29:37', NULL, 1),
(9, 'Nota de fecha 16/nov/2015', 2, 'Autorizada la practica, que presente hoja de vida para asignarla al departamento que corresponda.', 2, '2015-11-17 17:26:52', NULL, 1),
(10, 'Nota 16/nov./2015', 2, 'Autorizada la practica que aporte hoja de vida para remitirla al departamento que corresponda.', 2, '2015-11-17 17:18:59', NULL, 1),
(11, 'Of.FACES-SC-059', 2, 'Agregar al Folder de informe de Plan Nacional en Derechos Humanos. Generar copia para asistente técnico estrategia.', 2, '2015-11-17 17:15:09', NULL, 1),
(14, 'SEDI OFICIO NO.636', 2, 'Para archivo físico.', 2, '2015-11-19 10:23:05', NULL, 2),
(15, 'CC. Oficio CCD-101-2015', 2, 'Colocado en archivo físico.', 2, '2015-11-19 10:21:02', NULL, 2),
(16, 'CC Oficio CC-100-2015', 2, 'En archivo físico', 2, '2015-11-19 10:19:41', NULL, 2),
(17, 'CC Oficio CCD-102-2015', 2, 'Para archivo físico.', 2, '2015-11-19 10:18:28', NULL, 2),
(18, 'Nota: 14-nov-2015', 2, 'Escritorio de la Decana hoy jueves 19 de noviembre 2015.', 2, '2015-11-19 16:05:22', NULL, 1),
(19, 'Oficio 1232 SEDP', 2, 'sfa', 2, '2015-11-19 23:13:29', '2015-11-19', 0),
(20, 'Oficio SCU-162-2015', 2, 'En escritorio de la Decana el 20 de noviembre 2015', 2, '2015-11-20 15:52:43', NULL, 1),
(21, 'Oficio SCU-161-2015', 2, 'Escritorio de la Decana el viernes 20 de noviembre de 2015.', 2, '2015-11-20 15:55:26', NULL, 1),
(22, 'Oficio 1336-D-E.L./S.E.D.', 2, 'Escritorio de la Decana hoy viernes 20 de noviembre 2015.', 2, '2015-11-20 15:58:18', NULL, 1),
(23, 'DIRCOM Oficio No.641', 2, 'En escritorio de la Decana hoy 20 de noviembre 2015.', 2, '2015-11-20 16:00:44', NULL, 1),
(24, 'SEDI Oficio No.640', 2, 'En escritorio de la Decana hoy viernes 20 de noviembre 2015', 2, '2015-11-20 16:04:45', NULL, 1),
(25, 'Oficio VOAE 819-2015', 2, 'En escritorio de la Decana hoy viernes 20 de noviembre 2015', 2, '2015-11-20 16:07:19', NULL, 1),
(26, 'Oficio No.312 DCJG-FCJ', 2, 'En escritorio de la Decana hoy 20 de noviembre 2015.', 2, '2015-11-20 16:15:57', NULL, 1),
(27, 'Nabil Kawas: INVITACION', 2, 'm', 2, '2015-11-22 16:06:43', '2015-11-22', 0),
(28, 'Nota 20 de nov. 2015', 2, 'Escritorio de la Decana hoy 25 de noviembre 2015', 2, '2015-11-24 11:39:14', NULL, 1),
(29, 'Nota 25-nov-2015 FUUD-Der', 2, 'Escritorio de la Decana hoy 25-noviembre-2015.', 1, '2015-11-25 15:52:01', NULL, 1),
(30, 'CDM-107', 2, 'En escritorio de la Decana hoy 25-noviembre-2015', 2, '2015-11-25 15:55:40', NULL, 2),
(31, 'Oficio SFCJ-172', 2, 'En escritorio de la Decana hoy 25 de noviembre 2015', 2, '2015-11-25 16:09:54', NULL, 1),
(32, 'Oficio JDU-UNAH-No.364', 2, 'En escritorio de la Decana hoy 25 de noviembre 2015 y escaneado a la Abog. Linda Flores.', 2, '2015-11-25 16:12:46', NULL, 1),
(33, '2 libros/inv. Ciencias Es', 2, 'En escritorio de la Decana hoy 25 de noviembre 2015.', 1, '2015-11-25 16:15:34', NULL, 1),
(34, 'Oficio No.663-FCJ', 2, 'En escritorio de la Decana para firma hoy 25-noviembre-2015', 2, '2015-11-25 16:17:55', NULL, 1),
(35, 'CCD-102-2015', 7, 'Espera de una respuesta de parte de la Unidad Académica', 2, '2015-12-03 16:08:20', NULL, 1),
(36, 'IIJ-069-2015', 2, 'ninguna', 2, '2015-12-09 16:10:44', NULL, 1),
(37, '666-hhh', 34, 'este es un folio de prueba', 2, '2015-12-09 23:15:10', NULL, 1),
(38, '$mensaje="No se ha proces', 5, '$mensaje="No se ha procesado su peticion, comuniquese con el administrador del sistema ...";\n		 //    $codMensaje =0;', 2, '2015-12-10 01:05:36', NULL, 1),
(39, 'ddd', 5, 'ddd', 1, '2015-12-10 01:07:59', NULL, 1),
(40, 'sss', 6, 'sss', 1, '2015-12-10 01:08:59', NULL, 1),
(41, '001-2016', 13, 'La señora Decana está fuera de la oficina por período de vacaciones.', 1, '2016-01-07 16:15:31', NULL, 1),
(42, '002-2016', 30, 'El Abogado Penagos ya emitió su opinión sobre el caso. Sin embargo, expresa que por no tener su nombramiento aún no puede firmar dictamen. Está en espera de hablar con la señora Decana para poder realizar acción que corresponda.', 1, '2016-01-11 13:05:07', NULL, 1),
(43, '003-2016', NULL, 'SE LE DIO COPIA A LA COORDINADORA DE CARRERA', 2, '2016-01-11 13:08:05', NULL, 2),
(44, 'Oficio No.088-2016', 2, 'NA', 1, '2016-01-18 14:45:37', NULL, 1),
(45, 'Oficio No. VRA-089-2016', 2, 'na', 1, '2016-01-18 14:50:14', NULL, 1),
(46, 'Circular VRA-No.001-2016', 2, 'na', 2, '2016-01-18 15:07:35', NULL, 1),
(47, 'CCD-150-2016', 31, 'El día lunes se le remitirá a la Abg. Diana Valladares , para la firma del mismo.', 1, '2016-02-05 17:24:24', NULL, 1),
(48, '0001', 7, 'PRUEBA', 2, '2016-02-11 18:40:19', '2016-02-11', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seguimiento_historico`
--

DROP TABLE IF EXISTS `seguimiento_historico`;
CREATE TABLE IF NOT EXISTS `seguimiento_historico` (
  `Id_SeguimientoHistorico` int(11) NOT NULL auto_increment,
  `Id_Seguimiento` int(11) NOT NULL,
  `Id_Estado_Seguimiento` tinyint(4) NOT NULL,
  `Notas` text NOT NULL,
  `Prioridad` tinyint(4) NOT NULL,
  `FechaCambio` datetime NOT NULL,
  `idusuario` int(8) default NULL,
  PRIMARY KEY  (`Id_SeguimientoHistorico`),
  KEY `fk_seguimiento_historico_seguimiento` (`Id_Seguimiento`),
  KEY `fk_seguimiento_historico_tblEstdoSeguimiento_idx` (`Id_Estado_Seguimiento`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=50 ;

--
-- Volcar la base de datos para la tabla `seguimiento_historico`
--

INSERT INTO `seguimiento_historico` (`Id_SeguimientoHistorico`, `Id_Seguimiento`, `Id_Estado_Seguimiento`, `Notas`, `Prioridad`, `FechaCambio`, `idusuario`) VALUES
(1, 1, 1, 'En proceso', 1, '2015-11-16 14:42:46', 1),
(2, 2, 1, 'En proceso', 1, '2015-11-16 15:05:08', 1),
(3, 3, 1, 'El día de hoy lunes 16 de noviembre 2015 a esta nota quedo en el escritorio de la señora Decana.', 1, '2015-11-16 15:57:05', 1),
(4, 4, 1, 'El día de hoy martes 17 de noviembre ubiqué en el escritorio de la sra. Decana el oficio 1372 de Investigación Científica.', 1, '2015-11-17 12:13:11', 1),
(5, 5, 1, 'Nota ubicada en el escritorio de la Decana para su conocimiento.', 1, '2015-11-17 12:34:08', 1),
(6, 6, 1, 'El martes 17 de noviembre ubiqué en el escritorio de la Decana el Oficio No.093-MDH-2015.', 2, '2015-11-17 15:06:08', 1),
(7, 7, 1, 'El martes 17 de noviembre ubiqué en el escritorio de la Decana el Oficio 3271-D.G.T.H./S.E.D.P.', 2, '2015-11-17 15:12:02', 1),
(8, 8, 1, 'El martes 17 de noviembre ubiqué en el escritorio de la Decana la nota pidiendo autorización e invitando a la Decana al acto "Homenaje a los abogados/as víctimas de violencia"', 1, '2015-11-17 15:18:19', 1),
(9, 9, 1, 'El martes recibí y ubiqué la nota procedente de la Universidad de Defensa de Honduras de la abogada Nancy Janeth Cubas Rodríguez.', 2, '2015-11-17 15:23:54', 1),
(10, 10, 1, 'Hoy martes 17 de noviembre ubiqué en el escritorio de la Decana la solicitud de la Universidad de Defensa de Honduras relacionada con la abogada Patricia Elizabeth Rico Vásquez.', 2, '2015-11-17 15:26:50', 1),
(11, 11, 1, 'El martes 17 de noviembre ubiqué en el escritorio de la Decana el Oficio FACES-SC-059-2015 enviado por  la Facultad de Ciencias Espaciales.', 2, '2015-11-17 16:23:18', 1),
(12, 8, 1, 'Notificada, hacer nota de autorizacion del evento.', 1, '2015-11-17 17:03:55', 1),
(13, 11, 1, 'Agregar al Folder de informe de Plan Nacional en Derechos Humanos. Generar copia para asistente técnico estrategia.', 2, '2015-11-17 17:15:09', 1),
(14, 10, 1, 'Autorizada la practica que aporte hoja de vida para remitirla al departamento que corresponda.', 2, '2015-11-17 17:18:59', 1),
(15, 9, 1, 'Autorizada la practica, que presente hoja de vida para asignarla al departamento que corresponda.', 2, '2015-11-17 17:26:52', 1),
(16, 7, 1, 'Comunicar a la Maestría en Derechos Humanos. aclarando que el próximo año que inicie maestría se podrá iniciar de nuevo tramite de contrato.', 2, '2015-11-17 17:30:04', 1),
(17, 7, 1, 'Girar copia a la administración sobre respuesta.', 2, '2015-11-17 17:32:39', 1),
(18, 6, 1, 'Se autoriza apoyo,hacer nota que comunique a la Lic. Tercero y se copie la Ing. Melendez.', 2, '2015-11-17 17:34:26', 1),
(19, 5, 1, 'Enterada.', 1, '2015-11-17 17:37:07', 1),
(20, 4, 1, 'Adjuntar a folder de Plan Nacional de Derechos Humanos. Generar una copia para el Ing. Melendez.', 1, '2015-11-17 17:41:03', 1),
(21, 5, 2, 'Archivado', 1, '2015-11-18 14:27:06', 1),
(22, 12, 1, 'Ubicado en el escritorio de la Decana el 18 de noviembre 2015.', 2, '2015-11-18 16:27:05', 1),
(23, 13, 1, 'Ubicada en el escritorio de la Decana el 18 de noviembre de 2015.', 2, '2015-11-18 16:29:37', 1),
(24, 14, 1, 'Ubicado en el escritorio de la Decana el 18-noviembre-2015', 2, '2015-11-18 16:36:32', 1),
(25, 15, 1, 'En escritorio de la Decana el 18 de noviembre 2015', 2, '2015-11-18 16:39:47', 1),
(26, 16, 1, 'Escritorio de la Decana 18-nov-2015', 2, '2015-11-18 16:42:01', 1),
(27, 17, 1, 'Escritorio de la Decana 18-nov-2015', 2, '2015-11-18 16:43:50', 1),
(28, 17, 2, 'Para archivo físico.', 2, '2015-11-19 10:18:28', 1),
(29, 16, 2, 'En archivo físico', 2, '2015-11-19 10:19:41', 1),
(30, 15, 2, 'Colocado en archivo físico.', 2, '2015-11-19 10:21:02', 1),
(31, 14, 2, 'Para archivo físico.', 2, '2015-11-19 10:23:05', NULL),
(32, 18, 1, 'Escritorio de la Decana hoy jueves 19 de noviembre 2015.', 2, '2015-11-19 16:05:22', NULL),
(33, 19, 1, 'Escritorio de la Decana hoy jueves 19 de noviembre 2015', 2, '2015-11-19 16:09:20', NULL),
(34, 20, 1, 'En escritorio de la Decana el 20 de noviembre 2015', 2, '2015-11-20 15:52:43', NULL),
(35, 21, 1, 'Escritorio de la Decana el viernes 20 de noviembre de 2015.', 2, '2015-11-20 15:55:26', NULL),
(36, 22, 1, 'Escritorio de la Decana hoy viernes 20 de noviembre 2015.', 2, '2015-11-20 15:58:18', NULL),
(37, 23, 1, 'En escritorio de la Decana hoy 20 de noviembre 2015.', 2, '2015-11-20 16:00:44', NULL),
(38, 24, 1, 'En escritorio de la Decana hoy viernes 20 de noviembre 2015', 2, '2015-11-20 16:04:45', NULL),
(39, 25, 1, 'En escritorio de la Decana hoy viernes 20 de noviembre 2015', 2, '2015-11-20 16:07:19', NULL),
(40, 26, 1, 'En escritorio de la Decana hoy 20 de noviembre 2015.', 2, '2015-11-20 16:15:57', NULL),
(41, 27, 1, 'En escritorio de la Decana hoy viernes 20 de noviembre 2015.', 2, '2015-11-20 16:21:08', NULL),
(42, 27, 2, 'j', 2, '2015-11-22 16:06:29', NULL),
(43, 28, 1, 'Escritorio de la Decana hoy 25 de noviembre 2015', 2, '2015-11-24 11:39:14', NULL),
(44, 29, 1, 'Escritorio de la Decana hoy 25-noviembre-2015.', 1, '2015-11-25 15:52:01', NULL),
(45, 30, 2, 'En escritorio de la Decana hoy 25-noviembre-2015', 2, '2015-11-25 15:55:40', NULL),
(46, 31, 1, 'En escritorio de la Decana hoy 25 de noviembre 2015', 2, '2015-11-25 16:09:54', NULL),
(47, 32, 1, 'En escritorio de la Decana hoy 25 de noviembre 2015 y escaneado a la Abog. Linda Flores.', 2, '2015-11-25 16:12:46', NULL),
(48, 33, 1, 'En escritorio de la Decana hoy 25 de noviembre 2015.', 1, '2015-11-25 16:15:34', NULL),
(49, 34, 1, 'En escritorio de la Decana para firma hoy 25-noviembre-2015', 2, '2015-11-25 16:17:55', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sub_actividad`
--

DROP TABLE IF EXISTS `sub_actividad`;
CREATE TABLE IF NOT EXISTS `sub_actividad` (
  `id_sub_Actividad` int(11) NOT NULL auto_increment,
  `idActividad` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `descripcion` text NOT NULL,
  `fecha_monitoreo` date NOT NULL,
  `id_Encargado` varchar(20) NOT NULL,
  `ponderacion` int(11) NOT NULL,
  `costo` int(11) NOT NULL,
  `observacion` text NOT NULL,
  PRIMARY KEY  (`id_sub_Actividad`),
  KEY `idActividad` (`idActividad`),
  KEY `id_Encargado(Usuario)` (`id_Encargado`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Volcar la base de datos para la tabla `sub_actividad`
--


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sub_actividades_realizadas`
--

DROP TABLE IF EXISTS `sub_actividades_realizadas`;
CREATE TABLE IF NOT EXISTS `sub_actividades_realizadas` (
  `id_subActividadRealizada` int(11) NOT NULL auto_increment,
  `id_SubActividad` int(11) NOT NULL,
  `fecha_Realizacion` date NOT NULL,
  `observacion` text NOT NULL,
  PRIMARY KEY  (`id_subActividadRealizada`),
  UNIQUE KEY `id_SubActividad_2` (`id_SubActividad`),
  KEY `id_SubActividad` (`id_SubActividad`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Volcar la base de datos para la tabla `sub_actividades_realizadas`
--


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `telefono`
--

DROP TABLE IF EXISTS `telefono`;
CREATE TABLE IF NOT EXISTS `telefono` (
  `ID_Telefono` int(11) NOT NULL auto_increment,
  `Tipo` varchar(45) default NULL,
  `Numero` varchar(20) NOT NULL,
  `N_identidad` varchar(20) NOT NULL,
  PRIMARY KEY  (`ID_Telefono`),
  KEY `fk_Telefono_Persona1_idx` (`N_identidad`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=264 ;

--
-- Volcar la base de datos para la tabla `telefono`
--

INSERT INTO `telefono` (`ID_Telefono`, `Tipo`, `Numero`, `N_identidad`) VALUES
(1, NULL, '9808-6001', '0703-1991-00911'),
(2, NULL, '3243-6703', '0703-1991-01279'),
(3, NULL, '9983-3694', '0107-1964-00758'),
(4, NULL, '3246-1761', '0801-1988-16527'),
(5, NULL, '9542-4142', '0703-1991-02848'),
(6, NULL, '9920-3888', '0801-1993-08892'),
(7, NULL, '3345-4872', '0801-1976-12903'),
(8, NULL, '9692-9912', '0801-1987-14954'),
(9, NULL, '9666-6292', '0826-1991-00215'),
(10, NULL, '8797-7150', '0801-1991-03431'),
(11, NULL, '3251-3172', '0801-1991-09840'),
(12, NULL, '3361-1516', '0801-1969-07472'),
(13, NULL, '3259-2098', '0801-1976-02179'),
(14, NULL, '9799-8444', '0611-1978-00092'),
(15, NULL, '8733-9351', '1201-1991-00568'),
(16, NULL, '8904-5618', '0801-1991-20952'),
(17, NULL, '9734-9435', '0826-1990-00247'),
(18, NULL, '9724-9846', '1707-1990-00473'),
(19, NULL, '9472-1790', '0801-1969-01524'),
(20, NULL, '3303-2346', '0801-1992-21136'),
(21, NULL, '9720-7186', '0607-1983-00483'),
(22, NULL, '3157-0762', '1201-1991-00180'),
(23, NULL, '9925-0299', '1508-1992-00289'),
(24, NULL, '9494-0385', '0704-1989-01096'),
(25, NULL, '9750-3190', '0801-1993-02922'),
(26, NULL, '3164-5349', '0801-1992-00587'),
(27, NULL, '9570-6203', '0318-1990-01175'),
(28, NULL, '8946-1980', '1519-1993-00016'),
(29, NULL, '9969-5259', '0604-1982-00109'),
(30, NULL, '8935-8199', '1001-1993-00368'),
(31, NULL, '2201-6460', '0801-1991-05576'),
(32, NULL, '9953-8646', '0801-1976-04001'),
(33, NULL, '9731-9259', '0801-1958-07367'),
(34, NULL, '3335-9833', '1806-1990-00561'),
(35, NULL, '9968-0060', '0703-1991-01757'),
(36, NULL, '9755-7833', '1207-1982-00019'),
(37, NULL, '9612-3638', '0801-1978-01136'),
(38, NULL, '8956-0440', '0801-1987-05231'),
(39, NULL, '9693-1487', '0801-1991-14156'),
(40, NULL, '3358-0004', '0805-1985-00294'),
(41, NULL, '8890-5853', '0801-1982-09229'),
(42, NULL, '9663-4162', '1501-1993-03877'),
(43, NULL, '3159-3231', '0601-1990-02144'),
(44, NULL, '8934-7942', '0801-1991-11985'),
(45, NULL, '3174-0699', '0801-1994-00660'),
(46, NULL, '9530-5113', '0301-1991-02655'),
(47, NULL, '8882-4293', '0101-1991-02420'),
(48, NULL, '3295-6136', '0801-1977-00361'),
(49, NULL, '9982-1573', '0801-1993-01558'),
(50, NULL, '8750-0408', '1503-1993-01018'),
(51, NULL, '3276-8628', '0801-1992-15583'),
(52, NULL, '3293-9991', '0801-1991-19754'),
(53, NULL, '9971-4481', '0801-1975-22988'),
(54, NULL, '9925-7403', '1511-1959-00089'),
(55, NULL, '9835-3768', '1007-1983-00313'),
(56, NULL, '3145-7857', '0822-1985-00305'),
(57, NULL, '3238-4528', '0801-1990-22215'),
(58, NULL, '3208-5132', '0801-1990-14788'),
(59, NULL, '9878-8564', '0801-1967-05372'),
(60, NULL, '3299-3441', '0801-1980-12749'),
(61, NULL, '3274-1447', '1503-1993-00704'),
(62, NULL, '9556-9717', '1310-1990-00053'),
(63, NULL, '3356-8838', '0601-1978-02416'),
(64, NULL, '9880-3457', '1201-1953-00047'),
(65, NULL, '8939-7174', '1503-1968-00059'),
(66, NULL, '3331-8443', '0702-1991-00199'),
(67, NULL, '3233-9216', '0705-1977-00029'),
(68, NULL, '9640-7539', '0501-1973-09295'),
(69, NULL, '3395-1964', '0411-1991-00167'),
(70, NULL, '9960-1515', '0501-1973-05537'),
(71, NULL, '3291-0855', '0801-1990-17641'),
(72, NULL, '3152-0489', '1208-1992-00101'),
(73, NULL, '3225-3743', '0801-1991-06078'),
(74, NULL, '8755-8338', '1501-1989-01146'),
(75, NULL, '9706-3259', '0801-1990-11492'),
(76, NULL, '9779-0982', '0801-1967-05937'),
(77, NULL, '3293-9879', '0801-1991-24747'),
(78, NULL, '9628-4681', '0801-1993-03083'),
(79, NULL, '9577-9639', '0801-1991-19039'),
(80, NULL, '9730-0869', '0703-1992-04401'),
(81, NULL, '9649-0925', '0801-1986-10887'),
(82, NULL, '9901-5921', '1601-1971-00224'),
(83, NULL, '9488-6587', '0801-1994-07145'),
(84, NULL, '3152-5743', '0801-1991-11506'),
(85, NULL, '9579-5016', '1809-1953-00185'),
(86, NULL, '2270-9434', '0801-1966-09237'),
(87, NULL, '9623-7967', '0801-1966-08396'),
(88, NULL, '9791-0870', '0801-1994-00789'),
(89, NULL, '8761-3346', '0801-1990-15523'),
(90, NULL, '9987-2029', '0801-1956-00332'),
(91, NULL, '3192-4014', '0611-1983-00842'),
(92, NULL, '9888-7019', '0801-1964-06649'),
(93, NULL, '9839-7773', '0801-1989-13308'),
(94, NULL, '9508-0361', '0801-1954-03188'),
(95, NULL, '9819-1131', '0801-1991-11603'),
(96, NULL, '9986-1686', '1709-1990-00426'),
(97, NULL, '3384-4584', '1708-1974-00122'),
(98, NULL, '9689-3509', '0801-1977-12263'),
(99, NULL, '8731-9788', '0703-1988-02624'),
(100, NULL, '9916-2002', '0801-1987-09326'),
(101, NULL, '8761-5419', '0801-1979-04263'),
(102, NULL, '8826-3854', '0801-1990-21356'),
(103, NULL, '9939-7299', '0801-1985-09994'),
(104, NULL, '3379-9403', '0801-1983-15889'),
(105, NULL, '8203-5104', '0101-1991-00807'),
(106, NULL, '9816-9663', '0801-1958-03532'),
(107, NULL, '9702-3899', '0801-1967-09794'),
(108, NULL, '9623-2322', '1516-1991-00194'),
(109, NULL, '3247-2542', '0612-1977-00023'),
(110, NULL, '9921-0557', '0801-1991-05729'),
(111, NULL, '8849-2582', '0209-1988-00380'),
(112, NULL, '8909-7260', '0801-1990-13324'),
(113, NULL, '9979-1234', '0313-1991-00244'),
(114, NULL, '9668-5114', '1701-1991-01282'),
(115, NULL, '3150-7836', '0801-1977-01499'),
(116, NULL, '3322-9170', '1007-1984-00763'),
(117, NULL, '8812-5069', '0801-1991-02693'),
(118, NULL, '9928-1628', '0806-1968-00346'),
(119, NULL, '9995-5135', '0703-1976-03695'),
(120, NULL, '9659-0226', '1401-1984-01285'),
(121, NULL, '9875-5204', '1502-1981-00595'),
(122, NULL, '8975-8902', '0801-1981-04526'),
(123, NULL, '3245-0645', '0301-1992-02454'),
(124, NULL, '9453-4359', '0801-1987-05407'),
(125, NULL, '3382-7868', '0801-1990-10397'),
(126, NULL, '9647-4238', '0801-1967-06317'),
(127, NULL, '9763-0629', '0209-1985-02706'),
(128, NULL, '9793-1022', '0801-1992-22033'),
(129, NULL, '9817-2892', '0823-1992-00034'),
(130, NULL, '9856-4632', '0301-1992-02168'),
(131, NULL, '3178-0324', '0801-1984-05287'),
(132, NULL, '8875-8516', '1518-1980-00051'),
(133, NULL, '3388-6064', '0827-1993-00069'),
(134, NULL, '3167-3643', '0824-1991-00586'),
(135, NULL, '9638-2693', '1503-1986-01320'),
(136, NULL, '9959-9847', '0306-1990-00442'),
(137, NULL, '9971-6102', '0101-1992-02147'),
(138, NULL, '3361-1597', '0801-1983-12823'),
(139, NULL, '9853-3711', '0801-1991-20572'),
(140, NULL, '3154-3440', '0801-1978-11576'),
(141, NULL, '9948-1700', '1704-1978-00259'),
(142, NULL, '9786-4302', '0801-1990-18042'),
(143, NULL, '3248-4751', '0801-1989-05245'),
(144, NULL, '3269-0145', '0801-1983-02321'),
(145, NULL, '9919-1211', '0801-1983-04671'),
(146, NULL, '9560-5878', '0801-1981-01946'),
(147, NULL, '9717-3763', '0816-1990-00590'),
(148, NULL, '9872-9698', '0801-1960-00244'),
(149, NULL, '2774-2323', '1201-1990-00248'),
(150, NULL, '3318-5834', '0703-1992-03640'),
(151, NULL, '9520-5510', '0801-1992-18213'),
(152, NULL, '9584-1047', '0801-1994-19454'),
(153, NULL, '9464-0884', '0801-1980-04486'),
(154, NULL, '8765-1218', '1703-1993-00011'),
(155, NULL, '3311-0101', '0801-1990-01987'),
(156, NULL, '3180-4577', '0603-1988-00587'),
(157, NULL, '3149-4942', '0801-1994-01053'),
(158, NULL, '3235-3696', '0601-1964-01002'),
(159, NULL, '9899-8053', '1807-1978-02092'),
(160, NULL, '9987-1790', '0703-1980-04229'),
(161, NULL, '9972-5527', '0801-1985-00939'),
(162, NULL, '3267-5608', '0801-1989-10181'),
(163, NULL, '3148-9027', '0801-1977-06393'),
(164, NULL, '3385-5095', '0801-1979-15300'),
(165, NULL, '9648-0781', '0501-1969-08032'),
(166, NULL, '3333-2833', '0801-1991-15154'),
(167, NULL, '9860-8996', '0801-1988-17857'),
(168, NULL, '9995-7561', '1522-1993-00189'),
(169, NULL, '9757-8261', '0803-1992-00658'),
(170, NULL, '8854-1909', '0801-1964-05715'),
(171, NULL, '9622-5405', '0801-1990-01528'),
(172, NULL, '3232-7749', '0801-1991-25625'),
(173, NULL, '9840-6257', '0601-1992-10221'),
(174, NULL, '9553-6183', '0801-1989-21350'),
(175, NULL, '9839-7492', '0801-1990-14740'),
(176, NULL, '9952-1362', '0825-1985-00182'),
(177, NULL, '2201-0067', '0611-1975-00874'),
(178, NULL, '3187-7353', '0801-1994-10322'),
(179, NULL, '3192-0192', '0801-1991-23837'),
(180, NULL, '9807-3600', '0801-1992-06802'),
(181, NULL, '9781-6236', '0801-1982-01930'),
(182, NULL, '9664-9130', '0801-1975-08862'),
(183, NULL, '3381-5156', '0801-1992-22851'),
(184, NULL, '3254-9045', '1701-1994-00415'),
(185, NULL, '8885-9280', '0801-1991-00638'),
(186, NULL, '9951-4348', '0801-1992-22089'),
(187, NULL, '9571-7591', '1013-1983-00101'),
(188, NULL, '8865-6857', '0801-1977-12230'),
(189, NULL, '9658-8481', '0801-1993-18899'),
(190, NULL, '9651-3399', '1501-1964-00486'),
(191, NULL, '9534-9906', '0803-1948-00394'),
(192, NULL, '9942-3975', '1501-1966-00482'),
(193, NULL, '8795-1003', '0801-1991-19007'),
(194, NULL, '9495-4994', '0601-1973-01687'),
(195, NULL, '3344-4665', '0702-1991-00111'),
(196, NULL, '3281-6898', '1701-1994-01266'),
(197, NULL, '3175-3065', '0801-1992-19639'),
(198, NULL, '9713-7141', '1208-1987-00754'),
(199, NULL, '8734-3727', '0801-1971-10812'),
(200, NULL, '9622-2450', '0301-1990-00206'),
(201, NULL, '2229-3154', '0801-1960-03413'),
(202, NULL, '9791-9319', '1501-1993-03904'),
(203, NULL, '3283-1890', '0801-1993-03148'),
(204, NULL, '9725-2564', '0313-1993-00221'),
(205, NULL, '9792-1156', '0801-1977-08430'),
(206, NULL, '9999-9999', '0801-1903-33333'),
(207, NULL, '3170-8171', '0610-1976-00532'),
(208, NULL, '8801-4792', '0801-1992-20394'),
(209, NULL, '9806-4772', '1413-1992-00057'),
(210, NULL, '9680-6364', '1503-1991-01828'),
(211, NULL, '9883-9986', '1518-1989-00156'),
(212, NULL, '3219-0482', '0801-1985-13024'),
(213, NULL, '9747-5895', '1501-1988-02489'),
(214, NULL, '9592-7621', '0801-1979-17807'),
(215, NULL, '9510-3030', '0801-1973-06908'),
(216, NULL, '9475-4138', '1101-1986-00359'),
(217, NULL, '9827-1835', '0801-1990-20436'),
(218, NULL, '9568-4527', '0801-1987-21974'),
(219, NULL, '8866-9787', '0801-1982-05590'),
(220, NULL, '3395-0179', '0801-1982-07427'),
(221, NULL, '9702-3150', '1510-1991-00208'),
(222, NULL, '3202-1873', '0801-1984-16206'),
(223, NULL, '3346-6778', '0801-1993-01547'),
(224, NULL, '3376-6588', '0801-1972-05103'),
(225, NULL, '3202-7386', '0801-1978-05079'),
(226, NULL, '9477-4602', '0801-1979-10807'),
(227, NULL, '9889-9631', '0822-1975-00047'),
(228, NULL, '8731-7764', '1501-1981-02595'),
(229, NULL, '2220-6134', '0801-1982-12183'),
(230, NULL, '9769-7802', '0801-1991-03491'),
(231, NULL, '9783-2460', '0715-1989-01068'),
(232, NULL, '3393-1351', '0803-1960-00095'),
(233, NULL, '9843-0701', '0801-1988-10878'),
(234, NULL, '9999-9999', '0801-0000-00000'),
(235, NULL, '9704-2489', '1503-1980-01992'),
(236, NULL, '9476-2952', '1312-1974-00146'),
(237, NULL, '9459-8157', '0801-1963-01704'),
(238, NULL, '9703-3726', '0801-1992-16442'),
(239, NULL, '9875-6938', '0309-1990-00014'),
(240, NULL, '9611-6583', '0501-1993-00152'),
(241, NULL, '9999-9999', '0801-1959-03814'),
(242, NULL, '9999-9999', '0801-1991-19110'),
(243, NULL, '9866-1992', '0801-1993-04902'),
(244, NULL, '3301-9098', '0801-1991-09695'),
(245, NULL, '9482-4145', '0801-1992-04969'),
(246, NULL, '9534-1076', '0801-1968-01777'),
(247, NULL, '9721-3255', '0801-1991-20992'),
(248, NULL, '9661-2535', '0801-1978-00051'),
(249, NULL, '9960-8287', '0801-1988-15506'),
(250, NULL, '9925-3430', '0801-1993-20450'),
(251, NULL, '9895-8786', '0801-1989-23436'),
(252, NULL, '9513-5354', '0311-1987-00215'),
(253, NULL, '9466-7054', '1312-1989-00085'),
(254, NULL, '3307-9401', '1701-1990-00063'),
(255, NULL, '9606-3171', '0801-1991-18102'),
(256, NULL, '3216-8255', '0301-1990-00485'),
(257, NULL, '9596-1864', '0806-1962-00063'),
(258, NULL, '9777-4413', '0801-1978-03326'),
(259, NULL, '9801-5443', '0801-1974-11622'),
(260, NULL, '9557-1247', '0501-1974-07945'),
(261, NULL, '3352-5540', '0801-1973-02463'),
(262, NULL, '9457-1314', '0715-1991-00645'),
(263, NULL, '3266-5624', '0815-1990-00184');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_area`
--

DROP TABLE IF EXISTS `tipo_area`;
CREATE TABLE IF NOT EXISTS `tipo_area` (
  `id_Tipo_Area` int(11) NOT NULL auto_increment,
  `nombre` text NOT NULL,
  `observaciones` text NOT NULL,
  PRIMARY KEY  (`id_Tipo_Area`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Volcar la base de datos para la tabla `tipo_area`
--


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_estudio`
--

DROP TABLE IF EXISTS `tipo_estudio`;
CREATE TABLE IF NOT EXISTS `tipo_estudio` (
  `ID_Tipo_estudio` int(11) NOT NULL auto_increment,
  `Tipo_estudio` varchar(45) NOT NULL,
  PRIMARY KEY  (`ID_Tipo_estudio`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Volcar la base de datos para la tabla `tipo_estudio`
--

INSERT INTO `tipo_estudio` (`ID_Tipo_estudio`, `Tipo_estudio`) VALUES
(1, 'Doctorado'),
(2, 'Maestría'),
(3, 'Especialidad'),
(4, 'Licenciatura'),
(5, 'Bachiller'),
(6, 'Técnico');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipodepermiso`
--

DROP TABLE IF EXISTS `tipodepermiso`;
CREATE TABLE IF NOT EXISTS `tipodepermiso` (
  `id_tipo_permiso` int(11) NOT NULL,
  `tipo_permiso` varchar(90) NOT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=latin1;

--
-- Volcar la base de datos para la tabla `tipodepermiso`
--

INSERT INTO `tipodepermiso` (`id_tipo_permiso`, `tipo_permiso`) VALUES
(1, 'Vacaciones'),
(2, 'Tiempo compensatorio'),
(3, 'Corriente'),
(4, 'jhb');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `titulo`
--

DROP TABLE IF EXISTS `titulo`;
CREATE TABLE IF NOT EXISTS `titulo` (
  `id_titulo` int(11) NOT NULL auto_increment,
  `titulo` text NOT NULL,
  PRIMARY KEY  (`id_titulo`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=51 ;

--
-- Volcar la base de datos para la tabla `titulo`
--

INSERT INTO `titulo` (`id_titulo`, `titulo`) VALUES
(1, 'ENFERMERÍA'),
(2, 'INGENIERÍA AGRONÓMICA  '),
(3, 'INGENIERÍA AGROINDUSTRIAL'),
(4, 'INGENIERÍA CIVIL                               '),
(5, 'INGENIERÍA ELÉCTRICA INDUSTRIAL                '),
(6, 'INGENIERÍA EN CIENCIAS ACUÍCOLAS Y  RECURSOS MARINOS COSTEROS'),
(7, 'INGENIERÍA EN SISTEMAS                         '),
(8, 'INGENIERÍA FORESTAL  '),
(9, 'INGENIERÍA INDUSTRIAL                          '),
(10, 'INGENIERÍA MECÁNICA INDUSTRIAL                 '),
(11, 'INGENIERÍA QUÍMICA INDUSTRIAL                  '),
(12, 'LICENCIATURA EN ADMINISTRACIÓN ADUANERA   '),
(13, 'LICENCIATURA EN ADMINISTRACIÓN DE BANCA Y FINANZAS    '),
(14, 'LICENCIATURA EN ADMINISTRACIÓN DE EMPRESAS   '),
(15, 'LICENCIATURA EN ADMÓN.  DE EMPRESAS AGROPECUARIAS'),
(16, 'LICENCIATURA EN ADMINISTRACIÓN PÚBLICA  '),
(17, 'LICENCIATURA EN ANTROPOLOGÍA'),
(18, 'LICENCIATURA EN ASTRONOMÍA Y ASTROFÍSICA'),
(19, 'LICENCIATURA EN BIOLOGÍA'),
(20, 'LICENCIATURA EN COM.INTERNACIONAL CON ORIENT.EN AGROIND.'),
(21, 'LICENCIATURA EN CONTADURÍA PÚBLICA Y FINANZAS '),
(22, 'LICENCIATURA EN CIENCIAS JURÍDICAS                                   '),
(23, 'LICENCIATURA EN DESARROLLO LOCAL'),
(24, 'LICENCIATURA EN ECONOMÍA AGRÍCOLA'),
(25, 'LICENCIATURA EN ECONOMÍA  '),
(26, 'LICENCIATURA EN ECOTURISMO'),
(27, 'LICENCIATURA EN EDUCACIÓN FÍSICA  '),
(28, 'LICENCIATURA EN FILOSOFÍA   '),
(29, 'LICENCIATURA EN FÍSICA'),
(30, 'LICENCIATURA EN HISTORIA        '),
(31, 'LICENCIATURA EN INFORMÁTICA ADMINISTRATIVA'),
(32, 'LICENCIATURA EN LETRAS              '),
(33, 'LICENCIATURA EN LEN. EXT. CON ORIE.INGL. Y FRANCÉS     '),
(34, 'LICENCIATURA EN MATEMÁTICAS '),
(35, 'LICENCIATURA EN MERCADOTECNIA'),
(36, 'LICENCIATURA EN MÚSICA'),
(37, 'LICENCIATURA EN NUTRICIÓN'),
(38, 'LICENCIATURA EN PEDAGOGÍA                          '),
(39, 'LICENCIATURA EN PERIODISMO'),
(40, 'LICENCIATURA EN PSICOLOGÍA                 '),
(41, 'LICENCIATURA EN QUÍMICA INDUSTRIAL      '),
(42, 'LICENCIATURA EN SOCIOLOGÍA   '),
(43, 'LICENCIATURA EN TRABAJO SOCIAL                     '),
(44, 'MEDICINA '),
(45, 'MICROBIOLOGÍA'),
(46, 'ODONTOLOGÍA'),
(47, 'QUÍMICA Y FARMACIA'),
(50, 'ABOGADO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ubicacion_archivofisico`
--

DROP TABLE IF EXISTS `ubicacion_archivofisico`;
CREATE TABLE IF NOT EXISTS `ubicacion_archivofisico` (
  `Id_UbicacionArchivoFisico` int(5) NOT NULL auto_increment,
  `DescripcionUbicacionFisica` text NOT NULL,
  `Capacidad` int(10) NOT NULL,
  `TotalIngresados` int(10) NOT NULL default '0',
  `HabilitadoParaAlmacenar` tinyint(1) NOT NULL,
  PRIMARY KEY  (`Id_UbicacionArchivoFisico`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

--
-- Volcar la base de datos para la tabla `ubicacion_archivofisico`
--

INSERT INTO `ubicacion_archivofisico` (`Id_UbicacionArchivoFisico`, `DescripcionUbicacionFisica`, `Capacidad`, `TotalIngresados`, `HabilitadoParaAlmacenar`) VALUES
(1, 'Papelera Gloria', 1, 1000, 1),
(2, 'En tramite', 1, 1, 1),
(3, 'Decana', 1, 1000, 1),
(4, 'Ingeniero Walter', 1, 1000, 1),
(5, 'Administración', 1, 1000, 1),
(6, 'Jefaturas de Departamentos', 1, 1000, 1),
(7, 'Laboratorio Docente', 1, 1000, 1),
(8, 'Coordinación', 1, 1000, 1),
(9, 'Consultorio Jurídico', 1, 1000, 1),
(10, 'Escritorio de la Decana', 1, 1000, 1),
(11, 'Archivo Físico Gloria', 1, 1000, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ubicacion_notificaciones`
--

DROP TABLE IF EXISTS `ubicacion_notificaciones`;
CREATE TABLE IF NOT EXISTS `ubicacion_notificaciones` (
  `Id_UbicacionNotificaciones` tinyint(4) NOT NULL auto_increment,
  `DescripcionUbicacionNotificaciones` text NOT NULL,
  PRIMARY KEY  (`Id_UbicacionNotificaciones`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Volcar la base de datos para la tabla `ubicacion_notificaciones`
--


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `unidad_academica`
--

DROP TABLE IF EXISTS `unidad_academica`;
CREATE TABLE IF NOT EXISTS `unidad_academica` (
  `Id_UnidadAcademica` int(11) NOT NULL auto_increment,
  `NombreUnidadAcademica` text NOT NULL,
  `UbicacionUnidadAcademica` text NOT NULL,
  PRIMARY KEY  (`Id_UnidadAcademica`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

--
-- Volcar la base de datos para la tabla `unidad_academica`
--

INSERT INTO `unidad_academica` (`Id_UnidadAcademica`, `NombreUnidadAcademica`, `UbicacionUnidadAcademica`) VALUES
(1, 'CRA', 'ADMINISTRATIVO'),
(2, 'DEGT', 'ADMINISTRATIVO'),
(3, 'Facultad de Ingeniería', 'Edificio L1'),
(4, 'Facultad de Ciencias Jurídicas', 'n'),
(5, 'Investigación Científica', 'CISE'),
(6, 'Otra unidad', 'ninguna'),
(7, 'Unidades externas', 'varios'),
(8, 'Vicerrectoría Académica', 'Edificio Registro'),
(9, 'Vicerrectoría de Orientación y Asuntos Estudiantil', 'VOAE'),
(11, 'Dirección  de Ingreso Permanencia y Promoción', 'DIPP');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `universidad`
--

DROP TABLE IF EXISTS `universidad`;
CREATE TABLE IF NOT EXISTS `universidad` (
  `Id_universidad` int(11) NOT NULL auto_increment,
  `nombre_universidad` varchar(60) NOT NULL,
  `Id_pais` int(11) NOT NULL,
  PRIMARY KEY  (`Id_universidad`),
  KEY `fk_universidad_pais_idx` (`Id_pais`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=17 ;

--
-- Volcar la base de datos para la tabla `universidad`
--

INSERT INTO `universidad` (`Id_universidad`, `nombre_universidad`, `Id_pais`) VALUES
(1, 'Universidad Nacional Autónoma de Honduras (UNAH)', 1),
(2, 'Universidad Pedagógica Nacional Francisco Morazán (UPNFM)', 1),
(3, 'Universidad Tecnológica Centroamericana (UNITEC)', 1),
(4, ' Universidad Católica de Honduras (UNICAH) ', 1),
(5, 'Universidad Tecnológica de Honduras (UTH)', 1),
(6, 'Universidad José Cecilio del Valle (UJCV)', 1),
(7, ' Universidad Metropolitana de Honduras (UNIMETRO)', 1),
(8, 'Centro Universitario Tecnológico (CEUTEC)', 1),
(9, 'Escuela Agrícola Panamericana Zamorano', 1),
(10, 'Universidad Politécnica de Ingeniería de Honduras (UPI) ', 1),
(11, 'Centro de Diseño Arquitectura y Construcción (CEDAC)', 1),
(12, 'Universidad de San Pedro Sula', 1),
(13, 'Universidad Nacional de Agricultura (UNAG)', 1),
(14, 'Universidad Cristiana Evangélica Nuevo Milenio (UCENM)', 1),
(15, 'Universidad Cristiana de Honduras (UCRISH)', 1),
(16, 'Escuela Nacional de Ciencias Forestales', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

DROP TABLE IF EXISTS `usuario`;
CREATE TABLE IF NOT EXISTS `usuario` (
  `id_Usuario` int(11) NOT NULL auto_increment,
  `No_Empleado` varchar(13) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `Password` varbinary(250) NOT NULL,
  `Id_Rol` tinyint(4) NOT NULL,
  `Fecha_Creacion` date NOT NULL,
  `Fecha_Alta` date default NULL,
  `Estado` tinyint(1) NOT NULL,
  `esta_logueado` tinyint(1) default NULL,
  PRIMARY KEY  (`id_Usuario`),
  KEY `fk_usuarios_roles_idx` (`Id_Rol`),
  KEY `fk_usuario_empleado_` (`No_Empleado`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=35 ;

--
-- Volcar la base de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_Usuario`, `No_Empleado`, `nombre`, `Password`, `Id_Rol`, `Fecha_Creacion`, `Fecha_Alta`, `Estado`, `esta_logueado`) VALUES
(1, '2109', 'prueba', '81DF7D234F3B8F5487AF508C2C79B00A', 100, '2015-07-06', NULL, 1, 1),
(2, '6558', 'bessynazar', '35869D3215BBBBD3608F2184574ECD84', 50, '2015-11-16', NULL, 1, 0),
(3, '11538', 'waltermelendez', 'B7862F75646F3B7EDAD49C2A5D38789E', 100, '2015-11-16', NULL, 1, 0),
(4, '8708', 'anamoncada', '4E9F3DDDB50C81FEC3C6F7F9A0E6FAB3', 100, '2015-11-16', NULL, 1, 0),
(5, '3089', 'mariamaradiaga', 'BFC5B1DB170FB548AF4ECF74A23CB712', 40, '2015-11-16', NULL, 1, 0),
(6, '14', 'santosmaldonado', 'C0FB1492B5DCF0C687C45BB813A71639', 40, '2015-11-16', NULL, 1, 0),
(7, '13071', 'monicadormes', 'CA9C56E398410A28D03CB9BC83402A29', 45, '2015-11-16', NULL, 1, 0),
(8, '11022', 'carlosburgos', '1B4F0A5EC9B4F6A3D9E4AC535712CE20', 10, '2015-11-16', NULL, 1, 0),
(9, '7908', 'jhonnymembreno', '0B0A86BE3EC479858E7B0895A99E0601', 10, '2015-11-16', NULL, 1, 0),
(10, '11910', 'evelincanaca', '31C1519C2C4C8922856C379879A486C6', 10, '2015-11-16', NULL, 1, 0),
(11, '12969', 'jorgeaguilar', '51AB7A8C12EF116A0B0AA982F6726CC9', 100, '2015-11-16', NULL, 1, 1),
(12, '12968', 'elizabeth', '98CD0F3AC30CC8F533386EF4A5F2DA39', 100, '2015-11-16', NULL, 1, 1),
(13, '5538', 'gloriaoseguera', 'AA99974CA5672DC282C568F6B463F226', 45, '2015-11-16', NULL, 1, 1),
(34, '14', 'hllanos123456', 'C444203AF3C11D2F3BF84417F63CD33B', 20, '2015-12-05', NULL, 1, 0),
(14, '2109', 'darioaplicano', '0BA0914E26692FDF500A7F4428FD0732', 100, '2015-11-18', NULL, 1, 1),
(15, '6587', 'guillermocaballero', 'E8B0A2B145BE96C177921F816E6104A9', 20, '2015-11-18', NULL, 1, 0),
(16, '3942', 'jorgeherrera', '5AC22A801DA2BFD5CA2BC3FC63148030', 20, '2015-11-18', NULL, 1, 0),
(17, '8500', 'jorgereyes', '5B4BCC1B9CBB0E343C0071E03B255457', 20, '2015-11-18', NULL, 1, 0),
(18, '6490', 'sergiomejia', 'C477F34CB0AEDF1576C9FC5A1BDADA9D', 20, '2015-11-18', NULL, 1, 0),
(19, '7350', 'juanperez', '6DE1E319F490004F9CFBAADD4AA27917', 20, '2015-11-18', NULL, 1, 0),
(20, '8708', 'analourdes', 'AC15B2D417176C927FC71393F5C1028B', 45, '2015-11-19', '2015-11-19', 0, 0),
(21, '7107', 'suyapathumann', '7870E30DE9EA05046DBF1623B0C62566', 30, '2015-11-19', NULL, 1, 0),
(22, '6458', 'javierlopez', '2FCC7807205838E0BDF5AA1BC2BF0B69', 30, '2015-11-19', NULL, 1, 0),
(23, '6064', 'erlindaflores', '9AB67E17CC0CA50443899753130721D0', 30, '2015-11-19', NULL, 1, 0),
(24, '5989', 'aldamejia', '9C9DA5CFB9B672DE6042A5C1A9E99D67', 30, '2015-11-19', NULL, 1, 0),
(25, '1998', 'gloriaalvarado', '7A64EE166E12BC15E13374D4188CB6F0', 30, '2015-11-19', NULL, 1, 0),
(26, '2499', 'odirfernandez', '33A9A1B88F6851658B345E3974E9AD3F', 30, '2015-11-19', NULL, 1, 0),
(27, '3073', 'edmundoorellana', '8DA99A835E9411E2A1CE5A3B8B695276', 30, '2015-11-19', NULL, 1, 0),
(28, '5105', 'gaudybustillo', 'D170DD9DB83782C33411D4DB4DAB9CAE', 30, '2015-11-19', NULL, 1, 0),
(29, '1252', 'fernannunez', '1FE5E4C482889EDEB5BA74240AB12736', 30, '2015-11-19', NULL, 1, 0),
(30, '11630', 'josepenagos', '60A58B22C9417A11BCE2145358E7E213', 30, '2015-11-19', NULL, 1, 0),
(31, '1123', 'dianavalladares', '4C86C18E319F4AC0EA54927957DA336E', 30, '2015-11-19', NULL, 1, 0),
(32, '1874', 'jorgematute', '87BBF2278E2A2EFDA336DF9BB6FD690E', 30, '2015-11-19', NULL, 1, 0),
(33, '6647', 'anadolores', 'E60517B107BC788C1EB47333EAAC5BFF', 30, '2015-11-19', NULL, 1, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_alertado`
--

DROP TABLE IF EXISTS `usuario_alertado`;
CREATE TABLE IF NOT EXISTS `usuario_alertado` (
  `Id_UsuarioAlertado` int(11) NOT NULL auto_increment,
  `Id_Alerta` int(11) NOT NULL,
  `Id_Usuario` int(11) NOT NULL,
  PRIMARY KEY  (`Id_UsuarioAlertado`),
  KEY `fk_usuario_alertado_usuario_idx` (`Id_Usuario`),
  KEY `fk_usuario_alertado_alerta_idx` (`Id_Alerta`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Volcar la base de datos para la tabla `usuario_alertado`
--


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_log`
--

DROP TABLE IF EXISTS `usuario_log`;
CREATE TABLE IF NOT EXISTS `usuario_log` (
  `Id_log` int(11) NOT NULL auto_increment,
  `usuario` int(11) NOT NULL,
  `fecha_log` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `ip_conn` varchar(45) default NULL,
  PRIMARY KEY  (`Id_log`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=542 ;

--
-- Volcar la base de datos para la tabla `usuario_log`
--

INSERT INTO `usuario_log` (`Id_log`, `usuario`, `fecha_log`, `ip_conn`) VALUES
(1, 1, '2015-11-15 16:57:17', '201.190.18.37'),
(2, 1, '2015-11-15 16:57:17', '201.190.18.37'),
(3, 1, '2015-11-16 08:44:48', '10.10.13.206'),
(4, 1, '2015-11-16 10:29:31', '10.10.13.206'),
(5, 2, '2015-11-16 11:49:24', '10.10.13.206'),
(6, 3, '2015-11-16 11:49:38', '10.10.13.206'),
(7, 4, '2015-11-16 11:49:53', '10.10.13.206'),
(8, 5, '2015-11-16 11:50:14', '10.10.13.206'),
(9, 1, '2015-11-16 11:51:09', '10.10.13.206'),
(10, 6, '2015-11-16 11:51:49', '10.10.13.206'),
(11, 1, '2015-11-16 11:52:28', '10.10.13.206'),
(12, 7, '2015-11-16 11:53:07', '10.10.13.206'),
(13, 8, '2015-11-16 11:53:23', '10.10.13.206'),
(14, 9, '2015-11-16 11:53:47', '10.10.13.206'),
(15, 10, '2015-11-16 11:54:10', '10.10.13.206'),
(16, 11, '2015-11-16 11:54:24', '10.10.13.206'),
(17, 12, '2015-11-16 11:55:00', '10.10.13.206'),
(18, 12, '2015-11-16 11:55:30', '10.10.13.206'),
(19, 1, '2015-11-16 12:10:10', '10.10.13.206'),
(20, 1, '2015-11-16 13:14:34', '10.10.13.206'),
(21, 1, '2015-11-16 13:52:49', '10.10.13.206'),
(22, 13, '2015-11-16 14:01:31', '10.10.13.206'),
(23, 7, '2015-11-16 14:13:44', '10.10.13.22'),
(24, 12, '2015-11-16 14:19:19', '10.10.12.142'),
(25, 12, '2015-11-16 14:22:50', '10.10.12.145'),
(26, 12, '2015-11-16 14:24:49', '10.10.12.145'),
(27, 13, '2015-11-16 14:27:20', '10.10.12.145'),
(28, 12, '2015-11-16 14:29:23', '10.10.12.145'),
(29, 13, '2015-11-16 14:31:24', '10.10.12.145'),
(30, 1, '2015-11-16 14:37:51', '10.10.12.145'),
(31, 6, '2015-11-16 14:59:27', '10.10.12.140'),
(32, 13, '2015-11-16 15:33:14', '10.10.12.145'),
(33, 1, '2015-11-16 15:41:00', '10.10.12.145'),
(34, 6, '2015-11-16 15:44:26', '10.10.12.140'),
(35, 1, '2015-11-16 16:36:02', '10.10.13.204'),
(36, 11, '2015-11-16 16:36:33', '10.10.13.204'),
(37, 1, '2015-11-16 16:37:10', '10.10.13.204'),
(38, 6, '2015-11-16 17:01:52', '10.10.12.140'),
(39, 6, '2015-11-16 17:01:52', '10.10.12.140'),
(40, 1, '2015-11-16 22:50:27', '201.190.18.37'),
(41, 1, '2015-11-16 23:38:15', '201.190.18.37'),
(42, 1, '2015-11-16 23:41:21', '201.190.18.37'),
(43, 1, '2015-11-16 23:41:22', '201.190.18.37'),
(44, 1, '2015-11-16 23:59:45', '201.190.18.37'),
(45, 13, '2015-11-17 09:50:48', '10.10.12.145'),
(46, 1, '2015-11-17 09:59:01', '10.10.43.248'),
(47, 1, '2015-11-17 11:17:12', '10.10.13.206'),
(48, 3, '2015-11-17 11:39:16', '10.10.13.16'),
(49, 1, '2015-11-17 11:41:06', '10.10.13.206'),
(50, 13, '2015-11-17 11:45:14', '10.10.12.145'),
(51, 1, '2015-11-17 12:14:49', '10.10.12.145'),
(52, 1, '2015-11-17 12:34:34', '10.10.12.145'),
(53, 1, '2015-11-17 12:47:22', '10.10.12.145'),
(54, 1, '2015-11-17 12:48:15', '10.10.12.145'),
(55, 1, '2015-11-17 14:47:17', '10.10.13.204'),
(56, 1, '2015-11-17 14:48:58', '10.10.13.204'),
(57, 1, '2015-11-17 14:50:35', '10.10.13.204'),
(58, 11, '2015-11-17 14:51:31', '10.10.13.204'),
(59, 13, '2015-11-17 15:00:52', '10.10.12.145'),
(60, 3, '2015-11-17 15:04:48', '10.10.13.16'),
(61, 11, '2015-11-17 15:11:47', '10.10.13.204'),
(62, 1, '2015-11-17 15:19:25', '10.10.13.204'),
(63, 13, '2015-11-17 16:15:50', '10.10.12.145'),
(64, 3, '2015-11-17 16:38:14', '10.10.12.141'),
(65, 2, '2015-11-17 16:45:25', '10.10.12.141'),
(66, 3, '2015-11-17 17:18:28', '10.10.13.16'),
(67, 1, '2015-11-17 18:02:57', '10.10.13.204'),
(68, 1, '2015-11-17 18:54:13', '10.10.13.204'),
(69, 1, '2015-11-17 19:41:42', '10.10.13.204'),
(70, 1, '2015-11-17 23:59:40', '201.190.18.37'),
(71, 1, '2015-11-18 08:37:47', '10.10.13.206'),
(72, 3, '2015-11-18 09:14:24', '10.10.13.16'),
(73, 1, '2015-11-18 09:15:07', '10.10.43.248'),
(74, 1, '2015-11-18 09:16:34', '10.10.43.248'),
(75, 14, '2015-11-18 09:17:20', '10.10.43.248'),
(76, 1, '2015-11-18 09:49:26', '10.10.13.206'),
(77, 1, '2015-11-18 11:36:15', '10.10.13.212'),
(78, 2, '2015-11-18 11:36:49', '10.10.13.212'),
(79, 1, '2015-11-18 12:53:27', '10.10.13.206'),
(80, 13, '2015-11-18 13:43:43', '10.10.12.145'),
(81, 1, '2015-11-18 14:08:26', '10.10.13.206'),
(82, 1, '2015-11-18 14:25:59', '10.10.12.145'),
(83, 1, '2015-11-18 14:28:37', '10.10.12.145'),
(84, 3, '2015-11-18 14:34:50', '10.10.13.16'),
(85, 1, '2015-11-18 15:57:42', '10.10.13.204'),
(86, 13, '2015-11-18 16:10:52', '10.10.12.145'),
(87, 1, '2015-11-18 16:32:00', '10.10.13.204'),
(88, 1, '2015-11-18 16:42:13', '10.10.13.206'),
(89, 1, '2015-11-18 17:11:38', '10.10.13.204'),
(90, 1, '2015-11-18 17:59:36', '10.10.13.204'),
(91, 1, '2015-11-18 18:31:53', '10.10.13.204'),
(92, 1, '2015-11-19 08:41:14', '10.10.13.206'),
(93, 1, '2015-11-19 09:39:07', '10.10.13.206'),
(94, 13, '2015-11-19 10:13:03', '10.10.12.145'),
(95, 1, '2015-11-19 10:41:56', '10.10.43.248'),
(96, 1, '2015-11-19 11:26:33', '10.10.13.206'),
(97, 15, '2015-11-19 11:41:00', '10.10.13.206'),
(98, 16, '2015-11-19 11:41:21', '10.10.13.206'),
(99, 17, '2015-11-19 11:41:58', '10.10.13.206'),
(100, 18, '2015-11-19 11:42:15', '10.10.13.206'),
(101, 19, '2015-11-19 11:42:49', '10.10.13.206'),
(102, 1, '2015-11-19 11:43:54', '10.10.13.206'),
(103, 33, '2015-11-19 11:47:01', '10.10.13.206'),
(104, 21, '2015-11-19 11:47:18', '10.10.13.206'),
(105, 22, '2015-11-19 11:47:34', '10.10.13.206'),
(106, 23, '2015-11-19 11:48:26', '10.10.13.206'),
(107, 23, '2015-11-19 11:50:41', '10.10.13.206'),
(108, 24, '2015-11-19 11:50:57', '10.10.13.206'),
(109, 25, '2015-11-19 11:51:42', '10.10.13.206'),
(110, 26, '2015-11-19 11:51:55', '10.10.13.206'),
(111, 27, '2015-11-19 11:52:09', '10.10.13.206'),
(112, 28, '2015-11-19 11:52:22', '10.10.13.206'),
(113, 29, '2015-11-19 11:52:38', '10.10.13.206'),
(114, 30, '2015-11-19 11:54:46', '10.10.13.206'),
(115, 31, '2015-11-19 11:55:04', '10.10.13.206'),
(116, 32, '2015-11-19 11:55:18', '10.10.13.206'),
(117, 12, '2015-11-19 11:58:03', '10.10.13.206'),
(118, 1, '2015-11-19 12:57:36', '186.2.139.27'),
(119, 1, '2015-11-19 13:45:04', '10.10.13.206'),
(120, 1, '2015-11-19 15:03:22', '10.10.13.206'),
(121, 1, '2015-11-19 15:50:54', '10.10.13.206'),
(122, 13, '2015-11-19 16:03:10', '10.10.12.145'),
(123, 1, '2015-11-19 22:33:37', '201.190.18.37'),
(124, 1, '2015-11-19 22:33:38', '201.190.18.37'),
(125, 1, '2015-11-19 23:01:09', '201.190.18.37'),
(126, 1, '2015-11-19 23:01:09', '201.190.18.37'),
(127, 1, '2015-11-19 23:13:34', '201.190.18.37'),
(128, 1, '2015-11-19 23:40:08', '201.190.18.37'),
(129, 1, '2015-11-19 23:41:43', '190.53.233.71'),
(130, 1, '2015-11-19 23:42:24', '201.190.18.37'),
(131, 1, '2015-11-19 23:42:24', '201.190.18.37'),
(132, 1, '2015-11-19 23:42:24', '201.190.18.37'),
(133, 1, '2015-11-20 00:05:36', '190.53.233.71'),
(134, 1, '2015-11-20 00:58:23', '201.190.18.37'),
(135, 1, '2015-11-20 08:47:13', '10.10.13.206'),
(136, 2, '2015-11-20 08:47:36', '10.10.13.206'),
(137, 1, '2015-11-20 08:49:17', '66.85.148.52'),
(138, 12, '2015-11-20 08:57:28', '66.85.148.52'),
(139, 1, '2015-11-20 09:27:37', '10.10.13.206'),
(140, 2, '2015-11-20 09:27:52', '10.10.13.206'),
(141, 12, '2015-11-20 09:28:34', '66.85.148.52'),
(142, 1, '2015-11-20 09:34:15', '66.85.148.52'),
(143, 1, '2015-11-20 10:03:21', '66.85.148.52'),
(144, 1, '2015-11-20 10:31:15', '10.10.13.206'),
(145, 1, '2015-11-20 10:53:08', '66.85.148.52'),
(146, 12, '2015-11-20 11:08:10', '10.10.13.206'),
(147, 12, '2015-11-20 11:09:26', '66.85.148.52'),
(148, 2, '2015-11-20 11:28:20', '10.10.13.206'),
(149, 1, '2015-11-20 12:43:41', '10.10.13.206'),
(150, 1, '2015-11-20 15:10:40', '10.10.13.206'),
(151, 13, '2015-11-20 15:49:27', '10.10.12.145'),
(152, 1, '2015-11-20 20:42:22', '201.190.18.37'),
(153, 1, '2015-11-20 21:17:15', '201.190.18.37'),
(154, 1, '2015-11-20 21:17:16', '201.190.18.37'),
(155, 1, '2015-11-22 15:16:57', '201.190.18.37'),
(156, 1, '2015-11-22 15:16:58', '201.190.18.37'),
(157, 1, '2015-11-22 16:01:37', '201.190.18.37'),
(158, 1, '2015-11-22 16:01:37', '201.190.18.37'),
(159, 1, '2015-11-22 18:58:49', '201.190.18.37'),
(160, 1, '2015-11-22 18:58:50', '201.190.18.37'),
(161, 12, '2015-11-23 09:45:17', '10.10.13.206'),
(162, 1, '2015-11-23 12:03:53', '10.10.13.206'),
(163, 1, '2015-11-23 14:29:22', '10.10.13.206'),
(164, 1, '2015-11-23 14:54:03', '10.10.13.206'),
(165, 1, '2015-11-23 15:17:37', '10.10.13.206'),
(166, 1, '2015-11-24 01:28:25', '201.190.18.37'),
(167, 1, '2015-11-24 01:28:25', '201.190.18.37'),
(168, 1, '2015-11-24 09:05:03', '10.10.13.206'),
(169, 1, '2015-11-24 09:21:35', '10.10.13.206'),
(170, 13, '2015-11-24 11:36:31', '10.10.12.145'),
(171, 1, '2015-11-24 11:54:38', '10.10.13.206'),
(172, 1, '2015-11-24 15:34:48', '10.10.13.206'),
(173, 4, '2015-11-24 15:57:26', '10.10.13.206'),
(174, 1, '2015-11-24 22:44:08', '201.190.18.37'),
(175, 1, '2015-11-25 00:53:16', '201.190.18.37'),
(176, 1, '2015-11-25 08:06:08', '190.53.233.71'),
(177, 1, '2015-11-25 08:12:40', '190.53.233.71'),
(178, 1, '2015-11-25 08:37:07', '190.53.233.71'),
(179, 1, '2015-11-25 09:10:10', '10.10.13.206'),
(180, 1, '2015-11-25 09:59:38', '10.10.13.206'),
(181, 1, '2015-11-25 11:41:57', '190.107.154.46'),
(182, 13, '2015-11-25 15:47:40', '10.10.12.145'),
(183, 1, '2015-11-26 08:36:06', '10.10.13.206'),
(184, 4, '2015-11-26 10:27:15', '10.10.12.142'),
(185, 1, '2015-11-26 10:49:12', '10.10.13.206'),
(186, 4, '2015-11-26 11:40:29', '10.10.12.142'),
(187, 1, '2015-11-26 11:48:47', '10.10.13.206'),
(188, 1, '2015-11-26 11:53:02', '10.10.13.206'),
(189, 1, '2015-11-26 12:08:12', '10.10.13.206'),
(190, 1, '2015-11-26 17:32:29', '10.10.43.248'),
(191, 1, '2015-11-26 22:17:29', '201.190.18.37'),
(192, 1, '2015-11-26 22:17:30', '201.190.18.37'),
(193, 1, '2015-11-26 22:38:52', '201.190.18.37'),
(194, 1, '2015-11-26 23:00:45', '201.190.18.37'),
(195, 1, '2015-11-26 23:00:46', '201.190.18.37'),
(196, 1, '2015-11-26 23:16:09', '201.190.18.37'),
(197, 1, '2015-11-26 23:16:09', '201.190.18.37'),
(198, 1, '2015-11-26 23:35:20', '201.190.18.37'),
(199, 1, '2015-11-26 23:35:20', '201.190.18.37'),
(200, 1, '2015-11-26 23:35:20', '201.190.18.37'),
(201, 1, '2015-11-26 23:44:40', '201.190.18.37'),
(202, 1, '2015-11-26 23:58:52', '201.190.18.37'),
(203, 1, '2015-11-26 23:58:52', '201.190.18.37'),
(204, 1, '2015-11-27 00:19:59', '201.190.18.37'),
(205, 1, '2015-11-27 00:19:59', '201.190.18.37'),
(206, 1, '2015-11-27 00:32:02', '201.190.18.37'),
(207, 1, '2015-11-27 01:17:26', '201.190.18.37'),
(208, 1, '2015-11-27 01:27:00', '201.190.18.37'),
(209, 1, '2015-11-27 02:07:59', '201.190.18.37'),
(210, 1, '2015-11-27 09:54:13', '10.10.13.206'),
(211, 1, '2015-11-27 10:33:37', '10.10.13.206'),
(212, 1, '2015-11-27 11:58:34', '201.190.18.37'),
(213, 1, '2015-11-27 22:06:19', '201.190.18.37'),
(214, 1, '2015-11-28 12:01:14', '201.190.18.37'),
(215, 1, '2015-11-28 13:32:04', '201.190.18.37'),
(216, 1, '2015-11-28 16:44:19', '201.190.18.37'),
(217, 1, '2015-11-28 22:03:33', '201.190.18.37'),
(218, 1, '2015-11-28 22:03:34', '201.190.18.37'),
(219, 1, '2015-11-29 01:19:39', '201.190.18.37'),
(220, 1, '2015-11-29 12:11:44', '201.190.18.37'),
(221, 1, '2015-11-29 13:23:43', '190.53.233.71'),
(222, 1, '2015-11-29 13:39:20', '201.190.18.37'),
(223, 1, '2015-11-29 13:51:05', '190.53.233.71'),
(224, 1, '2015-11-29 15:31:13', '190.53.233.71'),
(225, 1, '2015-11-29 21:08:08', '201.190.18.37'),
(226, 1, '2015-11-29 21:15:55', '190.53.233.71'),
(227, 1, '2015-11-29 21:33:05', '190.92.43.85'),
(228, 1, '2015-11-29 22:15:24', '201.190.18.37'),
(229, 1, '2015-11-29 22:23:56', '190.92.43.85'),
(230, 1, '2015-11-29 22:45:47', '201.190.18.37'),
(231, 1, '2015-11-29 23:04:21', '201.190.18.37'),
(232, 1, '2015-11-29 23:52:54', '201.190.18.37'),
(233, 1, '2015-11-30 00:12:11', '201.190.18.37'),
(234, 1, '2015-11-30 00:31:05', '201.190.18.37'),
(235, 1, '2015-11-30 10:09:13', '10.10.13.206'),
(236, 1, '2015-11-30 10:57:29', '186.2.138.143'),
(237, 1, '2015-11-30 11:26:54', '186.2.139.135'),
(238, 1, '2015-11-30 12:27:58', '10.10.12.141'),
(239, 1, '2015-11-30 12:48:35', '201.190.18.37'),
(240, 4, '2015-11-30 18:39:08', '10.10.12.142'),
(241, 4, '2015-11-30 19:18:16', '10.10.12.142'),
(242, 1, '2015-11-30 19:24:48', '10.10.43.248'),
(243, 1, '2015-12-01 00:16:47', '201.190.18.37'),
(244, 1, '2015-12-01 00:16:51', '201.190.18.37'),
(245, 1, '2015-12-01 01:02:31', '201.190.18.37'),
(246, 1, '2015-12-01 01:30:32', '201.190.18.37'),
(247, 1, '2015-12-01 01:56:43', '201.190.18.37'),
(248, 1, '2015-12-01 02:27:01', '201.190.18.37'),
(249, 1, '2015-12-01 02:48:24', '201.190.18.37'),
(250, 1, '2015-12-01 08:18:55', '10.10.13.206'),
(251, 12, '2015-12-01 08:21:50', '10.10.13.206'),
(252, 12, '2015-12-01 08:37:44', '10.10.13.206'),
(253, 1, '2015-12-01 08:41:50', '10.10.13.206'),
(254, 1, '2015-12-01 10:39:26', '10.10.14.204'),
(255, 1, '2015-12-01 10:50:23', '10.10.13.206'),
(256, 1, '2015-12-01 12:46:31', '201.190.18.37'),
(257, 1, '2015-12-01 12:51:11', '190.107.154.46'),
(258, 1, '2015-12-01 13:04:45', '201.190.18.37'),
(259, 1, '2015-12-01 13:10:06', '190.107.154.46'),
(260, 1, '2015-12-01 14:45:17', '190.107.154.46'),
(261, 1, '2015-12-01 15:27:32', '10.10.43.248'),
(262, 1, '2015-12-01 15:49:50', '10.10.43.248'),
(263, 1, '2015-12-01 16:22:06', '190.107.154.46'),
(264, 4, '2015-12-01 16:57:56', '10.10.12.142'),
(265, 4, '2015-12-01 17:38:03', '10.10.12.142'),
(266, 1, '2015-12-01 23:20:02', '201.190.18.37'),
(267, 1, '2015-12-02 00:33:02', '201.190.18.37'),
(268, 1, '2015-12-02 01:06:54', '201.190.18.37'),
(269, 1, '2015-12-02 01:24:51', '201.190.18.37'),
(270, 1, '2015-12-02 15:48:55', '10.10.43.248'),
(271, 1, '2015-12-02 17:44:16', '10.10.43.248'),
(272, 1, '2015-12-02 21:18:44', '201.190.18.37'),
(273, 1, '2015-12-02 21:24:49', '201.190.18.37'),
(274, 1, '2015-12-02 21:47:31', '201.190.18.37'),
(275, 1, '2015-12-02 22:08:03', '201.190.18.37'),
(276, 1, '2015-12-02 22:27:23', '201.190.18.37'),
(277, 1, '2015-12-02 22:29:21', '201.190.18.37'),
(278, 1, '2015-12-03 00:02:41', '201.190.18.37'),
(279, 1, '2015-12-03 00:41:47', '190.92.43.55'),
(280, 1, '2015-12-03 00:46:59', '201.190.18.37'),
(281, 1, '2015-12-03 01:14:25', '201.190.18.37'),
(282, 1, '2015-12-03 02:49:34', '201.190.18.37'),
(283, 1, '2015-12-03 10:54:13', '201.190.18.37'),
(284, 7, '2015-12-03 15:31:16', '10.10.13.22'),
(285, 12, '2015-12-03 15:33:11', '10.10.13.22'),
(286, 7, '2015-12-03 15:34:05', '10.10.13.22'),
(287, 12, '2015-12-03 15:34:42', '10.10.13.22'),
(288, 7, '2015-12-03 15:36:57', '10.10.13.22'),
(289, 12, '2015-12-03 15:44:36', '10.10.13.22'),
(290, 12, '2015-12-03 15:48:08', '10.10.13.22'),
(291, 7, '2015-12-03 16:03:28', '10.10.13.22'),
(292, 12, '2015-12-03 16:22:12', '10.10.13.22'),
(293, 1, '2015-12-03 18:26:49', '186.2.139.212'),
(294, 1, '2015-12-03 22:52:33', '201.190.18.37'),
(295, 1, '2015-12-04 00:50:13', '201.190.18.37'),
(296, 7, '2015-12-04 08:10:49', '10.10.13.206'),
(297, 12, '2015-12-04 08:12:28', '10.10.13.206'),
(298, 7, '2015-12-04 08:13:15', '10.10.13.206'),
(299, 13, '2015-12-04 08:18:28', '10.10.13.206'),
(300, 6, '2015-12-04 08:25:50', '10.10.13.206'),
(301, 10, '2015-12-04 08:46:44', '10.10.13.206'),
(302, 2, '2015-12-04 08:47:48', '10.10.13.206'),
(303, 4, '2015-12-04 12:00:31', '10.10.12.142'),
(304, 4, '2015-12-04 12:47:58', '10.10.12.142'),
(305, 4, '2015-12-04 14:40:42', '10.10.12.142'),
(306, 4, '2015-12-04 15:19:51', '10.10.12.142'),
(307, 4, '2015-12-04 16:24:20', '10.10.12.142'),
(308, 1, '2015-12-04 20:21:44', '201.190.18.66'),
(309, 1, '2015-12-05 14:12:02', '201.190.18.37'),
(310, 1, '2015-12-05 15:24:53', '201.190.18.66'),
(311, 1, '2015-12-05 15:34:17', '201.190.18.37'),
(312, 1, '2015-12-05 21:11:26', '201.190.18.37'),
(313, 1, '2015-12-05 21:35:46', '201.190.18.37'),
(314, 34, '2015-12-05 21:42:21', '201.190.18.37'),
(315, 1, '2015-12-05 21:46:15', '201.190.18.37'),
(316, 1, '2015-12-06 11:59:36', '201.190.18.66'),
(317, 1, '2015-12-06 15:31:44', '201.190.18.37'),
(318, 1, '2015-12-06 17:50:30', '201.190.18.37'),
(319, 1, '2015-12-06 17:53:19', '201.190.18.37'),
(320, 1, '2015-12-06 18:10:48', '201.190.18.37'),
(321, 1, '2015-12-06 18:23:54', '201.190.18.37'),
(322, 1, '2015-12-06 19:15:32', '201.190.18.37'),
(323, 1, '2015-12-06 19:42:38', '201.190.18.37'),
(324, 1, '2015-12-06 23:23:51', '201.190.18.37'),
(325, 1, '2015-12-06 23:43:43', '201.190.18.37'),
(326, 1, '2015-12-07 00:18:44', '201.190.18.37'),
(327, 1, '2015-12-07 00:52:05', '190.92.43.56'),
(328, 1, '2015-12-07 00:59:54', '201.190.18.37'),
(329, 1, '2015-12-07 01:17:52', '201.190.18.37'),
(330, 1, '2015-12-07 01:39:59', '201.190.18.37'),
(331, 1, '2015-12-07 02:23:48', '190.92.43.97'),
(332, 1, '2015-12-07 02:27:20', '201.190.18.37'),
(333, 1, '2015-12-07 02:37:25', '201.190.18.37'),
(334, 1, '2015-12-07 02:37:53', '190.92.43.219'),
(335, 1, '2015-12-07 03:02:23', '201.190.18.37'),
(336, 2, '2015-12-07 08:55:18', '10.10.12.141'),
(337, 1, '2015-12-07 09:55:20', '10.10.43.248'),
(338, 1, '2015-12-07 10:13:30', '10.10.15.155'),
(339, 1, '2015-12-07 10:58:50', '10.10.43.248'),
(340, 1, '2015-12-07 11:39:20', '10.10.43.248'),
(341, 1, '2015-12-07 11:53:08', '10.10.43.248'),
(342, 1, '2015-12-07 13:48:50', '190.107.154.46'),
(343, 1, '2015-12-07 20:02:50', '190.53.233.71'),
(344, 1, '2015-12-08 10:20:42', '10.10.43.222'),
(345, 1, '2015-12-08 10:59:49', '10.10.43.222'),
(346, 1, '2015-12-08 18:02:05', '190.92.43.106'),
(347, 1, '2015-12-08 18:19:03', '190.92.43.106'),
(348, 1, '2015-12-08 18:43:16', '190.92.43.106'),
(349, 1, '2015-12-08 21:29:59', '190.92.43.99'),
(350, 1, '2015-12-08 21:32:37', '186.2.138.83'),
(351, 1, '2015-12-08 22:10:49', '201.190.18.37'),
(352, 1, '2015-12-08 22:45:06', '201.190.18.37'),
(353, 1, '2015-12-08 23:00:39', '201.190.18.37'),
(354, 1, '2015-12-08 23:19:01', '201.190.18.37'),
(355, 12, '2015-12-09 12:31:11', '10.10.13.206'),
(356, 5, '2015-12-09 14:40:52', '10.10.12.139'),
(357, 13, '2015-12-09 15:06:58', '10.10.12.145'),
(358, 6, '2015-12-09 15:19:45', '10.10.12.140'),
(359, 12, '2015-12-09 15:23:03', '10.10.13.206'),
(360, 5, '2015-12-09 15:34:01', '10.10.12.139'),
(361, 5, '2015-12-09 16:02:27', '10.10.13.206'),
(362, 5, '2015-12-09 16:08:08', '66.85.148.52'),
(363, 12, '2015-12-09 16:46:32', '10.10.13.206'),
(364, 6, '2015-12-09 17:06:35', '10.10.12.140'),
(365, 6, '2015-12-09 17:09:00', '10.10.12.140'),
(366, 1, '2015-12-09 21:35:21', '190.92.43.241'),
(367, 1, '2015-12-09 22:06:35', '190.92.43.144'),
(368, 1, '2015-12-09 22:08:36', '190.92.43.144'),
(369, 1, '2015-12-09 23:09:55', '201.190.18.37'),
(370, 1, '2015-12-10 00:38:42', '201.190.18.37'),
(371, 1, '2015-12-10 01:03:35', '201.190.18.37'),
(372, 1, '2015-12-10 02:05:02', '201.190.18.37'),
(373, 1, '2015-12-10 08:51:34', '201.190.18.37'),
(374, 1, '2015-12-10 18:50:49', '190.92.43.178'),
(375, 12, '2015-12-11 10:11:37', '10.10.13.206'),
(376, 3, '2015-12-11 11:16:22', '66.85.148.52'),
(377, 3, '2015-12-11 11:22:42', '10.10.13.206'),
(378, 2, '2015-12-11 11:24:43', '10.10.13.206'),
(379, 3, '2015-12-11 11:25:36', '10.10.13.206'),
(380, 12, '2015-12-11 11:29:15', '10.10.13.206'),
(381, 12, '2015-12-11 12:34:23', '10.10.13.206'),
(382, 6, '2015-12-11 12:53:41', '10.10.13.206'),
(383, 4, '2015-12-11 12:54:40', '10.10.13.206'),
(384, 7, '2015-12-11 12:55:17', '10.10.13.206'),
(385, 1, '2015-12-11 17:59:41', '201.190.18.37'),
(386, 1, '2015-12-11 20:21:47', '201.190.18.37'),
(387, 1, '2015-12-12 19:34:53', '201.190.18.37'),
(388, 1, '2015-12-12 19:59:00', '201.190.18.37'),
(389, 1, '2015-12-14 22:31:53', '201.190.18.37'),
(390, 4, '2015-12-15 17:37:49', '10.10.12.142'),
(391, 4, '2015-12-15 18:01:39', '10.10.12.142'),
(392, 4, '2015-12-17 17:42:16', '10.10.12.142'),
(393, 1, '2015-12-19 13:13:33', '190.107.154.46'),
(394, 4, '2016-01-07 11:22:26', '10.10.12.142'),
(395, 4, '2016-01-07 16:09:24', '10.10.12.142'),
(396, 4, '2016-01-07 18:08:13', '10.10.12.142'),
(397, 1, '2016-01-08 15:34:01', '190.92.43.145'),
(398, 4, '2016-01-09 15:30:11', '190.181.201.172'),
(399, 4, '2016-01-09 16:10:17', '190.181.201.172'),
(400, 4, '2016-01-09 16:10:20', '190.181.201.172'),
(401, 1, '2016-01-09 20:01:15', '186.2.139.135'),
(402, 4, '2016-01-11 12:05:25', '190.181.201.172'),
(403, 11, '2016-01-11 12:14:31', '10.10.13.204'),
(404, 12, '2016-01-11 12:43:01', '10.10.13.206'),
(405, 11, '2016-01-11 12:44:46', '10.10.13.204'),
(406, 11, '2016-01-11 12:45:26', '10.10.13.204'),
(407, 4, '2016-01-11 12:55:18', '10.10.12.142'),
(408, 4, '2016-01-11 13:30:53', '190.181.201.172'),
(409, 11, '2016-01-11 15:19:48', '10.10.13.204'),
(410, 4, '2016-01-11 16:46:10', '190.181.201.172'),
(411, 4, '2016-01-11 17:46:55', '190.181.201.172'),
(412, 4, '2016-01-11 20:14:47', '190.181.201.172'),
(413, 4, '2016-01-11 20:38:13', '190.181.201.172'),
(414, 4, '2016-01-11 21:33:27', '190.181.201.172'),
(415, 4, '2016-01-11 21:38:56', '190.181.201.172'),
(416, 4, '2016-01-12 09:10:46', '190.181.201.172'),
(417, 11, '2016-01-12 09:35:33', '10.10.13.204'),
(418, 4, '2016-01-12 09:35:41', '190.181.201.172'),
(419, 4, '2016-01-12 09:44:09', '190.181.201.172'),
(420, 4, '2016-01-12 09:48:49', '190.181.201.172'),
(421, 4, '2016-01-12 09:59:52', '190.181.201.172'),
(422, 11, '2016-01-12 10:05:12', '10.10.13.204'),
(423, 4, '2016-01-12 10:06:42', '190.181.201.172'),
(424, 12, '2016-01-12 11:17:17', '10.10.13.206'),
(425, 11, '2016-01-12 11:21:54', '10.10.13.204'),
(426, 12, '2016-01-12 11:34:08', '10.10.13.206'),
(427, 12, '2016-01-12 11:40:53', '66.85.148.52'),
(428, 12, '2016-01-12 12:14:48', '10.10.13.206'),
(429, 11, '2016-01-12 12:15:48', '10.10.13.204'),
(430, 11, '2016-01-12 12:24:01', '10.10.13.204'),
(431, 11, '2016-01-12 12:42:47', '10.10.13.204'),
(432, 12, '2016-01-12 12:43:47', '66.85.148.52'),
(433, 4, '2016-01-12 12:57:50', '190.181.201.172'),
(434, 4, '2016-01-12 13:21:51', '190.181.201.172'),
(435, 11, '2016-01-12 13:33:07', '10.10.13.204'),
(436, 11, '2016-01-12 14:50:15', '10.10.13.204'),
(437, 11, '2016-01-12 15:24:35', '10.10.13.204'),
(438, 11, '2016-01-12 15:51:33', '10.10.13.204'),
(439, 12, '2016-01-12 16:28:11', '66.85.148.52'),
(440, 11, '2016-01-12 16:31:49', '10.10.13.204'),
(441, 4, '2016-01-13 08:45:55', '190.181.201.172'),
(442, 4, '2016-01-13 09:08:12', '190.181.201.172'),
(443, 4, '2016-01-13 09:11:44', '190.181.201.172'),
(444, 11, '2016-01-13 09:20:09', '10.10.13.204'),
(445, 12, '2016-01-13 09:59:19', '66.85.148.52'),
(446, 11, '2016-01-13 10:04:51', '10.10.13.204'),
(447, 4, '2016-01-13 10:17:19', '190.181.201.172'),
(448, 11, '2016-01-13 10:30:22', '10.10.13.204'),
(449, 4, '2016-01-13 10:57:38', '190.181.201.172'),
(450, 4, '2016-01-13 11:02:40', '190.181.201.172'),
(451, 12, '2016-01-13 11:13:21', '10.10.13.206'),
(452, 11, '2016-01-13 11:35:33', '10.10.13.204'),
(453, 12, '2016-01-13 12:09:29', '10.10.13.206'),
(454, 11, '2016-01-13 13:37:47', '10.10.13.204'),
(455, 12, '2016-01-13 14:02:46', '10.10.13.206'),
(456, 11, '2016-01-13 14:17:34', '10.10.13.204'),
(457, 4, '2016-01-13 14:39:09', '190.181.201.172'),
(458, 4, '2016-01-14 08:29:49', '190.181.201.172'),
(459, 4, '2016-01-14 09:30:28', '190.181.201.172'),
(460, 4, '2016-01-14 09:47:43', '190.181.201.172'),
(461, 4, '2016-01-14 11:54:19', '190.181.201.172'),
(462, 4, '2016-01-14 12:06:28', '190.181.201.172'),
(463, 11, '2016-01-14 15:42:27', '10.10.13.204'),
(464, 12, '2016-01-14 15:51:31', '10.10.13.206'),
(465, 4, '2016-01-14 16:18:46', '190.181.201.172'),
(466, 11, '2016-01-14 16:38:31', '10.10.13.204'),
(467, 4, '2016-01-14 16:45:02', '190.181.201.172'),
(468, 4, '2016-01-15 08:48:10', '190.181.201.172'),
(469, 11, '2016-01-15 09:43:42', '10.10.13.204'),
(470, 4, '2016-01-15 09:58:26', '190.181.201.172'),
(471, 11, '2016-01-15 11:26:23', '10.10.13.204'),
(472, 4, '2016-01-15 11:36:27', '190.181.201.172'),
(473, 12, '2016-01-15 11:52:47', '10.10.13.206'),
(474, 11, '2016-01-15 12:25:47', '10.10.13.204'),
(475, 4, '2016-01-15 14:01:44', '190.181.201.172'),
(476, 4, '2016-01-15 14:45:15', '190.181.201.172'),
(477, 4, '2016-01-15 15:56:43', '190.181.201.172'),
(478, 11, '2016-01-15 16:00:25', '10.10.13.204'),
(479, 11, '2016-01-15 16:33:23', '10.10.13.204'),
(480, 4, '2016-01-15 16:50:38', '190.181.201.172'),
(481, 11, '2016-01-15 17:28:05', '10.10.13.204'),
(482, 4, '2016-01-15 17:45:55', '190.181.201.172'),
(483, 11, '2016-01-18 09:31:35', '10.10.13.204'),
(484, 11, '2016-01-18 10:01:38', '10.10.13.204'),
(485, 1, '2016-01-18 14:26:01', '10.10.13.206'),
(486, 5, '2016-01-18 14:30:58', '10.10.12.139'),
(487, 11, '2016-01-18 15:01:28', '10.10.13.204'),
(488, 5, '2016-01-18 15:01:34', '10.10.12.139'),
(489, 4, '2016-01-19 08:28:26', '190.181.201.172'),
(490, 4, '2016-01-19 12:52:53', '190.181.201.172'),
(491, 4, '2016-01-19 13:12:52', '190.181.201.172'),
(492, 12, '2016-01-21 14:59:01', '10.10.13.206'),
(493, 4, '2016-01-23 14:57:59', '190.181.201.172'),
(494, 4, '2016-01-24 15:44:51', '190.181.201.172'),
(495, 5, '2016-01-25 12:59:04', '10.10.12.139'),
(496, 1, '2016-01-27 17:03:01', '190.92.25.118'),
(497, 1, '2016-01-27 21:25:39', '201.190.18.229'),
(498, 1, '2016-01-30 12:26:41', '186.32.234.114'),
(499, 1, '2016-02-02 13:55:10', '201.190.18.130'),
(500, 1, '2016-02-02 14:05:09', '201.190.18.130'),
(501, 4, '2016-02-04 14:47:41', '190.53.203.89'),
(502, 11, '2016-02-04 18:32:23', '10.10.13.204'),
(503, 4, '2016-02-04 18:43:46', '190.53.203.89'),
(504, 7, '2016-02-05 17:19:07', '10.10.13.22'),
(505, 12, '2016-02-08 09:11:58', '10.10.13.206'),
(506, 12, '2016-02-08 09:42:56', '10.10.13.206'),
(507, 1, '2016-02-08 10:09:45', '186.2.138.96'),
(508, 12, '2016-02-08 10:32:11', '10.10.13.206'),
(509, 1, '2016-02-08 10:40:02', '10.10.13.206'),
(510, 4, '2016-02-09 13:11:33', '190.53.203.89'),
(511, 1, '2016-02-09 19:17:15', '10.10.13.206'),
(512, 4, '2016-02-10 18:00:08', '190.53.203.89'),
(513, 4, '2016-02-10 19:19:56', '190.53.203.89'),
(514, 4, '2016-02-11 10:02:07', '190.53.203.89'),
(515, 12, '2016-02-11 14:26:48', '10.10.13.206'),
(516, 12, '2016-02-11 15:11:58', '10.10.13.206'),
(517, 1, '2016-02-11 16:10:39', '10.10.13.206'),
(518, 12, '2016-02-11 16:51:04', '10.10.13.206'),
(519, 3, '2016-02-11 17:11:01', '10.10.13.206'),
(520, 2, '2016-02-11 17:11:55', '10.10.13.206'),
(521, 12, '2016-02-11 17:12:37', '10.10.13.206'),
(522, 2, '2016-02-11 17:13:09', '10.10.13.206'),
(523, 12, '2016-02-11 17:25:11', '10.10.13.206'),
(524, 2, '2016-02-11 17:28:57', '10.10.13.206'),
(525, 12, '2016-02-11 17:29:28', '10.10.13.206'),
(526, 3, '2016-02-11 17:31:36', '10.10.13.206'),
(527, 12, '2016-02-11 17:32:47', '10.10.13.206'),
(528, 12, '2016-02-11 17:53:34', '10.10.13.206'),
(529, 3, '2016-02-11 17:57:28', '10.10.13.206'),
(530, 12, '2016-02-11 17:58:36', '10.10.13.206'),
(531, 3, '2016-02-11 17:58:51', '10.10.13.206'),
(532, 12, '2016-02-11 18:04:17', '10.10.13.206'),
(533, 2, '2016-02-11 18:05:16', '10.10.13.206'),
(534, 12, '2016-02-11 18:19:54', '10.10.13.206'),
(535, 12, '2016-02-12 16:42:47', '10.10.13.206'),
(536, 1, '2016-02-14 12:49:16', '190.181.207.62'),
(537, 1, '2016-02-14 13:02:15', '190.181.207.62'),
(538, 1, '2016-02-14 13:06:02', '192.168.0.24'),
(539, 1, '2016-02-14 13:07:19', '190.181.207.62'),
(540, 1, '2016-02-14 13:36:43', '127.0.0.1'),
(541, 1, '2016-02-14 13:48:13', '190.181.207.62');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_notificado`
--

DROP TABLE IF EXISTS `usuario_notificado`;
CREATE TABLE IF NOT EXISTS `usuario_notificado` (
  `Id_UsuarioNotificado` int(11) NOT NULL auto_increment,
  `Id_Notificacion` int(11) NOT NULL,
  `Id_Usuario` int(11) NOT NULL,
  `IdUbicacionNotificacion` tinyint(4) NOT NULL,
  `Estado` tinyint(11) NOT NULL,
  `Fecha` datetime NOT NULL,
  PRIMARY KEY  (`Id_UsuarioNotificado`),
  KEY `fk_usuario_notificado_notificaciones_folios_idx` (`Id_Notificacion`),
  KEY `fk_usuario_notificado_ubicacion_notificacionesFolios` (`IdUbicacionNotificacion`),
  KEY `fk_usuario_notificado_usuario_idx` (`Id_Usuario`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

--
-- Volcar la base de datos para la tabla `usuario_notificado`
--

INSERT INTO `usuario_notificado` (`Id_UsuarioNotificado`, `Id_Notificacion`, `Id_Usuario`, `IdUbicacionNotificacion`, `Estado`, `Fecha`) VALUES
(1, 1, 3, 1, 1, '2015-11-17 16:57:14'),
(2, 2, 3, 1, 1, '2015-11-17 16:57:14'),
(3, 3, 1, 1, 0, '2015-12-06 00:00:00'),
(4, 4, 1, 1, 0, '2015-12-06 00:00:00'),
(5, 5, 1, 1, 0, '2015-12-06 00:00:00'),
(6, 5, 2, 3, 1, '2015-12-06 00:00:00'),
(7, 5, 3, 3, 1, '2015-12-06 00:00:00'),
(8, 6, 13, 3, 1, '2015-12-07 08:59:14'),
(9, 7, 13, 3, 1, '2015-12-07 08:59:14'),
(10, 8, 2, 3, 1, '2015-12-11 12:06:44'),
(11, 8, 3, 3, 1, '2015-12-11 12:06:44');
