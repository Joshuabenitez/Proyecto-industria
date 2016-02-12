-- phpMyAdmin SQL Dump
-- version 4.4.3
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 27-09-2015 a las 19:33:26
-- Versión del servidor: 5.6.24
-- Versión de PHP: 5.5.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `ccjj`
--

--
-- Volcado de datos para la tabla `actividades`
--

INSERT INTO `actividades` (`id_actividad`, `id_indicador`, `descripcion`, `correlativo`, `supuesto`, `justificacion`, `medio_verificacion`, `poblacion_objetivo`, `fecha_inicio`, `fecha_fin`) VALUES
(11, 4, 'actividad septiembre', 'correlativ', 'supuesto septiembre', 'justificacion septiembre', 'medio de verificacion septiembre', 'poblacion objetivo\n\n', '2015-09-10', '2015-09-16');

--
-- Volcado de datos para la tabla `area`
--

INSERT INTO `area` (`id_Area`, `nombre`, `id_tipo_area`, `observacion`) VALUES
(2, 'prueba', 2, 'prueba15'),
(3, 'area septiembre', 0, 'n.a.'),
(4, 'area septiembre', 2, 'n.a'),
(5, 'area septiembre', 5, '');

--
-- Volcado de datos para la tabla `cargo`
--

INSERT INTO `cargo` (`ID_cargo`, `Cargo`) VALUES
(2, 'DECANA'),
(3, 'ADMINISTRADOR'),
(4, 'Asistente de Soporte Técnico'),
(5, 'Asistente de Planificación Estratégica '),
(6, 'ASISTENTE ADMINISTRATIVO'),
(7, 'CONSERJE'),
(8, 'SECRETARIA DOCENTE'),
(9, 'ASISTENTE TECNICO'),
(10, 'SECRETARIO ACADEMICO'),
(11, 'SECRETARIA DOCENTE 1'),
(12, 'SECRETARIO DOCENTE 2'),
(13, 'COORDINADOR ACADEMICO'),
(14, 'AUXILIAR DE OFICINA'),
(15, 'JEFE DE DEPARTAMENTO DERECHO ADMINISTRATIVO'),
(16, 'JEFE DE DEPARTAMENTO DERECHO INTERNACIONAL'),
(17, 'JEFE DE DEPARTAMENTO DERECHO PRIVADO'),
(18, 'JEFE DE DEPARTAMENTO DERECHO PROCESAL PENAL'),
(19, 'JEFE DE DEPARTAMENTO TEORIA E HISTORIA'),
(20, 'JEFE DEPARTAMENTO CURRICULAR'),
(21, 'JEFE DE DEPARTAMENTO INVESTIGACION'),
(22, 'ASISTENTE OPERATIVO II');

--
-- Volcado de datos para la tabla `categorias_folios`
--

INSERT INTO `categorias_folios` (`Id_categoria`, `NombreCategoria`, `DescripcionCategoria`) VALUES
(2, 'CATEGORIA', 'ES'),
(4, 'categoria septiembre', 'desc'),
(5, 'EQUIVALENCIAS', 'Solicitud de Dictámenes'),
(6, 'EXPEDIENTES DE GRADUACIÓN', 'Graduaciones Públicas'),
(7, 'TÍTULOS POR VENTANILLA', 'Expedientes de Graduación');

--
-- Volcado de datos para la tabla `ca_acondicionamientos`
--

INSERT INTO `ca_acondicionamientos` (`codigo`, `nombre`) VALUES
(3, 'datashow'),
(13, 'PruebaAllanModificado'),
(5, 'datashow con pantalla'),
(6, 'datashow'),
(9, 'SOPORTE'),
(15, 'PruebaAllan'),
(16, 'PruebaAllan0'),
(17, 'PruebaAllan1'),
(18, 'PruebaAllan2'),
(19, 'PruebaAllan3'),
(20, 'PruebaAllan4'),
(21, 'PruebaAllan5');

--
-- Volcado de datos para la tabla `ca_areas`
--

INSERT INTO `ca_areas` (`codigo`, `nombre`) VALUES
(5, 'Docentes'),
(3, 'Campo vacio modificado'),
(8, 'Docentes'),
(12, 'nueva area de proyecto'),
(13, 'soporte'),
(19, 'eliZ');

--
-- Volcado de datos para la tabla `ca_aulas`
--

INSERT INTO `ca_aulas` (`codigo`, `cod_edificio`, `numero_aula`) VALUES
(1, 19, '123'),
(2, 20, '102'),
(3, 20, '201'),
(4, 21, '401'),
(5, 22, '102'),
(6, 5, '102'),
(7, 1, '102'),
(8, 2, '101'),
(9, 19, '456'),
(10, 35, 'PruebaAllanModificado'),
(11, 35, '99Modificado'),
(12, 19, '201'),
(13, 34, '101');

--
-- Volcado de datos para la tabla `ca_cursos_dias`
--

INSERT INTO `ca_cursos_dias` (`cod_curso`, `cod_dia`) VALUES
(2, 1),
(2, 2),
(3, 1),
(3, 2),
(3, 3),
(3, 4),
(4, 1),
(4, 2),
(4, 3),
(5, 1),
(5, 2),
(5, 3),
(5, 4),
(6, 1),
(6, 3),
(6, 5),
(7, 1),
(7, 2),
(7, 3),
(7, 4),
(8, 1),
(8, 2),
(8, 3),
(8, 4),
(9, 1),
(9, 2),
(9, 3),
(9, 4),
(10, 1),
(10, 2),
(10, 3),
(10, 4),
(10, 5),
(11, 1),
(11, 3),
(11, 5),
(12, 1),
(13, 1);

--
-- Volcado de datos para la tabla `ca_dias`
--

INSERT INTO `ca_dias` (`codigo`, `nombre`) VALUES
(2, 'Lunes'),
(3, 'Martes'),
(4, 'Miércoles'),
(5, 'Jueves'),
(6, 'Viernes'),
(7, 'Sábado'),
(8, 'Domingo');

--
-- Volcado de datos para la tabla `ca_empleados_proyectos`
--

INSERT INTO `ca_empleados_proyectos` (`no_empleado`, `dni_empleado`, `cod_proyecto`, `cod_rol_proyecto`) VALUES
('123444', '0000-0000-00000', 3, 1),
('11456464', '0801-9123-12323', 3, 2),
('12969', '0801-1985-18347', 4, 2),
('85863', '0501-1994-05961', 6, 1),
('00004', '0004-0004-00004', 9, 2),
('00005', '0005-0005-00005', 10, 2),
('999989', '9999-9999-99999', 4, 2);

--
-- Volcado de datos para la tabla `ca_estados_carga`
--

INSERT INTO `ca_estados_carga` (`codigo`, `descripcion`) VALUES
(2, 'En proceso'),
(4, 'Cancelada'),
(3, 'Rechazada');

--
-- Volcado de datos para la tabla `ca_facultades`
--

INSERT INTO `ca_facultades` (`codigo`, `nombre`) VALUES
(21, 'Economia'),
(7, 'economiaS'),
(20, 'PruebaAllanModificado?'),
(17, 'Informática'),
(23, 'Ciencias Jurídicas');

--
-- Volcado de datos para la tabla `ca_instancias_acondicionamientos`
--

INSERT INTO `ca_instancias_acondicionamientos` (`codigo`, `cod_acondicionamiento`) VALUES
(2, 3);

--
-- Volcado de datos para la tabla `ca_proyectos`
--

INSERT INTO `ca_proyectos` (`codigo`, `nombre`, `cod_vinculacion`, `cod_area`) VALUES
(2, 'proyecto nuevo', 15, 5),
(3, 'Lo que sea', 1, 3),
(4, 'Soporte tecnico', 5, 12),
(5, 'soporte tecnico', 3, 13),
(6, 'Nuevo proyecto ', 5, 8),
(7, 'Proyecto', 5, 3),
(8, 'hola3', 15, 5),
(9, 'PruebaAllan', 111, 5),
(10, 'elizabeth', 12, 19),
(11, 'PROYECTO SEPTIEMBRE', 12, 19);

--
-- Volcado de datos para la tabla `ca_roles_proyecto`
--

INSERT INTO `ca_roles_proyecto` (`codigo`, `nombre`) VALUES
(1, 'Coordinador'),
(2, 'Participante');

--
-- Volcado de datos para la tabla `ca_vinculaciones`
--

INSERT INTO `ca_vinculaciones` (`codigo`, `nombre`, `cod_facultad`) VALUES
(123, 'aistente', 17),
(12, 'eliz', 17),
(34, 'aistente', 7),
(12345, 'otro', 17),
(111, 'PruebaAllanModificado', 20);

--
-- Volcado de datos para la tabla `clases`
--

INSERT INTO `clases` (`ID_Clases`, `Clase`) VALUES
(8, 'Sociología'),
(9, 'Espanol General'),
(11, 'Historia de Honduras'),
(10, 'Filosofía'),
(12, 'Introducción a la estadística Social'),
(13, 'Met Tec Invest e Informática'),
(14, 'Ética General'),
(15, 'Lógica Jurídica'),
(16, 'Interpretación Jurídica'),
(17, 'Derecho Romano'),
(18, 'Introducción al estudio de Derecho'),
(19, 'Teoría General del Estado'),
(20, 'Derecho de la Familia'),
(21, 'Derecho de la Familia'),
(22, 'Teoría General del Proceso'),
(23, 'Derecho Penal I'),
(24, 'Teoría de la Constitución'),
(25, 'Derecho Forestal y de Aguas'),
(26, 'Derecho Privado I'),
(27, 'Derecho Procesal Civil I'),
(28, 'Derecho Penal II'),
(29, 'Derecho de la Ninez Adolescente Mujer'),
(30, 'Historia Const e Institu Política'),
(31, 'Derecho Laboral I'),
(32, 'Derecho Privado II'),
(33, 'Derecho Procesal Civil II'),
(34, 'Criminología'),
(35, 'Derecho Constitucional'),
(36, 'Derecho Internaciona Público I'),
(37, 'Derecho de Ejecución Penal III'),
(38, 'Derecho Privado III'),
(39, 'Derecho Laboral II'),
(40, 'Derecho Internacional Público II'),
(41, 'Derecho Administrativo I'),
(42, 'Derecho Privado IV'),
(43, 'Medicina Forence'),
(44, 'Derecho Mercantil I'),
(45, 'Derecho Ambiental'),
(46, 'Derecho Seguridad Social'),
(47, 'Derecho Administrativo II'),
(48, 'Derecho Mercantil II'),
(49, 'Derecho Agrario'),
(50, 'Derecho Admin Especial'),
(51, 'Derecho de Integración'),
(52, 'Derecho Laboral Especial'),
(53, 'Derecho Humano y Humanitario'),
(54, 'Derecho Internacional Privado'),
(55, 'Filosofía Derecho'),
(56, 'Derecho Notarial y Registro Inmobiliario'),
(57, 'Derecho Mercantil Especial'),
(58, 'Propiedad Intelectual'),
(59, 'Derecho Procesal Laboral'),
(60, 'Derecho Procesal Penal'),
(61, 'Justicia Administrativa'),
(62, 'Ética Profesional'),
(63, 'Módulo de Práctica Procesal Civil'),
(64, 'Módulo de Práctica Procesal Laboral'),
(65, 'Módulo de Criminalística'),
(66, 'Módulo de Práctica Procesal Penal'),
(67, 'Módulo de Práctica Procesal Administrativa'),
(68, 'Módulo de Métodos Alternativos y Solución de '),
(69, 'Módulo de Práctica Judicial Internacional'),
(70, 'Módulo de Derecho Notarial y Derecho Registra'),
(71, 'Módulo de Justicia Constitucional');

--
-- Volcado de datos para la tabla `clases_has_experiencia_academica`
--

INSERT INTO `clases_has_experiencia_academica` (`ID_Clases`, `ID_Experiencia_academica`) VALUES
(3, 1),
(4, 2),
(4, 3);

--
-- Volcado de datos para la tabla `costo_porcentaje_actividad_por_trimestre`
--

INSERT INTO `costo_porcentaje_actividad_por_trimestre` (`id_Costo_Porcentaje_Actividad_Por_Trimesrte`, `id_Actividad`, `costo`, `porcentaje`, `observacion`, `trimestre`) VALUES
(3, 11, 125000, 25, 'na', 1);

--
-- Volcado de datos para la tabla `departamento_laboral`
--

INSERT INTO `departamento_laboral` (`Id_departamento_laboral`, `nombre_departamento`) VALUES
(4, 'TEORIA E HISTORIA'),
(2, 'DERECHO PROCESAL PENAL'),
(3, ' INVESTIGACION'),
(5, 'DESARROLLO CURRICULAR'),
(6, 'DERECHO INTERNACIONAL'),
(7, 'DERECHO ADMINISTRATIVO'),
(8, 'DERECHO SOCIAL'),
(9, 'DERECHO PRIVADO'),
(10, 'DECANATO'),
(11, 'ADMINISTRACION'),
(12, 'COORDINACION'),
(13, 'LABORATORIO ESTUDIANTES'),
(14, 'LABORATORIO DOCENTES'),
(15, 'Docencia');

