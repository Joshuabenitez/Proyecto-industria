-- phpMyAdmin SQL Dump
-- version 3.3.8.1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 01-10-2015 a las 22:34:04
-- Versión del servidor: 5.0.91
-- Versión de PHP: 5.3.6-pl0-gentoo

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: 'ccjj'
--


DELIMITER $$
--
-- Procedimientos
--
CREATE  PROCEDURE `pa_eliminar_actividad`(
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

CREATE  PROCEDURE `pa_eliminar_actividad_terminada`(
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

CREATE  PROCEDURE `pa_eliminar_area`(
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

CREATE  PROCEDURE `pa_eliminar_costo_porcentaje_actividad_por_trimestre`(
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

CREATE  PROCEDURE `pa_eliminar_indicador`(
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

CREATE  PROCEDURE `pa_eliminar_objetivo_institucional`(
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

CREATE  PROCEDURE `pa_eliminar_poa`(
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

CREATE  PROCEDURE `pa_eliminar_responsables_por_actividad`(
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

CREATE  PROCEDURE `pa_eliminar_sub_actividad`(in id_sub_Actividad int)
begin
delete from sub_actividad where sub_actividad.id_sub_Actividad=id_sub_Actividad;
end$$

CREATE  PROCEDURE `pa_eliminar_sub_actividad_realizada`(
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

CREATE  PROCEDURE `pa_eliminar_tipo_area`(
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

CREATE  PROCEDURE `pa_insertar_actividad`(
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

CREATE  PROCEDURE `pa_insertar_actividades_terminadas`(IN `id_Actividad` INT, IN `fecha` DATE, IN `estado` VARCHAR(15), IN `id_Usuario` VARCHAR(20), IN `observaciones` TEXT)
begin 
	insert into actividades_terminadas (id_Actividad, fecha, estado, No_Empleado, observaciones) values (id_Actividad, fecha, estado, id_Usuario, observaciones);
end$$

CREATE  PROCEDURE `pa_insertar_area`(IN `nombre` VARCHAR(30), IN `id_tipo_Area` INT, IN `observacion` TEXT)
begin
	insert into area (nombre,id_tipo_area,observacion) values(nombre, id_tipo_Area,observacion);
end$$

CREATE  PROCEDURE `pa_insertar_costo_porcentaje_actividad_por_trimestre`(IN `id_Actividad` INT, IN `costo` INT, IN `porcentaje` INT, IN `observacion` TEXT, IN `trimestre` INT)
begin 
insert into costo_porcentaje_actividad_por_trimestre (id_Actividad, costo,porcentaje,observacion, trimestre)values(id_Actividad, costo,porcentaje,observacion, trimestre);
end$$

CREATE  PROCEDURE `pa_insertar_indicador`(IN `id_ObjetivosInstitucionales` INT, IN `nombre` VARCHAR(30), IN `descripcion` TEXT)
begin
	insert into indicadores (id_ObjetivosInsitucionales, nombre, descripcion) values (id_ObjetivosInstitucionales, nombre, descripcion);
end$$

CREATE  PROCEDURE `pa_insertar_objetivos_institucionales`(IN `definicion` TEXT, IN `area_Estrategica` TEXT, IN `resultados_Esperados` TEXT, IN `id_Area` INT, IN `id_Poa` INT)
begin 
	insert into objetivos_institucionales  (definicion,area_Estrategica,resultados_Esperados,id_Area,id_Poa) values (definicion,area_Estrategica,resultados_Esperados,id_Area,id_Poa);
end$$

CREATE  PROCEDURE `pa_insertar_poa`(IN `nombre` VARCHAR(30), IN `fecha_de_Inicio` DATE, IN `fecha_Fin` DATE, IN `descripcion` TEXT)
begin
insert into poa (nombre,fecha_de_Inicio,fecha_Fin,descripcion) values (nombre,fecha_de_Inicio,fecha_Fin, descripcion);
end$$

CREATE  PROCEDURE `pa_insertar_responsables_por_actividad`(IN `id_Actividad` INT, IN `id_Responsable` INT, IN `fecha_Asignacion` DATE, IN `observacion` TEXT)
begin
	insert into responsables_por_actividad (id_Actividad,id_Responsable,fecha_Asignacion,observacion) values (id_Actividad,id_Responsable,fecha_Asignacion,observacion);
end$$

CREATE  PROCEDURE `pa_insertar_sub_actividad`(IN `id_Actividad` INT, IN `nombre` VARCHAR(30), IN `descripcion` TEXT, IN `fecha_monitoreo` DATE, IN `id_Encargado` VARCHAR(20), IN `ponderacion` INT, IN `costo` INT, IN `observacion` TEXT)
begin
insert into sub_actividad (idActividad,nombre,descripcion,fecha_monitoreo,id_Encargado,ponderacion,costo,observacion) values(id_Actividad,nombre,descripcion,fecha_monitoreo,id_Encargado,ponderacion,costo,observacion);
end$$

CREATE  PROCEDURE `pa_insertar_sub_actividades_realizadas`(IN `id_SubActividad` INT, IN `fecha_Realizacion` DATE, IN `observacion` TEXT)
begin
	insert into sub_actividades_realizadas (id_SubActividad,fecha_Realizacion,observacion) values (id_SubActividad,fecha_Realizacion,observacion);
end$$

CREATE  PROCEDURE `pa_insertar_tipo_area`(IN `nombre` VARCHAR(30), IN `observaciones` TEXT)
begin
	insert into  tipo_area (nombre,observaciones) values(nombre,observaciones);
end$$

CREATE  PROCEDURE `pa_modificar_actividad`(IN `id_Actividad` INT, IN `id_Indicador` INT, IN `descripcion` TEXT, IN `correlativo` VARCHAR(10), IN `supuestos` TEXT, IN `justificacion` TEXT, IN `medio_Verificacion` TEXT, IN `poblacion_Objetivo` VARCHAR(20), IN `fecha_Inicio` DATE, IN `fecha_Fin` DATE)
begin
update actividades set id_indicador=id_Indicador, descripcion=descripcion, correlativo=correlativo, supuesto=supuesto, justificacion=justificacion, medio_verificacion=medio_Verificacion, poblacion_objetivo=poblacion_Objetivo,fecha_inicio=fecha_Inicio, fecha_fin=fecha_Fin 
where actividades.id_actividad= id_Actividad;
end$$

CREATE  PROCEDURE `pa_modificar_actividades_terminadas`(IN `id_Actividad_Terminada` INT, IN `id_Actividad` INT, IN `fecha` DATE, IN `estado` VARCHAR(15), IN `id_Usuario` VARCHAR(20), IN `observaciones` TEXT)
begin 
	update actividades_terminadas set id_Actividad=id_Actividad, fecha=fecha, estado=estado, No_Empleado=id_Usuario, observaciones=observaciones where actividades_terminadas.id_Actividades_Terminadas= id_Actividad_Terminada; 
end$$

CREATE  PROCEDURE `pa_modificar_area`(IN id_Area int ,IN nombre VARCHAR(30), IN id_tipo_Area INT, IN observacion TEXT)
begin
	update area set nombre=nombre,id_tipo_Area=id_tipo_Area,observaciones=observacion where area.id_Area=id_Area;
end$$

CREATE  PROCEDURE `pa_modificar_costo_porcentaje_actividad_por_trimestre`(IN id_Costo_Porcentaje_Actividad_Por_Trimesrte INT,IN id_Actividad INT, IN costo INT, IN porcentaje INT, IN observacion TEXT, IN trimestre INT)
begin 
update costo_porcentaje_actividad_por_trimestre set id_Actividad=id_ACtividad, costo=costo,porcentaje=porcentaje,observacion=observacion, trimestre=trimestre where costo_porcentaje_actividad_por_trimestre.id_Costo_Porcentaje_Actividad_Por_Trimesrte=id_Costo_Porcentaje_Actividad_Por_Trimesrte ;
end$$

CREATE  PROCEDURE `pa_modificar_indicador`(IN `id_Indicador` INT, IN `id_ObjetivosInstitucionales` INT, IN `nombre` VARCHAR(30), IN `descripcion` TEXT)
begin
update indicadores set id_ObjetivosInsitucionales=id_ObjetivosInstitucionales, nombre=nombre, descripcion=descripcion where indicadores.id_Indicadores=id_Indicador;
end$$

CREATE  PROCEDURE `pa_modificar_objetivos_institucionales`(IN id_Objetivo int,IN definicion TEXT, IN area_Estrategica TEXT, IN resultados_Esperados TEXT, IN id_Area INT, IN id_Poa INT)
begin 
update objetivos_institucionales set definicion=definicion,area_Estrategica=area_Estrategica,resultados_Esperados=resultados_Esperados,id_Area=id_Area,id_Poa=id_Poa where objetivos_institucionales.id_Objetivo= id_Objetivo ;
end$$

CREATE  PROCEDURE `pa_modificar_poa`(in id_Poa int,IN nombre VARCHAR(30), IN fecha_de_Inicio DATE, IN fecha_Fin DATE, IN descripcion TEXT)
begin
update poa set nombre=nombre,fecha_de_Inicio=fecha_de_Inicio,fecha_Fin=fecha_Fin,descripcion=descripcion
where poa.id_Poa=id_Poa;
end$$

CREATE  PROCEDURE `pa_modificar_responsables_por_actividad`(IN `id_Responsable_por_Act` INT, IN `id_Actividad` INT, IN `id_Responsable` INT, IN `fecha_Asignacion` DATE, IN `observacion` TEXT)
begin
update responsables_por_actividad set id_Actividad=id_Actividad,id_Responsable=id_Responsable,fecha_Asignacion=Fecha_Asignacion,observacion=observacion where responsables_por_actividad.id_Responsable_por_Actividad=id_Responsable_por_Act;
end$$

CREATE  PROCEDURE `pa_modificar_sub_actividad`(IN `id_sub_Act` INT, IN `id_Actividad` INT, IN `nombre` VARCHAR(30), IN `descripcion` TEXT, IN `fecha_monitoreo` DATE, IN `id_Encargado` VARCHAR(20), IN `ponderacion` INT, IN `costo` INT, IN `observacion` TEXT)
begin
update sub_actividad set idActividad=id_Actividad,nombre=nombre,descripcion=descripcion,fecha_monitoreo=fecha_monitoreo,id_Encargado=id_Encargado,ponderacion=ponderacion,costo=costo,observacion=observacion
where sub_actividad.id_sub_Actividad=id_sub_Act;
end$$

CREATE  PROCEDURE `pa_modificar_sub_actividades_realizadas`(in id_subActividadRealizada int,IN id_SubActividad INT, IN fecha_Realizacion DATE, IN observacion TEXT)
begin
update sub_actividades_realizadas set id_SubActividad=id_SubActividad,fecha_Realizacion=fecha_Realizacion,observacion=observacion 
where sub_actividades_Realizadas.id_subActividadRealizada=id_subActividadRealizada;
end$$

CREATE  PROCEDURE `pa_modificar_tipo_area`(IN id_Tipo_Area int,IN nombre VARCHAR(30), IN observaciones TEXT)
begin
	 update tipo_area set nombre=nombre,observaciones=observaciones where tipo_area.id_Tipo_Area=id_Tipo_Area;
end$$

CREATE  PROCEDURE `sp_actualizar_asignado_folio`(
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

CREATE  PROCEDURE `sp_actualizar_categorias_folios`(IN `Id_categoria_` INT(11), IN `NombreCategoria_` TEXT, IN `DescripcionCategoria_` TEXT, OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
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

CREATE  PROCEDURE `SP_ACTUALIZAR_CIUDAD`(
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

CREATE  PROCEDURE `sp_actualizar_estado_seguimiento`(IN `Id_Estado_Seguimiento_` TINYINT(4), IN `DescripcionEstadoSeguimiento_` TEXT, OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
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

CREATE  PROCEDURE `sp_actualizar_folio`( 
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

CREATE  PROCEDURE `SP_ACTUALIZAR_MENCION_HONORIFICA`(
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

CREATE  PROCEDURE `sp_actualizar_organizacion`(IN `Id_Organizacion_` INT(11), IN `NombreOrganizacion_` TEXT, IN `Ubicacion_` TEXT, OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
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

CREATE  PROCEDURE `SP_ACTUALIZAR_ORIENTACION`(
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

CREATE  PROCEDURE `SP_ACTUALIZAR_ORIENTACIONES`(
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

CREATE  PROCEDURE `SP_ACTUALIZAR_PERIODO`(
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

CREATE  PROCEDURE `SP_ACTUALIZAR_PLAN_ESTUDIO`(
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

CREATE  PROCEDURE `sp_actualizar_prioridad`(IN `Id_Prioridad_` TINYINT(4), IN `DescripcionPrioridad_` TEXT, OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
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

CREATE  PROCEDURE `sp_actualizar_seguimiento`(IN `numFolio_` VARCHAR(25), IN `fechaFin_` DATE, IN `prioridad_` TINYINT, IN `seguimiento_` TINYINT, IN `notas_` TEXT, OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
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
	 
     INSERT INTO seguimiento_historico VALUES(NULL,id,seguimiento_,notas_,prioridad_,NOW());

     SET mensaje = "El seguimiento ha sido actualizado satisfactoriamente."; 
     SET codMensaje = 1; 
   END IF; 
   
   COMMIT;
END$$

CREATE  PROCEDURE `SP_ACTUALIZAR_TIPO_DE_ESTUDIANTE`(
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

CREATE  PROCEDURE `sp_actualizar_ubicacion_archivo_fisica`(IN `Id_UbicacionArchivoFisico_` INT(5), IN `DescripcionUbicacionFisica_` TEXT, IN `Capacidad_` INT(10), IN `TotalIngresados_` INT(10), IN `HabilitadoParaAlmacenar_` TINYINT(1), OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
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

CREATE  PROCEDURE `sp_actualizar_ubicacion_notificaciones`(IN `Id_UbicacionNotificaciones_` TINYINT(4), IN `DescripcionUbicacionNotificaciones_` TEXT, OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
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

CREATE  PROCEDURE `sp_actualizar_unidad_academica`(IN `Id_UnidadAcademica_` INT(11), IN `NombreUnidadAcademica_` TEXT, IN `UbicacionUnidadAcademica_` TEXT, OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
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

CREATE  PROCEDURE `sp_actualizar_usuario`(IN `idUsuario` INT(11), IN `numEmpleado_` VARCHAR(13), IN `nombreAnt_` VARCHAR(30), IN `nombre_` VARCHAR(30), IN `Password_` VARCHAR(20), IN `rol_` INT(4), IN `fecha_` DATE, IN `estado_` BOOLEAN, OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
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

CREATE  PROCEDURE `SP_BUSQUEDA_SECRETARIA`(
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

CREATE  PROCEDURE `sp_check_seguimiento`( 
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

CREATE  PROCEDURE `SP_DAR_ALTA_SOLICITUD`(
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

CREATE  PROCEDURE `SP_ELIMINAR_ACONDICIONAMIENTOS`(
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

CREATE  PROCEDURE `SP_ELIMINAR_AREAS`(
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

CREATE  PROCEDURE `sp_eliminar_categorias_folios`(IN `sp_Id_categoria` INT, OUT `mensaje` VARCHAR(150), IN `codMensaje` TINYINT)
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

CREATE  PROCEDURE `SP_ELIMINAR_CIUDADES`(
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

CREATE  PROCEDURE `SP_ELIMINAR_ESTADOS`(
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

CREATE  PROCEDURE `sp_eliminar_estado_seguimiento`( 
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

CREATE  PROCEDURE `SP_ELIMINAR_FACULTADES`(
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

CREATE  PROCEDURE `SP_ELIMINAR_INSTANCIA_ACONDICIONAMIENTO`(
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

CREATE  PROCEDURE `SP_ELIMINAR_MENCION_HONORIFICA`(
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

CREATE  PROCEDURE `sp_eliminar_organizacion`( 
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

CREATE  PROCEDURE `SP_ELIMINAR_ORIENTACION`(
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

CREATE  PROCEDURE `SP_ELIMINAR_PERIODO`(
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

CREATE  PROCEDURE `SP_ELIMINAR_PLANES_ESTUDIO`(
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

CREATE  PROCEDURE `sp_eliminar_prioridad`( 
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

CREATE  PROCEDURE `SP_ELIMINAR_TIPOS_DE_SOLICITUD`(
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

CREATE  PROCEDURE `SP_ELIMINAR_TIPO_DE_ESTUDIANTE`(
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

CREATE  PROCEDURE `sp_eliminar_ubicacion_archivo_fisica`( 
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

CREATE  PROCEDURE `sp_eliminar_ubicacion_notificaciones`( 
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

CREATE  PROCEDURE `sp_eliminar_unidad_academica`( 
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

CREATE  PROCEDURE `SP_GESTIONAR_AREAS_VINCULACION`(
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

CREATE  PROCEDURE `SP_GESTIONAR_AULAS`(
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

CREATE  PROCEDURE `SP_GESTIONAR_EDIFICIOS`(
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

CREATE  PROCEDURE `SP_INSERTAR_AREAS`(
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

CREATE  PROCEDURE `sp_insertar_categorias_folios`(
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

CREATE  PROCEDURE `SP_INSERTAR_ESTADOS`(
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

CREATE  PROCEDURE `sp_insertar_estado_seguimiento`(
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

CREATE  PROCEDURE `sp_insertar_folio`(IN `numFolio_` VARCHAR(25), IN `fechaCreacion_` DATE, IN `fechaEntrada_` TIMESTAMP, IN `personaReferente_` TEXT, IN `unidadAcademica_` INT, IN `organizacion_` INT, IN categoria_ INT, IN `descripcion_` TEXT, IN `tipoFolio_` TINYINT, IN `ubicacionFisica_` INT(5), IN `prioridad_` TINYINT, IN `seguimiento_` INT(11), IN `notas_` TEXT, IN encargado INT, OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
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

CREATE  PROCEDURE `sp_insertar_folio_2`(IN `numFolio_` VARCHAR(25), IN `fechaCreacion_` DATE, IN `fechaEntrada_` TIMESTAMP, IN `personaReferente_` TEXT, IN `unidadAcademica_` INT, IN `organizacion_` INT, IN categoria_ INT, IN `descripcion_` TEXT, IN `tipoFolio_` TINYINT, IN `ubicacionFisica_` INT(5), IN `prioridad_` TINYINT, IN `seguimiento_` INT(11), IN `notas_` TEXT, IN encargado INT, IN folioRef VARCHAR(25), OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
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

CREATE  PROCEDURE `sp_insertar_organizacion`(
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

CREATE  PROCEDURE `sp_insertar_prioridad`(
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

CREATE  PROCEDURE `sp_insertar_ubicacion_archivo_fisica`(
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

CREATE  PROCEDURE `sp_insertar_ubicacion_notificacion`(
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

CREATE  PROCEDURE `sp_insertar_unidad_academica`( 
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

CREATE  PROCEDURE `sp_insertar_usuario`(IN `numEmpleado_` VARCHAR(13), IN `nombre_` VARCHAR(30), IN `Password_` VARCHAR(25), IN `rol_` INT(4), IN `fechaCreacion_` DATE, OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
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

CREATE  PROCEDURE `sp_lee_actividades_no_terminadas_poa`()
begin

select id_actividad,(select nombre from indicadores where indicadores.id_Indicadores=actividades.id_indicador) as indicador,descripcion,correlativo,supuesto,justificacion,medio_verificacion,poblacion_objetivo,fecha_inicio,fecha_fin from actividades where id_actividad not in (SELECT actividades_terminadas.id_Actividad FROM actividades_terminadas) and (select fecha_Fin from poa where poa.id_Poa in (select id_Poa from objetivos_institucionales where objetivos_institucionales.id_Objetivo in (select id_ObjetivosInsitucionales from indicadores where indicadores.id_Indicadores in (select id_indicador from actividades ))) and year(fecha_Fin) = year(now())) and (select fecha_de_Inicio from poa where poa.id_Poa in (select id_Poa from objetivos_institucionales where objetivos_institucionales.id_Objetivo in (select id_ObjetivosInsitucionales from indicadores where indicadores.id_Indicadores in (select id_indicador from actividades ))) and year(fecha_de_Inicio) = year(now())) and id_indicador in (select id_indicadores from indicadores where id_ObjetivosInsitucionales in (select id_Objetivo from objetivos_institucionales where id_Poa in(select id_Poa from poa where objetivos_institucionales.id_Poa =poa.id_Poa)));
end$$

CREATE  PROCEDURE `sp_lee_actividades_terminadas_poa`()
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

CREATE  PROCEDURE `sp_login`(IN `user_` VARCHAR(30), IN `pass` VARCHAR(25))
BEGIN
   SELECT id_Usuario,Id_Rol FROM usuario WHERE nombre = user_ AND pass = udf_Decrypt_derecho(Password) AND Estado = 1;
END$$

CREATE  PROCEDURE `sp_log_user`(IN `usuario_` INT(11), IN `ip` VARCHAR(45))
begin
    insert into usuario_log values (null,usuario_,now(),ip);
end$$

CREATE  PROCEDURE `SP_MODIFICAR_ACONDICIONAMIENTOS`(
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

CREATE  PROCEDURE `SP_MODIFICAR_AREAS`(
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

CREATE  PROCEDURE `SP_MODIFICAR_ESTADOS`(
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

CREATE  PROCEDURE `SP_MODIFICAR_FACULTADES`(
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

CREATE  PROCEDURE `SP_MODIFICAR_SOLICITUDES`(
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

CREATE  PROCEDURE `SP_MODIFICAR_TIPOS_SOLICITUDES`(
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

CREATE  PROCEDURE `SP_OBTENER_AREAS`(
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

CREATE  PROCEDURE `SP_OBTENER_AREAS_POYECTO`(
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

CREATE  PROCEDURE `SP_OBTENER_AREAS_VINCULACION`(
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

CREATE  PROCEDURE `SP_OBTENER_AREAS_VINCULACIONES`(
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

CREATE  PROCEDURE `SP_OBTENER_AULAS_POR_EDIFICIO`(
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

CREATE  PROCEDURE `SP_OBTENER_CIUDADES`(
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

CREATE  PROCEDURE `SP_OBTENER_EDIFICIOS`(
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

CREATE  PROCEDURE `SP_OBTENER_ESTADOS`(
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

CREATE  PROCEDURE `SP_OBTENER_ESTUDIANTES`(
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

CREATE  PROCEDURE `SP_OBTENER_INFORMACION_ESTUDIANTE`(
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

CREATE  PROCEDURE `SP_OBTENER_INSTANCIAS_ACONDICIONAMIENTOS`(
IN codInstanciaA INT)
BEGIN
SELECT codigo, cod_acondicionamiento FROM ca_instancias_acondicionamientos where 
cod_acondicionamiento=codInstanciaA;
end$$

CREATE  PROCEDURE `SP_OBTENER_MENCIONES_HONORIFICAS`(
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

CREATE  PROCEDURE `SP_OBTENER_PERIODOS_ACADEMICOS`(
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

CREATE  PROCEDURE `SP_OBTENER_PLANES_ESTUDIO`(
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

CREATE  PROCEDURE `SP_OBTENER_SOLICITUDES`(
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
        IF(sa_examenes_himno.nota_himno IS NULL, 'No', 'Si') AS APLICA_PARA_HIMNO
	FROM sa_solicitudes LEFT JOIN sa_examenes_himno ON(sa_solicitudes.codigo = sa_examenes_himno.cod_solicitud) 
		 INNER JOIN sa_periodos ON(sa_solicitudes.cod_periodo = sa_periodos.codigo)
		 INNER JOIN sa_tipos_solicitud ON(sa_tipos_solicitud.codigo = sa_solicitudes.cod_tipo_solicitud)
         INNER JOIN sa_estados_solicitud ON (sa_estados_solicitud.codigo = sa_solicitudes.cod_estado)
		inner join persona on (persona.N_identidad = sa_solicitudes.dni_estudiante);
END$$

CREATE  PROCEDURE `SP_OBTENER_TIPOS_ESTUDIANTES`(
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

CREATE  PROCEDURE `SP_OBTENER_TIPOS_SOLICITUDES_POR_ESTUDIANTE`(
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

CREATE  PROCEDURE `SP_REALIZAR_CAMBIO_TIPO_ESTUDIANTE`(
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

CREATE  PROCEDURE `SP_REGISTRAR_ACONDICIONAMIENTOS`(
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

CREATE  PROCEDURE `SP_REGISTRAR_CIUDAD`(
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

CREATE  PROCEDURE `SP_REGISTRAR_DOCENTE`(
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

CREATE  PROCEDURE `SP_REGISTRAR_ESTUDIANTE`(
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

CREATE  PROCEDURE `SP_REGISTRAR_FACULTADES`(
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

CREATE  PROCEDURE `SP_REGISTRAR_INSTANCIA_ACONDICIONAMIENTO`(
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

CREATE  PROCEDURE `SP_REGISTRAR_MENCION_HONORIFICA`(
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

CREATE  PROCEDURE `SP_REGISTRAR_ORIENTACIONES`(
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

CREATE  PROCEDURE `SP_REGISTRAR_PERIODO`(
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

CREATE  PROCEDURE `SP_REGISTRAR_PLAN_ESTUDIO`(
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

CREATE  PROCEDURE `SP_REGISTRAR_PROYECTO`(
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

CREATE  PROCEDURE `SP_REGISTRAR_SOLICITUD`(
	-- Descripción: Registra la solicitud de un estudiante
	-- LDeras 2015-07-01
    
    IN pcIdentidadEstudiante VARCHAR(500), -- Número de identidad del estudiante
    IN pcTipoSolicitud INT, -- Código de la solicitud a registrarse
    IN pnCodigoPeriodo INT, -- Código del periodo académico donde se realiza la solicitud
    IN pbSolicitudEsDeHimno BOOLEAN, -- Parámetro que determina si la solicitud es de himno nacional
    IN pdFechaSolicitudExamen DATE, -- Fecha de solicitud del examen del himno  	
    OUT pcMensajeError VARCHAR(1000) -- Parámetro para los mensajes de error
)
SP: BEGIN

	DECLARE vcTempMensajeError VARCHAR(1000); -- Variable para anteponer los posibles mensajes de error
    DECLARE vnCodigoEstadoSolicitudActiva INT DEFAULT 1; -- Código de estado de solicitud que define que la solicitud está activa
    DECLARE vnCodigoNuevoRegistroSolicitud INT; -- Variable para almacenar el código generado de solicitud
    
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
    
    -- Registrar la solicitud
    SET vcTempMensajeError := 'Error al registrar la solicitud ';
    
    INSERT INTO sa_solicitudes(fecha_solicitud, dni_estudiante, cod_periodo, cod_estado, cod_tipo_solicitud)
    VALUES (CURDATE(), pcIdentidadEstudiante, pnCodigoPeriodo, vnCodigoEstadoSolicitudActiva, pcTipoSolicitud);
    
    SET vnCodigoNuevoRegistroSolicitud := LAST_INSERT_ID();
    
    IF pbSolicitudEsDeHimno = 0 THEN

		-- Registrar la solicitud del examen
		SET vcTempMensajeError := 'Error al registrar el examen de himno';
		INSERT INTO sa_examenes_himno(cod_solicitud, nota_himno, fecha_examen_himno, fecha_solicitud)
		VALUES(vnCodigoNuevoRegistroSolicitud, CURDATE(), pdFechaSolicitudExamen, CURDATE());
    
    END IF;
    

    COMMIT;
    

END$$

CREATE  PROCEDURE `SP_REGISTRAR_TIPO_DE_ESTUDIANTE`(
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

CREATE  PROCEDURE `SP_REGISTRAR_TIPO_SOLICITUD`(
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

CREATE  PROCEDURE `SP_REPORTE_CARGA_ACADEMICA`(IN anio YEAR, IN periodo INT)
BEGIN

select ca_cursos.cod_carga, ca_cargas_academicas.cod_periodo,
persona.Primer_nombre , persona.Primer_apellido, clases.Clase, ca_secciones.codigo, ca_secciones.hora_inicio,
ca_secciones.hora_fin FROM ca_cargas_academicas inner JOIN ca_cursos on ca_cargas_academicas.codigo=
ca_cursos.cod_carga inner join clases on ca_cursos.cod_asignatura=clases.ID_Clases inner join ca_secciones on 
ca_cursos.cod_seccion=ca_secciones.codigo inner join empleado on ca_cursos.no_empleado=
empleado.No_empleado inner join persona on empleado.N_identidad= persona.N_identidad 
where ca_cargas_academicas.anio=anio and ca_cargas_academicas.cod_periodo=periodo order by ca_cargas_academicas.codigo;
END$$

CREATE  PROCEDURE `SP_REPORTE_PROYECTOS`(
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

CREATE  PROCEDURE `SP_REPROGRAMAR_SOLICITUD`(
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
CREATE  FUNCTION `sp_get_prioridad`(`numFolio_` VARCHAR(25)) RETURNS int(11)
BEGIN
   DECLARE pri INTEGER;
   SELECT Prioridad INTO pri FROM folios WHERE NroFolio = numFolio_;
   RETURN pri;
END$$

CREATE  FUNCTION `udf_Decrypt_derecho`(`var` VARBINARY(150)) RETURNS varchar(25) CHARSET latin1
BEGIN
   DECLARE ret varchar(25);
   SET ret = cast(AES_DECRYPT(unhex(var), 'Der3ch0') as char);
   RETURN ret;
END$$

CREATE  FUNCTION `udf_Encrypt_derecho`(`var` VARCHAR(25)) RETURNS varchar(150) CHARSET latin1
BEGIN  
   DECLARE ret BLOB;
   SET ret = hex(AES_ENCRYPT(var, 'Der3ch0'));
   RETURN ret;
END$$

CREATE PROCEDURE `PL_POA_MANTENIMIENTO_ELIMINAR_AREA`(IN `id_` INT(11), OUT `message_` VARCHAR(150), OUT `Tmessage_` TINYINT)
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
