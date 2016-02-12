-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 24-06-2015 a las 16:20:22
-- Versión del servidor: 5.6.21
-- Versión de PHP: 5.6.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `sistema_ciencias_juridicas`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_eliminar_actividad`(in id_Actividades int)
begin
delete from actividades where actividades.id_actividad=id_Actividades;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_eliminar_actividad_terminada`(in id_Actividades_Terminadas int)
begin
delete from actividades_terminadas where actividades_terminadas.id_Actividades_Terminadas=id_Actividades_Terminadas;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_eliminar_area`(in id_area int)
begin
delete from area where tipo_area.id_Area=id_area;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_eliminar_costo_porcentaje_actividad_por_trimestre`(in id int)
begin
delete from costo_porcentaje_actividad_por_trimestre where id_Costo_Porcentaje_Actividad_Por_Trimesrte=id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_eliminar_indicador`(in id_indicador int)
begin
delete from indicadores where indicadores.id_indicadores= id_indicador;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_eliminar_objetivo_institucional`(in id_objetivo int)
begin
delete from objetivos_institucionales where objetivos_institucionales.id_Objetivo= id_objetivo;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_eliminar_poa`(in id int)
begin
delete from poa where poa.id_Poa=id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_eliminar_responsables_por_actividad`(IN `id` INT)
begin
delete from responsables_por_actividad where responsables_por_actividad.id_Responsable_por_Actividad=id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_eliminar_sub_actividad`(in id_sub_Actividad int)
begin
delete from sub_actividad where sub_actividad.id_sub_Actividad=id_sub_Actividad;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_eliminar_sub_actividad_realizada`(IN `id_subActividadRealizada` INT)
begin
delete from sub_actividades_realizadas where sub_actividades_realizadas.id_subActividadRealizada=id_subActividadRealizada;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_eliminar_tipo_area`(in id_tipo_area int)
begin
delete from tipo_area where tipo_area.id_Tipo_Area=id_tipo_area;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_insertar_actividad`(IN `id_Indicador` INT, IN `descripcion` TEXT, IN `correlativo` VARCHAR(10), IN `supuestos` TEXT, IN `justificacion` TEXT, IN `medio_Verificacion` TEXT, IN `poblacion_Objetivo` VARCHAR(20), IN `fecha_Inicio` DATE, IN `fecha_Fin` DATE)
begin
insert into actividades (id_indicador, descripcion, correlativo, supuesto, justificacion, medio_verificacion, poblacion_objetivo,fecha_inicio, fecha_fin) values( id_Indicador, descripcion, correlativo, supuestos, justificacion, medio_Verificacion, poblacion_Objetivo,fecha_Inicio, fecha_Fin) ;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_insertar_actividades_terminadas`(IN `id_Actividad` INT, IN `fecha` DATE, IN `estado` VARCHAR(15), IN `id_Usuario` VARCHAR(20), IN `observaciones` TEXT)
begin 
	insert into actividades_terminadas (id_Actividad, fecha, estado, No_Empleado, observaciones) values (id_Actividad, fecha, estado, id_Usuario, observaciones);
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_insertar_area`(IN `nombre` VARCHAR(30), IN `id_tipo_Area` INT, IN `observacion` TEXT)
begin
	insert into area (nombre,id_tipo_area,observacion) values(nombre, id_tipo_Area,observacion);
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_insertar_costo_porcentaje_actividad_por_trimestre`(IN `id_Actividad` INT, IN `costo` INT, IN `porcentaje` INT, IN `observacion` TEXT, IN `trimestre` INT)
begin 
insert into costo_porcentaje_actividad_por_trimestre (id_Actividad, costo,porcentaje,observacion, trimestre)values(id_Actividad, costo,porcentaje,observacion, trimestre);
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_insertar_indicador`(IN `id_ObjetivosInstitucionales` INT, IN `nombre` VARCHAR(30), IN `descripcion` TEXT)
begin
	insert into indicadores (id_ObjetivosInsitucionales, nombre, descripcion) values (id_ObjetivosInstitucionales, nombre, descripcion);
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_insertar_objetivos_institucionales`(IN `definicion` TEXT, IN `area_Estrategica` TEXT, IN `resultados_Esperados` TEXT, IN `id_Area` INT, IN `id_Poa` INT)
begin 
	insert into objetivos_institucionales  (definicion,area_Estrategica,resultados_Esperados,id_Area,id_Poa) values (definicion,area_Estrategica,resultados_Esperados,id_Area,id_Poa);
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_insertar_poa`(IN `nombre` VARCHAR(30), IN `fecha_de_Inicio` DATE, IN `fecha_Fin` DATE, IN `descripcion` TEXT)
begin
insert into poa (nombre,fecha_de_Inicio,fecha_Fin,descripcion) values (nombre,fecha_de_Inicio,fecha_Fin, descripcion);
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_insertar_responsables_por_actividad`(IN `id_Actividad` INT, IN `id_Responsable` INT, IN `fecha_Asignacion` DATE, IN `observacion` TEXT)
begin
	insert into responsables_por_actividad (id_Actividad,id_Responsable,fecha_Asignacion,observacion) values (id_Actividad,id_Responsable,fecha_Asignacion,observacion);
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_insertar_sub_actividad`(IN `id_Actividad` INT, IN `nombre` VARCHAR(30), IN `descripcion` TEXT, IN `fecha_monitoreo` DATE, IN `id_Encargado` VARCHAR(20), IN `ponderacion` INT, IN `costo` INT, IN `observacion` TEXT)
begin
insert into sub_actividad (idActividad,nombre,descripcion,fecha_monitoreo,id_Encargado,ponderacion,costo,observacion) values(id_Actividad,nombre,descripcion,fecha_monitoreo,id_Encargado,ponderacion,costo,observacion);
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_insertar_sub_actividades_realizadas`(IN `id_SubActividad` INT, IN `fecha_Realizacion` DATE, IN `observacion` TEXT)
begin
	insert into sub_actividades_realizadas (id_SubActividad,fecha_Realizacion,observacion) values (id_SubActividad,fecha_Realizacion,observacion);
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_insertar_tipo_area`(IN `nombre` VARCHAR(30), IN `observaciones` TEXT)
begin
	insert into  tipo_area (nombre,observaciones) values(nombre,observaciones);
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_modificar_actividad`(IN `id_Actividad` INT, IN `id_Indicador` INT, IN `descripcion` TEXT, IN `correlativo` VARCHAR(10), IN `supuestos` TEXT, IN `justificacion` TEXT, IN `medio_Verificacion` TEXT, IN `poblacion_Objetivo` VARCHAR(20), IN `fecha_Inicio` DATE, IN `fecha_Fin` DATE)
begin
update actividades set id_indicador=id_Indicador, descripcion=descripcion, correlativo=correlativo, supuesto=supuesto, justificacion=justificacion, medio_verificacion=medio_Verificacion, poblacion_objetivo=poblacion_Objetivo,fecha_inicio=fecha_Inicio, fecha_fin=fecha_Fin 
where actividades.id_actividad= id_Actividad;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_modificar_actividades_terminadas`(IN `id_Actividad_Terminada` INT, IN `id_Actividad` INT, IN `fecha` DATE, IN `estado` VARCHAR(15), IN `id_Usuario` VARCHAR(20), IN `observaciones` TEXT)
begin 
	update actividades_terminadas set id_Actividad=id_Actividad, fecha=fecha, estado=estado, No_Empleado=id_Usuario, observaciones=observaciones where actividades_terminadas.id_Actividades_Terminadas= id_Actividad_Terminada; 
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_modificar_area`(IN id_Area int ,IN nombre VARCHAR(30), IN id_tipo_Area INT, IN observacion TEXT)
begin
	update area set nombre=nombre,id_tipo_Area=id_tipo_Area,observaciones=observacion where area.id_Area=id_Area;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_modificar_costo_porcentaje_actividad_por_trimestre`(IN id_Costo_Porcentaje_Actividad_Por_Trimesrte INT,IN id_Actividad INT, IN costo INT, IN porcentaje INT, IN observacion TEXT, IN trimestre INT)