--
-- Volcado de datos para la tabla `edificios`
--

INSERT INTO `edificios` (`Edificio_ID`, `descripcion`) VALUES
(21, 'J1'),
(19, 'C3'),
(20, 'C1'),
(22, 'F1'),
(34, 'B3'),
(35, 'C2'),
(36, 'A2'),
(40, 'edificio septiembre');

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`No_Empleado`, `N_identidad`, `Id_departamento`, `Fecha_ingreso`, `fecha_salida`, `Observacion`, `estado_empleado`) VALUES
('11456464', '0801-9123-12323', 2, '2015-06-06', NULL, 'OBS', 1),
('1234', '0501-1994-05967', 2, '2015-07-09', '2015-07-28', 'Observacion observacion', 0),
('12344', '1234-0000-00000', 2, '2015-07-09', NULL, 'ninguna', 1),
('123444', '0000-0000-00000', 2, '2015-07-07', NULL, '', 1),
('85863', '0501-1994-05961', 1, '2015-07-18', NULL, 'Esta es una observacion', 1),
('12968', '0801-1991-06974', 3, '2016-07-28', NULL, 'na', 1),
('11538', '1211-1980-00001', 3, '2014-02-10', '2015-07-29', '', 0),
('12969', '0801-1985-18347', 3, '2015-04-27', NULL, '', 1),
('15', '0000-0000-00015', 2, '2015-07-28', NULL, 'ninguna', 1),
('8708', '0801-1972-10136', 2, '2015-03-20', NULL, '', 1),
('777', '0801-1990-77777', 2, '2015-07-31', NULL, 'ninguna', 1),
('1234568', '1400-1400-14000', 2, '2015-08-03', NULL, 'ninguna', 1),
('00001', '0001-0001-00001', 4, '2015-08-13', '2015-09-01', 'n.a.', 0),
('00003', '0003-0003-00003', 4, '2015-08-06', '2015-09-01', 'n', 0),
('00004', '0004-0004-00004', 4, '2015-08-07', NULL, 'n', 1),
('00005', '0005-0005-00005', 5, '2015-08-06', NULL, 'n', 1),
('999989', '9999-9999-99999', 2, '2015-08-05', NULL, 'ninguna', 1),
('12345', '0801-1992-07543', 2, '2015-08-05', NULL, 'ninguna', 1),
('2', '0801-1991-21789', 2, '2015-08-05', '2015-09-01', 'ninguna', 0),
('77', '0801-1990-66666', 2, '2015-08-12', '2015-09-02', 'ninguna', 0),
('1014', '0202-1963-00018', 5, '0000-00-00', '2015-09-03', 'n', 0),
('8860', '0801-1977-13759', 5, '2003-01-01', NULL, '', 1),
('6558', '0801-1965-00177', 10, '0000-00-00', NULL, '', 1),
('5548', '0801-1959-03859', 10, '0000-00-00', NULL, '', 1),
('3089', '0801-1961-08415', 10, '0000-00-00', NULL, '', 1),
('11022', '0709-1990-00100', 11, '0000-00-00', NULL, '', 1),
('7908', '0801-1969-02793', 11, '0000-00-00', NULL, '', 1),
('01', '0801-1978-12387', 12, '0000-00-00', NULL, '', 1),
('11910', '0801-1988-16746', 13, '0000-00-00', NULL, '', 1),
('1414', '1414-1414-14141', 4, '2015-06-24', NULL, 'asd', 1);

--
-- Volcado de datos para la tabla `empleado_has_cargo`
--

INSERT INTO `empleado_has_cargo` (`No_Empleado`, `ID_cargo`, `Fecha_ingreso_cargo`, `Fecha_salida_cargo`) VALUES
('11456464', 3, '2015-07-09', NULL),
('85863', 2, '2015-07-18', NULL),
('12968', 4, '2015-07-28', NULL),
('11538', 2, '2014-02-10', '2015-07-29'),
('12969', 4, '2015-04-27', NULL),
('11538', 5, '2015-07-29', NULL),
('8708', 2, '2015-03-20', NULL),
('00001', 2, '2015-08-13', NULL),
('00003', 2, '2015-08-06', NULL),
('00004', 5, '2015-08-07', NULL),
('00005', 3, '2015-08-06', NULL),
('1014', 8, '0000-00-00', NULL),
('8860', 13, '2003-01-01', NULL),
('6558', 2, '0000-00-00', NULL),
('5548', 22, '0000-00-00', NULL),
('3089', 22, '0000-00-00', NULL),
('11022', 3, '0000-00-00', NULL),
('7908', 6, '0000-00-00', NULL),
('01', 22, '0000-00-00', NULL),
('11910', 2, '0000-00-00', NULL),
('1414', 2, '2015-06-24', NULL);

--
-- Volcado de datos para la tabla `estado_seguimiento`
--

INSERT INTO `estado_seguimiento` (`Id_Estado_Seguimiento`, `DescripcionEstadoSeguimiento`) VALUES
(8, 'Huelga'),
(9, 'Aprobada'),
(10, 'Denegada'),
(11, 'En proceso');

--
-- Volcado de datos para la tabla `estudios_academico`
--

INSERT INTO `estudios_academico` (`ID_Estudios_academico`, `Nombre_titulo`, `ID_Tipo_estudio`, `N_identidad`, `Id_universidad`) VALUES
(6, 'Licenciatura en Ingenieria en Sistemas', 1, '0000-0000-00000', 3),
(7, 'Maestria en Derecho Penal', 2, '0801-9123-12323', 3),
(8, 'Maestria en Derecho Penal', 2, '0000-0000-00000', 3),
(10, ' Informática Administrativa', 8, '0801-1991-06974', 5),
(11, 'Administración Empresarial', 9, '1211-1980-00001', 6),
(12, 'Administración Empresarial', 8, '0801-1985-18347', 5),
(13, 'Administración Empresarial', 9, '0000-0000-00178', 5);

--
-- Volcado de datos para la tabla `experiencia_academica`
--

INSERT INTO `experiencia_academica` (`ID_Experiencia_academica`, `Institucion`, `Tiempo`, `N_identidad`) VALUES
(1, 'UNAH', 20, '0000-0000-00000'),
(2, 'prueba', 2, '0801-1991-06974'),
(3, 'unah', 19, '0000-0000-00178');

--
-- Volcado de datos para la tabla `experiencia_laboral`
--

INSERT INTO `experiencia_laboral` (`ID_Experiencia_laboral`, `Nombre_empresa`, `Tiempo`, `N_identidad`) VALUES
(1, 'UNAH', 23, '0000-0000-00000'),
(2, 'pruebas', 20, '0801-1991-06974'),
(3, 'Prueba', 36, '0000-0000-00178');

--
-- Volcado de datos para la tabla `experiencia_laboral_has_cargo`
--

INSERT INTO `experiencia_laboral_has_cargo` (`ID_Experiencia_laboral`, `ID_cargo`) VALUES
(1, 3),
(2, 4),
(3, 3);

--
-- Volcado de datos para la tabla `folios`
--

INSERT INTO `folios` (`NroFolio`, `NroFolioRespuesta`, `FechaCreacion`, `FechaEntrada`, `PersonaReferente`, `UnidadAcademica`, `Organizacion`, `Categoria`, `DescripcionAsunto`, `TipoFolio`, `UbicacionFisica`, `Prioridad`) VALUES
('5', NULL, '2015-08-17', '2015-08-17 23:19:01', 'prueba', 3, NULL, 2, 'hola', 0, 5, 5),
('1', NULL, '2015-08-19', '2015-08-19 16:53:53', 'Rafael', NULL, 3, 2, 'fdsfsdf', 0, 5, 5),
('123123', NULL, '2015-08-23', '2015-08-23 20:41:40', 'asd', NULL, 3, 2, 'Descripcion', 1, 5, 5),
('123', NULL, '2015-09-02', '2015-09-02 18:33:03', 'Elizabeth', NULL, 4, 4, 'n', 1, 6, 6),
('folio de prueba', NULL, '2015-09-10', '2015-09-10 18:54:45', 'junior', NULL, 3, 2, 'prueba', 0, 5, 5),
('20', NULL, '2015-09-11', '2015-09-11 23:38:35', 'EMMA VIRGINIA ', NULL, 3, 2, 'ASUNTO', 1, 5, 5),
('Oficio 120', NULL, '2015-09-01', '2015-09-22 23:02:50', 'rutilia calderon', NULL, 5, 2, 'sddddddd', 0, 6, 5),
('015/2015', NULL, '2015-09-15', '2015-09-25 18:49:59', 'ESTER LÓPEZ', NULL, 4, 5, 'Se devuelve expediente de Carmen Mondragón', 1, 6, 5),
('002', NULL, '2015-09-10', '2015-09-25 19:01:07', 'Ester Lopez', NULL, 3, 5, 'Se devuelve expediente para recosideración de dictamen', 0, 6, 6);

--
-- Volcado de datos para la tabla `grupo_o_comite`
--

INSERT INTO `grupo_o_comite` (`ID_Grupo_o_comite`, `Nombre_Grupo_o_comite`) VALUES
(4, 'Pruebas'),
(3, 'Asistentes Técnicos');

--
-- Volcado de datos para la tabla `grupo_o_comite_has_empleado`
--

INSERT INTO `grupo_o_comite_has_empleado` (`ID_Grupo_o_comite`, `No_Empleado`) VALUES
(2, '123444'),
(2, '85863'),
(3, '12969');

--
-- Volcado de datos para la tabla `idioma`
--

INSERT INTO `idioma` (`ID_Idioma`, `Idioma`) VALUES
(2, 'Ingles'),
(3, 'Español'),
(4, 'Frances'),
(5, 'Chino Mandarín'),
(6, 'Italiano'),
(7, 'Japones'),
(8, 'Aleman'),
(9, 'Portugués'),
(10, 'Árabe'),
(11, 'Bengalí'),
(12, 'Indonesio'),
(13, 'Coreano'),
(14, 'Turco'),
(15, 'Vietnamita');

--
-- Volcado de datos para la tabla `idioma_has_persona`
--

INSERT INTO `idioma_has_persona` (`ID_Idioma`, `N_identidad`, `Nivel`, `Id`) VALUES
(2, '0801-1991-06974', '75', 1),
(3, '0801-1991-06974', '99', 2),
(2, '1211-1980-00001', '90', 3),
(2, '0801-1985-18347', '70', 4),
(4, '0000-0000-00178', '80', 5);

--
-- Volcado de datos para la tabla `indicadores`
--

INSERT INTO `indicadores` (`id_Indicadores`, `id_ObjetivosInsitucionales`, `nombre`, `descripcion`) VALUES
(4, 6, 'Tiempo', 'n.a.');

--
-- Volcado de datos para la tabla `motivos`
--

INSERT INTO `motivos` (`Motivo_ID`, `descripcion`) VALUES
(1, 'salud'),
(2, 'Familiar'),
(3, 'Laboral'),
(4, 'Otros'),
(5, 'dsxds'),
(6, 'fdf'),
(7, 'motivo septiembre');

--
-- Volcado de datos para la tabla `notificaciones_folios`
--

INSERT INTO `notificaciones_folios` (`Id_Notificacion`, `NroFolio`, `IdEmisor`, `Titulo`, `Cuerpo`, `FechaCreacion`, `IdUbicacionNotificacion`, `Estado`) VALUES
(1, '1', 1, 'a', 'asd', '2015-08-23 14:40:52', 2, 1),
(2, '1', 5, 'APURENSE', 'ES PARA AYER', '2015-09-11 17:45:23', 2, 1);

--
-- Volcado de datos para la tabla `objetivos_institucionales`
--

INSERT INTO `objetivos_institucionales` (`id_Objetivo`, `definicion`, `area_Estrategica`, `resultados_Esperados`, `id_Area`, `id_Poa`) VALUES
(6, 'Mejorar el rendimiento de la actividades de septiembre', 'Area Laboral', 'Lograr el cumplimiento de la actividades en menos tiempo', 4, 19);

--
-- Volcado de datos para la tabla `organizacion`
--

INSERT INTO `organizacion` (`Id_Organizacion`, `NombreOrganizacion`, `Ubicacion`) VALUES
(4, 'organizacion septiembre', 'A2'),
(3, 'PRUEBA FCJ', 'A-2'),
(5, 'CRA', 'ADMINISTRATIVO');

--
-- Volcado de datos para la tabla `pais`
--

