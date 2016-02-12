CREATE DATABASE  IF NOT EXISTS `ccjj` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `ccjj`;
-- MySQL dump 10.13  Distrib 5.6.23, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: ccjj
-- ------------------------------------------------------
-- Server version	5.6.16

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `actividades`
--

DROP TABLE IF EXISTS `actividades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actividades` (
  `id_actividad` int(11) NOT NULL AUTO_INCREMENT,
  `id_indicador` int(11) NOT NULL,
  `descripcion` text NOT NULL,
  `correlativo` varchar(20) NOT NULL,
  `supuesto` text NOT NULL,
  `justificacion` text NOT NULL,
  `medio_verificacion` text NOT NULL,
  `poblacion_objetivo` varchar(30) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  PRIMARY KEY (`id_actividad`),
  KEY `id_indicador` (`id_indicador`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `actividades_terminadas`
--

DROP TABLE IF EXISTS `actividades_terminadas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actividades_terminadas` (
  `id_Actividades_Terminadas` int(11) NOT NULL AUTO_INCREMENT,
  `id_Actividad` int(11) NOT NULL,
  `No_Empleado` varchar(20) NOT NULL,
  `fecha` date NOT NULL,
  `estado` varchar(15) NOT NULL,
  `observaciones` text,
  PRIMARY KEY (`id_Actividades_Terminadas`),
  KEY `id_Actividad` (`id_Actividad`),
  KEY `No_Empleado` (`No_Empleado`),
  CONSTRAINT `actividades_terminadas_ibfk_3` FOREIGN KEY (`id_Actividad`) REFERENCES `actividades` (`id_actividad`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `alerta`
--

DROP TABLE IF EXISTS `alerta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alerta` (
  `Id_Alerta` int(11) NOT NULL AUTO_INCREMENT,
  `NroFolioGenera` varchar(25) NOT NULL,
  `FechaCreacion` datetime NOT NULL,
  `Atendido` tinyint(1) NOT NULL,
  PRIMARY KEY (`Id_Alerta`),
  KEY `fk_alerta_folios_idx` (`NroFolioGenera`),
  CONSTRAINT `fk_alerta_folios` FOREIGN KEY (`NroFolioGenera`) REFERENCES `folios` (`NroFolio`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `area`
--

DROP TABLE IF EXISTS `area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `area` (
  `id_Area` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` text NOT NULL,
  `id_tipo_area` int(11) NOT NULL,
  `observacion` text NOT NULL,
  PRIMARY KEY (`id_Area`),
  KEY `id_tipo_area` (`id_tipo_area`),
  CONSTRAINT `area_ibfk_1` FOREIGN KEY (`id_tipo_area`) REFERENCES `tipo_area` (`id_Tipo_Area`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ca_acondicionamientos`
--

DROP TABLE IF EXISTS `ca_acondicionamientos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ca_acondicionamientos` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ca_areas`
--

DROP TABLE IF EXISTS `ca_areas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ca_areas` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ca_aulas`
--

DROP TABLE IF EXISTS `ca_aulas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ca_aulas` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `cod_edificio` int(11) NOT NULL,
  `numero_aula` varchar(100) NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `aulas_edificios_FK_idx` (`cod_edificio`),
  CONSTRAINT `aulas_edificios_FK` FOREIGN KEY (`cod_edificio`) REFERENCES `edificios` (`Edificio_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ca_aulas_instancias_acondicionamientos`
--

DROP TABLE IF EXISTS `ca_aulas_instancias_acondicionamientos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ca_aulas_instancias_acondicionamientos` (
  `cod_aula` int(11) NOT NULL,
  `cod_instancia_acondicionamiento` int(11) NOT NULL,
  PRIMARY KEY (`cod_aula`),
  KEY `a_i_a_instancias_acondicionamientos_FK_idx` (`cod_instancia_acondicionamiento`),
  CONSTRAINT `a_i_a_aulas_FK` FOREIGN KEY (`cod_aula`) REFERENCES `ca_aulas` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `a_i_a_instancias_acondicionamientos_FK` FOREIGN KEY (`cod_instancia_acondicionamiento`) REFERENCES `ca_instancias_acondicionamientos` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ca_cargas_academicas`
--

DROP TABLE IF EXISTS `ca_cargas_academicas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ca_cargas_academicas` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `cod_periodo` int(11) DEFAULT NULL,
  `no_empleado` varchar(20) DEFAULT NULL,
  `dni_empleado` varchar(20) DEFAULT NULL,
  `cod_estado` int(11) DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `cargas_academicas_periodos_FK_idx` (`cod_periodo`),
  KEY `cargas_academicas_empleados_FK_idx` (`no_empleado`,`dni_empleado`),
  KEY `cargas_academicas_estados_FK_idx` (`cod_estado`),
  CONSTRAINT `cargas_academicas_empleados_FK` FOREIGN KEY (`no_empleado`, `dni_empleado`) REFERENCES `empleado` (`No_Empleado`, `N_identidad`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cargas_academicas_estados_FK` FOREIGN KEY (`cod_estado`) REFERENCES `ca_estados_carga` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cargas_academicas_periodos_FK` FOREIGN KEY (`cod_periodo`) REFERENCES `sa_periodos` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ca_contratos`
--

DROP TABLE IF EXISTS `ca_contratos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ca_contratos` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ca_cursos`
--

DROP TABLE IF EXISTS `ca_cursos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ca_cursos` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `cupos` int(11) DEFAULT NULL,
  `cod_carga` int(11) DEFAULT NULL,
  `cod_seccion` int(11) DEFAULT NULL,
  `cod_asignatura` int(11) DEFAULT NULL,
  `cod_aula` int(11) DEFAULT NULL,
  `no_empleado` varchar(20) DEFAULT NULL,
  `dni_empleado` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `cursos_cargas_FK_idx` (`cod_carga`),
  KEY `cursos_secciones_FK_idx` (`cod_seccion`),
  KEY `cursos_asignaturas_FK_idx` (`cod_asignatura`),
  KEY `cursos_aulas_FK_idx` (`cod_aula`),
  KEY `cursos_empleados_FK_idx` (`no_empleado`,`dni_empleado`),
  CONSTRAINT `cursos_asignaturas_FK` FOREIGN KEY (`cod_asignatura`) REFERENCES `clases` (`ID_Clases`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cursos_aulas_FK` FOREIGN KEY (`cod_aula`) REFERENCES `ca_aulas` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cursos_cargas_FK` FOREIGN KEY (`cod_carga`) REFERENCES `ca_cargas_academicas` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cursos_empleados_FK` FOREIGN KEY (`no_empleado`, `dni_empleado`) REFERENCES `empleado` (`No_Empleado`, `N_identidad`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cursos_secciones_FK` FOREIGN KEY (`cod_seccion`) REFERENCES `ca_secciones` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ca_cursos_dias`
--

DROP TABLE IF EXISTS `ca_cursos_dias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ca_cursos_dias` (
  `cod_curso` int(11) NOT NULL,
  `cod_dia` int(11) NOT NULL,
  PRIMARY KEY (`cod_curso`,`cod_dia`),
  KEY `cursos_dias_dias_FK_idx` (`cod_dia`),
  CONSTRAINT `cursos_dias_clases_FK` FOREIGN KEY (`cod_curso`) REFERENCES `ca_cursos` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cursos_dias_dias_FK` FOREIGN KEY (`cod_dia`) REFERENCES `ca_dias` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ca_dias`
--

DROP TABLE IF EXISTS `ca_dias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ca_dias` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(9) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ca_empleados_contratos`
--

DROP TABLE IF EXISTS `ca_empleados_contratos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ca_empleados_contratos` (
  `no_empleado` varchar(20) NOT NULL,
  `dni_empleado` varchar(20) NOT NULL,
  `cod_contrato` int(11) NOT NULL,
  PRIMARY KEY (`no_empleado`,`dni_empleado`),
  KEY `e_c_contratos_FK_idx` (`cod_contrato`),
  CONSTRAINT `e_c_contratos_FK` FOREIGN KEY (`cod_contrato`) REFERENCES `ca_contratos` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `e_c_empleados_FK` FOREIGN KEY (`no_empleado`, `dni_empleado`) REFERENCES `empleado` (`No_Empleado`, `N_identidad`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ca_empleados_proyectos`
--

DROP TABLE IF EXISTS `ca_empleados_proyectos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ca_empleados_proyectos` (
  `no_empleado` varchar(20) NOT NULL,
  `dni_empleado` varchar(20) NOT NULL,
  `cod_proyecto` int(11) NOT NULL,
  `cod_rol_proyecto` int(11) NOT NULL,
  PRIMARY KEY (`no_empleado`,`dni_empleado`),
  KEY `d_e_p_proyectos_FK_idx` (`cod_proyecto`),
  KEY `d_e_p_roles_proyecto_FK_idx` (`cod_rol_proyecto`),
  CONSTRAINT `d_e_p_empleados_FK` FOREIGN KEY (`no_empleado`, `dni_empleado`) REFERENCES `empleado` (`No_Empleado`, `N_identidad`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `d_e_p_proyectos_FK` FOREIGN KEY (`cod_proyecto`) REFERENCES `ca_proyectos` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `d_e_p_roles_proyecto_FK` FOREIGN KEY (`cod_rol_proyecto`) REFERENCES `ca_roles_proyecto` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ca_estados_carga`
--

DROP TABLE IF EXISTS `ca_estados_carga`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ca_estados_carga` (
  `codigo` int(11) NOT NULL,
  `descripcion` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ca_facultades`
--

DROP TABLE IF EXISTS `ca_facultades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ca_facultades` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ca_instancias_acondicionamientos`
--

DROP TABLE IF EXISTS `ca_instancias_acondicionamientos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ca_instancias_acondicionamientos` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `cod_acondicionamiento` int(11) DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `instancias_acondicionamientos_acondicionamientos_FK_idx` (`cod_acondicionamiento`),
  CONSTRAINT `instancias_acondicionamientos_acondicionamientos_FK` FOREIGN KEY (`cod_acondicionamiento`) REFERENCES `ca_acondicionamientos` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ca_proyectos`
--

DROP TABLE IF EXISTS `ca_proyectos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ca_proyectos` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `cod_vinculacion` int(11) DEFAULT NULL,
  `cod_area` int(11) DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `proyectos_vinculaciones_FK_idx` (`cod_vinculacion`),
  KEY `proyectos_areas_FK_idx` (`cod_area`),
  CONSTRAINT `proyectos_areas_FK` FOREIGN KEY (`cod_area`) REFERENCES `ca_areas` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `proyectos_vinculaciones_FK` FOREIGN KEY (`cod_vinculacion`) REFERENCES `ca_vinculaciones` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ca_roles_proyecto`
--

DROP TABLE IF EXISTS `ca_roles_proyecto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ca_roles_proyecto` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ca_secciones`
--

DROP TABLE IF EXISTS `ca_secciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ca_secciones` (
  `codigo` int(11) NOT NULL,
  `hora_inicio` time DEFAULT NULL,
  `hora_fin` time DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ca_vinculaciones`
--

DROP TABLE IF EXISTS `ca_vinculaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ca_vinculaciones` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `cod_facultad` int(11) DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `vinculaciones_facultades_FK_idx` (`cod_facultad`),
  CONSTRAINT `vinculaciones_facultades_FK` FOREIGN KEY (`cod_facultad`) REFERENCES `ca_facultades` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cargo`
--

DROP TABLE IF EXISTS `cargo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cargo` (
  `ID_cargo` int(11) NOT NULL AUTO_INCREMENT,
  `Cargo` varchar(100) NOT NULL,
  PRIMARY KEY (`ID_cargo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categorias_folios`
--

DROP TABLE IF EXISTS `categorias_folios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorias_folios` (
  `Id_categoria` int(11) NOT NULL AUTO_INCREMENT,
  `NombreCategoria` text NOT NULL,
  `DescripcionCategoria` text,
  PRIMARY KEY (`Id_categoria`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clases`
--

DROP TABLE IF EXISTS `clases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clases` (
  `ID_Clases` int(11) NOT NULL AUTO_INCREMENT,
  `Clase` varchar(100) NOT NULL,
  PRIMARY KEY (`ID_Clases`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clases_has_experiencia_academica`
--

DROP TABLE IF EXISTS `clases_has_experiencia_academica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clases_has_experiencia_academica` (
  `ID_Clases` int(11) NOT NULL,
  `ID_Experiencia_academica` int(11) NOT NULL,
  PRIMARY KEY (`ID_Clases`,`ID_Experiencia_academica`),
  KEY `fk_Clases_has_Experiencia_academica_Experiencia_academica1_idx` (`ID_Experiencia_academica`),
  KEY `fk_Clases_has_Experiencia_academica_Clases1_idx` (`ID_Clases`),
  CONSTRAINT `fk_Clases_has_Experiencia_academica_Clases1` FOREIGN KEY (`ID_Clases`) REFERENCES `clases` (`ID_Clases`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Clases_has_Experiencia_academica_Experiencia_academica1` FOREIGN KEY (`ID_Experiencia_academica`) REFERENCES `experiencia_academica` (`ID_Experiencia_academica`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `costo_porcentaje_actividad_por_trimestre`
--

DROP TABLE IF EXISTS `costo_porcentaje_actividad_por_trimestre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `costo_porcentaje_actividad_por_trimestre` (
  `id_Costo_Porcentaje_Actividad_Por_Trimesrte` int(11) NOT NULL AUTO_INCREMENT,
  `id_Actividad` int(11) NOT NULL,
  `costo` int(11) NOT NULL,
  `porcentaje` int(11) NOT NULL,
  `observacion` text,
  `trimestre` int(11) NOT NULL,
  PRIMARY KEY (`id_Costo_Porcentaje_Actividad_Por_Trimesrte`),
  KEY `id_Actividad` (`id_Actividad`),
  CONSTRAINT `costo_porcentaje_actividad_por_trimestre_ibfk_1` FOREIGN KEY (`id_Actividad`) REFERENCES `actividades` (`id_actividad`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `departamento_laboral`
--

DROP TABLE IF EXISTS `departamento_laboral`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `departamento_laboral` (
  `Id_departamento_laboral` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_departamento` varchar(30) NOT NULL,
  PRIMARY KEY (`Id_departamento_laboral`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `edificios`
--

DROP TABLE IF EXISTS `edificios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edificios` (
  `Edificio_ID` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` text,
  PRIMARY KEY (`Edificio_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `empleado`
--

DROP TABLE IF EXISTS `empleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empleado` (
  `No_Empleado` varchar(20) NOT NULL,
  `N_identidad` varchar(20) NOT NULL,
  `Id_departamento` int(11) NOT NULL,
  `Fecha_ingreso` date NOT NULL,
  `fecha_salida` date DEFAULT NULL,
  `Observacion` text,
  `estado_empleado` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`No_Empleado`,`N_identidad`),
  UNIQUE KEY `No_Empleado_2` (`No_Empleado`),
  KEY `fk_Empleado_Persona1_idx` (`N_identidad`),
  KEY `fk_empleado_dep_idx` (`Id_departamento`),
  KEY `No_Empleado` (`No_Empleado`),
  CONSTRAINT `fk_empleado_dep` FOREIGN KEY (`Id_departamento`) REFERENCES `departamento_laboral` (`Id_departamento_laboral`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Empleado_Persona1` FOREIGN KEY (`N_identidad`) REFERENCES `persona` (`N_identidad`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `empleado_has_cargo`
--

DROP TABLE IF EXISTS `empleado_has_cargo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empleado_has_cargo` (
  `No_Empleado` varchar(20) NOT NULL,
  `ID_cargo` int(11) NOT NULL,
  `Fecha_ingreso_cargo` date NOT NULL,
  `Fecha_salida_cargo` date DEFAULT NULL,
  PRIMARY KEY (`No_Empleado`,`ID_cargo`),
  KEY `fk_Empleado_has_Cargo_Cargo1_idx` (`ID_cargo`),
  KEY `fk_Empleado_has_Cargo_Empleado1_idx` (`No_Empleado`),
  KEY `No_Empleado` (`No_Empleado`),
  CONSTRAINT `fk_Empleado_has_Cargo_Cargo1` FOREIGN KEY (`ID_cargo`) REFERENCES `cargo` (`ID_cargo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Empleado_has_Cargo_Empleado1` FOREIGN KEY (`No_Empleado`) REFERENCES `empleado` (`No_Empleado`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `estado_seguimiento`
--

DROP TABLE IF EXISTS `estado_seguimiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estado_seguimiento` (
  `Id_Estado_Seguimiento` tinyint(4) NOT NULL AUTO_INCREMENT,
  `DescripcionEstadoSeguimiento` text NOT NULL,
  PRIMARY KEY (`Id_Estado_Seguimiento`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `estudios_academico`
--

DROP TABLE IF EXISTS `estudios_academico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estudios_academico` (
  `ID_Estudios_academico` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre_titulo` varchar(100) NOT NULL,
  `ID_Tipo_estudio` int(11) NOT NULL,
  `N_identidad` varchar(20) NOT NULL,
  `Id_universidad` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_Estudios_academico`),
  KEY `fk_Estudios_academico_Tipo_estudio1_idx` (`ID_Tipo_estudio`),
  KEY `fk_Estudios_academico_Persona1_idx` (`N_identidad`),
  KEY `fk_estudio_universidad_idx` (`Id_universidad`),
  CONSTRAINT `fk_Estudios_academico_Persona1` FOREIGN KEY (`N_identidad`) REFERENCES `persona` (`N_identidad`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Estudios_academico_Tipo_estudio1` FOREIGN KEY (`ID_Tipo_estudio`) REFERENCES `tipo_estudio` (`ID_Tipo_estudio`),
  CONSTRAINT `fk_estudio_universidad` FOREIGN KEY (`Id_universidad`) REFERENCES `universidad` (`Id_universidad`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `experiencia_academica`
--

DROP TABLE IF EXISTS `experiencia_academica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `experiencia_academica` (
  `ID_Experiencia_academica` int(11) NOT NULL AUTO_INCREMENT,
  `Institucion` varchar(45) NOT NULL,
  `Tiempo` int(3) NOT NULL,
  `N_identidad` varchar(20) NOT NULL,
  PRIMARY KEY (`ID_Experiencia_academica`),
  KEY `fk_Experiencia_academica_Persona1_idx` (`N_identidad`),
  CONSTRAINT `fk_Experiencia_academica_Persona1` FOREIGN KEY (`N_identidad`) REFERENCES `persona` (`N_identidad`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `experiencia_laboral`
--

DROP TABLE IF EXISTS `experiencia_laboral`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `experiencia_laboral` (
  `ID_Experiencia_laboral` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre_empresa` varchar(45) NOT NULL,
  `Tiempo` int(3) NOT NULL,
  `N_identidad` varchar(20) NOT NULL,
  PRIMARY KEY (`ID_Experiencia_laboral`),
  KEY `fk_Experiencia_laboral_Persona1_idx` (`N_identidad`),
  CONSTRAINT `fk_Experiencia_laboral_Persona1` FOREIGN KEY (`N_identidad`) REFERENCES `persona` (`N_identidad`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `experiencia_laboral_has_cargo`
--

DROP TABLE IF EXISTS `experiencia_laboral_has_cargo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `experiencia_laboral_has_cargo` (
  `ID_Experiencia_laboral` int(11) NOT NULL,
  `ID_cargo` int(11) NOT NULL,
  PRIMARY KEY (`ID_Experiencia_laboral`,`ID_cargo`),
  KEY `fk_Experiencia_laboral_has_Cargo_Cargo1_idx` (`ID_cargo`),
  KEY `fk_Experiencia_laboral_has_Cargo_Experiencia_laboral1_idx` (`ID_Experiencia_laboral`),
  CONSTRAINT `fk_Experiencia_laboral_has_Cargo_Cargo1` FOREIGN KEY (`ID_cargo`) REFERENCES `cargo` (`ID_cargo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Experiencia_laboral_has_Cargo_Experiencia_laboral1` FOREIGN KEY (`ID_Experiencia_laboral`) REFERENCES `experiencia_laboral` (`ID_Experiencia_laboral`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `folios`
--

DROP TABLE IF EXISTS `folios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `folios` (
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
  `Prioridad` tinyint(4) NOT NULL,
  PRIMARY KEY (`NroFolio`),
  KEY `fk_folios_unidad_academica_unidadAcademica_idx` (`UnidadAcademica`),
  KEY `fk_folios_organizacion_organizacion_idx` (`Organizacion`),
  KEY `fk_folios_tblTipoPrioridad_idx` (`Prioridad`),
  KEY `fk_folios_ubicacion_archivofisico_ubicacionFisica_idx` (`UbicacionFisica`),
  KEY `fk_folio_folioRespuesta_idx` (`NroFolioRespuesta`),
  KEY `fk_folios_categoria_idx` (`Categoria`),
  CONSTRAINT `fk_folios_categoria` FOREIGN KEY (`Categoria`) REFERENCES `categorias_folios` (`Id_categoria`) ON UPDATE CASCADE,
  CONSTRAINT `fk_folios_organizacion_organizacion` FOREIGN KEY (`Organizacion`) REFERENCES `organizacion` (`Id_Organizacion`) ON UPDATE CASCADE,
  CONSTRAINT `fk_folios_tblTipoPrioridad` FOREIGN KEY (`Prioridad`) REFERENCES `prioridad` (`Id_Prioridad`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_folios_ubicacion_archivofisico_ubicacionFisica` FOREIGN KEY (`UbicacionFisica`) REFERENCES `ubicacion_archivofisico` (`Id_UbicacionArchivoFisico`) ON UPDATE CASCADE,
  CONSTRAINT `fk_folios_unidad_academica_unidadAcademica` FOREIGN KEY (`UnidadAcademica`) REFERENCES `unidad_academica` (`Id_UnidadAcademica`) ON UPDATE CASCADE,
  CONSTRAINT `fk_folio_folioRespuesta` FOREIGN KEY (`NroFolioRespuesta`) REFERENCES `folios` (`NroFolio`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `grupo_o_comite`
--

DROP TABLE IF EXISTS `grupo_o_comite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grupo_o_comite` (
  `ID_Grupo_o_comite` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre_Grupo_o_comite` varchar(45) NOT NULL,
  PRIMARY KEY (`ID_Grupo_o_comite`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `grupo_o_comite_has_empleado`
--

DROP TABLE IF EXISTS `grupo_o_comite_has_empleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grupo_o_comite_has_empleado` (
  `ID_Grupo_o_comite` int(11) NOT NULL,
  `No_Empleado` varchar(20) NOT NULL,
  PRIMARY KEY (`ID_Grupo_o_comite`,`No_Empleado`),
  KEY `fk_Grupo_o_comite_has_Empleado_Empleado1_idx` (`No_Empleado`),
  KEY `fk_Grupo_o_comite_has_Empleado_Grupo_o_comite1_idx` (`ID_Grupo_o_comite`),
  CONSTRAINT `fk_Grupo_o_comite_has_Empleado_Empleado1` FOREIGN KEY (`No_Empleado`) REFERENCES `empleado` (`No_Empleado`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Grupo_o_comite_has_Empleado_Grupo_o_comite1` FOREIGN KEY (`ID_Grupo_o_comite`) REFERENCES `grupo_o_comite` (`ID_Grupo_o_comite`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `idioma`
--

DROP TABLE IF EXISTS `idioma`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `idioma` (
  `ID_Idioma` int(11) NOT NULL AUTO_INCREMENT,
  `Idioma` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`ID_Idioma`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `idioma_has_persona`
--

DROP TABLE IF EXISTS `idioma_has_persona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `idioma_has_persona` (
  `ID_Idioma` int(11) NOT NULL,
  `N_identidad` varchar(20) NOT NULL,
  `Nivel` varchar(45) DEFAULT NULL,
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`Id`),
  KEY `fk_Idioma_has_Persona_Persona1_idx` (`N_identidad`),
  KEY `fk_Idioma_has_Persona_Idioma_idx` (`ID_Idioma`),
  CONSTRAINT `fk_Idioma_has_Persona_Idioma` FOREIGN KEY (`ID_Idioma`) REFERENCES `idioma` (`ID_Idioma`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Idioma_has_Persona_Persona1` FOREIGN KEY (`N_identidad`) REFERENCES `persona` (`N_identidad`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `indicadores`
--

DROP TABLE IF EXISTS `indicadores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indicadores` (
  `id_Indicadores` int(11) NOT NULL AUTO_INCREMENT,
  `id_ObjetivosInsitucionales` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `descripcion` text,
  PRIMARY KEY (`id_Indicadores`),
  KEY `id_ObjetivosInsitucionales` (`id_ObjetivosInsitucionales`),
  CONSTRAINT `indicadores_ibfk_1` FOREIGN KEY (`id_ObjetivosInsitucionales`) REFERENCES `objetivos_institucionales` (`id_Objetivo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `motivos`
--

DROP TABLE IF EXISTS `motivos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `motivos` (
  `Motivo_ID` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` text,
  PRIMARY KEY (`Motivo_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notificaciones_folios`
--

DROP TABLE IF EXISTS `notificaciones_folios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notificaciones_folios` (
  `Id_Notificacion` int(11) NOT NULL AUTO_INCREMENT,
  `NroFolio` varchar(25) NOT NULL,
  `IdEmisor` int(15) NOT NULL,
  `Titulo` text NOT NULL,
  `Cuerpo` text NOT NULL,
  `FechaCreacion` datetime NOT NULL,
  `IdUbicacionNotificacion` int(11) NOT NULL,
  `Estado` tinyint(4) NOT NULL,
  PRIMARY KEY (`Id_Notificacion`,`IdEmisor`),
  KEY `fk_notificaciones_folios_folios_idx` (`NroFolio`),
  KEY `fk_usuario_notificaciones_idx` (`IdEmisor`),
  CONSTRAINT `fk_notificaciones_folios_folios` FOREIGN KEY (`NroFolio`) REFERENCES `folios` (`NroFolio`) ON UPDATE CASCADE,
  CONSTRAINT `fk_usuario_notificaciones` FOREIGN KEY (`IdEmisor`) REFERENCES `usuario` (`id_Usuario`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `objetivos_institucionales`
--

DROP TABLE IF EXISTS `objetivos_institucionales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `objetivos_institucionales` (
  `id_Objetivo` int(11) NOT NULL AUTO_INCREMENT,
  `definicion` text NOT NULL,
  `area_Estrategica` text NOT NULL,
  `resultados_Esperados` text NOT NULL,
  `id_Area` int(11) NOT NULL,
  `id_Poa` int(11) NOT NULL,
  PRIMARY KEY (`id_Objetivo`),
  KEY `id_Area` (`id_Area`),
  KEY `id_Poa` (`id_Poa`),
  KEY `id_Area_2` (`id_Area`),
  CONSTRAINT `objetivos_institucionales_ibfk_2` FOREIGN KEY (`id_Poa`) REFERENCES `poa` (`id_Poa`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `objetivos_institucionales_ibfk_3` FOREIGN KEY (`id_Area`) REFERENCES `area` (`id_Area`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `organizacion`
--

DROP TABLE IF EXISTS `organizacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organizacion` (
  `Id_Organizacion` int(11) NOT NULL AUTO_INCREMENT,
  `NombreOrganizacion` text NOT NULL,
  `Ubicacion` text NOT NULL,
  PRIMARY KEY (`Id_Organizacion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pais`
--

DROP TABLE IF EXISTS `pais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pais` (
  `Id_pais` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre_pais` varchar(20) NOT NULL,
  PRIMARY KEY (`Id_pais`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `permisos`
--

DROP TABLE IF EXISTS `permisos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permisos` (
  `id_Permisos` int(11) NOT NULL AUTO_INCREMENT,
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
  `id_usuario` int(11) NOT NULL,
  PRIMARY KEY (`id_Permisos`),
  KEY `fk_motivo_idx` (`id_motivo`),
  KEY `fk_empleado_idx` (`No_Empleado`),
  KEY `fk_edificio_registro_idx` (`id_Edificio_Registro`),
  KEY `fk_revisado_idx` (`revisado_por`),
  KEY `fk_departamento_idx` (`id_departamento`),
  KEY `fk_usuario_idx` (`id_usuario`),
  CONSTRAINT `fk_departamento` FOREIGN KEY (`id_departamento`) REFERENCES `departamento_laboral` (`Id_departamento_laboral`),
  CONSTRAINT `fk_edificio_registro` FOREIGN KEY (`id_Edificio_Registro`) REFERENCES `edificios` (`Edificio_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_empleado` FOREIGN KEY (`No_Empleado`) REFERENCES `empleado` (`No_Empleado`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_motivo` FOREIGN KEY (`id_motivo`) REFERENCES `motivos` (`Motivo_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_revisado` FOREIGN KEY (`revisado_por`) REFERENCES `usuario` (`No_Empleado`),
  CONSTRAINT `fk_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_Usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `persona`
--

DROP TABLE IF EXISTS `persona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `persona` (
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
  `foto_perfil` varchar(60) NOT NULL,
  PRIMARY KEY (`N_identidad`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `poa`
--

DROP TABLE IF EXISTS `poa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `poa` (
  `id_Poa` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  `fecha_de_Inicio` date NOT NULL,
  `fecha_Fin` date NOT NULL,
  `descripcion` text NOT NULL,
  PRIMARY KEY (`id_Poa`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prioridad`
--

DROP TABLE IF EXISTS `prioridad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prioridad` (
  `Id_Prioridad` tinyint(4) NOT NULL,
  `DescripcionPrioridad` text NOT NULL,
  PRIMARY KEY (`Id_Prioridad`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prioridad_folio`
--

DROP TABLE IF EXISTS `prioridad_folio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prioridad_folio` (
  `Id_PrioridadFolio` int(11) NOT NULL AUTO_INCREMENT,
  `IdFolio` varchar(25) NOT NULL,
  `Id_Prioridad` tinyint(4) NOT NULL,
  `FechaEstablecida` date NOT NULL,
  PRIMARY KEY (`Id_PrioridadFolio`),
  KEY `fk_prioridad_folio_folios_idx` (`IdFolio`),
  KEY `fk_prioridad_folio_prioridad_idx` (`Id_Prioridad`),
  CONSTRAINT `fk_prioridad_folio_folios` FOREIGN KEY (`IdFolio`) REFERENCES `folios` (`NroFolio`) ON UPDATE CASCADE,
  CONSTRAINT `fk_prioridad_folio_prioridad` FOREIGN KEY (`Id_Prioridad`) REFERENCES `prioridad` (`Id_Prioridad`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `responsables_por_actividad`
--

DROP TABLE IF EXISTS `responsables_por_actividad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `responsables_por_actividad` (
  `id_Responsable_por_Actividad` int(11) NOT NULL AUTO_INCREMENT,
  `id_Actividad` int(11) NOT NULL,
  `id_Responsable` int(11) NOT NULL,
  `fecha_Asignacion` date NOT NULL,
  `observacion` text,
  PRIMARY KEY (`id_Responsable_por_Actividad`),
  KEY `id_Actividad` (`id_Actividad`,`id_Responsable`),
  KEY `id_Responsable` (`id_Responsable`),
  CONSTRAINT `responsables_por_actividad_ibfk_3` FOREIGN KEY (`id_Actividad`) REFERENCES `actividades` (`id_actividad`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `responsables_por_actividad_ibfk_4` FOREIGN KEY (`id_Responsable`) REFERENCES `grupo_o_comite` (`ID_Grupo_o_comite`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `Id_Rol` tinyint(4) NOT NULL,
  `Descripcion` text NOT NULL,
  PRIMARY KEY (`Id_Rol`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sa_ciudades`
--

DROP TABLE IF EXISTS `sa_ciudades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sa_ciudades` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sa_estados_solicitud`
--

DROP TABLE IF EXISTS `sa_estados_solicitud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sa_estados_solicitud` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sa_estudiantes`
--

DROP TABLE IF EXISTS `sa_estudiantes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sa_estudiantes` (
  `dni` varchar(20) NOT NULL,
  `no_cuenta` varchar(11) NOT NULL,
  `anios_inicio_estudio` int(11) NOT NULL,
  `indice_academico` decimal(10,0) NOT NULL,
  `fecha_registro` date NOT NULL,
  `uv_acumulados` int(11) NOT NULL,
  `cantcodad_solicitudes` int(11) DEFAULT NULL,
  `cod_plan_estudio` int(11) NOT NULL,
  `cod_ciudad_origen` int(11) NOT NULL,
  `cod_orientacion` int(11) NOT NULL,
  `cod_residencia_actual` int(11) NOT NULL,
  `anios_final_estudio` int(11) DEFAULT NULL,
  PRIMARY KEY (`dni`),
  UNIQUE KEY `no_cuenta_estudiantes_UC` (`no_cuenta`),
  KEY `estudiante_plan_FK_idx` (`cod_plan_estudio`),
  KEY `estudiante_ciudad_FK_idx` (`cod_ciudad_origen`),
  KEY `estudiante_orientacion_FK_idx` (`cod_orientacion`),
  KEY `estudiantes_lugar_origen_FK_idx` (`cod_residencia_actual`),
  CONSTRAINT `estudiantes_persona_FK` FOREIGN KEY (`dni`) REFERENCES `persona` (`N_identidad`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `estudiante_ciudad_FK` FOREIGN KEY (`cod_ciudad_origen`) REFERENCES `sa_ciudades` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `estudiante_orientacion_FK` FOREIGN KEY (`cod_orientacion`) REFERENCES `sa_orientaciones` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `estudiante_plan_FK` FOREIGN KEY (`cod_plan_estudio`) REFERENCES `sa_planes_estudio` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `estudiante_residencia_actual_FK` FOREIGN KEY (`cod_residencia_actual`) REFERENCES `sa_ciudades` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sa_estudiantes_correos`
--

DROP TABLE IF EXISTS `sa_estudiantes_correos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sa_estudiantes_correos` (
  `dni_estudiante` varchar(20) NOT NULL,
  `correo` varchar(50) NOT NULL,
  PRIMARY KEY (`dni_estudiante`,`correo`),
  CONSTRAINT `estudiante_correo_estudiante_FK` FOREIGN KEY (`dni_estudiante`) REFERENCES `sa_estudiantes` (`dni`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sa_estudiantes_menciones_honorificas`
--

DROP TABLE IF EXISTS `sa_estudiantes_menciones_honorificas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sa_estudiantes_menciones_honorificas` (
  `dni_estudiante` varchar(20) NOT NULL,
  `cod_mencion` int(11) NOT NULL,
  PRIMARY KEY (`dni_estudiante`,`cod_mencion`),
  KEY `estudiante_mencion_mencion_FK_idx` (`cod_mencion`),
  CONSTRAINT `estudiante_mencion_estudiante_FK` FOREIGN KEY (`dni_estudiante`) REFERENCES `sa_estudiantes` (`dni`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `estudiante_mencion_mencion_FK` FOREIGN KEY (`cod_mencion`) REFERENCES `sa_menciones_honorificas` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sa_estudiantes_tipos_estudiantes`
--

DROP TABLE IF EXISTS `sa_estudiantes_tipos_estudiantes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sa_estudiantes_tipos_estudiantes` (
  `codigo_tipo_estudiante` int(11) NOT NULL,
  `dni_estudiante` varchar(20) NOT NULL,
  `fecha_registro` datetime NOT NULL,
  PRIMARY KEY (`codigo_tipo_estudiante`,`dni_estudiante`),
  KEY `sa_estudiantes_tipos_estudiantes_estudiantes_idx` (`dni_estudiante`),
  CONSTRAINT `sa_estudiantes_tipos_estudiantes_estudiantes` FOREIGN KEY (`dni_estudiante`) REFERENCES `sa_estudiantes` (`dni`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sa_examenes_himno`
--

DROP TABLE IF EXISTS `sa_examenes_himno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sa_examenes_himno` (
  `cod_solicitud` int(11) NOT NULL,
  `fecha_solicitud` date NOT NULL,
  `nota_himno` decimal(10,0) DEFAULT NULL,
  `fecha_examen_himno` date DEFAULT NULL,
  PRIMARY KEY (`cod_solicitud`,`fecha_solicitud`),
  CONSTRAINT `examen_himno_solicitud_FK` FOREIGN KEY (`cod_solicitud`, `fecha_solicitud`) REFERENCES `sa_solicitudes` (`codigo`, `fecha_solicitud`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sa_menciones_honorificas`
--

DROP TABLE IF EXISTS `sa_menciones_honorificas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sa_menciones_honorificas` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sa_orientaciones`
--

DROP TABLE IF EXISTS `sa_orientaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sa_orientaciones` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sa_periodos`
--

DROP TABLE IF EXISTS `sa_periodos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sa_periodos` (
  `codigo` int(11) NOT NULL,
  `nombre` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sa_planes_estudio`
--

DROP TABLE IF EXISTS `sa_planes_estudio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sa_planes_estudio` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `uv` int(11) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sa_solicitudes`
--

DROP TABLE IF EXISTS `sa_solicitudes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sa_solicitudes` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `fecha_solicitud` date NOT NULL,
  `observaciones` varchar(50) DEFAULT NULL,
  `dni_estudiante` varchar(20) NOT NULL,
  `cod_periodo` int(11) NOT NULL,
  `cod_estado` int(11) NOT NULL,
  `cod_tipo_solicitud` int(11) NOT NULL,
  `cod_solicitud_padre` int(11) DEFAULT NULL,
  `fecha_solicitud_padre` date DEFAULT NULL,
  PRIMARY KEY (`codigo`,`fecha_solicitud`),
  KEY `solicitud_estudiante_FK_idx` (`dni_estudiante`),
  KEY `solicitud_periodo_FK_idx` (`cod_periodo`),
  KEY `solicitud_estados_solicitud_FK_idx` (`cod_estado`),
  KEY `solicitud_tipo_solicitud_FK_idx` (`cod_tipo_solicitud`),
  KEY `solicitud_solicitud_FK_idx` (`cod_solicitud_padre`,`fecha_solicitud_padre`),
  CONSTRAINT `solicitud_estados_solicitud_FK` FOREIGN KEY (`cod_estado`) REFERENCES `sa_estados_solicitud` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `solicitud_estudiante_FK` FOREIGN KEY (`dni_estudiante`) REFERENCES `sa_estudiantes` (`dni`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `solicitud_periodo_FK` FOREIGN KEY (`cod_periodo`) REFERENCES `sa_periodos` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `solicitud_solicitud_FK` FOREIGN KEY (`cod_solicitud_padre`, `fecha_solicitud_padre`) REFERENCES `sa_solicitudes` (`codigo`, `fecha_solicitud`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `solicitud_tipo_solicitud_FK` FOREIGN KEY (`cod_tipo_solicitud`) REFERENCES `sa_tipos_solicitud` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sa_tipos_estudiante`
--

DROP TABLE IF EXISTS `sa_tipos_estudiante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sa_tipos_estudiante` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sa_tipos_solicitud`
--

DROP TABLE IF EXISTS `sa_tipos_solicitud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sa_tipos_solicitud` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=123477 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sa_tipos_solicitud_tipos_alumnos`
--

DROP TABLE IF EXISTS `sa_tipos_solicitud_tipos_alumnos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sa_tipos_solicitud_tipos_alumnos` (
  `cod_tipo_solicitud` int(11) NOT NULL,
  `cod_tipo_alumno` int(11) NOT NULL,
  PRIMARY KEY (`cod_tipo_solicitud`,`cod_tipo_alumno`),
  KEY `tipo_alumno_tipo_solicitud_t_a_FK_idx` (`cod_tipo_alumno`),
  CONSTRAINT `tipo_alumno_tipo_solicitud_t_a_FK` FOREIGN KEY (`cod_tipo_alumno`) REFERENCES `sa_tipos_estudiante` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tipo_alumno_tipo_solicitud_t_s_FK` FOREIGN KEY (`cod_tipo_solicitud`) REFERENCES `sa_tipos_solicitud` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `seguimiento`
--

DROP TABLE IF EXISTS `seguimiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seguimiento` (
  `Id_Seguimiento` int(11) NOT NULL AUTO_INCREMENT,
  `NroFolio` varchar(25) NOT NULL,
  `UsuarioAsignado` int(11) DEFAULT NULL,
  `Notas` text NOT NULL,
  `Prioridad` tinyint(4) NOT NULL,
  `FechaInicio` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `FechaFinal` date DEFAULT NULL,
  `EstadoSeguimiento` tinyint(4) NOT NULL,
  PRIMARY KEY (`Id_Seguimiento`),
  KEY `fk_seguimiento_folios_idx` (`NroFolio`),
  KEY `fk_seguimiento_usuarioAsignado_idx` (`UsuarioAsignado`),
  CONSTRAINT `fk_seguimiento_folios` FOREIGN KEY (`NroFolio`) REFERENCES `folios` (`NroFolio`) ON UPDATE CASCADE,
  CONSTRAINT `fk_seguimiento_usuarioAsignado` FOREIGN KEY (`UsuarioAsignado`) REFERENCES `usuario` (`id_Usuario`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `seguimiento_historico`
--

DROP TABLE IF EXISTS `seguimiento_historico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seguimiento_historico` (
  `Id_SeguimientoHistorico` int(11) NOT NULL AUTO_INCREMENT,
  `Id_Seguimiento` int(11) NOT NULL,
  `Id_Estado_Seguimiento` tinyint(4) NOT NULL,
  `Notas` text NOT NULL,
  `Prioridad` tinyint(4) NOT NULL,
  `FechaCambio` datetime NOT NULL,
  PRIMARY KEY (`Id_SeguimientoHistorico`),
  KEY `fk_seguimiento_historico_seguimiento` (`Id_Seguimiento`),
  KEY `fk_seguimiento_historico_tblEstdoSeguimiento_idx` (`Id_Estado_Seguimiento`),
  CONSTRAINT `fk_seguimiento_historico_seguimiento1` FOREIGN KEY (`Id_Seguimiento`) REFERENCES `seguimiento` (`Id_Seguimiento`) ON UPDATE CASCADE,
  CONSTRAINT `fk_seguimiento_historico_tblEstdoSeguimiento` FOREIGN KEY (`Id_Estado_Seguimiento`) REFERENCES `estado_seguimiento` (`Id_Estado_Seguimiento`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sub_actividad`
--

DROP TABLE IF EXISTS `sub_actividad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sub_actividad` (
  `id_sub_Actividad` int(11) NOT NULL AUTO_INCREMENT,
  `idActividad` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `descripcion` text NOT NULL,
  `fecha_monitoreo` date NOT NULL,
  `id_Encargado` varchar(20) NOT NULL,
  `ponderacion` int(11) NOT NULL,
  `costo` int(11) NOT NULL,
  `observacion` text NOT NULL,
  PRIMARY KEY (`id_sub_Actividad`),
  KEY `idActividad` (`idActividad`),
  KEY `id_Encargado(Usuario)` (`id_Encargado`),
  CONSTRAINT `sub_actividad_ibfk_3` FOREIGN KEY (`idActividad`) REFERENCES `actividades` (`id_actividad`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sub_actividad_ibfk_4` FOREIGN KEY (`id_Encargado`) REFERENCES `empleado` (`No_Empleado`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sub_actividades_realizadas`
--

DROP TABLE IF EXISTS `sub_actividades_realizadas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sub_actividades_realizadas` (
  `id_subActividadRealizada` int(11) NOT NULL AUTO_INCREMENT,
  `id_SubActividad` int(11) NOT NULL,
  `fecha_Realizacion` date NOT NULL,
  `observacion` text NOT NULL,
  PRIMARY KEY (`id_subActividadRealizada`),
  UNIQUE KEY `id_SubActividad_2` (`id_SubActividad`),
  KEY `id_SubActividad` (`id_SubActividad`),
  CONSTRAINT `sub_actividades_realizadas_ibfk_2` FOREIGN KEY (`id_SubActividad`) REFERENCES `sub_actividad` (`id_sub_Actividad`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `telefono`
--

DROP TABLE IF EXISTS `telefono`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `telefono` (
  `ID_Telefono` int(11) NOT NULL AUTO_INCREMENT,
  `Tipo` varchar(45) DEFAULT NULL,
  `Numero` varchar(20) NOT NULL,
  `N_identidad` varchar(20) NOT NULL,
  PRIMARY KEY (`ID_Telefono`),
  KEY `fk_Telefono_Persona1_idx` (`N_identidad`),
  CONSTRAINT `fk_Telefono_Persona1` FOREIGN KEY (`N_identidad`) REFERENCES `persona` (`N_identidad`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipo_area`
--

DROP TABLE IF EXISTS `tipo_area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_area` (
  `id_Tipo_Area` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  `observaciones` text NOT NULL,
  PRIMARY KEY (`id_Tipo_Area`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipo_estudio`
--

DROP TABLE IF EXISTS `tipo_estudio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_estudio` (
  `ID_Tipo_estudio` int(11) NOT NULL AUTO_INCREMENT,
  `Tipo_estudio` varchar(45) NOT NULL,
  PRIMARY KEY (`ID_Tipo_estudio`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `titulo`
--

DROP TABLE IF EXISTS `titulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `titulo` (
  `id_titulo` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(50) NOT NULL,
  PRIMARY KEY (`id_titulo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ubicacion_archivofisico`
--

DROP TABLE IF EXISTS `ubicacion_archivofisico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ubicacion_archivofisico` (
  `Id_UbicacionArchivoFisico` int(5) NOT NULL AUTO_INCREMENT,
  `DescripcionUbicacionFisica` text NOT NULL,
  `Capacidad` int(10) NOT NULL,
  `TotalIngresados` int(10) NOT NULL DEFAULT '0',
  `HabilitadoParaAlmacenar` tinyint(1) NOT NULL,
  PRIMARY KEY (`Id_UbicacionArchivoFisico`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ubicacion_notificaciones`
--

DROP TABLE IF EXISTS `ubicacion_notificaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ubicacion_notificaciones` (
  `Id_UbicacionNotificaciones` tinyint(4) NOT NULL AUTO_INCREMENT,
  `DescripcionUbicacionNotificaciones` text NOT NULL,
  PRIMARY KEY (`Id_UbicacionNotificaciones`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `unidad_academica`
--

DROP TABLE IF EXISTS `unidad_academica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unidad_academica` (
  `Id_UnidadAcademica` int(11) NOT NULL AUTO_INCREMENT,
  `NombreUnidadAcademica` text NOT NULL,
  `UbicacionUnidadAcademica` text NOT NULL,
  PRIMARY KEY (`Id_UnidadAcademica`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `universidad`
--

DROP TABLE IF EXISTS `universidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `universidad` (
  `Id_universidad` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_universidad` varchar(60) NOT NULL,
  `Id_pais` int(11) NOT NULL,
  PRIMARY KEY (`Id_universidad`),
  KEY `fk_universidad_pais_idx` (`Id_pais`),
  CONSTRAINT `fk_universidad_pais` FOREIGN KEY (`Id_pais`) REFERENCES `pais` (`Id_pais`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `id_Usuario` int(11) NOT NULL AUTO_INCREMENT,
  `No_Empleado` varchar(13) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `Password` varbinary(250) NOT NULL,
  `Id_Rol` tinyint(4) NOT NULL,
  `Fecha_Creacion` date NOT NULL,
  `Fecha_Alta` date DEFAULT NULL,
  `Estado` tinyint(1) NOT NULL,
  `esta_logueado` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id_Usuario`),
  KEY `fk_usuarios_roles_idx` (`Id_Rol`),
  KEY `fk_usuario_empleado_idx` (`No_Empleado`),
  CONSTRAINT `fk_usuarios_roles` FOREIGN KEY (`Id_Rol`) REFERENCES `roles` (`Id_Rol`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_usuario_empleado` FOREIGN KEY (`No_Empleado`) REFERENCES `empleado` (`No_Empleado`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuario_alertado`
--

DROP TABLE IF EXISTS `usuario_alertado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario_alertado` (
  `Id_UsuarioAlertado` int(11) NOT NULL AUTO_INCREMENT,
  `Id_Alerta` int(11) NOT NULL,
  `Id_Usuario` int(11) NOT NULL,
  PRIMARY KEY (`Id_UsuarioAlertado`),
  KEY `fk_usuario_alertado_usuario_idx` (`Id_Usuario`),
  KEY `fk_usuario_alertado_alerta_idx` (`Id_Alerta`),
  CONSTRAINT `fk_usuario_alertado_alerta` FOREIGN KEY (`Id_Usuario`) REFERENCES `usuario` (`id_Usuario`),
  CONSTRAINT `fk_usuario_alertado_usuario` FOREIGN KEY (`Id_Alerta`) REFERENCES `alerta` (`Id_Alerta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuario_log`
--

DROP TABLE IF EXISTS `usuario_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario_log` (
  `Id_log` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` int(11) NOT NULL,
  `fecha_log` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ip_conn` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Id_log`)
) ENGINE=InnoDB AUTO_INCREMENT=262 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuario_notificado`
--

DROP TABLE IF EXISTS `usuario_notificado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario_notificado` (
  `Id_UsuarioNotificado` int(11) NOT NULL AUTO_INCREMENT,
  `Id_Notificacion` int(11) NOT NULL,
  `Id_Usuario` int(11) NOT NULL,
  `IdUbicacionNotificacion` tinyint(4) NOT NULL,
  `Estado` tinyint(11) NOT NULL,
  `Fecha` datetime NOT NULL,
  PRIMARY KEY (`Id_UsuarioNotificado`),
  KEY `fk_usuario_notificado_notificaciones_folios_idx` (`Id_Notificacion`),
  KEY `fk_usuario_notificado_ubicacion_notificacionesFolios` (`IdUbicacionNotificacion`),
  KEY `fk_usuario_notificado_usuario_idx` (`Id_Usuario`),
  CONSTRAINT `fk_usuario_notificado_notificaciones_folios` FOREIGN KEY (`Id_Notificacion`) REFERENCES `notificaciones_folios` (`Id_Notificacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_usuario_notificado_usuario` FOREIGN KEY (`Id_Usuario`) REFERENCES `usuario` (`id_Usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-08-12 21:33:25