begin 
update costo_porcentaje_actividad_por_trimestre set id_Actividad=id_ACtividad, costo=costo,porcentaje=porcentaje,observacion=observacion, trimestre=trimestre where costo_porcentaje_actividad_por_trimestre.id_Costo_Porcentaje_Actividad_Por_Trimesrte=id_Costo_Porcentaje_Actividad_Por_Trimesrte ;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_modificar_indicador`(IN `id_Indicador` INT, IN `id_ObjetivosInstitucionales` INT, IN `nombre` VARCHAR(30), IN `descripcion` TEXT)
begin
update indicadores set id_ObjetivosInsitucionales=id_ObjetivosInstitucionales, nombre=nombre, descripcion=descripcion where indicadores.id_Indicadores=id_Indicador;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_modificar_objetivos_institucionales`(IN id_Objetivo int,IN definicion TEXT, IN area_Estrategica TEXT, IN resultados_Esperados TEXT, IN id_Area INT, IN id_Poa INT)
begin 
update objetivos_institucionales set definicion=definicion,area_Estrategica=area_Estrategica,resultados_Esperados=resultados_Esperados,id_Area=id_Area,id_Poa=id_Poa where objetivos_institucionales.id_Objetivo= id_Objetivo ;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_modificar_poa`(in id_Poa int,IN nombre VARCHAR(30), IN fecha_de_Inicio DATE, IN fecha_Fin DATE, IN descripcion TEXT)
begin
update poa set nombre=nombre,fecha_de_Inicio=fecha_de_Inicio,fecha_Fin=fecha_Fin,descripcion=descripcion
where poa.id_Poa=id_Poa;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_modificar_responsables_por_actividad`(IN `id_Responsable_por_Act` INT, IN `id_Actividad` INT, IN `id_Responsable` INT, IN `fecha_Asignacion` DATE, IN `observacion` TEXT)
begin
update responsables_por_actividad set id_Actividad=id_Actividad,id_Responsable=id_Responsable,fecha_Asignacion=Fecha_Asignacion,observacion=observacion where responsables_por_actividad.id_Responsable_por_Actividad=id_Responsable_por_Act;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_modificar_sub_actividad`(IN `id_sub_Act` INT, IN `id_Actividad` INT, IN `nombre` VARCHAR(30), IN `descripcion` TEXT, IN `fecha_monitoreo` DATE, IN `id_Encargado` VARCHAR(20), IN `ponderacion` INT, IN `costo` INT, IN `observacion` TEXT)
begin
update sub_actividad set idActividad=id_Actividad,nombre=nombre,descripcion=descripcion,fecha_monitoreo=fecha_monitoreo,id_Encargado=id_Encargado,ponderacion=ponderacion,costo=costo,observacion=observacion
where sub_actividad.id_sub_Actividad=id_sub_Act;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_modificar_sub_actividades_realizadas`(in id_subActividadRealizada int,IN id_SubActividad INT, IN fecha_Realizacion DATE, IN observacion TEXT)
begin
update sub_actividades_realizadas set id_SubActividad=id_SubActividad,fecha_Realizacion=fecha_Realizacion,observacion=observacion 
where sub_actividades_Realizadas.id_subActividadRealizada=id_subActividadRealizada;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_modificar_tipo_area`(IN id_Tipo_Area int,IN nombre VARCHAR(30), IN observaciones TEXT)
begin
	 update tipo_area set nombre=nombre,observaciones=observaciones where tipo_area.id_Tipo_Area=id_Tipo_Area;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_asignado_folio`(
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_categorias_folios`(IN `Id_categoria_` INT(11), IN `NombreCategoria_` TEXT, IN `DescripcionCategoria_` TEXT, OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_estado_seguimiento`(IN `Id_Estado_Seguimiento_` TINYINT(4), IN `DescripcionEstadoSeguimiento_` TEXT, OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_folio`( 
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_organizacion`(IN `Id_Organizacion_` INT(11), IN `NombreOrganizacion_` TEXT, IN `Ubicacion_` TEXT, OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_prioridad`(IN `Id_Prioridad_` TINYINT(4), IN `DescripcionPrioridad_` TEXT, OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_seguimiento`(IN `numFolio_` VARCHAR(25), IN `fechaFin_` DATE, IN `prioridad_` TINYINT, IN `seguimiento_` TINYINT, IN `notas_` TEXT, OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_ubicacion_archivo_fisica`(IN `Id_UbicacionArchivoFisico_` INT(5), IN `DescripcionUbicacionFisica_` TEXT, IN `Capacidad_` INT(10), IN `TotalIngresados_` INT(10), IN `HabilitadoParaAlmacenar_` TINYINT(1), OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_ubicacion_notificaciones`(IN `Id_UbicacionNotificaciones_` TINYINT(4), IN `DescripcionUbicacionNotificaciones_` TEXT, OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_unidad_academica`(IN `Id_UnidadAcademica_` INT(11), IN `NombreUnidadAcademica_` TEXT, IN `UbicacionUnidadAcademica_` TEXT, OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_usuario`(IN `idUsuario` INT(11), IN `numEmpleado_` VARCHAR(13), IN `nombreAnt_` VARCHAR(30), IN `nombre_` VARCHAR(30), IN `Password_` VARCHAR(20), IN `rol_` INT(4), IN `fecha_` DATE, IN `estado_` BOOLEAN, OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_check_seguimiento`( 
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_eliminar_categorias_folios`(IN `sp_Id_categoria` INT, OUT `mensaje` VARCHAR(150), IN `codMensaje` TINYINT)
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_eliminar_estado_seguimiento`( 
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_eliminar_organizacion`( 
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_eliminar_prioridad`( 
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_eliminar_ubicacion_archivo_fisica`( 
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_eliminar_ubicacion_notificaciones`( 
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_eliminar_unidad_academica`( 
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_categorias_folios`(
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_estado_seguimiento`(
IN `Id_Estado_Seguimiento_` tinyint(4), 
IN `DescripcionEstadoSeguimiento_` text,
OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
BEGIN 
   START TRANSACTION;
   IF NOT EXISTS (SELECT 1 FROM estado_seguimiento WHERE Id_Estado_Seguimiento = Id_Estado_Seguimiento_) THEN 
     INSERT INTO  estado_seguimiento(Id_Estado_Seguimiento,DescripcionEstadoSeguimiento) 
     VALUES(Id_Estado_Seguimiento_,DescripcionEstadoSeguimiento_);			
     
     SET mensaje = "el estado de seguimiento ha sido insertado satisfactoriamente"; 
     SET codMensaje = 1;  
   ELSE
     SET mensaje = "existe un seguimiento igual, por favor revise el numero del seguimiento que desea ingresar";
     SET codMensaje = 0;
   END IF; 
      COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_folio`(IN `numFolio_` VARCHAR(25), IN `fechaCreacion_` DATE, IN `fechaEntrada_` TIMESTAMP, IN `personaReferente_` TEXT, IN `unidadAcademica_` INT, IN `organizacion_` INT, IN categoria_ INT, IN `descripcion_` TEXT, IN `tipoFolio_` TINYINT, IN `ubicacionFisica_` INT(5), IN `prioridad_` TINYINT, IN `seguimiento_` INT(11), IN `notas_` TEXT, IN encargado INT, OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_folio_2`(IN `numFolio_` VARCHAR(25), IN `fechaCreacion_` DATE, IN `fechaEntrada_` TIMESTAMP, IN `personaReferente_` TEXT, IN `unidadAcademica_` INT, IN `organizacion_` INT, IN categoria_ INT, IN `descripcion_` TEXT, IN `tipoFolio_` TINYINT, IN `ubicacionFisica_` INT(5), IN `prioridad_` TINYINT, IN `seguimiento_` INT(11), IN `notas_` TEXT, IN encargado INT, IN folioRef VARCHAR(25), OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_organizacion`(
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_prioridad`(
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_ubicacion_archivo_fisica`(
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_ubicacion_notificacion`(
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_unidad_academica`( 
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_usuario`(IN `numEmpleado_` VARCHAR(13), IN `nombre_` VARCHAR(30), IN `Password_` VARCHAR(25), IN `rol_` INT(4), IN `fechaCreacion_` DATE, OUT `mensaje` VARCHAR(150), OUT `codMensaje` TINYINT)
BEGIN 

   START TRANSACTION;

   IF NOT EXISTS (SELECT 1 FROM usuario WHERE nombre = nombre_) THEN 

     INSERT INTO usuario VALUES(NULL,numEmpleado_,nombre_,udf_Encrypt_derecho(Password_),rol_,fechaCreacion_,NULL,1);

     SET mensaje = "El usuario ha sido insertado satisfactoriamente."; 
     SET codMensaje = 1;  
   ELSE
     SET mensaje = "El usuario ya existe en sistema, por favor revise el nombre del usuario que desea ingresar";
     SET codMensaje = 0;
   END IF; 
   
   COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_lee_actividades_no_terminadas_poa`()
begin

select id_actividad,(select nombre from indicadores where indicadores.id_Indicadores=actividades.id_indicador) as indicador,descripcion,correlativo,supuesto,justificacion,medio_verificacion,poblacion_objetivo,fecha_inicio,fecha_fin from actividades where id_actividad not in (SELECT actividades_terminadas.id_Actividad FROM actividades_terminadas) and (select fecha_Fin from poa where poa.id_Poa in (select id_Poa from objetivos_institucionales where objetivos_institucionales.id_Objetivo in (select id_ObjetivosInsitucionales from indicadores where indicadores.id_Indicadores in (select id_indicador from actividades ))) and year(fecha_Fin) = year(now())) and (select fecha_de_Inicio from poa where poa.id_Poa in (select id_Poa from objetivos_institucionales where objetivos_institucionales.id_Objetivo in (select id_ObjetivosInsitucionales from indicadores where indicadores.id_Indicadores in (select id_indicador from actividades ))) and year(fecha_de_Inicio) = year(now())) and id_indicador in (select id_indicadores from indicadores where id_ObjetivosInsitucionales in (select id_Objetivo from objetivos_institucionales where id_Poa in(select id_Poa from poa where objetivos_institucionales.id_Poa =poa.id_Poa)));
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_lee_actividades_terminadas_poa`()
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_login`(IN `user_` VARCHAR(30), IN `pass` VARCHAR(25))
BEGIN
   SELECT id_Usuario,Id_Rol FROM usuario WHERE nombre = user_ AND pass = udf_Decrypt_derecho(Password) AND Estado = 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_log_user`(IN `usuario_` INT(11), IN `ip` VARCHAR(45))
begin
    insert into usuario_log values (null,usuario_,now(),ip);
end$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `sp_get_prioridad`(`numFolio_` VARCHAR(25)) RETURNS int(11)
BEGIN
   DECLARE pri INTEGER;
   SELECT Prioridad INTO pri FROM folios WHERE NroFolio = numFolio_;
   RETURN pri;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `udf_Decrypt_derecho`(`var` VARBINARY(150)) RETURNS varchar(25) CHARSET latin1
BEGIN
   DECLARE ret varchar(25);
   SET ret = cast(AES_DECRYPT(unhex(var), 'Der3ch0') as char);
   RETURN ret;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `udf_Encrypt_derecho`(`var` VARCHAR(25)) RETURNS varchar(150) CHARSET latin1
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

CREATE TABLE IF NOT EXISTS `actividades` (
`id_actividad` int(11) NOT NULL,
  `id_indicador` int(11) NOT NULL,
  `descripcion` text NOT NULL,
  `correlativo` varchar(20) NOT NULL,
  `supuesto` text NOT NULL,
  `justificacion` text NOT NULL,
  `medio_verificacion` text NOT NULL,
  `poblacion_objetivo` varchar(30) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `actividades`
--

INSERT INTO `actividades` (`id_actividad`, `id_indicador`, `descripcion`, `correlativo`, `supuesto`, `justificacion`, `medio_verificacion`, `poblacion_objetivo`, `fecha_inicio`, `fecha_fin`) VALUES
(1, 1, 'Actividad', '1', 's', 'j', 'm', 'p', '2015-04-01', '2015-06-01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actividades_terminadas`
--

CREATE TABLE IF NOT EXISTS `actividades_terminadas` (
`id_Actividades_Terminadas` int(11) NOT NULL,
  `id_Actividad` int(11) NOT NULL,
  `No_Empleado` varchar(20) NOT NULL,
  `fecha` date NOT NULL,
  `estado` varchar(15) NOT NULL,
  `observaciones` text
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `actividades_terminadas`
--

INSERT INTO `actividades_terminadas` (`id_Actividades_Terminadas`, `id_Actividad`, `No_Empleado`, `fecha`, `estado`, `observaciones`) VALUES
(1, 1, 'Elizabeth', '2015-05-05', 'REALIZADA', 'kkk');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alerta`
--

CREATE TABLE IF NOT EXISTS `alerta` (
`Id_Alerta` int(11) NOT NULL,
  `NroFolioGenera` varchar(25) NOT NULL,
  `FechaCreacion` datetime NOT NULL,
  `Atendido` tinyint(1) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `alerta`
--

INSERT INTO `alerta` (`Id_Alerta`, `NroFolioGenera`, `FechaCreacion`, `Atendido`) VALUES
(1, '207', '2015-05-14 20:32:06', 0),
(2, 'folio1', '2015-05-14 20:32:06', 0),
(3, '206', '2015-05-14 20:32:06', 0),
(4, '206', '2015-05-22 16:13:17', 0),
(5, '207', '2015-05-22 16:13:21', 0),
(6, 'folio1', '2015-05-22 16:13:21', 0),
(7, '206', '2015-05-22 20:32:06', 0),
(8, '207', '2015-05-22 20:32:07', 0),
(9, 'folio1', '2015-05-22 20:32:07', 0),
(10, '206', '2015-05-25 16:04:35', 0),
(11, '207', '2015-05-25 16:04:35', 0),
(12, 'folio1', '2015-05-25 16:04:37', 0),
(13, '206', '2015-05-25 20:32:06', 0),
(14, '207', '2015-05-25 20:32:06', 0),
(15, 'folio1', '2015-05-25 20:32:06', 0),
(16, '206', '2015-05-26 20:32:06', 0),
(17, '207', '2015-05-26 20:32:06', 0),
(18, 'folio1', '2015-05-26 20:32:06', 0),
(19, '206', '2015-05-27 20:32:06', 0),
(20, '207', '2015-05-27 20:32:06', 0),
(21, 'folio1', '2015-05-27 20:32:06', 0),
(22, '465465465', '2015-06-08 14:18:51', 0),
(23, '206', '2015-06-08 14:18:54', 0),
(24, '207', '2015-06-08 14:18:55', 0),
(25, 'folio1', '2015-06-08 14:18:55', 0),
(26, '465465465', '2015-06-08 20:32:06', 0),
(27, '206', '2015-06-08 20:32:06', 0),
(28, '207', '2015-06-08 20:32:06', 0),
(29, 'folio1', '2015-06-08 20:32:06', 0),
(30, '206', '2015-06-17 18:09:25', 0),
(31, '207', '2015-06-17 18:09:25', 0),
(32, '465465465', '2015-06-17 18:09:28', 0),
(33, 'folio1', '2015-06-17 18:09:28', 0),
(34, '206', '2015-06-17 20:32:06', 0),
(35, '207', '2015-06-17 20:32:06', 0),
(36, '465465465', '2015-06-17 20:32:06', 0),
(37, 'folio1', '2015-06-17 20:32:06', 0),
(38, '206', '2015-06-18 20:32:06', 0),
(39, '207', '2015-06-18 20:32:06', 0),
(40, '465465465', '2015-06-18 20:32:06', 0),
(41, 'folio1', '2015-06-18 20:32:06', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `area`
--

CREATE TABLE IF NOT EXISTS `area` (
`id_Area` int(11) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `id_tipo_area` int(11) NOT NULL,
  `observacion` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `area`
--

INSERT INTO `area` (`id_Area`, `nombre`, `id_tipo_area`, `observacion`) VALUES
(1, 'Area 1', 1, ''),
(2, 'coordinacion', 1, 'sfsdf');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cargo`
--

CREATE TABLE IF NOT EXISTS `cargo` (
`ID_cargo` int(11) NOT NULL,
  `Cargo` varchar(45) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `cargo`
--

INSERT INTO `cargo` (`ID_cargo`, `Cargo`) VALUES
(1, ' Asistente Soporte TÃ©cnico'),
(3, 'Asistente Administrativo'),
(4, 'Decano'),
(5, 'Administrador'),
(6, 'Secretaria Docente I'),
(7, 'ASISTENTE TECNICO DE GESTION ESTRATEGICA'),
(8, 'Secretaria Docente II');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias_folios`
--

CREATE TABLE IF NOT EXISTS `categorias_folios` (
`Id_categoria` int(11) NOT NULL,
  `NombreCategoria` text NOT NULL,
  `DescripcionCategoria` text
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `categorias_folios`
--

INSERT INTO `categorias_folios` (`Id_categoria`, `NombreCategoria`, `DescripcionCategoria`) VALUES
(1, 'categoria1', 'ejemplo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clases`
--

CREATE TABLE IF NOT EXISTS `clases` (
`ID_Clases` int(11) NOT NULL,
  `Clase` varchar(45) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `clases`
--

INSERT INTO `clases` (`ID_Clases`, `Clase`) VALUES
(1, 'Control de Calidad');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clases_has_experiencia_academica`
--

CREATE TABLE IF NOT EXISTS `clases_has_experiencia_academica` (
  `ID_Clases` int(11) NOT NULL,
  `ID_Experiencia_academica` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `clases_has_experiencia_academica`
--

INSERT INTO `clases_has_experiencia_academica` (`ID_Clases`, `ID_Experiencia_academica`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `costo_porcentaje_actividad_por_trimestre`
--

CREATE TABLE IF NOT EXISTS `costo_porcentaje_actividad_por_trimestre` (
`id_Costo_Porcentaje_Actividad_Por_Trimesrte` int(11) NOT NULL,
  `id_Actividad` int(11) NOT NULL,
  `costo` int(11) NOT NULL,
  `porcentaje` int(11) NOT NULL,
  `observacion` text,
  `trimestre` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `costo_porcentaje_actividad_por_trimestre`
--

INSERT INTO `costo_porcentaje_actividad_por_trimestre` (`id_Costo_Porcentaje_Actividad_Por_Trimesrte`, `id_Actividad`, `costo`, `porcentaje`, `observacion`, `trimestre`) VALUES
(1, 1, 5000, 50, 'obs', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamento_laboral`
--

CREATE TABLE IF NOT EXISTS `departamento_laboral` (
`Id_departamento_laboral` int(11) NOT NULL,
  `nombre_departamento` varchar(30) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `departamento_laboral`
--

INSERT INTO `departamento_laboral` (`Id_departamento_laboral`, `nombre_departamento`) VALUES
(1, 'DIR Y ADMON CIENCIAS JURIDICAS'),
(2, 'Soporte TÃ©cnico');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `edificios`
--

CREATE TABLE IF NOT EXISTS `edificios` (
`Edificio_ID` int(11) NOT NULL,
  `descripcion` text
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `edificios`
--

INSERT INTO `edificios` (`Edificio_ID`, `descripcion`) VALUES
(1, 'A2'),
(2, 'Edificio Administrativo'),
(3, 'C2'),
(4, 'F1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE IF NOT EXISTS `empleado` (
  `No_Empleado` varchar(20) NOT NULL,
  `N_identidad` varchar(20) NOT NULL,
  `Id_departamento` int(11) NOT NULL,
  `Fecha_ingreso` date NOT NULL,
  `fecha_salida` date DEFAULT NULL,
  `Observacion` text,
  `estado_empleado` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`No_Empleado`, `N_identidad`, `Id_departamento`, `Fecha_ingreso`, `fecha_salida`, `Observacion`, `estado_empleado`) VALUES
('0101', '0801-1991-06974', 1, '2015-04-27', NULL, 'Pendiente cÃ³digo de empleado', 1),
('1', '0001-0001-00001', 2, '2015-05-25', '2015-05-25', 'ej', 0),
('11022', '0709199000100', 1, '2014-03-10', NULL, '', 1),
('11910', '0801-1988-16746', 1, '2014-09-08', NULL, '', 1),
('1234', '0000-0000-00000', 1, '2015-03-06', '0000-00-00', 'prueba', 1),
('234', '1', 1, '2000-04-12', '2015-05-14', 'ninguna', 0),
('5548', '0801195903859', 1, '1981-04-21', NULL, 'me quiero jubilar', 1),
('6858', '0801-1965-00177', 1, '1989-01-01', NULL, 'Caliad y Mejora Continua', 1),
('7908', '0801-1969-02793', 1, '1991-02-01', NULL, '', 1),
('999', '0801-1985-18347', 1, '2015-05-04', NULL, '', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado_has_cargo`
--

CREATE TABLE IF NOT EXISTS `empleado_has_cargo` (
  `No_Empleado` varchar(20) NOT NULL,
  `ID_cargo` int(11) NOT NULL,
  `Fecha_ingreso_cargo` date NOT NULL,
  `Fecha_salida_cargo` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `empleado_has_cargo`
--

INSERT INTO `empleado_has_cargo` (`No_Empleado`, `ID_cargo`, `Fecha_ingreso_cargo`, `Fecha_salida_cargo`) VALUES
('0101', 1, '2015-04-27', NULL),
('1', 1, '2015-05-25', NULL),
('11022', 5, '2014-03-10', NULL),
('11910', 1, '2014-09-08', NULL),
('234', 4, '2000-04-12', NULL),
('5548', 3, '1981-04-21', NULL),
('6858', 4, '1989-01-01', NULL),
('7908', 3, '1991-02-01', NULL),
('999', 1, '2015-05-04', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_seguimiento`
--

CREATE TABLE IF NOT EXISTS `estado_seguimiento` (
`Id_Estado_Seguimiento` tinyint(4) NOT NULL,
  `DescripcionEstadoSeguimiento` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `estado_seguimiento`
--

INSERT INTO `estado_seguimiento` (`Id_Estado_Seguimiento`, `DescripcionEstadoSeguimiento`) VALUES
(1, 'en seguimiento'),
(2, 'Empezo con seguimiento'),
(3, 'En espera'),
(4, 'Sin seguimiento'),
(5, 'Seguimiento finalizado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudios_academico`
--

CREATE TABLE IF NOT EXISTS `estudios_academico` (
`ID_Estudios_academico` int(11) NOT NULL,
  `Nombre_titulo` varchar(45) NOT NULL,
  `ID_Tipo_estudio` int(11) NOT NULL,
  `N_identidad` varchar(20) NOT NULL,
  `Id_universidad` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `estudios_academico`
--

INSERT INTO `estudios_academico` (`ID_Estudios_academico`, `Nombre_titulo`, `ID_Tipo_estudio`, `N_identidad`, `Id_universidad`) VALUES
(3, 'InformÃ¡tica Administrativa', 1, '0801-1985-18347', 4),
(4, 'Pedagogia', 1, '0801-1969-02793', 4),
(5, 'Master en Actividad Fisica Entrenamiento y Ge', 2, '0709199000100', 8),
(6, 'Administracion Industrial y Negocios', 1, '0709199000100', 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `experiencia_academica`
--

CREATE TABLE IF NOT EXISTS `experiencia_academica` (
`ID_Experiencia_academica` int(11) NOT NULL,
  `Institucion` varchar(45) NOT NULL,
  `Tiempo` int(3) NOT NULL,
  `N_identidad` varchar(20) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `experiencia_academica`
--

INSERT INTO `experiencia_academica` (`ID_Experiencia_academica`, `Institucion`, `Tiempo`, `N_identidad`) VALUES
(1, 'UNAH', 7, '0709199000100');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `experiencia_laboral`
--

CREATE TABLE IF NOT EXISTS `experiencia_laboral` (
`ID_Experiencia_laboral` int(11) NOT NULL,
  `Nombre_empresa` varchar(45) NOT NULL,
  `Tiempo` int(3) NOT NULL,
  `N_identidad` varchar(20) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `experiencia_laboral`
--

INSERT INTO `experiencia_laboral` (`ID_Experiencia_laboral`, `Nombre_empresa`, `Tiempo`, `N_identidad`) VALUES
(1, 'Unah', 24, '0801-1969-02793');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `experiencia_laboral_has_cargo`
--

CREATE TABLE IF NOT EXISTS `experiencia_laboral_has_cargo` (
  `ID_Experiencia_laboral` int(11) NOT NULL,
  `ID_cargo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `experiencia_laboral_has_cargo`
--

INSERT INTO `experiencia_laboral_has_cargo` (`ID_Experiencia_laboral`, `ID_cargo`) VALUES
(1, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `folios`
--

CREATE TABLE IF NOT EXISTS `folios` (
  `NroFolio` varchar(25) NOT NULL,
  `NroFolioRespuesta` varchar(25) DEFAULT NULL,
  `FechaCreacion` date NOT NULL,
  `FechaEntrada` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `PersonaReferente` text NOT NULL,
  `UnidadAcademica` int(11) DEFAULT NULL,
  `Organizacion` int(11) DEFAULT NULL,
  `Categoria` int(11) NOT NULL,
  `DescripcionAsunto` text,
  `TipoFolio` tinyint(1) NOT NULL,
  `UbicacionFisica` int(5) NOT NULL,
  `Prioridad` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `folios`
--

INSERT INTO `folios` (`NroFolio`, `NroFolioRespuesta`, `FechaCreacion`, `FechaEntrada`, `PersonaReferente`, `UnidadAcademica`, `Organizacion`, `Categoria`, `DescripcionAsunto`, `TipoFolio`, `UbicacionFisica`, `Prioridad`) VALUES
('20', 'ppp2', '2015-05-04', '2015-05-07 19:08:50', 'ppp', 2, NULL, 1, 'ppp', 0, 3, 1),
('206', NULL, '2015-05-05', '2015-05-06 02:02:59', 'Fernando Vargas', 2, NULL, 1, 'Solicituda de vacaiones de Juan Perez', 1, 3, 3),
('207', NULL, '2015-05-05', '2015-05-14 20:32:06', 'Walter Levi Melendez', NULL, 1, 1, 'visto bueno para el nombramiento del procurador', 0, 3, 3),
('465465465', NULL, '2015-05-04', '2015-06-08 20:32:06', 'ejemplo', NULL, 1, 1, 'ej', 1, 2, 3),
('folio1', NULL, '2015-05-05', '2015-05-14 20:32:06', 'juan', 1, NULL, 1, 'ejemplo descripcion', 0, 2, 3),
('ppp2', NULL, '2015-05-06', '2015-05-08 02:36:23', 'ppp', 1, NULL, 1, 'pppoo', 1, 2, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grupo_o_comite`
--

CREATE TABLE IF NOT EXISTS `grupo_o_comite` (
`ID_Grupo_o_comite` int(11) NOT NULL,
  `Nombre_Grupo_o_comite` varchar(45) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `grupo_o_comite`
--

INSERT INTO `grupo_o_comite` (`ID_Grupo_o_comite`, `Nombre_Grupo_o_comite`) VALUES
(1, 'tecnologia');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grupo_o_comite_has_empleado`
--

CREATE TABLE IF NOT EXISTS `grupo_o_comite_has_empleado` (
  `ID_Grupo_o_comite` int(11) NOT NULL,
  `No_Empleado` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `grupo_o_comite_has_empleado`
--

INSERT INTO `grupo_o_comite_has_empleado` (`ID_Grupo_o_comite`, `No_Empleado`) VALUES
(1, '0101');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `idioma`
--

CREATE TABLE IF NOT EXISTS `idioma` (
`ID_Idioma` int(11) NOT NULL,
  `Idioma` varchar(45) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `idioma`
--

INSERT INTO `idioma` (`ID_Idioma`, `Idioma`) VALUES
(2, 'Ingles'),
(3, 'Aleman'),
(4, 'Portugues'),
(5, 'Italiano'),
(6, 'Frances');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `idioma_has_persona`
--

CREATE TABLE IF NOT EXISTS `idioma_has_persona` (
  `ID_Idioma` int(11) NOT NULL,
  `N_identidad` varchar(20) NOT NULL,
  `Nivel` varchar(45) DEFAULT NULL,
`Id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `idioma_has_persona`
--

INSERT INTO `idioma_has_persona` (`ID_Idioma`, `N_identidad`, `Nivel`, `Id`) VALUES
(2, '0801-1985-18347', '70', 3),
(2, '0801-1969-02793', '30', 4),
(2, '0709199000100', '80', 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `indicadores`
--

CREATE TABLE IF NOT EXISTS `indicadores` (
`id_Indicadores` int(11) NOT NULL,
  `id_ObjetivosInsitucionales` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `descripcion` text
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `indicadores`
--

INSERT INTO `indicadores` (`id_Indicadores`, `id_ObjetivosInsitucionales`, `nombre`, `descripcion`) VALUES
(1, 1, 'Indicador 1', 'Ninguna');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `motivos`
--

CREATE TABLE IF NOT EXISTS `motivos` (
`Motivo_ID` int(11) NOT NULL,
  `descripcion` text
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `motivos`
--

INSERT INTO `motivos` (`Motivo_ID`, `descripcion`) VALUES
(1, 'Salud'),
(2, 'Problema Familiar'),
(3, 'Estudio');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificaciones_folios`
--

CREATE TABLE IF NOT EXISTS `notificaciones_folios` (
`Id_Notificacion` int(11) NOT NULL,
  `NroFolio` varchar(25) NOT NULL,
  `IdEmisor` int(15) NOT NULL,
  `Titulo` text NOT NULL,
  `Cuerpo` text NOT NULL,
  `FechaCreacion` datetime NOT NULL,
  `IdUbicacionNotificacion` int(11) NOT NULL,
  `Estado` tinyint(4) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `notificaciones_folios`
--

INSERT INTO `notificaciones_folios` (`Id_Notificacion`, `NroFolio`, `IdEmisor`, `Titulo`, `Cuerpo`, `FechaCreacion`, `IdUbicacionNotificacion`, `Estado`) VALUES
(1, '206', 8, 'Vacaciones de Juan Perez', 'estimada Deacana, le noifico que el folio 206 ya recibio respuesta y necesita su aprobación de inmediato, porfavor atender.', '2015-05-05 20:04:59', 2, 1),
(2, '207', 9, 'Nombramiento procurador', 'Remira nombre de asignación', '2015-05-05 20:49:28', 2, 1),
(3, '20', 1, 'ttt', 'mmm', '2015-05-07 21:00:26', 2, 1),
(4, '20', 13, 'urgente', 'Corregior', '2015-05-25 21:42:30', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `objetivos_institucionales`
--

CREATE TABLE IF NOT EXISTS `objetivos_institucionales` (
`id_Objetivo` int(11) NOT NULL,
  `definicion` text NOT NULL,
  `area_Estrategica` text NOT NULL,
  `resultados_Esperados` text NOT NULL,
  `id_Area` int(11) NOT NULL,
  `id_Poa` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `objetivos_institucionales`
--

INSERT INTO `objetivos_institucionales` (`id_Objetivo`, `definicion`, `area_Estrategica`, `resultados_Esperados`, `id_Area`, `id_Poa`) VALUES
(1, 'Objetivo 1', 'Area Estrategica 1', 'Resultado', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `organizacion`
--

CREATE TABLE IF NOT EXISTS `organizacion` (
`Id_Organizacion` int(11) NOT NULL,
  `NombreOrganizacion` text NOT NULL,
  `Ubicacion` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `organizacion`
--

INSERT INTO `organizacion` (`Id_Organizacion`, `NombreOrganizacion`, `Ubicacion`) VALUES
(1, 'CIPRODEH', 'Tegucigalpa');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pais`
--

CREATE TABLE IF NOT EXISTS `pais` (
`Id_pais` int(11) NOT NULL,
  `Nombre_pais` varchar(20) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `pais`
--

INSERT INTO `pais` (`Id_pais`, `Nombre_pais`) VALUES
(1, 'Honduras'),
(2, 'Mexico'),
(3, 'Estados Unidos'),
(4, 'Costa Rica'),
(5, 'El Salvador'),
(6, 'Nicaragua'),
(7, 'Panama'),
(8, 'Guatemala'),
(9, 'EspaÃ±a');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permisos`
--

CREATE TABLE IF NOT EXISTS `permisos` (
`id_Permisos` int(11) NOT NULL,
  `id_departamento` int(11) NOT NULL,
  `No_Empleado` varchar(20) NOT NULL,
  `id_motivo` int(11) NOT NULL,
  `dias_permiso` int(11) NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_finalizacion` time NOT NULL,
  `fecha` datetime NOT NULL,
  `fecha_solicitud` date NOT NULL,
  `estado` varchar(15) DEFAULT NULL,
  `observacion` varchar(200) DEFAULT NULL,
  `revisado_por` varchar(15) DEFAULT NULL,
  `id_Edificio_Registro` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `permisos`
--

INSERT INTO `permisos` (`id_Permisos`, `id_departamento`, `No_Empleado`, `id_motivo`, `dias_permiso`, `hora_inicio`, `hora_finalizacion`, `fecha`, `fecha_solicitud`, `estado`, `observacion`, `revisado_por`, `id_Edificio_Registro`, `id_usuario`) VALUES
(2, 1, '11910', 1, 1, '07:00:00', '14:00:00', '2015-05-06 00:00:00', '2015-05-05', 'Finalizado', NULL, '11910', 1, 3),
(3, 1, '0101', 1, 2, '00:15:00', '17:00:00', '2015-05-06 00:00:00', '2015-05-05', 'Denegado', 'Es falsa su justificaciÃ³n', '11910', 1, 2),
(4, 1, '0101', 1, 3, '14:00:00', '17:00:00', '2015-05-06 00:00:00', '2015-05-05', 'Denegado', 'negativo', '6858', 1, 2),
(5, 1, '234', 1, 0, '13:15:00', '14:15:00', '2015-05-01 00:00:00', '2015-05-07', 'Finalizado', NULL, '1234', 1, 6),
(6, 1, '999', 1, 1, '14:15:00', '14:15:00', '2015-05-01 00:00:00', '2015-05-07', 'Finalizado', NULL, '1234', 1, 11),
(7, 1, '1234', 1, 0, '14:15:00', '21:15:00', '2015-05-22 00:00:00', '2015-05-07', 'Espera', NULL, NULL, 1, 11),
(8, 1, '1234', 1, 2, '05:30:00', '22:00:00', '2015-05-25 00:00:00', '2015-05-22', 'Espera', NULL, NULL, 1, 1),
(12, 1, '1234', 1, 2, '08:00:00', '14:00:00', '2015-05-29 00:00:00', '2015-05-25', 'Espera', NULL, NULL, 1, 1),
(13, 1, '6858', 1, 2, '10:00:00', '16:00:00', '2015-05-29 00:00:00', '2015-05-25', 'Espera', NULL, NULL, 1, 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE IF NOT EXISTS `persona` (
  `N_identidad` varchar(20) NOT NULL,
  `Primer_nombre` varchar(20) NOT NULL,
  `Segundo_nombre` varchar(20) DEFAULT NULL,
  `Primer_apellido` varchar(45) NOT NULL,
  `Segundo_apellido` varchar(20) DEFAULT NULL,
  `Fecha_nacimiento` date NOT NULL,
  `Sexo` varchar(1) DEFAULT NULL,
  `Direccion` varchar(300) NOT NULL,
  `Correo_electronico` varchar(40) DEFAULT NULL,
  `Estado_Civil` varchar(15) DEFAULT NULL,
  `Nacionalidad` varchar(20) NOT NULL,
  `foto_perfil` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`N_identidad`, `Primer_nombre`, `Segundo_nombre`, `Primer_apellido`, `Segundo_apellido`, `Fecha_nacimiento`, `Sexo`, `Direccion`, `Correo_electronico`, `Estado_Civil`, `Nacionalidad`, `foto_perfil`) VALUES
('0000-0000-00000', 'prueba', 'Prueba', 'Prueba', 'Prueba', '2015-03-29', 'F', 'prueba', 'prueba@prueba.com', 'soltero', 'prueba', ''),
('0001-0001-00001', 'EJ', 'EJ', 'EJ', 'EJ', '1986-01-16', 'F', 'EJ', 'ej@hotmail.com', 'Soltero', 'EJ', ''),
('020196300018', 'Santos', 'Liduvina', 'Maldonado', 'Puerto', '1985-01-01', 'M', 'Col Prueba', 'muestra@yahoo.com', 'soltero', 'HondureÃ±a', ''),
('0709199000100', 'Carlos', 'Luis', 'Burgos', 'Ochoa', '1990-07-07', 'M', 'Lomas de Jacaleapa, calle principal.', 'carlosl_beck@hotmail.com', 'Soltero', 'HondureÃ±o', ''),
('0801-1965-00177', 'Bessy', 'Margoth', 'Nazar', 'Herrera', '1965-01-05', 'F', 'Lomas de Santa LucÃ­a', 'bmnazarh@hotmail.com', 'Casado', 'HondureÃ±a', ''),
('0801-1969-02793', 'Jhonny', 'Alexis', 'MembreÃ±o', 'Vallecillo', '1969-06-02', 'M', 'Col. Venezuela, sector b.', 'jhonnymembreo@yahoo.es', 'Soltero', 'HondureÃ±a', ''),
('0801-1985-18347', 'Jorge', 'Luis', 'Aguiilar', 'Flores', '1985-09-15', 'M', 'Col. Villa Olimpica, Sector 3, Bloque 3, casa 5306', 'jorge_aguilar@unah.hn', 'soltero', 'HondureÃ±a', ''),
('0801-1988-16746', 'Evelin', 'Rocio', 'Canaca', 'Arriola', '1988-09-06', 'F', 'Colonia Altos de la Independencia', 'ecanaca@unah.edu.hn', 'Soltero', 'HondureÃ±a', ''),
('0801-1991-06974', 'Elizabeth', 'Francis', 'Tercero', 'Calix', '1991-03-31', 'M', 'Col Nueva Suyapa', 'elitercero@yahoo.es', 'soltero', 'HondureÃ±a', ''),
('0801195903859', 'Gloria', 'Isabel', 'Oseguera', 'Lopez', '1959-09-21', 'F', 'col. la esperanza', 'gloriaoseguera@yahoo.com', 'Casado', 'HondureÃ±a', ''),
('0801198600005', 'jorge', 'luis', 'aguilar', 'flores', '1986-09-16', 'F', 'col', 'guij@yahoo.com', 'Soltero', 'hondureÃ±a', ''),
('1', 'decana', 't', 'muestra', 'r', '1985-04-02', 'M', 'Col. Villanueva', 'muestra@yahoo.com', 'casado', 'HondureÃ±a', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `poa`
--

CREATE TABLE IF NOT EXISTS `poa` (
`id_Poa` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `fecha_de_Inicio` date NOT NULL,
  `fecha_Fin` date NOT NULL,
  `descripcion` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `poa`
--

INSERT INTO `poa` (`id_Poa`, `nombre`, `fecha_de_Inicio`, `fecha_Fin`, `descripcion`) VALUES
(1, 'POA 2015', '2015-01-01', '2015-12-31', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prioridad`
--

CREATE TABLE IF NOT EXISTS `prioridad` (
  `Id_Prioridad` tinyint(4) NOT NULL,
  `DescripcionPrioridad` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `prioridad`
--

INSERT INTO `prioridad` (`Id_Prioridad`, `DescripcionPrioridad`) VALUES
(1, 'Informativo'),
(2, 'Normal'),
(3, 'Urgente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prioridad_folio`
--

CREATE TABLE IF NOT EXISTS `prioridad_folio` (
`Id_PrioridadFolio` int(11) NOT NULL,
  `IdFolio` varchar(25) NOT NULL,
  `Id_Prioridad` tinyint(4) NOT NULL,
  `FechaEstablecida` date NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `prioridad_folio`
--

INSERT INTO `prioridad_folio` (`Id_PrioridadFolio`, `IdFolio`, `Id_Prioridad`, `FechaEstablecida`) VALUES
(1, 'folio1', 2, '2015-05-05'),
(2, '206', 3, '2015-05-05'),
(3, '207', 2, '2015-05-05'),
(4, '20', 1, '2015-05-07'),
(5, 'ppp2', 2, '2015-05-07'),
(6, '207', 2, '2015-05-14'),
(7, 'folio1', 2, '2015-05-14'),
(8, '465465465', 1, '2015-05-25'),
(9, '465465465', 1, '2015-06-08'),
(10, '465465465', 2, '2015-06-08');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `responsables_por_actividad`
--

CREATE TABLE IF NOT EXISTS `responsables_por_actividad` (
`id_Responsable_por_Actividad` int(11) NOT NULL,
  `id_Actividad` int(11) NOT NULL,
  `id_Responsable` int(11) NOT NULL,
  `fecha_Asignacion` date NOT NULL,
  `observacion` text
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `responsables_por_actividad`
--

INSERT INTO `responsables_por_actividad` (`id_Responsable_por_Actividad`, `id_Actividad`, `id_Responsable`, `fecha_Asignacion`, `observacion`) VALUES
(1, 1, 1, '2015-05-05', 'obs');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE IF NOT EXISTS `roles` (
  `Id_Rol` tinyint(4) NOT NULL,
  `Descripcion` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`Id_Rol`, `Descripcion`) VALUES
(10, 'Usuario Basico'),
(20, 'Docente'),
(29, 'Asistente Jefatura'),
(30, 'Jefe Departamento'),
(40, 'Secretaria General'),
(45, 'Secretaria Decana'),
(50, 'Decano'),
(100, 'root');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seguimiento`
--

CREATE TABLE IF NOT EXISTS `seguimiento` (
`Id_Seguimiento` int(11) NOT NULL,
  `NroFolio` varchar(25) NOT NULL,
  `UsuarioAsignado` int(11) DEFAULT NULL,
  `Notas` text NOT NULL,
  `Prioridad` tinyint(4) NOT NULL,
  `FechaInicio` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `FechaFinal` date DEFAULT NULL,
  `EstadoSeguimiento` tinyint(4) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `seguimiento`
--

INSERT INTO `seguimiento` (`Id_Seguimiento`, `NroFolio`, `UsuarioAsignado`, `Notas`, `Prioridad`, `FechaInicio`, `FechaFinal`, `EstadoSeguimiento`) VALUES
(1, 'folio1', 5, 'prueba seguimiento', 2, '2015-05-06 01:27:55', NULL, 2),
(2, '206', 8, 'Este folio se lo envié a Fernando Vargas el 6 de mayo de 2015 y todavia no hay respuesta', 3, '2015-05-06 02:02:59', NULL, 1),
(3, '207', 8, 'descripcion seguimeitno', 2, '2015-05-06 02:48:41', NULL, 1),
(4, '20', 8, 'ppopo', 1, '2015-05-07 19:05:24', '2015-05-07', 5),
(5, 'ppp2', 6, 'fff', 2, '2015-05-07 18:38:04', '2015-05-07', 5),
(6, '465465465', 13, 'ej', 1, '2015-05-26 03:38:02', NULL, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seguimiento_historico`
--

CREATE TABLE IF NOT EXISTS `seguimiento_historico` (
`Id_SeguimientoHistorico` int(11) NOT NULL,
  `Id_Seguimiento` int(11) NOT NULL,
  `Id_Estado_Seguimiento` tinyint(4) NOT NULL,
  `Notas` text NOT NULL,
  `Prioridad` tinyint(4) NOT NULL,
  `FechaCambio` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `seguimiento_historico`
--

INSERT INTO `seguimiento_historico` (`Id_SeguimientoHistorico`, `Id_Seguimiento`, `Id_Estado_Seguimiento`, `Notas`, `Prioridad`, `FechaCambio`) VALUES
(1, 1, 2, 'prueba seguimiento', 2, '2015-05-05 11:27:56'),
(2, 2, 1, 'Este folio se lo envié a Fernando Vargas el 6 de mayo de 2015 y todavia no hay respuesta', 3, '2015-05-05 12:02:59'),
(3, 3, 1, 'descripcion seguimeitno', 2, '2015-05-05 12:48:41'),
(4, 4, 2, 'ppp', 1, '2015-05-07 12:34:12'),
(5, 4, 3, 'pp1', 1, '2015-05-07 12:35:12'),
(6, 5, 4, 'oooo', 2, '2015-05-07 12:36:23'),
(7, 5, 5, 'fff', 2, '2015-05-07 12:38:04'),
(8, 4, 5, 'ppopo', 1, '2015-05-07 13:05:24'),
(9, 6, 5, 'ej', 1, '2015-05-25 13:38:02');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sub_actividad`
--

CREATE TABLE IF NOT EXISTS `sub_actividad` (
`id_sub_Actividad` int(11) NOT NULL,
  `idActividad` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `descripcion` text NOT NULL,
  `fecha_monitoreo` date NOT NULL,
  `id_Encargado` varchar(20) NOT NULL,
  `ponderacion` int(11) NOT NULL,
  `costo` int(11) NOT NULL,
  `observacion` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `sub_actividad`
--

INSERT INTO `sub_actividad` (`id_sub_Actividad`, `idActividad`, `nombre`, `descripcion`, `fecha_monitoreo`, `id_Encargado`, `ponderacion`, `costo`, `observacion`) VALUES
(1, 1, 'Sub 1', 'des', '2015-04-21', '0101', 120, 200, 'obs'),
(2, 1, 'sub 2', 'des', '2015-05-20', '0101', 50, 350, 'o');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sub_actividades_realizadas`
--

CREATE TABLE IF NOT EXISTS `sub_actividades_realizadas` (
`id_subActividadRealizada` int(11) NOT NULL,
  `id_SubActividad` int(11) NOT NULL,
  `fecha_Realizacion` date NOT NULL,
  `observacion` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `sub_actividades_realizadas`
--

INSERT INTO `sub_actividades_realizadas` (`id_subActividadRealizada`, `id_SubActividad`, `fecha_Realizacion`, `observacion`) VALUES
(1, 1, '2015-05-05', 'observacion'),
(2, 2, '2015-05-05', 'hhh');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `telefono`
--

CREATE TABLE IF NOT EXISTS `telefono` (
`ID_Telefono` int(11) NOT NULL,
  `Tipo` varchar(45) NOT NULL,
  `Numero` varchar(20) NOT NULL,
  `N_identidad` varchar(20) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `telefono`
--

INSERT INTO `telefono` (`ID_Telefono`, `Tipo`, `Numero`, `N_identidad`) VALUES
(1, 'celular', '3295-0542', '0801-1985-18347'),
(2, 'fijo', '2235-7045', '0801-1985-18347'),
(3, 'celular', '3219-7293', '0801-1969-02793'),
(4, 'celular', '99062671', '0709199000100');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_area`
--

CREATE TABLE IF NOT EXISTS `tipo_area` (
`id_Tipo_Area` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `observaciones` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipo_area`
--

INSERT INTO `tipo_area` (`id_Tipo_Area`, `nombre`, `observaciones`) VALUES
(1, 'Docencia', 'ninguna'),
(2, 'prueba', 'ninguna');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_estudio`
--

CREATE TABLE IF NOT EXISTS `tipo_estudio` (
`ID_Tipo_estudio` int(11) NOT NULL,
  `Tipo_estudio` varchar(45) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipo_estudio`
--

INSERT INTO `tipo_estudio` (`ID_Tipo_estudio`, `Tipo_estudio`) VALUES
(1, 'licenciatura'),
(2, 'Maestria'),
(3, 'Doctorado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `titulo`
--

CREATE TABLE IF NOT EXISTS `titulo` (
`id_titulo` int(11) NOT NULL,
  `titulo` varchar(50) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `titulo`
--

INSERT INTO `titulo` (`id_titulo`, `titulo`) VALUES
(1, 'InformÃ¡tica Administrativa'),
(2, 'Pedagogia'),
(3, 'Master en Actividad Fisica Entrenamiento y Gestion'),
(4, 'Administracion Industrial y Negocios');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ubicacion_archivofisico`
--

CREATE TABLE IF NOT EXISTS `ubicacion_archivofisico` (
`Id_UbicacionArchivoFisico` int(5) NOT NULL,
  `DescripcionUbicacionFisica` text NOT NULL,
  `Capacidad` int(10) NOT NULL,
  `TotalIngresados` int(10) NOT NULL DEFAULT '0',
  `HabilitadoParaAlmacenar` tinyint(1) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `ubicacion_archivofisico`
--

INSERT INTO `ubicacion_archivofisico` (`Id_UbicacionArchivoFisico`, `DescripcionUbicacionFisica`, `Capacidad`, `TotalIngresados`, `HabilitadoParaAlmacenar`) VALUES
(2, 'ubi', 100, 1, 1),
(3, 'Archivo 1', 500, 0, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ubicacion_notificaciones`
--

CREATE TABLE IF NOT EXISTS `ubicacion_notificaciones` (
`Id_UbicacionNotificaciones` tinyint(4) NOT NULL,
  `DescripcionUbicacionNotificaciones` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `ubicacion_notificaciones`
--

INSERT INTO `ubicacion_notificaciones` (`Id_UbicacionNotificaciones`, `DescripcionUbicacionNotificaciones`) VALUES
(1, 'Basurero'),
(2, 'Enviadas'),
(3, 'Recibidas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `unidad_academica`
--

CREATE TABLE IF NOT EXISTS `unidad_academica` (
`Id_UnidadAcademica` int(11) NOT NULL,
  `NombreUnidadAcademica` text NOT NULL,
  `UbicacionUnidadAcademica` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `unidad_academica`
--

INSERT INTO `unidad_academica` (`Id_UnidadAcademica`, `NombreUnidadAcademica`, `UbicacionUnidadAcademica`) VALUES
(1, 'unidad1', 'ejemplo'),
(2, 'Vicerrectoria Academica', 'CU UNAH');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `universidad`
--

CREATE TABLE IF NOT EXISTS `universidad` (
`Id_universidad` int(11) NOT NULL,
  `nombre_universidad` varchar(50) NOT NULL,
  `Id_pais` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `universidad`
--

INSERT INTO `universidad` (`Id_universidad`, `nombre_universidad`, `Id_pais`) VALUES
(4, 'UNAH', 1),
(5, 'UNITEC', 1),
(6, 'Universidad Catolica', 1),
(7, 'Jose Cecilio del Valle', 1),
(8, 'Miguel de Cervantes', 9);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE IF NOT EXISTS `usuario` (
`id_Usuario` int(11) NOT NULL,
  `No_Empleado` varchar(13) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `Password` varbinary(250) NOT NULL,
  `Id_Rol` tinyint(4) NOT NULL,
  `Fecha_Creacion` date NOT NULL,
  `Fecha_Alta` date DEFAULT NULL,
  `Estado` tinyint(1) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_Usuario`, `No_Empleado`, `nombre`, `Password`, `Id_Rol`, `Fecha_Creacion`, `Fecha_Alta`, `Estado`) VALUES
(1, '1234', 'prueba', 0x3831444637443233344633423846353438374146353038433243373942303041, 100, '2015-03-11', NULL, 1),
(2, '0101', 'Elizabeth', 0x3938434430463341433330434338463533333338364546344135463244413339, 100, '2015-05-05', NULL, 1),
(3, '11910', 'ecanaca', 0x3039414430453646453845363742443434443145393537454633364436413836, 100, '2015-05-05', NULL, 1),
(4, '999', 'Jaguilar', 0x34393036443039314539344631394336324334333543344544464330364338314441303136383638413034343430344133313934393830313243443944384635, 100, '2015-05-05', NULL, 1),
(5, '7908', 'jhonnym', 0x4334343432303341463343313144324633424638343431374636334344333342, 40, '2015-05-05', NULL, 1),
(6, '6858', 'decana', 0x4444433946423744384330314344333439373233384345444445353645303731, 50, '2015-05-05', NULL, 1),
(7, '11910', 'ecanacajefe', 0x3039414430453646453845363742443434443145393537454633364436413836, 30, '2015-05-05', NULL, 1),
(8, '5548', 'gloriaoseguera', 0x4132384435313038333533334337383043463131433243323534313137423946, 45, '2015-05-05', NULL, 1),
(9, '6858', 'bmnazarh', 0x4644364130463932443535364438393845464236333630394437364434353541, 50, '2015-05-05', NULL, 1),
(10, '11022', 'Burgos23', 0x3642453835384534373838333646353238444544423731354142373732463638, 40, '2015-05-05', NULL, 1),
(11, '1234', 'arlea', 0x4334343432303341463343313144324633424638343431374636334344333342, 29, '2015-05-07', NULL, 1),
(12, '1234', 'jdepa', 0x3039414430453646453845363742443434443145393537454633364436413836, 30, '2015-05-07', NULL, 1),
(13, '1', 'ejemplo', 0x4530304446323132364535414534433341423637393939353536383030434246, 40, '2015-05-25', NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_alertado`
--

CREATE TABLE IF NOT EXISTS `usuario_alertado` (
`Id_UsuarioAlertado` int(11) NOT NULL,
  `Id_Alerta` int(11) NOT NULL,
  `Id_Usuario` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=229 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuario_alertado`
--

INSERT INTO `usuario_alertado` (`Id_UsuarioAlertado`, `Id_Alerta`, `Id_Usuario`) VALUES
(1, 3, 1),
(2, 3, 2),
(3, 3, 3),
(4, 3, 4),
(5, 3, 6),
(6, 3, 9),
(7, 4, 1),
(8, 4, 2),
(9, 4, 3),
(10, 4, 4),
(11, 4, 6),
(12, 4, 9),
(13, 5, 1),
(14, 5, 2),
(15, 5, 3),
(16, 5, 4),
(17, 5, 6),
(18, 5, 9),
(19, 6, 1),
(20, 6, 2),
(21, 6, 3),
(22, 6, 4),
(23, 6, 6),
(24, 6, 9),
(25, 7, 1),
(26, 7, 2),
(27, 7, 3),
(28, 7, 4),
(29, 7, 6),
(30, 7, 9),
(31, 8, 1),
(32, 8, 2),
(33, 8, 3),
(34, 8, 4),
(35, 8, 6),
(36, 8, 9),
(37, 9, 1),
(38, 9, 2),
(39, 9, 3),
(40, 9, 4),
(41, 9, 6),
(42, 9, 9),
(43, 10, 1),
(44, 10, 2),
(45, 10, 3),
(46, 10, 4),
(47, 10, 6),
(48, 10, 9),
(49, 11, 1),
(50, 11, 2),
(51, 11, 3),
(52, 11, 4),
(53, 11, 6),
(54, 11, 9),
(55, 12, 1),
(56, 12, 2),
(57, 12, 3),
(58, 12, 4),
(59, 12, 6),
(60, 12, 9),
(61, 13, 1),
(62, 13, 2),
(63, 13, 3),
(64, 13, 4),
(65, 13, 6),
(66, 13, 9),
(67, 14, 1),
(68, 14, 2),
(69, 14, 3),
(70, 14, 4),
(71, 14, 6),
(72, 14, 9),
(73, 15, 1),
(74, 15, 2),
(75, 15, 3),
(76, 15, 4),
(77, 15, 6),
(78, 15, 9),
(79, 16, 1),
(80, 16, 2),
(81, 16, 3),
(82, 16, 4),
(83, 16, 6),
(84, 16, 9),
(85, 17, 1),
(86, 17, 2),
(87, 17, 3),
(88, 17, 4),
(89, 17, 6),
(90, 17, 9),
(91, 18, 1),
(92, 18, 2),
(93, 18, 3),
(94, 18, 4),
(95, 18, 6),
(96, 18, 9),
(97, 19, 1),
(98, 19, 2),
(99, 19, 3),
(100, 19, 4),
(101, 19, 6),
(102, 19, 9),
(103, 20, 1),
(104, 20, 2),
(105, 20, 3),
(106, 20, 4),
(107, 20, 6),
(108, 20, 9),
(109, 21, 1),
(110, 21, 2),
(111, 21, 3),
(112, 21, 4),
(113, 21, 6),
(114, 21, 9),
(115, 22, 5),
(116, 22, 6),
(117, 22, 8),
(118, 22, 9),
(119, 22, 10),
(120, 22, 13),
(121, 23, 1),
(122, 23, 2),
(123, 23, 3),
(124, 23, 4),
(125, 23, 6),
(126, 23, 9),
(127, 24, 1),
(128, 24, 2),
(129, 24, 3),
(130, 24, 4),
(131, 24, 6),
(132, 24, 9),
(133, 25, 1),
(134, 25, 2),
(135, 25, 3),
(136, 25, 4),
(137, 25, 6),
(138, 25, 9),
(139, 27, 1),
(140, 27, 2),
(141, 27, 3),
(142, 27, 4),
(143, 27, 6),
(144, 27, 9),
(145, 28, 1),
(146, 28, 2),
(147, 28, 3),
(148, 28, 4),
(149, 28, 6),
(150, 28, 9),
(151, 29, 1),
(152, 29, 2),
(153, 29, 3),
(154, 29, 4),
(155, 29, 6),
(156, 29, 9),
(157, 30, 1),
(158, 30, 2),
(159, 30, 3),
(160, 30, 4),
(161, 30, 6),
(162, 30, 9),
(163, 31, 1),
(164, 31, 2),
(165, 31, 3),
(166, 31, 4),
(167, 31, 6),
(168, 31, 9),
(169, 32, 1),
(170, 32, 2),
(171, 32, 3),
(172, 32, 4),
(173, 32, 6),
(174, 32, 9),
(175, 33, 1),
(176, 33, 2),
(177, 33, 3),
(178, 33, 4),
(179, 33, 6),
(180, 33, 9),
(181, 34, 1),
(182, 34, 2),
(183, 34, 3),
(184, 34, 4),
(185, 34, 6),
(186, 34, 9),
(187, 35, 1),
(188, 35, 2),
(189, 35, 3),
(190, 35, 4),
(191, 35, 6),
(192, 35, 9),
(193, 36, 1),
(194, 36, 2),
(195, 36, 3),
(196, 36, 4),
(197, 36, 6),
(198, 36, 9),
(199, 37, 1),
(200, 37, 2),
(201, 37, 3),
(202, 37, 4),
(203, 37, 6),
(204, 37, 9),
(205, 38, 1),
(206, 38, 2),
(207, 38, 3),
(208, 38, 4),
(209, 38, 6),
(210, 38, 9),
(211, 39, 1),
(212, 39, 2),
(213, 39, 3),
(214, 39, 4),
(215, 39, 6),
(216, 39, 9),
(217, 40, 1),
(218, 40, 2),
(219, 40, 3),
(220, 40, 4),
(221, 40, 6),
(222, 40, 9),
(223, 41, 1),
(224, 41, 2),
(225, 41, 3),
(226, 41, 4),
(227, 41, 6),
(228, 41, 9);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_log`
--

CREATE TABLE IF NOT EXISTS `usuario_log` (
`Id_log` int(11) NOT NULL,
  `usuario` int(11) NOT NULL,
  `fecha_log` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ip_conn` varchar(45) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=159 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuario_log`
--

INSERT INTO `usuario_log` (`Id_log`, `usuario`, `fecha_log`, `ip_conn`) VALUES
(66, 1, '2015-04-30 12:24:09', '::1'),
(67, 1, '2015-04-30 13:47:48', '::1'),
(68, 1, '2015-04-30 14:38:18', '::1'),
(69, 1, '2015-04-30 15:10:19', '::1'),
(70, 1, '2015-04-30 15:35:59', '10.8.44.96'),
(71, 1, '2015-05-05 15:27:13', '10.8.44.214'),
(72, 1, '2015-05-05 15:27:38', '10.8.44.215'),
(73, 1, '2015-05-05 15:30:57', '10.8.44.214'),
(74, 1, '2015-05-05 15:35:42', '10.8.44.246'),
(75, 1, '2015-05-05 15:36:02', '10.8.44.207'),
(76, 1, '2015-05-05 15:36:06', '10.8.44.140'),
(77, 1, '2015-05-05 15:44:19', '10.8.44.215'),
(78, 1, '2015-05-05 15:45:32', '10.8.44.207'),
(79, 1, '2015-05-05 15:54:18', '10.8.44.215'),
(80, 2, '2015-05-05 16:04:25', '10.8.44.207'),
(81, 3, '2015-05-05 16:04:48', '10.8.44.140'),
(82, 4, '2015-05-05 16:04:56', '10.8.44.246'),
(83, 5, '2015-05-05 16:08:06', '10.8.44.214'),
(84, 1, '2015-05-05 16:08:18', '10.8.44.214'),
(85, 5, '2015-05-05 16:09:14', '10.8.44.214'),
(86, 1, '2015-05-05 16:09:39', '10.8.44.214'),
(87, 5, '2015-05-05 16:16:42', '10.8.44.214'),
(88, 5, '2015-05-05 16:21:15', '10.8.44.214'),
(89, 5, '2015-05-05 16:25:27', '10.8.44.214'),
(90, 1, '2015-05-05 16:55:07', '10.8.44.246'),
(91, 1, '2015-05-05 17:02:21', '10.8.44.214'),
(92, 3, '2015-05-05 17:19:58', '10.8.44.140'),
(93, 1, '2015-05-05 17:24:09', '10.8.44.214'),
(94, 7, '2015-05-05 17:30:44', '10.8.44.140'),
(95, 3, '2015-05-05 17:33:24', '10.8.44.140'),
(96, 1, '2015-05-05 17:33:51', '10.8.44.214'),
(97, 7, '2015-05-05 17:34:34', '10.8.44.140'),
(98, 4, '2015-05-05 17:37:04', '10.8.44.246'),
(99, 1, '2015-05-05 17:43:09', '10.8.44.32'),
(100, 8, '2015-05-05 17:50:53', '10.8.44.32'),
(101, 1, '2015-05-05 17:53:15', '10.8.44.32'),
(102, 8, '2015-05-05 17:56:40', '10.8.44.32'),
(103, 1, '2015-05-05 18:34:04', '::1'),
(104, 9, '2015-05-05 18:39:11', '::1'),
(105, 9, '2015-05-05 18:52:10', '::1'),
(106, 1, '2015-05-05 18:56:07', '10.8.44.239'),
(107, 1, '2015-05-05 19:48:29', '10.8.44.40'),
(108, 10, '2015-05-05 20:02:58', '10.8.44.40'),
(109, 10, '2015-05-05 20:05:32', '10.8.44.40'),
(110, 3, '2015-05-06 19:23:58', '10.8.44.77'),
(111, 1, '2015-05-06 20:01:15', '10.8.44.239'),
(112, 1, '2015-05-07 16:37:59', '::1'),
(113, 11, '2015-05-07 16:49:41', '::1'),
(114, 1, '2015-05-07 16:56:17', '::1'),
(115, 1, '2015-05-07 16:59:33', '::1'),
(116, 1, '2015-05-07 17:04:21', '::1'),
(117, 1, '2015-05-07 17:05:25', '::1'),
(118, 6, '2015-05-07 17:06:21', '::1'),
(119, 1, '2015-05-07 17:13:25', '::1'),
(120, 12, '2015-05-07 17:14:41', '::1'),
(121, 1, '2015-05-07 18:26:09', '10.8.44.79'),
(122, 1, '2015-05-07 18:27:23', '10.8.44.214'),
(123, 11, '2015-05-07 18:28:02', '10.8.44.214'),
(124, 1, '2015-05-07 18:36:08', '10.8.44.214'),
(125, 12, '2015-05-07 18:36:55', '10.8.44.214'),
(126, 1, '2015-05-07 19:02:34', '10.8.44.79'),
(127, 8, '2015-05-07 19:03:28', '10.8.44.79'),
(128, 1, '2015-05-07 19:06:24', '10.8.44.79'),
(129, 1, '2015-05-14 14:56:34', '10.8.44.79'),
(130, 1, '2015-05-14 16:14:09', '10.8.44.56'),
(131, 1, '2015-05-14 17:51:31', '10.8.44.56'),
(132, 1, '2015-05-14 19:24:03', '10.8.44.56'),
(133, 1, '2015-05-14 19:37:19', '10.8.44.56'),
(134, 1, '2015-05-14 19:47:46', '10.8.44.56'),
(135, 1, '2015-05-14 19:51:49', '10.8.44.79'),
(136, 1, '2015-05-14 20:09:56', '10.8.44.79'),
(137, 1, '2015-05-22 16:14:35', '10.8.44.79'),
(138, 1, '2015-05-22 17:42:44', '10.8.44.56'),
(139, 1, '2015-05-22 18:21:41', '10.8.44.79'),
(140, 1, '2015-05-22 18:51:42', '::1'),
(141, 1, '2015-05-22 18:54:53', '::1'),
(142, 1, '2015-05-22 19:21:12', '10.8.44.79'),
(143, 1, '2015-05-22 19:25:31', '10.8.44.79'),
(144, 1, '2015-05-22 19:25:46', '10.8.44.79'),
(145, 1, '2015-05-25 16:08:04', '10.8.44.79'),
(146, 1, '2015-05-25 19:07:33', '10.8.44.56'),
(147, 1, '2015-05-25 19:07:52', '10.8.44.56'),
(148, 1, '2015-05-25 19:12:40', '10.8.44.56'),
(149, 1, '2015-05-25 19:15:05', '10.8.44.56'),
(150, 13, '2015-05-25 19:27:17', '10.8.44.56'),
(151, 1, '2015-05-25 19:47:14', '10.8.44.56'),
(152, 6, '2015-05-25 19:53:42', '10.8.44.56'),
(153, 1, '2015-05-26 20:21:11', '10.8.44.77'),
(154, 1, '2015-05-26 20:47:45', '10.8.44.77'),
(155, 1, '2015-05-26 21:56:40', '10.8.44.77'),
(156, 1, '2015-05-26 22:54:23', '10.8.44.77'),
(157, 1, '2015-05-26 22:59:26', '10.8.44.77'),
(158, 1, '2015-05-28 14:55:52', '10.8.44.151');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_notificado`
--

CREATE TABLE IF NOT EXISTS `usuario_notificado` (
`Id_UsuarioNotificado` int(11) NOT NULL,
  `Id_Notificacion` int(11) NOT NULL,
  `Id_Usuario` int(11) NOT NULL,
  `IdUbicacionNotificacion` tinyint(4) NOT NULL,
  `Estado` tinyint(11) NOT NULL,
  `Fecha` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuario_notificado`
--

INSERT INTO `usuario_notificado` (`Id_UsuarioNotificado`, `Id_Notificacion`, `Id_Usuario`, `IdUbicacionNotificacion`, `Estado`, `Fecha`) VALUES
(1, 1, 6, 3, 1, '2015-05-05 20:04:59'),
(2, 2, 8, 3, 1, '2015-05-05 20:49:28'),
(3, 3, 8, 1, 1, '2015-05-07 21:00:26'),
(4, 4, 1, 3, 1, '2015-05-25 21:42:30');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `actividades`
--
ALTER TABLE `actividades`
 ADD PRIMARY KEY (`id_actividad`), ADD KEY `id_indicador` (`id_indicador`);

--
-- Indices de la tabla `actividades_terminadas`
--
ALTER TABLE `actividades_terminadas`
 ADD PRIMARY KEY (`id_Actividades_Terminadas`), ADD KEY `id_Actividad` (`id_Actividad`), ADD KEY `No_Empleado` (`No_Empleado`);

--
-- Indices de la tabla `alerta`
--
ALTER TABLE `alerta`
 ADD PRIMARY KEY (`Id_Alerta`), ADD KEY `fk_alerta_folios` (`NroFolioGenera`);

--
-- Indices de la tabla `area`
--
ALTER TABLE `area`
 ADD PRIMARY KEY (`id_Area`), ADD KEY `id_tipo_area` (`id_tipo_area`);

--
-- Indices de la tabla `cargo`
--
ALTER TABLE `cargo`
 ADD PRIMARY KEY (`ID_cargo`);

--
-- Indices de la tabla `categorias_folios`
--
ALTER TABLE `categorias_folios`
 ADD PRIMARY KEY (`Id_categoria`);

--
-- Indices de la tabla `clases`
--
ALTER TABLE `clases`
 ADD PRIMARY KEY (`ID_Clases`);

--
-- Indices de la tabla `clases_has_experiencia_academica`
--
ALTER TABLE `clases_has_experiencia_academica`
 ADD PRIMARY KEY (`ID_Clases`,`ID_Experiencia_academica`), ADD KEY `fk_Clases_has_Experiencia_academica_Experiencia_academica1_idx` (`ID_Experiencia_academica`), ADD KEY `fk_Clases_has_Experiencia_academica_Clases1_idx` (`ID_Clases`);

--
-- Indices de la tabla `costo_porcentaje_actividad_por_trimestre`
--
ALTER TABLE `costo_porcentaje_actividad_por_trimestre`
 ADD PRIMARY KEY (`id_Costo_Porcentaje_Actividad_Por_Trimesrte`), ADD KEY `id_Actividad` (`id_Actividad`);

--
-- Indices de la tabla `departamento_laboral`
--
ALTER TABLE `departamento_laboral`
 ADD PRIMARY KEY (`Id_departamento_laboral`);

--
-- Indices de la tabla `edificios`
--
ALTER TABLE `edificios`
 ADD PRIMARY KEY (`Edificio_ID`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
 ADD PRIMARY KEY (`No_Empleado`,`N_identidad`), ADD UNIQUE KEY `No_Empleado_2` (`No_Empleado`), ADD KEY `fk_Empleado_Persona1_idx` (`N_identidad`), ADD KEY `fk_empleado_dep` (`Id_departamento`), ADD KEY `No_Empleado` (`No_Empleado`);

--
-- Indices de la tabla `empleado_has_cargo`
--
ALTER TABLE `empleado_has_cargo`
 ADD PRIMARY KEY (`No_Empleado`,`ID_cargo`), ADD KEY `fk_Empleado_has_Cargo_Cargo1_idx` (`ID_cargo`), ADD KEY `fk_Empleado_has_Cargo_Empleado1_idx` (`No_Empleado`), ADD KEY `No_Empleado` (`No_Empleado`);

--
-- Indices de la tabla `estado_seguimiento`
--
ALTER TABLE `estado_seguimiento`
 ADD PRIMARY KEY (`Id_Estado_Seguimiento`);

--
-- Indices de la tabla `estudios_academico`
--
ALTER TABLE `estudios_academico`
 ADD PRIMARY KEY (`ID_Estudios_academico`), ADD KEY `fk_Estudios_academico_Tipo_estudio1_idx` (`ID_Tipo_estudio`), ADD KEY `fk_Estudios_academico_Persona1_idx` (`N_identidad`), ADD KEY `fk_estudio_universidad` (`Id_universidad`);

--
-- Indices de la tabla `experiencia_academica`
--
ALTER TABLE `experiencia_academica`
 ADD PRIMARY KEY (`ID_Experiencia_academica`), ADD KEY `fk_Experiencia_academica_Persona1_idx` (`N_identidad`);

--
-- Indices de la tabla `experiencia_laboral`
--
ALTER TABLE `experiencia_laboral`
 ADD PRIMARY KEY (`ID_Experiencia_laboral`), ADD KEY `fk_Experiencia_laboral_Persona1_idx` (`N_identidad`);

--
-- Indices de la tabla `experiencia_laboral_has_cargo`
--
ALTER TABLE `experiencia_laboral_has_cargo`
 ADD PRIMARY KEY (`ID_Experiencia_laboral`,`ID_cargo`), ADD KEY `fk_Experiencia_laboral_has_Cargo_Cargo1_idx` (`ID_cargo`), ADD KEY `fk_Experiencia_laboral_has_Cargo_Experiencia_laboral1_idx` (`ID_Experiencia_laboral`);

--
-- Indices de la tabla `folios`
--
ALTER TABLE `folios`
 ADD PRIMARY KEY (`NroFolio`), ADD KEY `fk_folios_unidad_academica_unidadAcademica` (`UnidadAcademica`), ADD KEY `fk_folios_organizacion_organizacion` (`Organizacion`), ADD KEY `fk_folios_tblTipoPrioridad` (`Prioridad`), ADD KEY `fk_folios_ubicacion_archivofisico_ubicacionFisica` (`UbicacionFisica`), ADD KEY `fk_folio_folioRespuesta` (`NroFolioRespuesta`), ADD KEY `fk_folios_categoria` (`Categoria`);

--
-- Indices de la tabla `grupo_o_comite`
--
ALTER TABLE `grupo_o_comite`
 ADD PRIMARY KEY (`ID_Grupo_o_comite`);

--
-- Indices de la tabla `grupo_o_comite_has_empleado`
--
ALTER TABLE `grupo_o_comite_has_empleado`
 ADD PRIMARY KEY (`ID_Grupo_o_comite`,`No_Empleado`), ADD KEY `fk_Grupo_o_comite_has_Empleado_Empleado1_idx` (`No_Empleado`), ADD KEY `fk_Grupo_o_comite_has_Empleado_Grupo_o_comite1_idx` (`ID_Grupo_o_comite`);

--
-- Indices de la tabla `idioma`
--
ALTER TABLE `idioma`
 ADD PRIMARY KEY (`ID_Idioma`);

--
-- Indices de la tabla `idioma_has_persona`
--
ALTER TABLE `idioma_has_persona`
 ADD PRIMARY KEY (`Id`), ADD KEY `fk_Idioma_has_Persona_Persona1_idx` (`N_identidad`), ADD KEY `fk_Idioma_has_Persona_Idioma_idx` (`ID_Idioma`);

--
-- Indices de la tabla `indicadores`
--
ALTER TABLE `indicadores`
 ADD PRIMARY KEY (`id_Indicadores`), ADD KEY `id_ObjetivosInsitucionales` (`id_ObjetivosInsitucionales`);

--
-- Indices de la tabla `motivos`
--
ALTER TABLE `motivos`
 ADD PRIMARY KEY (`Motivo_ID`);

--
-- Indices de la tabla `notificaciones_folios`
--
ALTER TABLE `notificaciones_folios`
 ADD PRIMARY KEY (`Id_Notificacion`,`IdEmisor`), ADD KEY `fk_notificaciones_folios_folios` (`NroFolio`), ADD KEY `fk_usuario_notificaciones` (`IdEmisor`);

--
-- Indices de la tabla `objetivos_institucionales`
--
ALTER TABLE `objetivos_institucionales`
 ADD PRIMARY KEY (`id_Objetivo`), ADD KEY `id_Area` (`id_Area`), ADD KEY `id_Poa` (`id_Poa`), ADD KEY `id_Area_2` (`id_Area`);

--
-- Indices de la tabla `organizacion`
--
ALTER TABLE `organizacion`
 ADD PRIMARY KEY (`Id_Organizacion`);

--
-- Indices de la tabla `pais`
--
ALTER TABLE `pais`
 ADD PRIMARY KEY (`Id_pais`);

--
-- Indices de la tabla `permisos`
--
ALTER TABLE `permisos`
 ADD PRIMARY KEY (`id_Permisos`), ADD KEY `fk_motivo` (`id_motivo`), ADD KEY `fk_empleado` (`No_Empleado`), ADD KEY `fk_edificio_registro` (`id_Edificio_Registro`), ADD KEY `fk_revisado` (`revisado_por`), ADD KEY `fk_departamento` (`id_departamento`), ADD KEY `fk_usuario` (`id_usuario`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
 ADD PRIMARY KEY (`N_identidad`);

--
-- Indices de la tabla `poa`
--
ALTER TABLE `poa`
 ADD PRIMARY KEY (`id_Poa`);

--
-- Indices de la tabla `prioridad`
--
ALTER TABLE `prioridad`
 ADD PRIMARY KEY (`Id_Prioridad`);

--
-- Indices de la tabla `prioridad_folio`
--
ALTER TABLE `prioridad_folio`
 ADD PRIMARY KEY (`Id_PrioridadFolio`), ADD KEY `fk_prioridad_folio_folios` (`IdFolio`), ADD KEY `fk_prioridad_folio_prioridad` (`Id_Prioridad`);

--
-- Indices de la tabla `responsables_por_actividad`
--
ALTER TABLE `responsables_por_actividad`
 ADD PRIMARY KEY (`id_Responsable_por_Actividad`), ADD KEY `id_Actividad` (`id_Actividad`,`id_Responsable`), ADD KEY `id_Responsable` (`id_Responsable`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
 ADD PRIMARY KEY (`Id_Rol`);

--
-- Indices de la tabla `seguimiento`
--
ALTER TABLE `seguimiento`
 ADD PRIMARY KEY (`Id_Seguimiento`), ADD KEY `fk_seguimiento_folios` (`NroFolio`), ADD KEY `fk_seguimiento_usuarioAsignado` (`UsuarioAsignado`);

--
-- Indices de la tabla `seguimiento_historico`
--
ALTER TABLE `seguimiento_historico`
 ADD PRIMARY KEY (`Id_SeguimientoHistorico`), ADD KEY `fk_seguimiento_historico_seguimiento` (`Id_Seguimiento`), ADD KEY `fk_seguimiento_historico_tblEstdoSeguimiento` (`Id_Estado_Seguimiento`);

--
-- Indices de la tabla `sub_actividad`
--
ALTER TABLE `sub_actividad`
 ADD PRIMARY KEY (`id_sub_Actividad`), ADD KEY `idActividad` (`idActividad`), ADD KEY `id_Encargado(Usuario)` (`id_Encargado`);

--
-- Indices de la tabla `sub_actividades_realizadas`
--
ALTER TABLE `sub_actividades_realizadas`
 ADD PRIMARY KEY (`id_subActividadRealizada`), ADD UNIQUE KEY `id_SubActividad_2` (`id_SubActividad`), ADD KEY `id_SubActividad` (`id_SubActividad`);

--
-- Indices de la tabla `telefono`
--
ALTER TABLE `telefono`
 ADD PRIMARY KEY (`ID_Telefono`), ADD KEY `fk_Telefono_Persona1_idx` (`N_identidad`);

--
-- Indices de la tabla `tipo_area`
--
ALTER TABLE `tipo_area`
 ADD PRIMARY KEY (`id_Tipo_Area`);

--
-- Indices de la tabla `tipo_estudio`
--
ALTER TABLE `tipo_estudio`
 ADD PRIMARY KEY (`ID_Tipo_estudio`);

--
-- Indices de la tabla `titulo`
--
ALTER TABLE `titulo`
 ADD PRIMARY KEY (`id_titulo`);

--
-- Indices de la tabla `ubicacion_archivofisico`
--
ALTER TABLE `ubicacion_archivofisico`
 ADD PRIMARY KEY (`Id_UbicacionArchivoFisico`);

--
-- Indices de la tabla `ubicacion_notificaciones`
--
ALTER TABLE `ubicacion_notificaciones`
 ADD PRIMARY KEY (`Id_UbicacionNotificaciones`);

--
-- Indices de la tabla `unidad_academica`
--
ALTER TABLE `unidad_academica`
 ADD PRIMARY KEY (`Id_UnidadAcademica`);

--
-- Indices de la tabla `universidad`
--
ALTER TABLE `universidad`
 ADD PRIMARY KEY (`Id_universidad`), ADD KEY `fk_universidad_pais` (`Id_pais`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
 ADD PRIMARY KEY (`id_Usuario`), ADD KEY `fk_usuarios_roles` (`Id_Rol`), ADD KEY `fk_usuario_empleado` (`No_Empleado`);

--
-- Indices de la tabla `usuario_alertado`
--
ALTER TABLE `usuario_alertado`
 ADD PRIMARY KEY (`Id_UsuarioAlertado`), ADD KEY `fk_usuario_alertado_usuario` (`Id_Usuario`), ADD KEY `fk_usuario_alertado_alerta` (`Id_Alerta`);

--
-- Indices de la tabla `usuario_log`
--
ALTER TABLE `usuario_log`
 ADD PRIMARY KEY (`Id_log`);

--
-- Indices de la tabla `usuario_notificado`
--
ALTER TABLE `usuario_notificado`
 ADD PRIMARY KEY (`Id_UsuarioNotificado`), ADD KEY `fk_usuario_notificado_notificaciones_folios` (`Id_Notificacion`), ADD KEY `fk_usuario_notificado_ubicacion_notificacionesFolios` (`IdUbicacionNotificacion`), ADD KEY `fk_usuario_notificado_usuario` (`Id_Usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `actividades`
--
ALTER TABLE `actividades`
MODIFY `id_actividad` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `actividades_terminadas`
--
ALTER TABLE `actividades_terminadas`
MODIFY `id_Actividades_Terminadas` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `alerta`
--
ALTER TABLE `alerta`
MODIFY `Id_Alerta` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=42;
--
-- AUTO_INCREMENT de la tabla `area`
--
ALTER TABLE `area`
MODIFY `id_Area` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `cargo`
--
ALTER TABLE `cargo`
MODIFY `ID_cargo` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT de la tabla `categorias_folios`
--
ALTER TABLE `categorias_folios`
MODIFY `Id_categoria` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `clases`
--
ALTER TABLE `clases`
MODIFY `ID_Clases` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `costo_porcentaje_actividad_por_trimestre`
--
ALTER TABLE `costo_porcentaje_actividad_por_trimestre`
MODIFY `id_Costo_Porcentaje_Actividad_Por_Trimesrte` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `departamento_laboral`
--
ALTER TABLE `departamento_laboral`
MODIFY `Id_departamento_laboral` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `edificios`
--
ALTER TABLE `edificios`
MODIFY `Edificio_ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `estado_seguimiento`
--
ALTER TABLE `estado_seguimiento`
MODIFY `Id_Estado_Seguimiento` tinyint(4) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `estudios_academico`
--
ALTER TABLE `estudios_academico`
MODIFY `ID_Estudios_academico` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT de la tabla `experiencia_academica`
--
ALTER TABLE `experiencia_academica`
MODIFY `ID_Experiencia_academica` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `experiencia_laboral`
--
ALTER TABLE `experiencia_laboral`
MODIFY `ID_Experiencia_laboral` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `grupo_o_comite`
--
ALTER TABLE `grupo_o_comite`
MODIFY `ID_Grupo_o_comite` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `idioma`
--
ALTER TABLE `idioma`
MODIFY `ID_Idioma` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT de la tabla `idioma_has_persona`
--
ALTER TABLE `idioma_has_persona`
MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `indicadores`
--
ALTER TABLE `indicadores`
MODIFY `id_Indicadores` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `motivos`
--
ALTER TABLE `motivos`
MODIFY `Motivo_ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `notificaciones_folios`
--
ALTER TABLE `notificaciones_folios`
MODIFY `Id_Notificacion` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `objetivos_institucionales`
--
ALTER TABLE `objetivos_institucionales`
MODIFY `id_Objetivo` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `organizacion`
--
ALTER TABLE `organizacion`
MODIFY `Id_Organizacion` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `pais`
--
ALTER TABLE `pais`
MODIFY `Id_pais` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT de la tabla `permisos`
--
ALTER TABLE `permisos`
MODIFY `id_Permisos` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT de la tabla `poa`
--
ALTER TABLE `poa`
MODIFY `id_Poa` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `prioridad_folio`
--
ALTER TABLE `prioridad_folio`
MODIFY `Id_PrioridadFolio` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT de la tabla `responsables_por_actividad`
--
ALTER TABLE `responsables_por_actividad`
MODIFY `id_Responsable_por_Actividad` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `seguimiento`
--
ALTER TABLE `seguimiento`
MODIFY `Id_Seguimiento` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT de la tabla `seguimiento_historico`
--
ALTER TABLE `seguimiento_historico`
MODIFY `Id_SeguimientoHistorico` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT de la tabla `sub_actividad`
--
ALTER TABLE `sub_actividad`
MODIFY `id_sub_Actividad` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `sub_actividades_realizadas`
--
ALTER TABLE `sub_actividades_realizadas`
MODIFY `id_subActividadRealizada` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `telefono`
--
ALTER TABLE `telefono`
MODIFY `ID_Telefono` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `tipo_area`
--
ALTER TABLE `tipo_area`
MODIFY `id_Tipo_Area` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `tipo_estudio`
--
ALTER TABLE `tipo_estudio`
MODIFY `ID_Tipo_estudio` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `titulo`
--
ALTER TABLE `titulo`
MODIFY `id_titulo` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `ubicacion_archivofisico`
--
ALTER TABLE `ubicacion_archivofisico`
MODIFY `Id_UbicacionArchivoFisico` int(5) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `ubicacion_notificaciones`
--
ALTER TABLE `ubicacion_notificaciones`
MODIFY `Id_UbicacionNotificaciones` tinyint(4) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `unidad_academica`
--
ALTER TABLE `unidad_academica`
MODIFY `Id_UnidadAcademica` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `universidad`
--
ALTER TABLE `universidad`
MODIFY `Id_universidad` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
MODIFY `id_Usuario` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT de la tabla `usuario_alertado`
--
ALTER TABLE `usuario_alertado`
MODIFY `Id_UsuarioAlertado` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=229;
--
-- AUTO_INCREMENT de la tabla `usuario_log`
--
ALTER TABLE `usuario_log`
MODIFY `Id_log` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=159;
--
-- AUTO_INCREMENT de la tabla `usuario_notificado`
--
ALTER TABLE `usuario_notificado`
MODIFY `Id_UsuarioNotificado` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `actividades_terminadas`
--
ALTER TABLE `actividades_terminadas`
ADD CONSTRAINT `actividades_terminadas_ibfk_3` FOREIGN KEY (`id_Actividad`) REFERENCES `actividades` (`id_actividad`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `alerta`
--
ALTER TABLE `alerta`
ADD CONSTRAINT `fk_alerta_folios` FOREIGN KEY (`NroFolioGenera`) REFERENCES `folios` (`NroFolio`);

--
-- Filtros para la tabla `area`
--
ALTER TABLE `area`
ADD CONSTRAINT `area_ibfk_1` FOREIGN KEY (`id_tipo_area`) REFERENCES `tipo_area` (`id_Tipo_Area`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `clases_has_experiencia_academica`
--
ALTER TABLE `clases_has_experiencia_academica`
ADD CONSTRAINT `fk_Clases_has_Experiencia_academica_Clases1` FOREIGN KEY (`ID_Clases`) REFERENCES `clases` (`ID_Clases`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `fk_Clases_has_Experiencia_academica_Experiencia_academica1` FOREIGN KEY (`ID_Experiencia_academica`) REFERENCES `experiencia_academica` (`ID_Experiencia_academica`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `costo_porcentaje_actividad_por_trimestre`
--
ALTER TABLE `costo_porcentaje_actividad_por_trimestre`
ADD CONSTRAINT `costo_porcentaje_actividad_por_trimestre_ibfk_1` FOREIGN KEY (`id_Actividad`) REFERENCES `actividades` (`id_actividad`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `empleado`
--
ALTER TABLE `empleado`
ADD CONSTRAINT `fk_Empleado_Persona1` FOREIGN KEY (`N_identidad`) REFERENCES `persona` (`N_identidad`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `fk_empleado_dep` FOREIGN KEY (`Id_departamento`) REFERENCES `departamento_laboral` (`Id_departamento_laboral`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `empleado_has_cargo`
--
ALTER TABLE `empleado_has_cargo`
ADD CONSTRAINT `fk_Empleado_has_Cargo_Cargo1` FOREIGN KEY (`ID_cargo`) REFERENCES `cargo` (`ID_cargo`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `fk_Empleado_has_Cargo_Empleado1` FOREIGN KEY (`No_Empleado`) REFERENCES `empleado` (`No_Empleado`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `estudios_academico`
--
ALTER TABLE `estudios_academico`
ADD CONSTRAINT `fk_Estudios_academico_Persona1` FOREIGN KEY (`N_identidad`) REFERENCES `persona` (`N_identidad`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `fk_Estudios_academico_Tipo_estudio1` FOREIGN KEY (`ID_Tipo_estudio`) REFERENCES `tipo_estudio` (`ID_Tipo_estudio`),
ADD CONSTRAINT `fk_estudio_universidad` FOREIGN KEY (`Id_universidad`) REFERENCES `universidad` (`Id_universidad`);

--
-- Filtros para la tabla `experiencia_academica`
--
ALTER TABLE `experiencia_academica`
ADD CONSTRAINT `fk_Experiencia_academica_Persona1` FOREIGN KEY (`N_identidad`) REFERENCES `persona` (`N_identidad`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `experiencia_laboral`
--
ALTER TABLE `experiencia_laboral`
ADD CONSTRAINT `fk_Experiencia_laboral_Persona1` FOREIGN KEY (`N_identidad`) REFERENCES `persona` (`N_identidad`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `experiencia_laboral_has_cargo`
--
ALTER TABLE `experiencia_laboral_has_cargo`
ADD CONSTRAINT `fk_Experiencia_laboral_has_Cargo_Cargo1` FOREIGN KEY (`ID_cargo`) REFERENCES `cargo` (`ID_cargo`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `fk_Experiencia_laboral_has_Cargo_Experiencia_laboral1` FOREIGN KEY (`ID_Experiencia_laboral`) REFERENCES `experiencia_laboral` (`ID_Experiencia_laboral`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `folios`
--
ALTER TABLE `folios`
ADD CONSTRAINT `fk_folio_folioRespuesta` FOREIGN KEY (`NroFolioRespuesta`) REFERENCES `folios` (`NroFolio`) ON UPDATE CASCADE,
ADD CONSTRAINT `fk_folios_categoria` FOREIGN KEY (`Categoria`) REFERENCES `categorias_folios` (`Id_categoria`) ON UPDATE CASCADE,
ADD CONSTRAINT `fk_folios_organizacion_organizacion` FOREIGN KEY (`Organizacion`) REFERENCES `organizacion` (`Id_Organizacion`) ON UPDATE CASCADE,
ADD CONSTRAINT `fk_folios_tblTipoPrioridad` FOREIGN KEY (`Prioridad`) REFERENCES `prioridad` (`Id_Prioridad`) ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT `fk_folios_ubicacion_archivofisico_ubicacionFisica` FOREIGN KEY (`UbicacionFisica`) REFERENCES `ubicacion_archivofisico` (`Id_UbicacionArchivoFisico`) ON UPDATE CASCADE,
ADD CONSTRAINT `fk_folios_unidad_academica_unidadAcademica` FOREIGN KEY (`UnidadAcademica`) REFERENCES `unidad_academica` (`Id_UnidadAcademica`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `grupo_o_comite_has_empleado`
--
ALTER TABLE `grupo_o_comite_has_empleado`
ADD CONSTRAINT `fk_Grupo_o_comite_has_Empleado_Empleado1` FOREIGN KEY (`No_Empleado`) REFERENCES `empleado` (`No_Empleado`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `fk_Grupo_o_comite_has_Empleado_Grupo_o_comite1` FOREIGN KEY (`ID_Grupo_o_comite`) REFERENCES `grupo_o_comite` (`ID_Grupo_o_comite`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `idioma_has_persona`
--
ALTER TABLE `idioma_has_persona`
ADD CONSTRAINT `fk_Idioma_has_Persona_Idioma` FOREIGN KEY (`ID_Idioma`) REFERENCES `idioma` (`ID_Idioma`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `fk_Idioma_has_Persona_Persona1` FOREIGN KEY (`N_identidad`) REFERENCES `persona` (`N_identidad`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `indicadores`
--
ALTER TABLE `indicadores`
ADD CONSTRAINT `indicadores_ibfk_1` FOREIGN KEY (`id_ObjetivosInsitucionales`) REFERENCES `objetivos_institucionales` (`id_Objetivo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `notificaciones_folios`
--
ALTER TABLE `notificaciones_folios`
ADD CONSTRAINT `fk_notificaciones_folios_folios` FOREIGN KEY (`NroFolio`) REFERENCES `folios` (`NroFolio`) ON UPDATE CASCADE,
ADD CONSTRAINT `fk_usuario_notificaciones` FOREIGN KEY (`IdEmisor`) REFERENCES `usuario` (`id_Usuario`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `objetivos_institucionales`
--
ALTER TABLE `objetivos_institucionales`
ADD CONSTRAINT `objetivos_institucionales_ibfk_2` FOREIGN KEY (`id_Poa`) REFERENCES `poa` (`id_Poa`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `objetivos_institucionales_ibfk_3` FOREIGN KEY (`id_Area`) REFERENCES `area` (`id_Area`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `permisos`
--
ALTER TABLE `permisos`
ADD CONSTRAINT `fk_departamento` FOREIGN KEY (`id_departamento`) REFERENCES `departamento_laboral` (`Id_departamento_laboral`),
ADD CONSTRAINT `fk_edificio_registro` FOREIGN KEY (`id_Edificio_Registro`) REFERENCES `edificios` (`Edificio_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `fk_empleado` FOREIGN KEY (`No_Empleado`) REFERENCES `empleado` (`No_Empleado`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `fk_motivo` FOREIGN KEY (`id_motivo`) REFERENCES `motivos` (`Motivo_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `fk_revisado` FOREIGN KEY (`revisado_por`) REFERENCES `usuario` (`No_Empleado`),
ADD CONSTRAINT `fk_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_Usuario`);

--
-- Filtros para la tabla `prioridad_folio`
--
ALTER TABLE `prioridad_folio`
ADD CONSTRAINT `fk_prioridad_folio_folios` FOREIGN KEY (`IdFolio`) REFERENCES `folios` (`NroFolio`) ON UPDATE CASCADE,
ADD CONSTRAINT `fk_prioridad_folio_prioridad` FOREIGN KEY (`Id_Prioridad`) REFERENCES `prioridad` (`Id_Prioridad`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `responsables_por_actividad`
--
ALTER TABLE `responsables_por_actividad`
ADD CONSTRAINT `responsables_por_actividad_ibfk_3` FOREIGN KEY (`id_Actividad`) REFERENCES `actividades` (`id_actividad`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `responsables_por_actividad_ibfk_4` FOREIGN KEY (`id_Responsable`) REFERENCES `grupo_o_comite` (`ID_Grupo_o_comite`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `seguimiento`
--
ALTER TABLE `seguimiento`
ADD CONSTRAINT `fk_seguimiento_folios` FOREIGN KEY (`NroFolio`) REFERENCES `folios` (`NroFolio`) ON UPDATE CASCADE,
ADD CONSTRAINT `fk_seguimiento_usuarioAsignado` FOREIGN KEY (`UsuarioAsignado`) REFERENCES `usuario` (`id_Usuario`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `seguimiento_historico`
--
ALTER TABLE `seguimiento_historico`
ADD CONSTRAINT `fk_seguimiento_historico_seguimiento1` FOREIGN KEY (`Id_Seguimiento`) REFERENCES `seguimiento` (`Id_Seguimiento`) ON UPDATE CASCADE,
ADD CONSTRAINT `fk_seguimiento_historico_tblEstdoSeguimiento` FOREIGN KEY (`Id_Estado_Seguimiento`) REFERENCES `estado_seguimiento` (`Id_Estado_Seguimiento`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `sub_actividad`
--
ALTER TABLE `sub_actividad`
ADD CONSTRAINT `sub_actividad_ibfk_3` FOREIGN KEY (`idActividad`) REFERENCES `actividades` (`id_actividad`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `sub_actividad_ibfk_4` FOREIGN KEY (`id_Encargado`) REFERENCES `empleado` (`No_Empleado`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `sub_actividades_realizadas`
--
ALTER TABLE `sub_actividades_realizadas`
ADD CONSTRAINT `sub_actividades_realizadas_ibfk_2` FOREIGN KEY (`id_SubActividad`) REFERENCES `sub_actividad` (`id_sub_Actividad`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `telefono`
--
ALTER TABLE `telefono`
ADD CONSTRAINT `fk_Telefono_Persona1` FOREIGN KEY (`N_identidad`) REFERENCES `persona` (`N_identidad`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `universidad`
--
ALTER TABLE `universidad`
ADD CONSTRAINT `fk_universidad_pais` FOREIGN KEY (`Id_pais`) REFERENCES `pais` (`Id_pais`);

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
ADD CONSTRAINT `fk_usuario_empleado` FOREIGN KEY (`No_Empleado`) REFERENCES `empleado` (`No_Empleado`) ON UPDATE CASCADE,
ADD CONSTRAINT `fk_usuarios_roles` FOREIGN KEY (`Id_Rol`) REFERENCES `roles` (`Id_Rol`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `usuario_alertado`
--
ALTER TABLE `usuario_alertado`
ADD CONSTRAINT `fk_usuario_alertado_alerta` FOREIGN KEY (`Id_Usuario`) REFERENCES `usuario` (`id_Usuario`),
ADD CONSTRAINT `fk_usuario_alertado_usuario` FOREIGN KEY (`Id_Alerta`) REFERENCES `alerta` (`Id_Alerta`);

--
-- Filtros para la tabla `usuario_notificado`
--
ALTER TABLE `usuario_notificado`
ADD CONSTRAINT `fk_usuario_notificado_notificaciones_folios` FOREIGN KEY (`Id_Notificacion`) REFERENCES `notificaciones_folios` (`Id_Notificacion`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `fk_usuario_notificado_usuario` FOREIGN KEY (`Id_Usuario`) REFERENCES `usuario` (`id_Usuario`);

DELIMITER $$
--
-- Eventos
--
CREATE DEFINER=`root`@`localhost` EVENT `crear_alertas_diarias` ON SCHEDULE EVERY 1 DAY STARTS '2015-03-14 20:32:06' ON COMPLETION NOT PRESERVE ENABLE COMMENT 'Crea las alertas que se generan por la no atencion a el seguimie' DO BEGIN
	      DECLARE v_finished INTEGER DEFAULT 0;
		  DECLARE numFolio varchar(25) DEFAULT "";
		  DECLARE seguimiento INTEGER DEFAULT 0;
		  DECLARE fechaFin DATE;
 
          -- declare cursor 
		  DEClARE folio_cursor CURSOR FOR
          SELECT NroFolio FROM folios;
 
          -- declare NOT FOUND handler
          DECLARE CONTINUE HANDLER
          FOR NOT FOUND SET v_finished = 1;
 
		  OPEN folio_cursor ;
		  
			folios_loop: LOOP
 
                FETCH folio_cursor INTO numFolio;
				
                IF v_finished = 1 THEN
					LEAVE folios_loop;
                END IF;
 
                SET fechaFin = (SELECT FechaFinal FROM seguimiento WHERE NroFolio = numFolio);
				SET seguimiento = (SELECT Id_Seguimiento FROM seguimiento WHERE NroFolio = numFolio);
				
                IF fechaFin IS NULL THEN
					CALL sp_check_seguimiento(numFolio,seguimiento);
				END IF;
				
			END LOOP folios_loop;
 
          CLOSE folio_cursor ;
      END$$

DELIMITER ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
