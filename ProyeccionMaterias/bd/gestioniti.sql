-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generacion: 19-10-2020 a las 20:12:55
-- Version del servidor: 10.4.11-MariaDB
-- Version de PHP: 7.2.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `gestioniti`
--
DROP DATABASE IF EXISTS gestioniti;
CREATE DATABASE gestioniti;
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumno`
--
USE gestioniti;
CREATE TABLE `alumno` (
  `idAlumno` int(11) NOT NULL,
  `Matricula` varchar(255) NOT NULL,
  `ApellidoPaterno` varchar(255) NOT NULL,
  `ApellidoMaterno` varchar(255) NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Contrasena` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Indices de la tabla `alumno`
--
ALTER TABLE `alumno`
  ADD PRIMARY KEY (`idAlumno`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `alumno`
--
ALTER TABLE `alumno`
  MODIFY `idAlumno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=225;
-- -----------------------------------------------------
-- Table `gestioniti`.`administrador`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gestioniti`.`administrador` ;

CREATE TABLE IF NOT EXISTS `gestioniti`.`administrador` (
  `idadministrador` INT NOT NULL,
  `contrasena` VARCHAR(45) NOT NULL,
  `Nombre` NVARCHAR(45) NOT NULL,
  `ApellidoP` NVARCHAR(45) NOT NULL,
  `ApellidoM` NVARCHAR(45) NOT NULL,
  PRIMARY KEY (`idadministrador`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gestioniti`.`materias`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gestioniti`.`materias` ;

CREATE TABLE IF NOT EXISTS `gestioniti`.`materias` (
  `idmaterias` NVARCHAR(45) NOT NULL,
  `Nombre` NVARCHAR(45) NOT NULL,
  `Periodo` INT NOT NULL,
  `Nivel` NVARCHAR(45) NOT NULL,
  `Area` NVARCHAR(45) NOT NULL,
  `Creditos` INT NOT NULL,
  `Semestre` iNT NOT NULL,
FULLTEXT (Nombre),
  PRIMARY KEY (`idmaterias`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gestioniti`.`pre requisitos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gestioniti`.`preRequisitos` ;

CREATE TABLE IF NOT EXISTS `gestioniti`.`preRequisitos` (
  `idRequisito` INT NOT NULL,
  `idmaterias` NVARCHAR(45) NOT NULL,
  `preRequisito` NVARCHAR(45) NULL,
  PRIMARY KEY (`idRequisito`),
  CONSTRAINT `fk_preRequisitos_materias`
    FOREIGN KEY (`idmaterias`)
    REFERENCES `gestioniti`.`materias` (`idmaterias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`alumno_has_materias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gestioniti`.`control_materias` (
  `idControl` INT NOT NULL AUTO_INCREMENT,
  `idAlumno` INT NOT NULL,
  `idmaterias` NVARCHAR(45) NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idControl`),
  CONSTRAINT `fk_control_materias_alumno`
    FOREIGN KEY (`idAlumno`)
    REFERENCES `gestioniti`.`alumno` (`idAlumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_control_materias_materias1`
    FOREIGN KEY (`idmaterias`)
    REFERENCES `gestioniti`.`materias` (`idmaterias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE gestioniti;


-- Insercion de materias

INSERT INTO materias(idmaterias, nombre, periodo, nivel, area, creditos,semestre) VALUES('IntMat', 'Introduccion a las matematicas', 1, 'Basico', 'Ciencias basicas', 6,1),
('IntPro', 'Introduccion a la programacion', 1, 'Basico', 'Modelado de sistemas', 6,1),
('TGS','Teoria general de sistemas y sistemas de infromacion', 1, 'Basico', 'Modelado de sistemas', 4,1),
('POOI', 'Programacion orientada a objetos 1', 2, 'Basico', 'Modelado de sistemas', 6,1),
('FHM', 'Formacion humana y social', 1, 'Basico', 'Formacion general universitaria', 4,1),
('LEN1','Lengua extranjera 1', 1, 'Basico', 'Formacion general universitaria', 4,1),
('CALDeI', 'Calculo diferencial e integral', 2, 'Basico', 'Ciencias basicas', 6,2),
('ALGL', 'Algebra lineal con aplicaciones', 2, 'Basico', 'Ciencias basicas', 6,2),
('MOD', 'Modelado de proceso de negocios', 2, 'Basico', 'Modelado de sistemas', 4,2),
('DHPC', 'Desarrollo humano del pensamiento critico', 2, 'Basico', 'Formacion general universitaria', 4,2),
('LEN2', 'Lengua extranjera II', 2, 'Basico', 'Formacion general universitaria', 4,2),
('PROBAyE', 'Probabilidad y estadistica', 3, 'Basico', 'Ciencias basicas', 6,3),
('MatDis', 'Matematicas discretas', 3, 'Basico', 'Ciencias basicas', 6,3),
('POOII', 'Programacion orientada a objetos 2', 3, 'Basico', 'Modelado de sistemas', 6,3),
('HerraW', 'Herramientas web', 3, 'Basico', 'Tecnologia', 6,3),
('LEN3', 'Lengua extranjera III', 3, 'Basico', 'Formacion general universitaria', 4,3),
('RedCom', 'Redes de computadoras', 4, 'Basico', 'Ciencias basicas', 6,4),
('MetEst', 'Metodos estadisticos', 4, 'Basico', 'Ciencias basicas', 6,4),
('IS1', 'Ingenieria de software I', 4, 'Basico', 'Modelado de sistemas', 6,4),
('DisBD', 'Diseño de base de datos', 4, 'Basico', 'Modelado de sistemas', 6,4),
('LEN4', 'Lengua extranjera IV', 4, 'Basico', 'Formacion general universitaria', 4,4),
('RedSer', 'Redes y servicios', 5, 'Formativo', 'Ciencias basicas', 6,5),
('FPL', 'Fundamentos de la programacion logica', 5, 'Formativo', 'Modelado de sistemas', 4,5),
('IS2', 'Ingenieria de software II', 5, 'Formativo', 'Modelado de sistemas', 6,5),
('AdmonBD', 'Administracion de base de datos', 5, 'Formativo', 'Modelado de sistemas', 6,5),
('AdmonSO', 'Administracion de sistemas operativos', 5, 'Formativo', 'Tecnologia', 7,5),
('AdmonRed', 'Administracion de redes', 6, 'Formativo', 'Tecnologia', 6,5),
('AdmonProy', 'Administracion de proyectos', 6, 'Formativo', 'Modelado de sistemas', 5,6),
('DisInt', 'Diseño de lainteraccion', 6, 'Formativo', 'Tecnologia', 6,6),
('MinDat', 'Mineria de datos', 6, 'Formativo', 'Tecnologia', 6,6),
('CompDis', 'Computo distribuido', 6, 'Formativo', 'Modelado de sistemas', 6,6),
('TecWeb', 'Tecnologias web', 6, 'Formativo', 'Modelado de sistemas', 6,6),
('CTRLC', 'Control de calidad y SW', 7, 'Formativo', 'Tecnologia', 6,7),
('IntNeg', 'Inteligencia de negocios', 7, 'Formativo', 'Tecnologia', 6,7),
('ModDW', 'Modelado de desarrollo web', 7, 'Formativo', 'Tecnologia', 6,7),
-- Optativa 1
-- Optativa DESIT
('ServSoc', 'Servicio social', 8, 'Formativo', '-', 10,8),
('TrabCol', 'Trabajo colaborativo', 8, 'Formativo', 'Tecnologia', 6,8),
('SerWeb', 'Servicios web', 8, 'Formativo', 'Tecnologia', 6,8),
-- Optativa 2
-- Optativa 3
('IntSyA', 'Integracion de sistemas y arquitecturas', 9, 'Formativo', 'Ciencias basicas', 6,9),
('PracPro', 'Practica profesional', 9, 'Formativo', '-', 5,9),
('ProgMovil', 'Programacion de dispositivos mobiles', 9, 'Formativo', 'Tecnologia', 6,9),
('PI+D1', 'Proyecto I+ D 1', 9, 'Formativo', 'Tecnologia', 5,9);


INSERT INTO preRequisitos(idRequisito, idMaterias, preRequisito) VALUES (1, 'CALDeI', 'IntMat'),
(2, 'ALGL', 'IntMat'), (3, 'POOI', 'IntPro'), (4, 'MOD', 'TGS'), (5, 'DHPC', 'FHM'),
(6, 'LEN2', 'LEN1'), (7, 'PROBAyE', 'CALDeI'), (8, 'MatDis', 'ALGL'), (9, 'POOII', 'POOI'),
(10, 'LEN3', 'LEN2'), (11, 'RedCom', 'PROBAyE'), (12, 'MetEst', 'PROBAyE'), (13, 'IS1', 'MOD'),
(14, 'DisBD', 'MOD'), (15, 'LEN4', 'LEN3'), (16, 'RedSer', 'RedCom'), (17, 'FPL', 'MatDis'),
(18, 'IS2', 'IS1'), (19, 'AdmonBD', 'DisBD'), (20, 'AdmonSO', 'POOII'), (21, 'AdmonRed', 'RedSer'),
(22, 'DisInt', 'IS2'), (23, 'MinDat', 'AdmonBD'), (24, 'CompDis', 'POOII'), (25, 'TecWeb', 'HerraW'),
(26, 'CTRLC', 'IS2'), (27, 'IntNeg', 'MinDat'), (28, 'ModDW', 'CompDis'), (29, 'ModDW', 'TecWeb'),
(30, 'TrabCol', 'ModDW'), (31, 'SerWeb', 'ModDW'), (32, 'IntSyA', 'RedCom'), (33, 'ProgMovil', 'RedCom'),
(34, 'PI+D1', 'AdmonProy'), (35, 'PI+D1', 'TecWeb');

--
-- Volcado de datos para la tabla `alumno`
--

INSERT INTO `alumno` (`idAlumno`, `Matricula`, `ApellidoPaterno`, `ApellidoMaterno`, `Nombre`, `Contrasena`) VALUES
(1, '201722320', 'GARDUZA', 'RIVEROLL', 'OMAR ALEJANDRO', '201722320'),
(2, '201637864', 'VILLARREAL', 'ONOFRE', 'ROSA LAURA', '201637864'),
(3, '201731245', 'MARTINEZ', 'FERNANDEZ', 'SERGIO ALBERTO', '201731245'),
(4, '201731153', 'CARMONA', 'AVENDAÑO', 'LLUVIA NAOMY', '201731153'),
(5, '201623399', 'BELLO', 'SPEZZIA', 'JORGE LUIS', '201623399'),
(6, '201731994', 'COBA', 'PULIDO', 'MARTIN', '201731994'),
(7, '201639995', 'AMADOR', 'BARRIENTOS', 'LUIS LEONARDO', '201639995'),
(8, '201730144', 'RODRIGUEZ', 'VAZQUEZ', 'LIZBETH', '201730144'),
(9, '201750132', 'CARRILLO', 'MONCAYO', 'EMILIANO', '201750132'),
(10, '201664780', 'HERNANDEZ', 'CUACUA', 'ROSA GABRIELA', '201664780'),
(11, '201634433', 'CALIXTO', 'CRUZ', 'ESTEBAN', '201634433'),
(12, '201738077', 'HERNaNDEZ', 'REYES', 'LUIS DAVID', '201738077'),
(13, '201648713', 'LoPEZ', 'ARAGoN', 'JORGE ALBERTO', '201648713'),
(14, '201742163', 'PEREZ', 'MONTIEL', 'DANIEL', '201742163'),
(15, '201632174', 'VIVEROS', 'JUAREZ', 'OLIVER YOUSU', '201632174'),
(16, '201738265', 'PASTEN', 'CASTAÑON', 'CHRISTIAN DE JESUS', '201738265'),
(17, '201755917', 'CANIZO', 'CORTES', 'DAVID', '201755917'),
(18, '201733898', 'SALAZAR', 'BARAJAS', 'CARLOS NOe', '201733898'),
(19, '201756396', 'CRUZ', 'ZAMORA', 'MARiA FERNANDA', '201756396'),
(20, '201744183', 'QUIROZ', 'CUAUTLE', 'DAMARIS LIZBETH', '201744183'),
(21, '201642459', 'MOLINA', 'LECHUGA', 'JORGE', '201642459'),
(22, '201643509', 'RUBIO', 'QUINTERO', 'REBECA', '201643509'),
(23, '201664822', 'ROSAS', 'ORTEGA', 'SANDRA DANAE', '201664822'),
(24, '201624127', 'LOPEZ', 'HERNANDEZ', 'CHRISTIAN DE JESUS', '201624127'),
(25, '201728123', 'FUENTES', 'PEREZ', 'MARiA JOSe', '201728123'),
(26, '201749651', 'VAZQUEZ', 'ARCE', 'SARAHI', '201749651'),
(27, '201732709', 'CAMPOS', 'VAZQUEZ', 'VICTOR MANUEL', '201732709'),
(28, '201648521', 'FLORES', 'CABAÑAS', 'JUAN PABLO', '201648521'),
(29, '201738087', 'HUERTA', 'GARCIA', 'JOSE CARLOS', '201738087'),
(30, '201758049', 'MARTINEZ', 'HERNANDEZ', 'GERARDO', '201758049'),
(31, '201759869', 'SOSA', 'SaNCHEZ', 'ODILON', '201759869'),
(32, '201630062', 'GALGUERA', 'CABALLERO', 'ALFONSO', '201630062'),
(33, '201661597', 'HERNANDEZ', 'LUNA', 'EDGAR', '201661597'),
(34, '201657415', 'TAPIA', 'OCAÑA', 'BRENDA ARIADNA', '201657415'),
(35, '201772239', 'MALAGoN', 'ORTiZ', 'OSCAR AMADEUS', '201772239'),
(36, '201735076', 'GARNICA', 'SANCHEZ', 'DANIEL', '201735076'),
(37, '201728869', 'PACIFUENTES', 'HERNaNDEZ', 'FRANCISCO ALEJANDRO', '201728869'),
(38, '201621582', 'PATRICIO', 'HERNANDEZ', 'OSCAR', '201621582'),
(39, '201750069', 'BERRA', 'SALAZAR', 'HUGO', '201750069'),
(40, '201624306', 'MONFIL', 'QUIJANO', 'JIUBER', '201624306'),
(41, '201726720', 'CASELIN', 'COVARRUBIAS', 'GUILLERMO', '201726720'),
(42, '201735836', 'MARQUEZ', 'GARCIA', 'OMAR FERNANDO', '201735836'),
(43, '201718099', 'GONZALEZ', 'AVENDAÑO', 'ROBERTO CARLOS', '201718099'),
(44, '201733550', 'FLORES', 'GARCIA', 'ALEJANDRA LIZBETH', '201733550'),
(45, '201629266', 'AMADOR', 'ORTIZ', 'LUIS ANGEL', '201629266'),
(46, '201729158', 'MORENO', 'HERNANDEZ', 'NADIA FERNANDA', '201729158'),
(47, '201765959', 'GENIS', 'DE LA ROSA', 'ANGEL RICARDO', '201765959'),
(48, '201658563', 'LOZADA', 'MENDOZA', 'DYLAN SALOMON', '201658563'),
(49, '201641378', 'GONZALEZ', 'VILLEGAS', 'IVAN', '201641378'),
(50, '201626983', 'CARRANZA', 'LOPEZ', 'SARBIA SARAHI', '201626983'),
(51, '201748452', 'FLORES', 'HERNANDEZ', 'DIANA', '201748452'),
(52, '201768725', 'RAMIREZ', 'JACOBO', 'CRISTINA', '201768725'),
(53, '201711847', 'GOMEZ', 'JUAREZ', 'MARIA LUISA', '201711847'),
(54, '201734804', 'IBAÑEZ', 'DE OLMOS', 'JOAQUIN ANTONIO', '201734804'),
(55, '201734061', 'ESTRADA', 'BERISTAIN', 'BRAYAN NOe', '201734061'),
(56, '201748095', 'BANDERAS', 'BARRERA', 'LUIS ROLANDO', '201748095'),
(57, '201739966', 'GARGALLO', 'RUBIO', 'JONATHAN INOCENTE', '201739966'),
(58, '201740571', 'SORIANO', 'SOLIS', 'MISSAEL', '201740571'),
(59, '201734175', 'ORTEGA', 'MUÑOZ', 'LIZBETH', '201734175'),
(60, '201765852', 'GAONA', 'FUENTES', 'FERNANDO', '201765852'),
(61, '201624193', 'LoPEZ', 'ESCAMILLA', 'EDGAR', '201624193'),
(62, '201631524', 'RIVERA', 'LUNA', 'BRAYAN JOSHUA', '201631524'),
(63, '201664726', 'PANIAGUA', 'RAMOS', 'JORGE ANTONIO', '201664726'),
(64, '201756698', 'FLORES', 'BASILIO', 'ABRAHAM', '201756698'),
(65, '201770169', 'TREJO', 'OLVERA', 'EMMANUEL', '201770169'),
(66, '201711039', 'CUAHUTLE', 'GRACIDAS', 'ORLANDO', '201711039'),
(67, '201636396', 'MONTIEL', 'ESTRADA', 'MAYRA VANESSA', '201636396'),
(68, '201772447', 'CORTES', 'FRANCO', 'CHRISTOPHER', '201772447'),
(69, '201618364', 'ORTIZ', 'MITRE', 'NOEL ANDREW', '201618364'),
(70, '201630954', 'MONTES', 'GoMEZ', 'MARIO', '201630954'),
(71, '201636121', 'MENDEZ', 'SUAREZ', 'ISMAEL', '201636121'),
(72, '201725532', 'GoMEZ', 'VILLEGAS', 'aNGEL', '201725532'),
(73, '201703609', 'RIVEROS', 'HERNANDEZ', 'ARTURO', '201703609'),
(74, '201744278', 'RUIZ', 'CARRERA', 'JORGE ERNESTO', '201744278'),
(75, '201728890', 'ROMAN', 'MERINO', 'JESUS', '201728890'),
(76, '201733645', 'HUERTA', 'RAMOS', 'SAUL ALEJANDRO', '201733645'),
(77, '201736923', 'ANTONIO', 'POBLANO', 'DANIEL', '201736923'),
(78, '201726925', 'OLIVARES', 'ARROYO', 'LISSETTE', '201726925'),
(79, '201636798', 'PEREZ', 'SAN MARITN', 'LUIS ADRIAN', '201636798'),
(80, '201743414', 'CARREON', 'VAZQUEZ', 'MIGUEL ANGEL', '201743414'),
(81, '201738580', 'BRIONES', 'NOCHEBUENA', 'CARLOS', '201738580'),
(82, '201743860', 'LOZANO', 'RAMOS', 'JULIO ROBERTO', '201743860'),
(83, '201621922', 'VALERA', 'FURLONG', 'DANIEL', '201621922'),
(84, '201764091', 'CARRETO', 'XOCHIPILTECATL', 'DANIEL', '201764091'),
(85, '201624390', 'MARTINEZ', 'VASQUEZ', 'KEBYN CRISTOPHER', '201624390'),
(86, '201744272', 'ROMERO', 'XICOTENCATL', 'RAFAEL', '201744272'),
(87, '201768581', 'PEÑA', 'MORA', 'KEVIN', '201768581'),
(88, '201764720', 'CRUZ', 'PELaEZ', 'JUAN PABLO ENRIQUE', '201764720'),
(89, '201766290', 'HERNANDEZ', 'VAZQUEZ', 'DAVID', '201766290'),
(90, '201749575', 'TENORIO', 'LoPEZ', 'LUIS ARTURO', '201749575'),
(91, '201653936', 'PORTILLO', 'SANCHEZ', 'MONICA', '201653936'),
(92, '201746033', 'RODRiGUEZ', 'PEDROZA', 'ERIK FERNANDO', '201746033'),
(93, '201759555', 'RUIZ', 'GOMEZ', 'IVAN RAFAEL', '201759555'),
(94, '201643839', 'SARMIENTO', 'BARRIOS', 'ESTEFANIA', '201643839'),
(95, '201772452', 'CORTINA', 'GARCIA', 'JESUS DAVID', '201772452'),
(96, '201768606', 'PORRAS', 'MENeNDEZ', 'RAFAEL', '201768606'),
(97, '201767116', 'MALDONADO', 'RODRIGUEZ', 'MITZI LIZBETH', '201767116'),
(98, '201744202', 'RAMIREZ', 'SEGURA', 'AYRAN GERARDO', '201744202'),
(99, '201624552', 'PEREIRA', 'LANDAVERDE', 'LUIS OSCAR', '201624552'),
(100, '201647957', 'GALINDO', 'FLORES', 'SAID', '201647957'),
(101, '201730081', 'LOPEZ', 'ANTONIO', 'EDUARDO', '201730081'),
(102, '201625290', 'TRUJILLO', 'MACHORRO', 'EDUARDO', '201625290'),
(103, '201701240', 'DURANGO', 'TORRES', 'JARELLY FaTIMA', '201701240'),
(104, '201770730', 'ZARATE', 'OCAÑA', 'MELANIE', '201770730'),
(105, '201619690', 'CASTILLO', 'MORALES', 'CITLALI', '201619690'),
(106, '201648232', 'GOVEA', 'SAUCEDO', 'MITSU BIALI', '201648232'),
(107, '201766540', 'JAIMES', 'RUIZ', 'ANDRES', '201766540'),
(108, '201768230', 'OSORNO', 'FLORES', 'LUIS GUSTAVO', '201768230'),
(109, '201702242', 'ANCHEYTA', 'COTZOMI', 'LUIS FERNANDO', '201702242'),
(110, '201758356', 'MARCIAL', 'MARIN', 'ALAN JAMIT', '201758356'),
(111, '201660753', 'RAMIREZ', 'JUAREZ', 'JUAN CARLOS', '201660753'),
(112, '201624239', 'MARTINEZ', 'CRUZ', 'MARCO ANTONIO', '201624239'),
(113, '201631751', 'SANCHEZ', 'AQUINO', 'EDUARDO IVAN', '201631751'),
(114, '201652632', 'CAMPOS', 'FLORES', 'MARIA ESTRELLITA', '201652632'),
(115, '201735084', 'SANDOVAL', 'ROMERO', 'RAYMUNDO', '201735084'),
(116, '201756985', 'GOMEZ', 'MARTINEZ', 'JOHAN SAID', '201756985'),
(117, '201758479', 'MOMOX', 'RAMIRO', 'MIGUEL ANGEL', '201758479'),
(118, '201758614', 'OCELOTL', 'ROMERO', 'JUAN PABLO', '201758614'),
(119, '201741793', 'CUEVAS', 'COUTIÑO', 'IVAN', '201741793'),
(120, '201766428', 'HERNANDEZ', 'CAMPOS', 'MARCOS', '201766428'),
(121, '201770786', 'ZARATE', 'YAÑEZ', 'CRISTIAN', '201770786'),
(122, '201749978', 'ALTAMIRANO', 'AReVALO', 'JAIME ANTONIO', '201749978'),
(123, '201651083', 'SANCHEZ', 'PEREZ', 'CARLOS', '201651083'),
(124, '201619624', 'DURAN', 'PEREZ', 'ISAI', '201619624'),
(125, '201727178', 'HERNANDEZ', 'VIVANCO', 'CARLOS', '201727178'),
(126, '201745018', 'CRUZ', 'GARCIA', 'JORGE ANTONIO', '201745018'),
(127, '201733667', 'JIMeNEZ', 'ABASOLO', 'GERMaN ALEJANDRO', '201733667'),
(128, '201708677', 'MARTINEZ', 'ROCHA', 'CHRISTIAN ALEJANDRO', '201708677'),
(129, '201632456', 'RIVERA', 'GUERRERO', 'JUAN CARLOS', '201632456'),
(130, '201750228', 'CRUZ', 'RUBIN', 'LUIS EDUARDO', '201750228'),
(131, '201737219', 'TAPIA', 'HERNANDEZ', 'OMAR', '201737219'),
(132, '201631301', 'PEREZ', 'GARCIA', 'NANCY', '201631301'),
(133, '201730865', 'MARIE', 'SANCHEZ', 'MIGUEL ANGEL', '201730865'),
(134, '201752072', 'SANTOS', 'RAMIREZ', 'EVELIN JASURI', '201752072'),
(135, '201755710', 'AVILA', 'SANCHEZ', 'RODOLFO', '201755710'),
(136, '201757181', 'GARCiA', 'GONZaLEZ', 'ALFREDO', '201757181'),
(137, '201619638', 'APARICIO', 'RUIZ', 'ARTURO', '201619638'),
(138, '201652547', 'CHAVEZ', 'QUIEBRAS', 'ALVARO', '201652547'),
(139, '201652463', 'CALDERON', 'MEIXUEIRO', 'RICARDO', '201652463'),
(140, '201617565', 'CORTES', 'VILLEGAS', 'DIEGO ROBERTO', '201617565'),
(141, '201726821', 'GONZaLEZ', 'CARVAJAL', 'JOSE LUIS', '201726821'),
(142, '201763490', 'AGUIRRE', 'MARTINEZ', 'ARMANDO', '201763490'),
(143, '201643277', 'RAMOS', 'GAMBOA', 'BRHAYAN', '201643277'),
(144, '201658280', 'BLAS', 'ROMERO', 'CARLOS SANTIAGO', '201658280'),
(145, '201766967', 'LIMA', 'BELLO', 'JESUS BRAYAN', '201766967'),
(146, '201620213', 'RODRIGUEZ', 'RUIZ', 'JOSE EDUARDO', '201620213'),
(147, '201759644', 'SANCHEZ', 'LOPEZ', 'FERNANDO', '201759644'),
(148, '201658357', 'CASTRO', 'BALBUENA', 'DIEGO ISUI', '201658357'),
(149, '201621530', 'NÚÑEZ', 'ZAVALA', 'MARIO ALONSO', '201621530'),
(150, '201654266', 'SANDOVAL', 'MENDOZA', 'JOSE RICARDO', '201654266'),
(151, '201744288', 'RAMIREZ', 'SALDiVAR', 'JORGE JOVANNI', '201744288'),
(152, '201769502', 'SANCHEZ', 'SANCHEZ', 'LUIS ANGEL', '201769502'),
(153, '201741962', 'HERNANDEZ', 'COCA', 'OSCAR', '201741962'),
(154, '201748450', 'FLORES', 'GARCIA', 'GERARDO', '201748450'),
(155, '201647907', 'FERNANDEZ', 'PEREZ', 'DAVID', '201647907'),
(156, '201765309', 'FLORES', 'GARCIA', 'MISAEL', '201765309'),
(157, '201629264', 'AMADOR', 'FLORES', 'LUIS ALBERTO', '201629264'),
(158, '201733505', 'DE', 'JESUS', 'GONZALEZ ALFONSO', '201733505'),
(159, '201768276', 'PARADA', 'HERNaNDEZ', 'MARIA ISABEL', '201768276'),
(160, '201651454', 'TEJEDA', 'SANTOS', 'DAVID ORLANDO', '201651454'),
(161, '201654937', 'SaNCHEZ', 'PADILLA', 'ITZEL', '201654937'),
(162, '201664768', 'MALDONADO', 'GUTIERREZ', 'MARCO ANTONIO', '201664768'),
(163, '201630140', 'GOMEZ', 'CABRERA', 'LUIS ALBERTO', '201630140'),
(164, '201642924', 'PALESTINA', 'CURIEL', 'EDWIN URBANO', '201642924'),
(165, '201763530', 'ALVARADO', 'BUENO', 'JESUS FERNANDO', '201763530'),
(166, '201764936', 'DEL VALLE', 'LoPEZ', 'JESUS EDUARDO', '201764936'),
(167, '201635684', 'HERNaNDEZ', 'VARGAS', 'JOSe ANTONIO', '201635684'),
(168, '201719869', 'RIVERA', 'RAMOS', 'MAYDI', '201719869'),
(169, '201636378', 'MORALES', 'CASTILLO', 'JULIO DAVID', '201636378'),
(170, '201654584', 'VIOLANTE', 'ARRIAGA', 'IVAN ALEXIS', '201654584'),
(171, '201640543', 'COLoN', 'GARRIDO', 'MARIO ALEJANDRO', '201640543'),
(172, '201662524', 'VIVAR', 'LEAL', 'ALAN', '201662524'),
(173, '201746008', 'RAMiREZ', 'NAVOR', 'JESÚS ALEXIS', '201746008'),
(174, '201765485', 'GARCIA', 'LUNA', 'MARCOS EMMANUEL', '201765485'),
(175, '201744164', 'PAREDES', 'PeREZ', 'DIANA MELISSA', '201744164'),
(176, '201658508', 'HERNANDEZ', 'NEGRETE', 'DANIEL IVAN', '201658508'),
(177, '201661512', 'GONZaLEZ', 'AGUILAR', 'JUNIOR ALEJANDRO', '201661512'),
(178, '201653704', 'MICHIMANI', 'CAMARGO', 'JOSe FERNANDO', '201653704'),
(179, '201634242', 'AMARO', 'JUaREZ', 'SAÚL VICENTE', '201634242'),
(180, '201650369', 'HERNANDEZ', 'CAMPOS', 'SANDRA MARIA', '201650369'),
(181, '201643734', 'SALINAS', 'LOPEZ', 'JUAN FELIPE', '201643734'),
(182, '201625100', 'VASQUEZ', 'SALAUS', 'INGRIND ITZEL', '201625100'),
(183, '201769797', 'SALINAS', 'RAMiREZ', 'CHRISTIAN ABRAHAM', '201769797'),
(184, '201630116', 'GARCIA', 'SARMIENTO', 'GUILLERMO', '201630116'),
(185, '201649648', 'RODRIGUEZ', 'BELEN', 'JOSUE DAVID', '201649648'),
(186, '201624026', 'HERNANDEZ', 'HERNANDEZ', 'LUIS ANGEL', '201624026'),
(187, '201743556', 'FERNaNDEZ', 'GoMEZ', 'JOSe ENRIQUE', '201743556'),
(188, '201742253', 'RANGEL', 'ROSAS', 'EDGAR', '201742253'),
(189, '201648244', 'GUTIERREZ', 'HERNANDEZ', 'ROBERTO CARLOS', '201648244'),
(190, '201637910', 'ZEMPOALTECATL', 'LOPEZ', 'IRBIN ISAI', '201637910'),
(191, '201764282', 'CORDERO', 'CRISOSTOMO', 'MARCOS', '201764282'),
(192, '201749893', 'ALEJO', 'CARCAMO', 'JESUS HOSMAN', '201749893'),
(193, '201647003', 'APANCO', 'GUTIERREZ', 'ALVARO', '201647003'),
(194, '201771446', 'PINEDA', 'MOLINA', 'HECTOR ADRIAN', '201771446'),
(195, '201758719', 'ORTIZ', 'GUZMaN', 'MAXIMILIANO', '201758719'),
(196, '201739818', 'CABRERA', 'LANDOIS', 'GUILLERMO ARMANDO', '201739818'),
(197, '201644111', 'TORRES', 'LOPEZ', 'JOSE ALFREDO', '201644111'),
(198, '201627054', 'CARLOS', 'ORTEGA', 'ALEJANDRO AXAYACATL', '201627054'),
(199, '201635527', 'HERNANDEZ', 'HERNANDEZ', 'RICARDO', '201635527'),
(200, '201648688', 'LOPEZ', 'MORALES', 'MARIANO', '201648688'),
(201, '201770225', 'TIRO', 'ECATL', 'JOSUE ALEJANDRO', '201770225'),
(202, '201657805', 'CARIÑO', 'REYES', 'RENE', '201657805'),
(203, '201842437', 'HERNANDEZ', 'SANCHEZ', 'LUIS FERNANDO', '201842437'),
(204, '201864394', 'NAVARRO', 'LAZCANO', 'MONSERRAT', '201864394'),
(205, '201833163', 'HERRERA', 'CHAVEZ', 'REBECA', '201833163'),
(206, '201860744', 'FLORES', 'ARRIAGA', 'MARIANA BELEN', '201860744'),
(207, '201858919', 'BAROJAS', 'GARCIA', 'ROCIO', '201858919'),
(208, '201862930', 'LEON', 'SERRANO', 'ESTEBAN MIGUEL', '201862930'),
(209, '201853797', 'PABLO', 'SANTOS', 'JUAN CARLOS', '201853797'),
(210, '201829255', 'LUIS', 'ALBERTO', 'MAUPOME TOLEDANO', '201829255'),
(211, '201853977', 'RIVERA', 'HERNANDEZ', 'ALMA ILEANA', '201853977'),
(212, '201843788', 'GALLOSO', 'TAPIA', 'LUIS DONALDO', '201843788'),
(213, '201848290', 'PeREZ', 'PeREZ', 'STEPHANE', '201848290'),
(214, '201853158', 'LoPEZ', 'SOSA', 'ITZEL', '201853158'),
(215, '201848052', 'MARTINEZ', 'GONZALEZ', 'LUIS ALBERTO', '201848052'),
(216, '201848839', 'TORIZ', 'SANCHEZ', 'ELIA MARIA', '201848839'),
(217, '201865950', 'RAMiREZ', 'SANTIAGO', 'GENARO', '201865950'),
(218, '201829153', 'ACOLTZI', 'RUIZ', 'ALEX URIEL', '201829153'),
(219, '201861680', 'GUTIeRREZ', 'LEoN', 'RICARDO IGNACIO', '201861680'),
(220, '201852626', 'GARCIA', 'MeNDEZ', 'SAUL', '201852626'),
(221, '201854404', 'SOSA', 'VEGA', 'JOSe CARLOS', '201854404'),
(222, '201874722', 'MaRQUEZ', 'TEPOX', 'LAURA PATRICIA', '201874722'),
(223, '201847578', 'HERNANDEZ', 'GARCIA', 'TOMAS', '201847578'),
(224, '201859386', 'CHIQUITO', 'ONOFRE', 'HUGO ALEXIS', '201859386');

INSERT INTO control_materias(idAlumno, idmaterias, estado) VALUES (211,'IntMat', 'Finalizado'),
(211, 'MOD', 'En curso'),(211,'IntPro', 'Finalizado'),(211,'TGS', 'Finalizado'), (211,'FHM', 'Finalizado'),
(211,'LEN1', 'Finalizado'), (211, 'CALDeI', 'En curso'),(211, 'ALGL', 'En curso'), (211, 'POOI', 'En curso'),
(211, 'DHPC', 'En curso'),(211, 'LEN2', 'En curso'), (211,'PROBAyE','Pendiente'),(211,'MatDis','Pendiente'),
(211,'POOII','Pendiente'),(211,'HerraW','Pendiente'),(211,'LEN3','Pendiente'),(211,'RedCom','Pendiente'),
(211,'MetEst','Pendiente'),(211,'IS1','Pendiente'),(211,'DisBD','Pendiente'),(211,'LEN4','Pendiente'),
(211,'RedSer','Pendiente'),(211,'FPL','Pendiente'),(211,'IS2','Pendiente'),(211,'AdmonBD','Pendiente'),
(211,'AdmonSO','Pendiente'),(203, 'IntMat', 'Finalizado'), (203, 'IntPro', 'Finalizado'),
(203, 'TGS', 'Finalizado'), (203, 'LEN1', 'Finalizado'), (203, 'FHM', 'Finalizado'), (203, 'CALDeI', 'Finalizado'),
(203, 'ALGL', 'Finalizado'), (203, 'POOI', 'Finalizado'), (203, 'MOD', 'Finalizado'), (203, 'DHPC', 'Finalizado'),
(203, 'LEN2', 'Finalizado'), (203, 'PROBAyE', 'Finalizado'), (203, 'MatDis', 'Finalizado'), (203, 'POOII', 'Finalizado'),
(203, 'HerraW', 'Finalizado'), (203, 'LEN3', 'Finalizado'), (203, 'RedCom', 'Finalizado'), (203, 'MetEst', 'En curso'),
(203, 'IS1', 'Finalizado'), (203, 'DisBD', 'Finalizado'), (203, 'LEN4', 'Finalizado'), (203, 'FPL', 'En curso'),
(203, 'IS2', 'En curso'), (203, 'AdmonBD', 'En curso'), (203, 'AdmonSO', 'En curso');

INSERT INTO control_materias(idAlumno, idmaterias, estado) VALUES (203,'AdmonRed','Pendiente'),(203,'AdmonProy','Pendiente'),
(203,'DisInt','Pendiente'),(203,'MinDat','Pendiente'),(203,'CompDis','Pendiente'),(203,'TecWeb','Pendiente'),
(203,'CTRLC','Pendiente'),(203,'IntNeg','Pendiente'),(203,'ModDW','Pendiente');

--
-- indices para tablas volcadas
--

--

COMMIT;

insert into administrador (idadministrador,contrasena,nombre,ApellidoP,ApellidoM) values
(1001,1001,'Armando','Rios','Acevedo');
alter table alumno ADD PeriodoAct int(11) NOT NULL after idAlumno;
UPDATE alumno set PeriodoAct=5 where idAlumno =203;
UPDATE alumno set PeriodoAct=2 where idAlumno =211;
UPDATE control_materias set estado="Pendiente" where idmaterias ="ALGL" and idAlumno=203;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
