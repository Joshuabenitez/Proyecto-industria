CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_OBTENER_SOLICITUDES`(OUT `pcMensajeError` VARCHAR(500))
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
END;

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_OBTENER_SOLICITUDES_REPORTES`(OUT `pcMensajeError` VARCHAR(500))
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
    	sa_tipos_solicitud.nombre as TIPOSOLICITUD,
    	sa_tipos_solicitud.codigo as CODTIPOSOLICITUD 
FROM sa_solicitudes
	INNER JOIN persona on sa_solicitudes.dni_estudiante = 	persona.N_identidad
    INNER JOIN sa_tipos_solicitud on sa_solicitudes.cod_tipo_solicitud = sa_tipos_solicitud.codigo
    WHERE sa_solicitudes.cod_tipo_solicitud IN (123488, 123489, 123491,123492) OR
     sa_solicitudes.codigo IN (SELECT sa_examenes_himno.cod_solicitud FROM sa_examenes_himno WHERE sa_examenes_himno.nota_himno BETWEEN 0 AND 100);
END;

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGISTRAR_SOLICITUD`(IN `pcIdentidadEstudiante` VARCHAR(500), IN `pcTipoSolicitud` INT, IN `pnCodigoPeriodo` INT, IN `pbSolicitudEsDeHimno` BOOLEAN, IN `pdFechaSolicitudExamen` DATE, OUT `pcMensajeError` VARCHAR(1000))
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
    SET pbSolicitudEsDeHimno := (SELECT IF(COUNT(codigo)>=1,0,1) FROM sa_tipos_solicitud WHERE sa_tipos_solicitud.nombre like '%himno%');
    
    IF pbSolicitudEsDeHimno = 0 THEN

				SET vcTempMensajeError := 'Error al registrar el examen de himno';
		INSERT INTO sa_examenes_himno(cod_solicitud, fecha_examen_himno, fecha_solicitud)
		VALUES(vnCodigoNuevoRegistroSolicitud, pdFechaSolicitudExamen, CURDATE());
    
    END IF;
    

    COMMIT;
    

END;