INSERT INTO `pais` (`Id_pais`, `Nombre_pais`) VALUES
(2, 'Honduras'),
(3, 'Estados Unidos'),
(4, 'Mexico'),
(5, 'Guatemala'),
(6, 'ChinaTaiwan'),
(7, 'El Salvador'),
(8, 'Nicaragua'),
(9, 'Panama'),
(10, 'Costa Rica'),
(11, 'Espana'),
(12, 'Francia'),
(13, 'Italia'),
(14, 'Canada'),
(15, 'Japón'),
(16, 'China'),
(17, 'Corea'),
(18, 'Venezuela'),
(19, 'Colombia'),
(20, 'Chile'),
(21, 'Argentina'),
(22, 'Japon');

--
-- Volcado de datos para la tabla `permisos`
--

INSERT INTO `permisos` (`id_Permisos`, `id_departamento`, `No_Empleado`, `id_motivo`, `dias_permiso`, `hora_inicio`, `hora_finalizacion`, `fecha`, `fecha_solicitud`, `estado`, `observacion`, `revisado_por`, `id_Edificio_Registro`, `id_usuario`) VALUES
(1, 2, '123444', 1, 0, '08:00:00', '11:00:00', '0006-05-06 00:00:00', '2015-07-28', 'Espera', NULL, NULL, 18, 1),
(2, 3, '12969', 2, 5, '08:00:00', '15:30:00', '2015-08-11 00:00:00', '2015-07-29', 'Espera', NULL, NULL, 19, 4),
(3, 3, '12969', 1, 3, '09:30:00', '13:30:00', '2015-08-26 00:00:00', '2015-07-29', 'Espera', NULL, NULL, 21, 4),
(4, 3, '12969', 2, 1, '09:00:00', '13:00:00', '2015-08-26 00:00:00', '2015-07-29', 'Espera', NULL, NULL, 19, 4),
(5, 2, '123444', 1, 1, '01:00:00', '02:00:00', '0000-00-00 00:00:00', '2015-07-29', 'Espera', NULL, NULL, 21, 1),
(6, 3, '12969', 3, 4, '09:30:00', '14:00:00', '2015-08-03 00:00:00', '2015-07-30', 'Espera', NULL, NULL, 20, 4),
(7, 4, '00001', 3, 3, '02:00:00', '08:00:00', '2015-08-05 00:00:00', '2015-08-04', 'Espera', NULL, NULL, 20, 6),
(8, 4, '00001', 2, 4, '08:00:00', '03:30:00', '2015-08-06 00:00:00', '2015-08-04', 'Espera', NULL, NULL, 19, 6),
(9, 4, '00001', 4, 3, '01:00:00', '07:00:00', '0000-00-00 00:00:00', '2015-08-17', 'Espera', NULL, NULL, 21, 6),
(10, 4, '00001', 6, 1, '01:00:00', '07:00:00', '0000-00-00 00:00:00', '2015-08-17', 'Espera', NULL, NULL, 34, 6),
(11, 4, '00001', 1, 2, '13:00:00', '20:00:00', '2015-08-17 00:00:00', '2015-08-17', 'Espera', NULL, NULL, 21, 6),
(12, 4, '00001', 5, 5, '08:00:00', '10:00:00', '2015-08-17 00:00:00', '2015-08-17', 'Espera', NULL, NULL, 21, 6),
(13, 5, '00005', 1, 0, '09:00:00', '11:00:00', '2015-08-25 00:00:00', '2015-08-17', 'Espera', NULL, NULL, 19, 9),
(14, 5, '00005', 1, 1, '14:00:00', '15:00:00', '2015-08-17 00:00:00', '2015-08-17', 'Espera', NULL, NULL, 21, 9),
(15, 2, '123444', 7, 2, '01:00:00', '08:00:00', '0000-00-00 00:00:00', '2015-09-02', 'Espera', NULL, NULL, 40, 1),
(16, 5, '00005', 1, 0, '01:00:00', '07:00:00', '0000-00-00 00:00:00', '2015-09-02', 'Espera', NULL, NULL, 21, 9),
(17, 10, '3089', 4, 1, '08:00:00', '03:30:00', '0000-00-00 00:00:00', '2015-09-11', 'Espera', NULL, NULL, 36, 14),
(18, 11, '7908', 2, 1, '08:00:00', '03:30:00', '0000-00-00 00:00:00', '2015-09-11', 'Espera', NULL, NULL, 36, 16),
(19, 2, '8708', 2, 1, '01:00:00', '08:00:00', '0009-09-15 00:00:00', '2015-09-11', 'Espera', NULL, NULL, 36, 5),
(20, 11, '11022', 4, 5, '01:00:00', '02:00:00', '2023-09-15 00:00:00', '2015-09-25', 'Espera', NULL, NULL, 36, 15);

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`N_identidad`, `Primer_nombre`, `Segundo_nombre`, `Primer_apellido`, `Segundo_apellido`, `Fecha_nacimiento`, `Sexo`, `Direccion`, `Correo_electronico`, `Estado_Civil`, `Nacionalidad`, `foto_perfil`) VALUES
('0000-0000-00000', 'Luis', 'Manuel', 'Reyes', 'Deras', '2015-07-16', 'M', '', 'correonuevo@gmail.com', 'viudo', 'Nacionalidad', ''),
('0050-0000-00000', 's', 'p', 's', 's', '2015-06-06', 'M', 'D', 'correo', 'Casado', 'Nacionalidad', ''),
('01', 'S', 'P', 'O', 'K', '2015-06-06', 'M', '', NULL, NULL, '', ''),
('021', 'S', 'P', 'O', 'K', '2015-06-06', 'M', '', NULL, NULL, '', ''),
('0301-1993-04250', 'Carlos', 'Alberto', 'Salgado', 'Montoya', '1993-10-22', 'F', 'Col. Kennedy 4ta Entrada, frente a Consejo Liberal.', 'calbertsm@gmail.com', 'viudo', 'Hondurena', ''),
('0501-1994-05961', 'L', 'M', 'R', 'd', '2015-06-06', 'M', 'D', 'l@gmail.com', 'soltero', 'H', ''),
('0501-1994-05962', 'M', 'R', 'D', 'R', '2015-06-06', 'M', '', 'l@gmail.com', 'Soltero', 'Nacionalidad', ''),
('0501-1994-05967', 'S', 'S', 'S', 'S', '2015-07-14', 'M', 'Dirección', 'l@gmail.com', 'Casado', 'Nacionalidad', ''),
('0801-9123-12323', 'Claudio', '', 'Paz', '', '2015-07-09', 'M', 'Nuevo Paraiso, Morocelí', 'klypaz@gmail.com', 'Soltero', 'Hondureña', ''),
('0808-1232-12312', 'P', 'S', 'N', 'S', '2015-06-06', 'F', 'D', 'm@gmail.com', 'Divorciado', 'N', ''),
('1234-0000-00000', 's', 'p', 's', 's', '2015-06-06', 'M', 'D', 'correo', 'Casado', 'Nacionalidad', ''),
('1234-1978-91011', 'sdfghjk', 'DSAD', 'mdqow', 'dmi', '2015-07-20', 'F', '', NULL, NULL, '', ''),
('0801-1991-06974', 'Elizabeth', '', 'Tercero', 'Calix', '0066-05-26', 'F', 'ni', 'prueba@yahoo.com', 'Soltero', 'Hondureña', ''),
('1211-1980-00001', 'Walter', 'levi', 'Meléndez', 'Perdomo', '1980-01-01', 'M', 'Lomas de Miraflores Sur, apartamento Venecia n°12', 'walter.melendez@unah.edu.hn', 'Casado', 'Hondureña', ''),
('0801-1985-18347', 'Jorge', 'Luis', 'Aguilar', 'Flores', '1985-09-15', 'M', '', 'jorge.aguilar@unah.edu.hn', 'soltero', 'Hondureña', ''),
('0801-1959-03858', 'Elizabeth', '', 'Tercero', 'Dubua', '2015-07-29', 'F', 'na', 'prueba@yahoo.com', 'Soltero', 'Hondureña', ''),
('0000-0000-00015', 'Prueba', 'Prueba', 'Pruebas', '', '1980-08-27', 'M', '', 'prueba@yahoo.com', 'Soltero', 'hondureña', ''),
('0801-1972-10136', 'Ana', '', 'Moncada', 'Torres', '1972-07-07', 'F', '', 'analourdes@yahoo.com', 'soltero', 'Hondureña', ''),
('0501-0501-05010', 'Pedro ', 'Pablo', 'Perez', 'Hernandez', '2015-05-05', 'F', 'Col. Kennedy', 'jose@gmail.com', 'Soltero', 'Hondurena', ''),
('0000-0000-00178', 'pruebas', '', 'prueba', 'prueba', '1990-07-27', 'M', '', 'prueba@yahoo.com', 'soltero', 'hondureña', ''),
('0000-0000-00156', 'prueba', 'prueba', 'prueba', 'prueba', '1990-07-30', 'F', '', 'prueba@yahoo.com', 'Soltero', 'salvadoreña', ''),
('0801-1990-77777', 'Allan', 'Ricardo', 'Diaz', 'Gomez', '1990-09-09', 'M', 'col. José A. Ulloa', 'allandiazgomez@gamil.com', 'Viudo', 'Hondureña', ''),
('0801-1990-77778', 'Jose', 'Ricardo', 'Diaz', 'Gomez', '1990-09-09', 'M', 'Ulloa', 'allandiazgomez@gmail.com', 'Viudo', 'Hondureña', ''),
('0802-1991-33333', 'Ana', 'Maria', 'Wow', 'wow', '1991-09-09', 'F', 'Sunseri', 'anamen@yahoo.com', 'Casado', 'Argentina', ''),
('0801-1991-21784', 'Yenifer', 'Shisell', 'Morazan', 'Ferrufino', '1991-10-16', 'F', 'Res. santa maria', 'shisellmorazan@hotmail.es', 'Soltero', 'Hondureña', ''),
('1400-1400-14000', 'Primer', 'Segundo', 'Primer', 'Segundo', '2015-08-18', 'M', 'Direccion', 'c@gmail.com', 'Soltero', 'Nacionalidad', ''),
('0801-1991-21785', 'Gleny', 'Mabel', 'Velasquez', 'Girón', '1993-02-23', 'F', 'Res. la joya', 'mabel@hotmail.com', 'Casado', 'Hondureña', ''),
('0001-0001-00001', 'secretaria', '', 'secretaria', 'secretaria', '2015-08-12', 'F', 'n.a', 'secre@yahoo.com', 'soltero', 'hondureña', ''),
('0002-0002-00002', 'estudiante', '', 'estudiante', 'estudiante', '2015-08-12', 'F', 'ej', 'ej@yahoo.com', 'Soltero', 'hondureña', ''),
('0003-0003-00003', 'secretariadeca', '', 'secretariadeca', 'secretariadeca', '2015-08-12', 'M', 'n', 'secretariadeca@yahoo.es', 'Casado', 'hondureña', ''),
('0004-0004-00004', 'asistente', '', 'asistente', 'asistente', '2015-08-20', 'M', 'n', 'asistente@yahoo.com', 'Casado', 'hondureña', ''),
('0005-0005-00005', 'deca', '', 'deca', 'deca', '2015-08-12', 'F', 'n', 'deca@hhjk.es', 'Casado', 'hondureña', ''),
('8888-8888-88888', 'Primer nombre', 'Segundo nombre', 'Primer apellido', 'Segundo apellido', '2015-05-05', 'M', 'Direccion', 'correo@gmail.com', 'Soltero', 'Hondurena', ''),
('9999-9999-99999', 'Pedro', 'Pablo', 'Pérez', 'Hernandez', '1999-08-01', 'M', 'Dirección', 'pedro@gmail.com', 'Soltero', 'Hondureña', ''),
('0801-1991-21786', 'Kelvin', 'Julian', 'Murillo', 'Galo', '1991-06-11', 'M', 'col. cerro grande', 'kenvil@gmail.com', 'Soltero', 'hondureña', ''),
('0801-1992-07543', 'Jose', 'Carlos', 'Bogran', 'Molina', '2015-08-03', 'M', 'col. las uvas', 'jose@gmail.com', 'Soltero', 'Hondureña', ''),
('0801-1991-21789', 'Kelvin', 'Julian', 'Murillo', 'Galo', '2014-05-01', 'M', 'col. cerro grande', 'kelvin@gmail.com', 'Soltero', 'hondureña', ''),
('0801-1990-12345', 'Yenifer', 'Shisell', 'Morazan', 'Ferrufino', '2015-08-18', 'F', 'Col. Santa Lucia', 'yenifer@gmail.com', 'Soltero', 'Hondureña', ''),
('0801-1990-66666', 'Alan', 'Ricardo', 'Diaz', 'Gomez', '1990-12-12', 'M', 'Col. Ulloa', 'd.allanricado@yahoo.com', 'Viudo', 'Hondureña', ''),
('0801-1991-77777', 'Ana', 'Linda', 'Hermosa', 'Preciosa', '1990-05-05', 'F', 'Col. Ulloa', 'analinda@yahoo.com', 'Viudo', 'Hondureña', ''),
('0301-1993-04251', 'Carlos', 'Alberto', 'Salgado', 'Montoya', '1993-10-22', 'M', 'C', 'calbertsm@gmail.com', 'Soltero', 'Hondureno', ''),
('0301-1990-00604', 'Juan', 'Ramón', 'Salgado', 'Montoya', '1990-10-26', 'M', 'C', 'jsalgado@gmail.com', 'Soltero', 'Hondureno', ''),
('0007-0007-00007', 'eliestudiante', 'eli', 'eliestudiante', 'eliestudiante', '0000-00-00', 'F', 'N.A.', 'prueba@yahoo.es', 'soltero', 'hondureña', ''),
('0801-1977-13759', 'Rafael', 'Edgardo', 'Diaz del Valle', 'Oliva', '1977-11-06', 'M', 'Altos del Trapiche', 'rafael@diazdelvalle.com', 'Casado', 'Hn', ''),
('0202-0000-00000', 'EEF', 'FDEF', 'EFDE', 'Puerto', '0000-00-00', 'F', 'n', 'S@yahoo.es', 'soltero', 'hondureña', ''),
('0801-1965-00177', 'BESSY', 'MARGOT ', 'NAZAR ', 'HERRERA', '1965-01-05', 'F', '', 'bmnazarh@hotmail.com', 'soltero', 'hondureña', ''),
('0801-1959-03859', 'GLORIA', 'ISABEL', 'OSEGUERA', 'LOPEZ', '1959-09-21', 'F', '', 'gloriaoseguera@yahoo.com', 'soltero', 'hondureña', ''),
('0801-1961-08415', 'MARIA ', 'ROSINDA ', 'MARADIAGA ', 'RUIZ', '1961-09-24', 'F', '', 'rosindamaradiaga@yahoo.com', 'soltero', 'hondureña', ''),
('0202-1963-00018', 'Santos', 'Liduvina', 'Maldonado', 'Puerto', '1963-09-12', 'F', '', 'lidumaldonado@yahoo.es', 'soltero', 'hondureña', ''),
('0709-1990-00100', 'CARLOS', 'LUIS ', 'BURGOS', 'OCHOA', '1990-07-07', 'M', '', 'carlos_beck@hotmail.com', 'soltero', 'hondureña', ''),
('0801-1969-02793', 'JHONNY ', 'ALEXIS ', 'MEMBREÑO', 'MEMBREÑO', '1969-06-02', 'M', '', 'jhonny.membreño@unah.edu.hn', 'Soltero', 'hondureña', ''),
('0801-1978-12387', 'MONICA ', 'ESMERALDA ', 'DORMES ', 'RAMIREZ', '1978-00-00', 'F', '', 'esmeraldadormes772@gmail.com', 'Soltero', 'hondureña', ''),
('0801-1988-16746', 'EVELIN ', 'ROCIO ', 'CANACA ', 'ARRIOLA', '1988-09-06', 'F', '', 'ecanaca@unah.edu.hn', 'Soltero', 'hondureña', ''),
('0801-1971-10136', 'JUAN', 'JUAN', 'SSS', 'SS', '0000-00-00', 'F', 'SS', 'SDJDJD@GMAIL.COM', 'Soltero', 'SS', ''),
('0801-1987-09326', 'IRIS', 'ALEJANDRA', 'CHAVARRÍA', 'LAGOS', '1987-04-24', 'F', '', 'irishawi@hotmail.com', 'Soltero', 'hondureña', ''),
('1414-1414-14141', 'Prueba de error', '', 'Prueba de error', 'Prueba de error', '2015-06-24', 'M', 'Direccion', 'q@gmail.com', 'Soltero', 'Hondurena', '');

--
-- Volcado de datos para la tabla `poa`
--

INSERT INTO `poa` (`id_Poa`, `nombre`, `fecha_de_Inicio`, `fecha_Fin`, `descripcion`) VALUES
(19, 'POA SEPTIEMBRE', '2015-09-02', '2016-09-02', 'Eficiencia');

--
-- Volcado de datos para la tabla `prioridad`
--

INSERT INTO `prioridad` (`Id_Prioridad`, `DescripcionPrioridad`) VALUES
(5, 'PRUEBA'),
(6, 'desc prioridad');

--
-- Volcado de datos para la tabla `prioridad_folio`
--

INSERT INTO `prioridad_folio` (`Id_PrioridadFolio`, `IdFolio`, `Id_Prioridad`, `FechaEstablecida`) VALUES
(2, '123123', 5, '2015-08-23'),
(3, '123', 6, '2015-09-02'),
(4, 'folio de prueba', 5, '2015-09-10'),
(5, '20', 5, '2015-09-11'),
(6, 'Oficio 120', 5, '2015-09-22'),
(7, '002', 6, '2015-09-25');

--
-- Volcado de datos para la tabla `responsables_por_actividad`
--

INSERT INTO `responsables_por_actividad` (`id_Responsable_por_Actividad`, `id_Actividad`, `id_Responsable`, `fecha_Asignacion`, `observacion`) VALUES
(4, 11, 3, '2015-09-09', 'na');

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

--
-- Volcado de datos para la tabla `sa_ciudades`
--

INSERT INTO `sa_ciudades` (`codigo`, `nombre`) VALUES
(1, ''),
(2, 'Tegucigalpa'),
(4, 'Santa Rosa de Copan'),
(22, 'Gracias a Dios'),
(13, 'Copan'),
(21, 'Olancho'),
(8, 'El Progreso'),
(9, ''),
(10, 'Valle'),
(11, 'La Paz'),
(24, 'PruebaAllan');

--
-- Volcado de datos para la tabla `sa_estados_solicitud`
--

INSERT INTO `sa_estados_solicitud` (`codigo`, `descripcion`) VALUES
(1, 'Activa'),
(2, 'Desactiva');

--
-- Volcado de datos para la tabla `sa_estudiantes`
--

INSERT INTO `sa_estudiantes` (`dni`, `no_cuenta`, `anios_inicio_estudio`, `indice_academico`, `fecha_registro`, `uv_acumulados`, `cantcodad_solicitudes`, `cod_plan_estudio`, `cod_ciudad_origen`, `cod_orientacion`, `cod_residencia_actual`, `anios_final_estudio`) VALUES
('0801-1987-09326', '20051008272', 2005, '71', '2015-09-19', 265, NULL, 16, 2, 2, 2, 2015),
('0501-0501-05010', '20112011201', 1, '88', '2015-07-29', 52, NULL, 1, 1, 2, 1, 0),
('0801-1990-77778', '20091000028', 5, '61', '2015-07-31', 70, NULL, 8, 2, 8, 2, 0),
('0801-1971-10136', '20120001201', 1990, '98', '2015-09-11', 1, NULL, 1, 2, 2, 2, 2015),
('0801-1991-21784', '20101003771', 1, '75', '2015-08-01', 56, NULL, 9, 2, 8, 2, 0),
('0801-1991-21785', '20101003661', 1, '80', '2015-08-04', 1, NULL, 9, 1, 2, 1, 0),
('0002-0002-00002', '20101002705', 5, '100', '2015-08-04', 52, NULL, 9, 2, 4, 2, 0),
('8888-8888-88888', '20882008640', 1, '87', '2015-08-04', 1, NULL, 9, 1, 2, 1, 0),
('0801-1991-21786', '20101003772', 5, '80', '2015-08-05', 56, NULL, 15, 1, 2, 1, 0),
('0801-1990-12345', '20091000370', 5, '2', '2015-08-05', 20, NULL, 15, 9, 4, 21, 0),
('0801-1991-77777', '20081000028', 8, '61', '2015-08-12', 6, NULL, 8, 9, 2, 9, 0),
('0301-1993-04251', '20121001759', 2012, '87', '2015-08-12', 50, NULL, 15, 2, 3, 2, 2015),
('0301-1990-00604', '20091900402', 2009, '83', '2015-08-12', 67, NULL, 15, 2, 4, 2, 2014),
('0007-0007-00007', '20101002707', 1990, '98', '2015-08-17', 54, NULL, 1, 4, 8, 4, 2015),
('0801-1977-13759', '20101003881', 1996, '89', '2015-08-19', 254, NULL, 16, 2, 8, 2, 2003);

--
-- Volcado de datos para la tabla `sa_estudiantes_correos`
--

INSERT INTO `sa_estudiantes_correos` (`dni_estudiante`, `correo`) VALUES
('0002-0002-00002', 'ej@yahoo.com'),
('0007-0007-00007', 'prueba@yahoo.es'),
('0301-1990-00604', 'jsalgado@gmail.com'),
('0301-1993-04251', 'calbertsm@gmail.com'),
('0501-0501-05010', 'jose@gmail.com'),
('0801-1959-03859', 'prueba@yahoo.com'),
('0801-1971-10136', 'SDJDJD@GMAIL.COM'),
('0801-1977-13759', 'rafael@diazdelvalle.com'),
('0801-1987-09326', 'irishawi@hotmail.com'),
('0801-1990-12345', 'yenifer@gmail.com'),
('0801-1990-77778', 'allandiazgomez@gmail.com'),
('0801-1991-21784', 'shisellmorazan@hotmail.es'),
('0801-1991-21785', 'mabel@hotmail.com'),
('0801-1991-21786', 'kenvil@gmail.com'),
('0801-1991-77777', 'analinda@yahoo.com'),
('0802-1991-33333', 'anamen@yahoo.com'),
('8888-8888-88888', 'correo@gmail.com');

--
-- Volcado de datos para la tabla `sa_estudiantes_menciones_honorificas`
--

INSERT INTO `sa_estudiantes_menciones_honorificas` (`dni_estudiante`, `cod_mencion`) VALUES
('0002-0002-00002', 4),
('0007-0007-00007', 2),
('0301-1990-00604', 2),
('0301-1993-04251', 2),
('0501-0501-05010', 1),
('0801-1959-03859', 0),
('0801-1971-10136', 2),
('0801-1977-13759', 7),
('0801-1987-09326', 6),
('0801-1990-12345', 2),
('0801-1990-77778', 3),
('0801-1991-21784', 2),
('0801-1991-21785', 1),
('0801-1991-21786', 1),
('0801-1991-77777', 3),
('0802-1991-33333', 1),
('8888-8888-88888', 1);

--
-- Volcado de datos para la tabla `sa_estudiantes_tipos_estudiantes`
--

INSERT INTO `sa_estudiantes_tipos_estudiantes` (`codigo_tipo_estudiante`, `dni_estudiante`, `fecha_registro`) VALUES
(2, '0801-1959-03859', '2015-07-28 16:46:24'),
(1, '0501-0501-05010', '2015-07-29 00:41:48'),
(1, '0801-1990-77778', '2015-07-31 17:43:12'),
(1, '0802-1991-33333', '2015-07-31 17:46:52'),
(2, '0802-1991-33333', '2015-07-31 17:47:50'),
(1, '0801-1991-21784', '2015-08-01 22:41:26'),
(2, '0801-1991-21784', '2015-08-02 02:02:14'),
(1, '0801-1991-21785', '2015-08-04 02:31:10'),
(1, '0002-0002-00002', '2015-08-04 12:48:31'),
(1, '8888-8888-88888', '2015-08-04 23:51:45'),
(2, '8888-8888-88888', '2015-08-04 23:58:53'),
(2, '0801-1991-21786', '2015-08-05 02:03:17'),
(1, '0801-1991-21786', '2015-08-05 02:05:27'),
(1, '0801-1990-12345', '2015-08-05 11:14:04'),
(2, '0801-1990-12345', '2015-08-05 11:16:24'),
(4, '0801-1991-77777', '2015-08-12 01:55:15'),
(7, '0801-1991-77777', '2015-08-12 02:10:06'),
(1, '0801-1991-77777', '2015-08-12 02:10:18'),
(2, '0301-1993-04251', '2015-08-12 23:36:26'),
(2, '0301-1990-00604', '2015-08-12 23:37:59'),
(2, '0007-0007-00007', '2015-08-17 13:56:13'),
(7, '0007-0007-00007', '2015-08-17 13:57:12'),
(4, '0007-0007-00007', '2015-08-17 13:57:25'),
(2, '0801-1977-13759', '2015-08-19 09:54:47'),
(6, '0801-1971-10136', '2015-09-11 18:00:51'),
(6, '0801-1987-09326', '2015-09-19 13:13:45');

--
-- Volcado de datos para la tabla `sa_examenes_himno`
--

INSERT INTO `sa_examenes_himno` (`cod_solicitud`, `fecha_solicitud`, `nota_himno`, `fecha_examen_himno`) VALUES
(21, '2015-08-03', '20150803', '0000-00-00'),
(22, '2015-08-04', '20150804', '0000-00-00'),
(23, '2015-08-04', '20150804', '2015-08-06'),
(24, '2015-08-04', '20150804', '0000-00-00'),
(25, '2015-08-04', '20150804', '0000-00-00'),
(26, '2015-08-04', '20150804', '0000-00-00'),
(27, '2015-08-04', '20150804', '0000-00-00'),
(28, '2015-08-04', '20150804', '0000-00-00'),
(29, '2015-08-04', '20150804', '0000-00-00'),
(30, '2015-08-04', '20150804', '2015-08-09'),
(31, '2015-08-05', '20150805', '0000-00-00'),
(32, '2015-08-05', '20150805', '2015-08-14'),
(33, '2015-08-09', NULL, '2015-05-05'),
(34, '2015-08-12', NULL, '2015-10-10'),
(35, '2015-08-19', NULL, '0000-00-00'),
(36, '2015-08-19', NULL, '0000-00-00'),
(37, '2015-08-19', '20150819', '2015-08-19'),
(38, '2015-09-16', '20150916', '0000-00-00');

--
-- Volcado de datos para la tabla `sa_menciones_honorificas`
--

INSERT INTO `sa_menciones_honorificas` (`codigo`, `descripcion`) VALUES
(2, 'Cum Laude'),
(13, 'Magna Cum Laude'),
(11, 'N/A'),
(12, 'Summa Cum Laude');

--
-- Volcado de datos para la tabla `sa_orientaciones`
--

INSERT INTO `sa_orientaciones` (`codigo`, `descripcion`) VALUES
(2, 'Derecho Mercantil'),
(3, 'Ciencias Politicas'),
(4, 'Derechos Humanos'),
(5, 'Derecho Maritimo'),
(8, 'Informática'),
(16, 'N/A'),
(11, 'mercantil'),
(12, 'mercantil2');

--
-- Volcado de datos para la tabla `sa_periodos`
--

INSERT INTO `sa_periodos` (`codigo`, `nombre`) VALUES
(5, 'PruebaAllan'),
(6, 'Segundo Periodo'),
(3, 'Primer periodo'),
(4, 'Tercer Periodo');

--
-- Volcado de datos para la tabla `sa_planes_estudio`
--

INSERT INTO `sa_planes_estudio` (`codigo`, `nombre`, `uv`) VALUES
(1, 'Prueba1', 45),
(8, '', 54),
(15, 'Increible', 56),
(9, 'plan agosto', 50),
(16, 'Nuevo Plan', 20),
(22, 'Plan 2003', NULL),
(23, 'Plan 1978', NULL);

--
-- Volcado de datos para la tabla `sa_solicitudes`
--

INSERT INTO `sa_solicitudes` (`codigo`, `fecha_solicitud`, `observaciones`, `dni_estudiante`, `cod_periodo`, `cod_estado`, `cod_tipo_solicitud`, `cod_solicitud_padre`, `fecha_solicitud_padre`) VALUES
(31, '2015-08-05', NULL, '0801-1991-21784', 1, 1, 1, NULL, NULL),
(32, '2015-08-05', NULL, '0801-1990-12345', 1, 1, 1, NULL, NULL),
(27, '2015-09-04', NULL, '0002-0002-00002', 2, 1, 1, NULL, NULL),
(26, '2015-08-04', NULL, '0002-0002-00002', 2, 2, 1, NULL, NULL),
(33, '2015-08-09', NULL, '0002-0002-00002', 2, 2, 1, 26, NULL),
(34, '2015-08-12', NULL, '0002-0002-00002', 2, 1, 1, 26, NULL),
(35, '2015-08-19', NULL, '0002-0002-00002', 2, 1, 1, 33, NULL),
(36, '2015-08-19', NULL, '0002-0002-00002', 2, 1, 1, 26, NULL),
(37, '2015-08-19', NULL, '0801-1977-13759', 4, 1, 123482, NULL, NULL),
(38, '2015-09-16', NULL, '0801-1959-03859', 4, 1, 123481, NULL, NULL);

--
-- Volcado de datos para la tabla `sa_tipos_estudiante`
--

INSERT INTO `sa_tipos_estudiante` (`codigo`, `descripcion`) VALUES
(1, ''),
(2, 'Doctorado'),
(4, 'Doctorado'),
(6, 'PruebaAllan'),
(7, 'PruebaAllan0'),
(8, 'ghfghfgh'),
(9, 'Pregrado');

--
-- Volcado de datos para la tabla `sa_tipos_solicitud`
--

INSERT INTO `sa_tipos_solicitud` (`codigo`, `nombre`) VALUES
(1, 'Hola1'),
(123483, 'EXAMEN DE HIMNO'),
(123457, 'Hola1'),
(123485, 'Certificación Firma CJG'),
(123459, 'hola mundo'),
(123472, 'Solicitud 5'),
(123461, 'nuevaSolicitud'),
(123467, 'Editando tipos'),
(123469, 'Prueba sistema'),
(123468, 'urgentes'),
(123481, 'himno2'),
(123480, 'tipo de solicitud'),
(123478, 'Solicitud 3'),
(123479, 'PruebaAllan'),
(123482, 'GRE'),
(123484, 'EXPEDIENTE DE GRADUACIÓN'),
(123486, 'Solicitud Constancia de Egresado');

--
-- Volcado de datos para la tabla `sa_tipos_solicitud_tipos_alumnos`
--

INSERT INTO `sa_tipos_solicitud_tipos_alumnos` (`cod_tipo_solicitud`, `cod_tipo_alumno`) VALUES
(1, 1),
(123478, 1),
(123479, 1),
(123480, 2),
(123481, 2),
(123482, 2),
(123483, 1),
(123484, 6),
(123485, 1),
(123486, 1);

--
-- Volcado de datos para la tabla `seguimiento`
--

INSERT INTO `seguimiento` (`Id_Seguimiento`, `NroFolio`, `UsuarioAsignado`, `Notas`, `Prioridad`, `FechaInicio`, `FechaFinal`, `EstadoSeguimiento`) VALUES
(2, '123123', 4, 'd', 5, '2015-08-23 20:41:23', NULL, 8),
(3, '123', 3, 'ninguna', 6, '2015-09-02 18:33:03', NULL, 11),
(4, 'folio de prueba', NULL, 'prueba', 5, '2015-09-10 18:54:45', NULL, 9),
(5, '20', 5, 'PRUEBA', 5, '2015-09-11 23:38:35', NULL, 11),
(6, 'Oficio 120', 9, 'faltan documentos de soporte', 5, '2015-09-22 23:02:50', NULL, 11),
(7, '002', 6, 'en proceso de aprobación', 6, '2015-09-25 19:01:07', NULL, 11);

--
-- Volcado de datos para la tabla `seguimiento_historico`
--

INSERT INTO `seguimiento_historico` (`Id_SeguimientoHistorico`, `Id_Seguimiento`, `Id_Estado_Seguimiento`, `Notas`, `Prioridad`, `FechaCambio`) VALUES
(2, 2, 8, 'Nota', 5, '2015-08-23 14:40:32'),
(3, 2, 8, 'd', 5, '2015-08-23 14:41:23'),
(4, 3, 11, 'ninguna', 6, '2015-09-02 12:33:03'),
(5, 4, 9, 'prueba', 5, '2015-09-10 12:54:45'),
(6, 5, 11, 'PRUEBA', 5, '2015-09-11 17:38:35'),
(7, 6, 11, 'faltan documentos de soporte', 5, '2015-09-22 17:02:50'),
(8, 7, 11, 'en proceso de aprobación', 6, '2015-09-25 13:01:07');

--
-- Volcado de datos para la tabla `sub_actividad`
--

INSERT INTO `sub_actividad` (`id_sub_Actividad`, `idActividad`, `nombre`, `descripcion`, `fecha_monitoreo`, `id_Encargado`, `ponderacion`, `costo`, `observacion`) VALUES
(1, 11, 'subactividad de septiembre', 'desc subactividad de septiembre', '2015-09-10', '12969', 10, 10000, 'observacion septiembre sub');

--
-- Volcado de datos para la tabla `telefono`
--

INSERT INTO `telefono` (`ID_Telefono`, `Tipo`, `Numero`, `N_identidad`) VALUES
(5, 'celular', '9999-9999', '0801-1991-06974'),
(6, 'fijo', '2222-2222', '0801-1991-06974'),
(7, 'celular', '3394-4311', '1211-1980-00001'),
(8, 'celular', '32950542', '0801-1985-18347'),
(9, NULL, '9999-9999', '0801-1959-03859'),
(10, NULL, '9999-9999', '0501-0501-05010'),
(11, 'celular', '32055020', '0000-0000-00178'),
(12, NULL, '9913-2938', '0801-1990-77778'),
(13, NULL, '3333-3333', '0802-1991-33333'),
(14, NULL, '9999-9999', '0801-1991-21784'),
(15, NULL, '2222-2222', '0801-1991-21785'),
(16, NULL, '9999-9999', '0002-0002-00002'),
(17, NULL, '9999-9999', '8888-8888-88888'),
(18, NULL, '9999-9999', '0801-1991-21786'),
(19, NULL, '3645-4522', '0801-1990-12345'),
(20, NULL, '9999-9999', '0801-1991-77777'),
(21, NULL, '9832-2008', '0301-1993-04251'),
(22, NULL, '3340-3008', '0301-1990-00604'),
(23, NULL, '9999-9999', '0007-0007-00007'),
(24, NULL, '9710-9201', '0801-1977-13759'),
(25, NULL, '3280-1140', '0801-1971-10136'),
(26, NULL, '9916-2002', '0801-1987-09326');

--
-- Volcado de datos para la tabla `tipo_area`
--

INSERT INTO `tipo_area` (`id_Tipo_Area`, `nombre`, `observaciones`) VALUES
(2, 'prueba', 'prueba15'),
(5, 'tipo de area septiembre', '');

--
-- Volcado de datos para la tabla `tipo_estudio`
--

INSERT INTO `tipo_estudio` (`ID_Tipo_estudio`, `Tipo_estudio`) VALUES
(10, 'Especialidad'),
(9, 'Maestria'),
(3, 'Doctorado'),
(8, 'Licenciatura'),
(11, 'PERITO'),
(12, 'BACHILLER'),
(13, 'TECNICO');

--
-- Volcado de datos para la tabla `titulo`
--

INSERT INTO `titulo` (`id_titulo`, `titulo`) VALUES
(9, 'Administración Empresarial'),
(8, 'Matematicas'),
(6, 'Medicina'),
(7, 'Abogado'),
(10, 'Ciencias Juridicas'),
(11, 'PERITO MERCANTIL'),
(12, ' CIENCIAS Y LETRAS'),
(13, 'INDUSTRIAL'),
(14, 'INFORMATICA ADMINISTRATIVA'),
(15, 'NUTRICION'),
(16, 'ADMINISTRACION DE EMPRESAS'),
(17, 'FILOSOFIA'),
(18, 'PEDAGOGIA'),
(19, 'DERECHO'),
(20, 'DERECHOS HUMANOS'),
(21, 'TRABAJO SOCIAL'),
(22, 'PSICOLOGÍA'),
(23, 'DERECHO TRIBUTARIO'),
(24, 'DERECHO PROCESAL PENAL'),
(25, 'CRIMINOLOGIA');

--
-- Volcado de datos para la tabla `ubicacion_archivofisico`
--

INSERT INTO `ubicacion_archivofisico` (`Id_UbicacionArchivoFisico`, `DescripcionUbicacionFisica`, `Capacidad`, `TotalIngresados`, `HabilitadoParaAlmacenar`) VALUES
(6, 'documentos', 300, 2000, 1),
(5, 'EDIFICIO PRUEBA', 20, 30, 1);

--
-- Volcado de datos para la tabla `ubicacion_notificaciones`
--

INSERT INTO `ubicacion_notificaciones` (`Id_UbicacionNotificaciones`, `DescripcionUbicacionNotificaciones`) VALUES
(7, 'Espere un momento'),
(6, 'PRUEBA');

--
-- Volcado de datos para la tabla `unidad_academica`
--

INSERT INTO `unidad_academica` (`Id_UnidadAcademica`, `NombreUnidadAcademica`, `UbicacionUnidadAcademica`) VALUES
(4, 'unidad academica septiembre', 'A2'),
(3, 'FAMILIA', 'A-2');

--
-- Volcado de datos para la tabla `universidad`
--

INSERT INTO `universidad` (`Id_universidad`, `nombre_universidad`, `Id_pais`) VALUES
(8, 'UNIVERSIDAD CATÓLICA DE HONDURAS', 2),
(4, 'Universidad Pedagógica Francisco Morazan', 2),
(12, 'UNAH', 2),
(6, 'UNITEC', 2),
(9, 'CENTRO DE DISEÑO ARQUITECTURA Y CONSTRUCCION', 2),
(10, 'UTH ', 2),
(11, 'UNIVERSIDAD JOSÉ CECILIO DEL VALLE', 2),
(13, 'UNIVERSIDAD METROPOLITANA DE HONDURAS', 2),
(14, 'UNIVERSIDAD POLITECNICA DE INGENIERIA DE HONDURAS', 2),
(15, 'CEUTEC', 2),
(16, 'ESCUELA AGRICOLA PANAMERICANA ZAMORANO', 2),
(17, 'ESCUELA NACIONAL DE CIENCIAS FORESTALES', 2),
(18, 'UNIVERSIDAD DE SAN PEDRO SULA', 2),
(19, 'UNIVERSIDAD NACIONAL DE AGRICULTURA', 2),
(20, 'UNIVERSIDAD CRISTIANA DE HONDURAS', 2),
(21, 'INCAE BUSINESS SCHOOL', 2);

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_Usuario`, `No_Empleado`, `nombre`, `Password`, `Id_Rol`, `Fecha_Creacion`, `Fecha_Alta`, `Estado`, `esta_logueado`) VALUES
(1, '123444', 'prueba', 0x3831444637443233344633423846353438374146353038433243373942303041, 100, '2015-07-06', NULL, 1, 0),
(2, '123444', 'lmrd1', 0x4334343432303341463343313144324633424638343431374636334344333342, 100, '2015-07-28', NULL, 1, 0),
(3, '12968', 'elizabeth', 0x3938434430463341433330434338463533333338364546344135463244413339, 100, '2015-07-29', NULL, 1, 0),
(4, '12969', 'jorgeaguilar', 0x4637463839324138413446413633443635354334393833313736454645383542, 100, '2015-07-29', NULL, 1, 0),
(5, '8708', 'anamoncada', 0x3534324233384344393434323239323243343243364636433243323734363734, 100, '2015-07-30', NULL, 1, 0),
(6, '00001', 'secretaria', 0x3534463031304337413430433141413034463939383644323144333431354344, 40, '2015-08-04', NULL, 1, 0),
(7, '00003', 'secretariadeca', 0x3531323846424442423931384146363042313635353736433733353930443539, 45, '2015-08-04', NULL, 1, 0),
(8, '00004', 'asistente', 0x4234324430303842394445344634343031453343443331454339343843354442, 29, '2015-08-04', NULL, 1, 0),
(9, '00005', 'decana', 0x4239464346394331313536423143354431433130383230464345364438343643, 50, '2015-08-04', NULL, 1, 0),
(10, '12969', 'Docente', 0x3136373232363238333142354145424634414443374541463837394344423437, 20, '2015-08-10', NULL, 1, 0),
(11, '12344', 'Liduvina', 0x4245394437344631414136453145373046463941303535323536324230454535, 40, '2015-09-02', '2015-09-03', 0, 0),
(12, '6558', 'bessynazar', 0x3335383639443332313542424242443336303846323138343537344543443834, 50, '2015-09-03', NULL, 1, 0),
(13, '5548', 'gloriaoseguera', 0x4141393939373443413536373244433238324335363846364234363346323236, 45, '2015-09-03', NULL, 1, 0),
(14, '3089', 'mariamaradiaga', 0x4246433542314442313730464235343841463445434637344132334342373132, 40, '2015-09-03', NULL, 1, 0),
(15, '11022', 'carlosburgos', 0x3142344630413545433942344636413344394534414335333537313243453230, 10, '2015-09-03', NULL, 1, 0),
(16, '7908', 'jhonnymembreno', 0x3042304138364245334543343739383538453742303839354139394530363031, 10, '2015-09-03', NULL, 1, 0),
(17, '01', 'monicadormes', 0x4341394335364533393834313041323844303343423942433833343032413239, 40, '2015-09-03', NULL, 1, 0),
(18, '11910', 'evelincanaca', 0x3331433135313943324334433839323238353643333739383739413438364336, 10, '2015-09-03', NULL, 1, 0);

--
-- Volcado de datos para la tabla `usuario_log`
--

INSERT INTO `usuario_log` (`Id_log`, `usuario`, `fecha_log`, `ip_conn`) VALUES
(141, 1, '2015-07-07 02:51:30', '::1'),
(142, 1, '2015-07-07 03:04:21', '::1'),
(143, 1, '2015-07-07 04:04:10', '::1'),
(144, 1, '2015-07-09 06:56:43', '::1'),
(145, 1, '2015-07-09 06:57:10', '::1'),
(146, 1, '2015-07-09 07:24:43', '::1'),
(147, 1, '2015-07-09 07:26:32', '192.168.0.16'),
(148, 1, '2015-07-09 07:28:15', '192.168.0.22'),
(149, 1, '2015-07-09 07:28:15', '192.168.0.22'),
(150, 1, '2015-07-09 07:28:35', '192.168.0.5'),
(151, 1, '2015-07-09 07:30:48', '::1'),
(152, 1, '2015-07-09 07:51:35', '::1'),
(153, 1, '2015-07-09 07:57:15', '192.168.0.5'),
(154, 1, '2015-07-09 08:21:13', '192.168.0.5'),
(155, 1, '2015-07-09 08:36:33', '::1'),
(156, 1, '2015-07-09 08:38:30', '192.168.0.22'),
(157, 1, '2015-07-09 08:38:30', '192.168.0.22'),
(158, 1, '2015-07-09 08:51:17', '::1'),
(159, 1, '2015-07-09 08:52:33', '::1'),
(160, 1, '2015-07-09 08:56:41', '::1'),
(161, 1, '2015-07-09 09:03:03', '::1'),
(162, 1, '2015-07-09 09:12:31', '192.168.0.16'),
(163, 1, '2015-07-09 09:39:38', '192.168.0.5'),
(164, 1, '2015-07-09 09:39:43', '::1'),
(165, 1, '2015-07-09 09:41:58', '::1'),
(166, 1, '2015-07-09 10:02:15', '::1'),
(167, 1, '2015-07-09 10:04:13', '::1'),
(168, 1, '2015-07-09 10:12:55', '192.168.0.16'),
(169, 1, '2015-07-09 10:16:36', '::1'),
(170, 1, '2015-07-09 10:56:39', '::1'),
(171, 1, '2015-07-09 11:02:08', '::1'),
(172, 1, '2015-07-09 11:02:30', '::1'),
(173, 1, '2015-07-09 11:04:00', '192.168.0.5'),
(174, 1, '2015-07-09 11:18:57', '192.168.0.22'),
(175, 1, '2015-07-09 11:18:57', '192.168.0.22'),
(176, 1, '2015-07-09 11:27:48', '::1'),
(177, 1, '2015-07-09 11:29:21', '::1'),
(178, 1, '2015-07-09 11:49:38', '::1'),
(179, 1, '2015-07-09 12:00:41', '192.168.0.16'),
(180, 1, '2015-07-09 12:01:42', '::1'),
(181, 1, '2015-07-09 12:02:04', '192.168.0.5'),
(182, 1, '2015-07-09 12:02:26', '192.168.0.22'),
(183, 1, '2015-07-09 12:02:26', '192.168.0.22'),
(184, 1, '2015-07-09 12:08:44', '::1'),
(185, 1, '2015-07-09 12:18:06', '192.168.0.5'),
(186, 1, '2015-07-09 12:18:12', '::1'),
(187, 1, '2015-07-09 12:45:05', '192.168.0.5'),
(188, 1, '2015-07-09 12:47:44', '192.168.0.5'),
(189, 1, '2015-07-09 13:20:58', '::1'),
(190, 1, '2015-07-09 13:26:23', '192.168.0.22'),
(191, 1, '2015-07-09 13:26:23', '192.168.0.22'),
(192, 1, '2015-07-10 01:40:06', '::1'),
(193, 1, '2015-07-11 04:31:00', '::1'),
(194, 1, '2015-07-11 06:01:37', '::1'),
(195, 1, '2015-07-11 06:09:46', '192.168.0.23'),
(196, 1, '2015-07-11 06:11:58', '192.168.0.22'),
(197, 1, '2015-07-11 06:24:10', '192.168.0.23'),
(198, 1, '2015-07-11 06:35:04', '192.168.0.23'),
(199, 1, '2015-07-11 06:58:32', '192.168.0.22'),
(200, 1, '2015-07-11 07:23:49', '192.168.0.23'),
(201, 1, '2015-07-11 07:28:53', '::1'),
(202, 1, '2015-07-11 07:30:48', '192.168.0.22'),
(203, 1, '2015-07-11 07:31:35', '192.168.0.23'),
(204, 1, '2015-07-11 07:38:27', '192.168.0.17'),
(205, 1, '2015-07-11 07:38:27', '192.168.0.17'),
(206, 1, '2015-07-11 07:58:12', '192.168.0.17'),
(207, 1, '2015-07-11 07:58:13', '192.168.0.17'),
(208, 1, '2015-07-11 08:03:01', '::1'),
(209, 1, '2015-07-11 08:34:38', '192.168.0.23'),
(210, 1, '2015-07-11 08:46:38', '192.168.0.23'),
(211, 1, '2015-07-11 08:47:36', '192.168.0.17'),
(212, 1, '2015-07-11 08:47:36', '192.168.0.17'),
(213, 1, '2015-07-11 09:03:51', '::1'),
(214, 1, '2015-07-11 09:09:40', '192.168.0.23'),
(215, 1, '2015-07-11 09:19:33', '192.168.0.22'),
(216, 1, '2015-07-11 09:22:06', '192.168.0.17'),
(217, 1, '2015-07-11 09:22:06', '192.168.0.17'),
(218, 1, '2015-07-11 09:33:52', '192.168.0.24'),
(219, 1, '2015-07-11 09:43:37', '192.168.0.23'),
(220, 1, '2015-07-11 09:54:41', '192.168.0.24'),
(221, 1, '2015-07-11 09:54:57', '192.168.0.17'),
(222, 1, '2015-07-11 09:54:57', '192.168.0.17'),
(223, 1, '2015-07-11 10:21:12', '192.168.0.24'),
(224, 1, '2015-07-11 10:45:03', '192.168.0.23'),
(225, 1, '2015-07-11 10:48:12', '192.168.0.22'),
(226, 1, '2015-07-11 11:17:30', '192.168.0.17'),
(227, 1, '2015-07-11 11:17:30', '192.168.0.17'),
(228, 1, '2015-07-11 11:20:43', '::1'),
(229, 1, '2015-07-11 11:26:21', '::1'),
(230, 1, '2015-07-11 11:31:27', '192.168.0.24'),
(231, 1, '2015-07-11 11:43:26', '::1'),
(232, 1, '2015-07-11 11:45:08', '192.168.0.22'),
(233, 1, '2015-07-11 12:07:47', '192.168.0.22'),
(234, 1, '2015-07-11 12:21:10', '192.168.0.24'),
(235, 1, '2015-07-11 13:01:08', '192.168.0.17'),
(236, 1, '2015-07-11 13:01:08', '192.168.0.17'),
(237, 1, '2015-07-11 13:03:38', '192.168.0.24'),
(258, 1, '2015-07-27 02:15:50', '201.190.18.72'),
(259, 1, '2015-07-27 02:17:39', '190.5.79.106'),
(260, 1, '2015-07-27 02:20:44', '190.5.79.106'),
(261, 1, '2015-07-27 02:51:04', '190.5.79.106'),
(262, 1, '2015-07-27 05:51:27', '190.92.55.20'),
(263, 1, '2015-07-27 06:25:10', '186.32.234.114'),
(264, 1, '2015-07-27 18:33:13', '10.8.73.76'),
(265, 1, '2015-07-27 22:21:02', '190.4.63.222'),
(266, 1, '2015-07-27 22:21:36', '186.32.247.135'),
(267, 1, '2015-07-28 00:11:50', '10.8.92.227'),
(268, 1, '2015-07-28 00:33:16', '10.8.92.227'),
(269, 1, '2015-07-28 06:12:45', '186.2.144.142'),
(270, 1, '2015-07-28 07:06:14', '190.92.55.101'),
(271, 1, '2015-07-28 07:06:17', '190.56.253.178'),
(272, 1, '2015-07-28 07:23:01', '190.211.137.19'),
(273, 1, '2015-07-28 07:37:33', '190.53.87.229'),
(274, 1, '2015-07-28 16:25:02', '10.8.44.151'),
(275, 1, '2015-07-28 16:50:11', '10.8.44.244'),
(276, 1, '2015-07-28 17:01:23', '190.5.79.106'),
(277, 1, '2015-07-28 17:02:58', '190.5.79.106'),
(278, 1, '2015-07-28 18:30:10', '10.8.44.244'),
(279, 1, '2015-07-28 19:13:12', '10.8.44.214'),
(280, 1, '2015-07-28 19:15:02', '10.8.44.156'),
(281, 1, '2015-07-28 19:47:05', '10.8.44.244'),
(282, 1, '2015-07-28 21:12:40', '10.8.44.244'),
(283, 1, '2015-07-28 21:17:14', '10.8.44.151'),
(284, 1, '2015-07-28 21:36:43', '10.8.44.151'),
(285, 1, '2015-07-28 22:17:51', '186.2.136.25'),
(286, 1, '2015-07-28 22:42:47', '10.8.44.151'),
(287, 1, '2015-07-28 23:51:51', '10.8.44.239'),
(288, 1, '2015-07-29 00:33:39', '10.8.44.244'),
(289, 1, '2015-07-29 00:53:03', '10.8.44.244'),
(290, 1, '2015-07-29 01:52:14', '190.5.79.106'),
(291, 1, '2015-07-29 01:54:41', '190.5.79.106'),
(292, 1, '2015-07-29 06:40:05', '190.56.253.52'),
(293, 1, '2015-07-29 16:39:38', '10.8.92.181'),
(294, 1, '2015-07-29 17:03:26', '10.8.92.135'),
(295, 1, '2015-07-29 17:26:18', '10.8.44.151'),
(296, 1, '2015-07-29 17:28:08', '10.8.44.244'),
(297, 1, '2015-07-29 17:57:06', '10.8.44.151'),
(298, 1, '2015-07-29 18:30:30', '10.8.44.151'),
(299, 1, '2015-07-29 19:44:51', '10.8.44.151'),
(300, 1, '2015-07-29 22:19:30', '10.8.44.151'),
(301, 4, '2015-07-29 22:23:56', '10.8.44.151'),
(302, 1, '2015-07-29 23:05:56', '10.8.44.151'),
(303, 4, '2015-07-29 23:11:20', '10.8.44.151'),
(304, 1, '2015-07-30 01:29:35', '190.181.223.15'),
(305, 1, '2015-07-30 01:41:36', '190.181.223.15'),
(306, 1, '2015-07-30 16:43:47', '10.8.44.151'),
(307, 4, '2015-07-30 16:58:17', '10.8.44.96'),
(308, 1, '2015-07-30 17:15:33', '10.8.44.151'),
(309, 1, '2015-07-30 17:35:21', '10.8.44.151'),
(310, 4, '2015-07-30 17:36:33', '10.8.44.151'),
(311, 4, '2015-07-30 18:00:26', '10.8.44.151'),
(312, 4, '2015-07-30 18:36:35', '10.8.44.151'),
(313, 1, '2015-07-30 18:47:10', '10.8.44.151'),
(314, 1, '2015-07-30 18:47:26', '190.130.23.12'),
(315, 4, '2015-07-30 19:22:01', '10.8.44.151'),
(316, 1, '2015-07-30 19:22:36', '10.8.44.151'),
(317, 4, '2015-07-30 19:32:54', '10.8.44.151'),
(318, 4, '2015-07-30 21:18:37', '10.8.44.151'),
(319, 1, '2015-07-30 21:48:52', '10.8.44.31'),
(320, 5, '2015-07-30 21:55:48', '10.8.44.31'),
(321, 1, '2015-07-31 17:58:45', '201.190.18.250'),
(322, 1, '2015-07-31 18:23:16', '201.190.18.250'),
(323, 1, '2015-07-31 20:18:07', '201.190.18.250'),
(324, 1, '2015-07-31 22:19:56', '201.190.18.250'),
(325, 1, '2015-07-31 22:28:41', '201.190.18.250'),
(326, 1, '2015-07-31 23:39:35', '201.190.18.250'),
(327, 1, '2015-08-01 01:19:42', '190.92.55.79'),
(328, 1, '2015-08-01 02:45:59', '190.181.197.101'),
(329, 1, '2015-08-02 04:36:38', '190.211.137.59'),
(330, 1, '2015-08-02 08:01:14', '190.211.137.59'),
(331, 1, '2015-08-02 18:16:08', '190.5.79.106'),
(332, 4, '2015-08-03 04:14:06', '161.0.213.124'),
(333, 1, '2015-08-03 17:47:32', '10.8.92.135'),
(334, 1, '2015-08-04 01:30:35', '181.209.246.37'),
(335, 1, '2015-08-04 02:55:29', '190.5.79.106'),
(336, 1, '2015-08-04 04:44:39', '181.209.246.37'),
(337, 1, '2015-08-04 04:46:27', '190.211.137.101'),
(338, 1, '2015-08-04 05:13:36', '190.92.55.100'),
(339, 1, '2015-08-04 05:14:00', '181.209.246.37'),
(340, 1, '2015-08-04 05:31:55', '190.181.223.15'),
(341, 1, '2015-08-04 06:31:35', '190.92.55.100'),
(342, 1, '2015-08-04 08:25:14', '190.211.137.101'),
(343, 1, '2015-08-04 09:15:57', '190.211.137.101'),
(344, 1, '2015-08-04 16:50:15', '10.8.44.111'),
(345, 1, '2015-08-04 17:41:12', '10.8.44.111'),
(346, 1, '2015-08-04 17:45:16', '10.8.92.42'),
(347, 6, '2015-08-04 17:53:49', '10.8.44.111'),
(348, 1, '2015-08-04 18:01:20', '146.185.28.59'),
(349, 1, '2015-08-04 18:19:52', '10.8.44.111'),
(350, 6, '2015-08-04 18:34:15', '10.8.44.111'),
(351, 6, '2015-08-04 19:04:18', '146.185.28.59'),
(352, 6, '2015-08-04 21:18:59', '10.8.44.68'),
(353, 6, '2015-08-04 22:18:48', '10.8.44.68'),
(354, 6, '2015-08-04 22:39:29', '10.8.44.68'),
(355, 6, '2015-08-05 00:50:20', '10.8.44.68'),
(356, 1, '2015-08-05 01:10:12', '190.181.223.15'),
(357, 1, '2015-08-05 01:16:11', '10.8.44.68'),
(358, 7, '2015-08-05 01:18:50', '10.8.44.68'),
(359, 1, '2015-08-05 01:19:14', '10.8.44.68'),
(360, 7, '2015-08-05 01:20:03', '10.8.44.68'),
(361, 1, '2015-08-05 01:20:19', '10.8.44.68'),
(362, 8, '2015-08-05 01:22:37', '10.8.44.68'),
(363, 1, '2015-08-05 01:23:24', '10.8.44.68'),
(364, 9, '2015-08-05 01:27:17', '10.8.44.68'),
(365, 1, '2015-08-05 01:51:52', '181.209.246.148'),
(366, 1, '2015-08-05 01:54:38', '181.209.246.148'),
(367, 1, '2015-08-05 02:05:39', '181.209.246.148'),
(368, 1, '2015-08-05 04:37:18', '181.209.246.54'),
(369, 1, '2015-08-05 05:13:08', '190.92.55.46'),
(370, 1, '2015-08-05 05:13:30', '181.209.246.54'),
(371, 1, '2015-08-05 05:28:38', '190.211.137.69'),
(372, 1, '2015-08-05 05:35:17', '181.209.246.54'),
(373, 1, '2015-08-05 05:39:28', '181.209.246.54'),
(374, 1, '2015-08-05 05:44:57', '190.92.55.46'),
(375, 1, '2015-08-05 05:44:59', '190.211.137.69'),
(376, 1, '2015-08-05 06:11:38', '190.211.137.69'),
(377, 1, '2015-08-05 06:32:18', '181.209.246.54'),
(378, 1, '2015-08-05 07:42:52', '190.211.137.69'),
(379, 1, '2015-08-05 13:19:47', '190.92.55.38'),
(380, 1, '2015-08-05 16:20:01', '190.56.253.90'),
(381, 1, '2015-08-08 05:20:40', '190.211.137.35'),
(382, 1, '2015-08-08 16:46:47', '181.209.246.130'),
(383, 1, '2015-08-08 17:54:51', '181.209.246.130'),
(384, 1, '2015-08-08 18:23:41', '181.209.246.130'),
(385, 1, '2015-08-08 21:23:22', '190.53.87.229'),
(386, 1, '2015-08-08 22:22:22', '181.209.246.48'),
(387, 1, '2015-08-09 01:16:16', '190.211.137.64'),
(388, 1, '2015-08-09 01:16:16', '190.211.137.64'),
(389, 1, '2015-08-09 06:58:27', '190.211.137.64'),
(390, 1, '2015-08-09 19:16:14', '190.181.223.15'),
(391, 1, '2015-08-09 22:27:02', '190.181.223.15'),
(392, 1, '2015-08-09 22:28:34', '190.211.137.57'),
(393, 1, '2015-08-09 22:36:17', '201.190.18.15'),
(394, 1, '2015-08-09 23:58:31', '181.210.54.194'),
(395, 1, '2015-08-10 01:00:08', '181.209.246.130'),
(396, 1, '2015-08-10 01:35:19', '181.209.246.130'),
(397, 1, '2015-08-10 01:45:54', '181.210.54.194'),
(398, 1, '2015-08-10 02:58:22', '201.190.18.15'),
(399, 1, '2015-08-10 03:12:13', '181.209.246.130'),
(400, 1, '2015-08-10 03:29:13', '181.210.54.194'),
(401, 1, '2015-08-10 03:59:32', '181.210.54.194'),
(402, 1, '2015-08-10 04:50:49', '201.190.18.136'),
(403, 1, '2015-08-10 04:50:50', '201.190.18.136'),
(404, 1, '2015-08-10 04:57:22', '181.209.246.130'),
(405, 1, '2015-08-10 05:01:51', '181.209.246.130'),
(406, 1, '2015-08-10 20:36:47', '10.10.16.35'),
(407, 1, '2015-08-10 21:32:53', '10.8.44.39'),
(408, 4, '2015-08-10 21:48:02', '10.8.44.39'),
(409, 1, '2015-08-10 21:51:20', '10.8.44.39'),
(410, 4, '2015-08-10 21:56:53', '10.8.44.39'),
(411, 1, '2015-08-10 22:01:48', '10.8.44.39'),
(412, 1, '2015-08-10 22:01:49', '10.8.44.39'),
(413, 9, '2015-08-10 22:06:28', '10.8.44.39'),
(414, 1, '2015-08-10 22:23:30', '10.8.44.39'),
(415, 9, '2015-08-10 22:34:34', '10.8.44.39'),
(416, 1, '2015-08-10 22:47:22', '10.8.44.39'),
(417, 10, '2015-08-10 22:50:43', '10.8.44.39'),
(418, 9, '2015-08-10 22:51:47', '10.8.44.39'),
(419, 9, '2015-08-10 23:05:32', '10.8.44.39'),
(420, 9, '2015-08-10 23:28:52', '10.8.44.39'),
(421, 1, '2015-08-10 23:29:36', '10.8.44.39'),
(422, 9, '2015-08-10 23:29:55', '10.8.44.39'),
(423, 1, '2015-08-11 01:27:02', '190.56.253.19'),
(424, 1, '2015-08-11 05:28:09', '190.56.253.19'),
(425, 1, '2015-08-11 05:54:13', '190.211.137.69'),
(426, 9, '2015-08-11 16:53:40', '10.8.44.39'),
(427, 1, '2015-08-11 17:55:54', '10.10.16.30'),
(428, 1, '2015-08-12 04:40:39', '186.2.138.212'),
(429, 1, '2015-08-12 05:24:19', '201.190.18.72'),
(430, 1, '2015-08-12 06:17:23', '186.2.138.63'),
(431, 1, '2015-08-12 07:43:32', '186.2.138.63'),
(432, 4, '2015-08-12 16:33:36', '10.8.44.39'),
(433, 1, '2015-08-12 17:48:42', '10.8.44.39'),
(434, 9, '2015-08-12 17:49:39', '10.8.44.39'),
(435, 1, '2015-08-12 20:54:42', '181.209.246.193'),
(436, 1, '2015-08-13 05:33:09', '201.190.18.15'),
(437, 1, '2015-08-17 17:01:36', '10.8.44.110'),
(438, 1, '2015-08-17 17:37:50', '10.8.44.39'),
(439, 9, '2015-08-17 18:03:17', '10.8.44.39'),
(440, 9, '2015-08-17 18:21:01', '10.8.44.39'),
(441, 1, '2015-08-17 18:59:38', '23.235.227.108'),
(442, 6, '2015-08-17 19:02:06', '23.235.227.108'),
(443, 9, '2015-08-17 19:02:19', '10.8.44.39'),
(444, 6, '2015-08-17 19:06:03', '10.8.44.110'),
(445, 6, '2015-08-17 19:07:09', '23.235.227.108'),
(446, 6, '2015-08-17 19:31:54', '10.8.44.110'),
(447, 9, '2015-08-17 19:40:45', '10.8.44.39'),
(448, 9, '2015-08-17 19:43:17', '10.8.44.39'),
(449, 6, '2015-08-17 19:53:27', '23.235.227.108'),
(450, 9, '2015-08-17 21:22:42', '10.8.44.39'),
(451, 1, '2015-08-17 21:23:03', '23.235.227.108'),
(452, 1, '2015-08-17 21:24:19', '10.8.44.110'),
(453, 1, '2015-08-17 21:39:00', '23.235.227.108'),
(454, 9, '2015-08-17 22:02:44', '10.8.44.39'),
(455, 9, '2015-08-17 22:35:21', '23.235.227.108'),
(456, 9, '2015-08-17 22:48:06', '10.8.44.110'),
(457, 1, '2015-08-17 22:54:45', '23.235.227.108'),
(458, 9, '2015-08-17 22:57:45', '23.235.227.108'),
(459, 1, '2015-08-17 22:59:20', '23.235.227.108'),
(460, 9, '2015-08-17 23:12:10', '23.235.227.108'),
(461, 1, '2015-08-19 05:40:15', '190.56.253.255'),
(462, 1, '2015-08-19 13:16:28', '190.211.137.86'),
(463, 1, '2015-08-19 15:47:44', '10.10.40.238'),
(464, 1, '2015-08-19 15:52:09', '10.10.40.238'),
(465, 1, '2015-08-19 16:18:14', '10.10.40.238'),
(466, 1, '2015-08-19 16:50:11', '10.10.40.238'),
(467, 1, '2015-08-19 20:13:30', '10.8.44.39'),
(468, 1, '2015-08-20 19:51:47', '201.190.18.72'),
(469, 1, '2015-08-21 07:41:37', '201.190.18.107'),
(470, 1, '2015-08-21 07:41:50', '201.190.18.107'),
(471, 1, '2015-08-21 21:55:00', '190.211.137.88'),
(472, 1, '2015-08-22 02:21:55', '190.92.55.16'),
(473, 1, '2015-08-22 07:37:32', '190.92.55.16'),
(474, 1, '2015-08-22 18:30:50', '201.190.18.200'),
(475, 1, '2015-08-22 18:31:56', '190.92.55.115'),
(476, 1, '2015-08-22 19:43:07', '186.2.138.222'),
(477, 1, '2015-08-22 23:26:35', '186.2.139.77'),
(478, 1, '2015-08-23 00:39:42', '190.92.55.113'),
(479, 1, '2015-08-23 17:02:41', '190.92.55.19'),
(480, 1, '2015-08-23 19:26:15', '190.181.223.15'),
(481, 1, '2015-08-23 19:32:31', '181.210.54.194'),
(482, 1, '2015-08-23 19:59:58', '190.92.55.19'),
(483, 1, '2015-08-23 20:25:34', '190.181.223.15'),
(484, 1, '2015-08-23 20:27:17', '190.181.223.15'),
(485, 1, '2015-08-23 20:52:37', '190.211.137.9'),
(486, 1, '2015-08-23 21:07:22', '190.181.223.15'),
(487, 1, '2015-08-23 21:23:48', '186.2.138.131'),
(488, 1, '2015-08-23 22:04:11', '190.211.137.9'),
(489, 1, '2015-08-23 23:17:49', '190.56.253.201'),
(490, 1, '2015-08-24 05:07:08', '190.53.87.229'),
(491, 1, '2015-08-24 05:48:34', '201.190.18.200'),
(492, 1, '2015-08-24 05:49:16', '186.32.234.114'),
(493, 1, '2015-08-24 05:55:07', '190.56.253.77'),
(494, 1, '2015-08-24 05:58:51', '201.190.18.200'),
(495, 1, '2015-08-24 05:58:51', '201.190.18.200'),
(496, 1, '2015-08-24 05:59:02', '186.2.138.232'),
(497, 1, '2015-08-24 06:10:06', '190.53.87.229'),
(498, 1, '2015-08-24 15:42:41', '186.2.138.134'),
(499, 1, '2015-08-25 08:45:11', '186.32.234.114'),
(500, 1, '2015-08-25 21:19:54', '10.10.43.222'),
(501, 1, '2015-08-28 16:32:00', '201.190.18.107'),
(502, 1, '2015-08-31 03:40:32', '190.211.137.96'),
(503, 1, '2015-09-01 18:23:02', '10.8.44.56'),
(504, 1, '2015-09-01 18:23:08', '10.8.44.56'),
(505, 1, '2015-09-01 18:38:21', '10.8.44.140'),
(506, 1, '2015-09-01 18:38:46', '10.8.44.246'),
(507, 1, '2015-09-01 18:38:54', '10.8.44.205'),
(508, 1, '2015-09-01 18:59:51', '10.8.44.56'),
(509, 1, '2015-09-01 19:05:09', '10.8.44.56'),
(510, 1, '2015-09-01 19:05:09', '10.8.44.174'),
(511, 1, '2015-09-01 19:18:23', '10.8.2.15'),
(512, 1, '2015-09-01 19:22:15', '10.8.2.158'),
(513, 1, '2015-09-01 19:40:02', '10.8.44.214'),
(514, 1, '2015-09-01 19:43:01', '10.8.44.214'),
(515, 1, '2015-09-01 19:43:44', '10.8.44.246'),
(516, 1, '2015-09-01 20:32:14', '161.0.213.124'),
(517, 1, '2015-09-01 20:59:27', '23.235.227.108'),
(518, 1, '2015-09-01 21:36:17', '10.8.44.39'),
(519, 1, '2015-09-01 23:14:55', '23.235.227.108'),
(520, 1, '2015-09-02 16:21:18', '23.235.227.108'),
(521, 1, '2015-09-02 16:37:07', '23.235.227.108'),
(522, 9, '2015-09-02 16:38:43', '23.235.227.108'),
(523, 1, '2015-09-02 17:05:32', '23.235.227.108'),
(524, 9, '2015-09-02 17:06:25', '23.235.227.108'),
(525, 1, '2015-09-02 17:22:08', '23.235.227.108'),
(526, 1, '2015-09-02 17:31:34', '10.8.44.244'),
(527, 1, '2015-09-02 17:41:03', '10.8.44.81'),
(528, 1, '2015-09-02 17:58:03', '10.8.44.81'),
(529, 1, '2015-09-02 18:08:06', '23.235.227.108'),
(530, 1, '2015-09-02 18:18:12', '10.8.44.81'),
(531, 1, '2015-09-02 18:30:40', '10.8.44.244'),
(532, 1, '2015-09-02 18:35:55', '10.8.44.81'),
(533, 1, '2015-09-02 18:46:16', '10.8.44.39'),
(534, 1, '2015-09-02 19:18:42', '10.8.44.239'),
(535, 1, '2015-09-02 20:12:44', '10.8.44.239'),
(536, 1, '2015-09-02 21:05:28', '23.235.227.108'),
(537, 1, '2015-09-02 22:40:31', '23.235.227.108'),
(538, 1, '2015-09-03 04:41:30', '190.92.44.10'),
(539, 1, '2015-09-03 04:49:46', '190.92.44.10'),
(540, 1, '2015-09-03 16:16:34', '23.235.227.108'),
(541, 1, '2015-09-03 17:30:02', '23.235.227.108'),
(542, 1, '2015-09-03 18:20:46', '23.235.227.108'),
(543, 1, '2015-09-03 18:49:32', '23.235.227.108'),
(544, 1, '2015-09-03 21:39:52', '23.235.227.108'),
(545, 12, '2015-09-03 21:58:01', '23.235.227.108'),
(546, 5, '2015-09-03 21:58:25', '23.235.227.108'),
(547, 13, '2015-09-03 21:58:43', '23.235.227.108'),
(548, 14, '2015-09-03 21:59:02', '23.235.227.108'),
(549, 17, '2015-09-03 21:59:20', '23.235.227.108'),
(550, 1, '2015-09-03 21:59:52', '23.235.227.108'),
(551, 15, '2015-09-03 22:01:15', '23.235.227.108'),
(552, 16, '2015-09-03 22:01:44', '23.235.227.108'),
(553, 18, '2015-09-03 22:02:05', '23.235.227.108'),
(554, 4, '2015-09-03 22:02:18', '23.235.227.108'),
(555, 1, '2015-09-03 22:04:17', '23.235.227.108'),
(556, 1, '2015-09-07 15:38:30', '10.10.40.211'),
(557, 1, '2015-09-07 15:40:21', '10.10.40.211'),
(558, 1, '2015-09-09 15:40:10', '23.235.227.108'),
(559, 1, '2015-09-09 17:10:38', '23.235.227.108'),
(560, 1, '2015-09-09 19:52:41', '23.235.227.108'),
(561, 4, '2015-09-10 00:47:44', '10.8.44.39'),
(562, 1, '2015-09-10 00:48:46', '10.8.44.110'),
(563, 1, '2015-09-10 00:55:12', '10.8.44.110'),
(564, 5, '2015-09-10 00:55:54', '10.8.44.110'),
(565, 5, '2015-09-10 00:56:06', '10.8.44.110'),
(566, 1, '2015-09-10 17:59:22', '10.8.44.87'),
(567, 1, '2015-09-10 18:23:56', '10.8.44.87'),
(568, 1, '2015-09-10 18:28:19', '10.8.44.87'),
(569, 1, '2015-09-10 18:30:36', '10.8.44.87'),
(570, 1, '2015-09-10 18:51:26', '10.8.44.87'),
(571, 1, '2015-09-10 18:51:32', '10.8.44.87'),
(572, 1, '2015-09-10 19:01:55', '10.8.44.87'),
(573, 1, '2015-09-10 21:32:58', '146.185.31.213'),
(574, 18, '2015-09-10 23:29:20', '10.8.44.56'),
(575, 12, '2015-09-11 01:32:31', '10.8.44.247'),
(576, 1, '2015-09-11 15:39:00', '146.185.31.213'),
(577, 1, '2015-09-11 16:07:54', '146.185.31.213'),
(578, 1, '2015-09-11 16:34:34', '146.185.31.213'),
(579, 1, '2015-09-11 18:46:24', '146.185.31.213'),
(580, 14, '2015-09-11 21:50:39', '146.185.31.213'),
(581, 16, '2015-09-11 22:23:03', '146.185.31.213'),
(582, 16, '2015-09-11 22:32:47', '146.185.31.213'),
(583, 1, '2015-09-11 23:25:07', '146.185.31.213'),
(584, 5, '2015-09-11 23:25:55', '146.185.31.213'),
(585, 5, '2015-09-11 23:28:23', '146.185.31.213'),
(586, 1, '2015-09-16 15:49:21', '146.185.31.213'),
(587, 1, '2015-09-16 16:37:18', '146.185.31.213'),
(588, 1, '2015-09-16 16:42:41', '10.8.44.81'),
(589, 1, '2015-09-16 18:03:44', '146.185.31.213'),
(590, 1, '2015-09-16 19:03:24', '146.185.31.213'),
(591, 1, '2015-09-16 19:33:55', '146.185.31.213'),
(592, 1, '2015-09-16 22:20:13', '146.185.31.213'),
(593, 1, '2015-09-16 23:06:53', '146.185.31.213'),
(594, 1, '2015-09-16 23:53:27', '146.185.31.213'),
(595, 12, '2015-09-17 01:18:27', '146.185.31.213'),
(596, 1, '2015-09-18 05:48:36', '190.56.253.48'),
(597, 1, '2015-09-18 22:14:28', '190.92.43.96'),
(598, 1, '2015-09-18 22:15:18', '190.92.43.96'),
(599, 1, '2015-09-18 22:15:19', '190.92.43.96'),
(600, 1, '2015-09-19 19:00:00', '10.8.44.31'),
(601, 5, '2015-09-19 19:00:48', '10.8.44.31'),
(602, 1, '2015-09-20 17:53:15', '190.181.223.15'),
(603, 1, '2015-09-20 18:44:57', '190.181.223.15'),
(604, 13, '2015-09-22 22:55:36', '146.185.31.213'),
(605, 14, '2015-09-23 19:36:20', '10.8.44.91'),
(606, 14, '2015-09-23 23:13:31', '10.8.44.91'),
(607, 15, '2015-09-24 18:20:23', '10.8.44.174'),
(608, 5, '2015-09-24 21:03:45', '10.8.44.31'),
(609, 5, '2015-09-25 18:36:37', '10.8.44.31'),
(610, 1, '2015-09-25 18:40:11', '10.8.44.31'),
(611, 5, '2015-09-25 18:41:54', '10.8.44.31'),
(612, 1, '2015-09-25 19:17:53', '10.8.44.174'),
(613, 15, '2015-09-25 23:17:53', '146.185.31.213');

--
-- Volcado de datos para la tabla `usuario_notificado`
--

INSERT INTO `usuario_notificado` (`Id_UsuarioNotificado`, `Id_Notificacion`, `Id_Usuario`, `IdUbicacionNotificacion`, `Estado`, `Fecha`) VALUES
(1, 1, 4, 3, 1, '2015-08-23 14:40:52'),
(2, 2, 1, 3, 1, '2015-09-11 17:45:23'),
(3, 2, 2, 3, 1, '2015-09-11 17:45:23'),
(4, 2, 3, 3, 1, '2015-09-11 17:45:23');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
