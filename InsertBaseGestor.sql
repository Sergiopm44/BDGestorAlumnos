-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema GestionAlumnos
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema GestionAlumnos
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `GestionAlumnos` DEFAULT CHARACTER SET utf8 ;
USE `GestionAlumnos` ;

-- -----------------------------------------------------
-- Table `GestionAlumnos`.`Curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GestionAlumnos`.`Curso` (
  `idCurso` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`idCurso`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GestionAlumnos`.`Alumno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GestionAlumnos`.`Alumno` (
  `idAlumno` INT NOT NULL AUTO_INCREMENT,
  `dniA` VARCHAR(9) NOT NULL,
  `fechNa` DATE NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `usuario` VARCHAR(45) NOT NULL,
  `contrasenia` VARCHAR(45) NOT NULL,
  `telefono` INT NULL,
  `email` VARCHAR(45) NULL,
  `Curso_idCurso` INT NOT NULL,
  PRIMARY KEY (`idAlumno`, `dniA`, `Curso_idCurso`),
  INDEX `fk_Alumno_Curso_idx` (`Curso_idCurso` ASC) ,
  CONSTRAINT `fk_Alumno_Curso`
    FOREIGN KEY (`Curso_idCurso`)
    REFERENCES `GestionAlumnos`.`Curso` (`idCurso`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GestionAlumnos`.`Centro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GestionAlumnos`.`Centro` (
  `idCentro` INT NOT NULL AUTO_INCREMENT,
  `nif` INT NOT NULL,
  `direccion` VARCHAR(100) NOT NULL,
  `localidad` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  `cPostal` INT NOT NULL,
  `Telefono` INT NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCentro`, `nif`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GestionAlumnos`.`Departamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GestionAlumnos`.`Departamentos` (
  `idDepartamentos` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(150) NOT NULL,
  `numDepartamento` INT NOT NULL,
  PRIMARY KEY (`idDepartamentos`))
ENGINE = MRG_MyISAM;


-- -----------------------------------------------------
-- Table `GestionAlumnos`.`Profesores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GestionAlumnos`.`Profesores` (
  `idProfesor` INT NOT NULL AUTO_INCREMENT,
  `dniP` VARCHAR(9) NOT NULL,
  `fechNa` DATE NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `usuario` VARCHAR(45) NOT NULL,
  `contrasenia` VARCHAR(45) NOT NULL,
  `telefono` INT NULL,
  `email` VARCHAR(45) NULL,
  `Departamentos_idDepartamentos` INT NOT NULL,
  PRIMARY KEY (`idProfesor`, `dniP`, `Departamentos_idDepartamentos`),
  INDEX `fk_Profesores_Departamentos1_idx` (`Departamentos_idDepartamentos` ASC) ,
  CONSTRAINT `fk_Profesores_Departamentos1`
    FOREIGN KEY (`Departamentos_idDepartamentos`)
    REFERENCES `GestionAlumnos`.`Departamentos` (`idDepartamentos`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GestionAlumnos`.`Curso_has_Profesores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GestionAlumnos`.`Curso_has_Profesores` (
  `Curso_idCurso` INT NOT NULL,
  `Profesores_idProfesor` INT NOT NULL,
  `Profesores_dniP` VARCHAR(9) NOT NULL,
  `Profesores_Departamentos_idDepartamentos` INT NOT NULL,
  PRIMARY KEY (`Curso_idCurso`, `Profesores_idProfesor`, `Profesores_dniP`, `Profesores_Departamentos_idDepartamentos`),
  INDEX `fk_Curso_has_Profesores_Profesores1_idx` (`Profesores_idProfesor` ASC, `Profesores_dniP` ASC, `Profesores_Departamentos_idDepartamentos` ASC) ,
  INDEX `fk_Curso_has_Profesores_Curso1_idx` (`Curso_idCurso` ASC) ,
  CONSTRAINT `fk_Curso_has_Profesores_Curso1`
    FOREIGN KEY (`Curso_idCurso`)
    REFERENCES `GestionAlumnos`.`Curso` (`idCurso`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Curso_has_Profesores_Profesores1`
    FOREIGN KEY (`Profesores_idProfesor` , `Profesores_dniP` , `Profesores_Departamentos_idDepartamentos`)
    REFERENCES `GestionAlumnos`.`Profesores` (`idProfesor` , `dniP` , `Departamentos_idDepartamentos`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GestionAlumnos`.`Curso_has_Centro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GestionAlumnos`.`Curso_has_Centro` (
  `Curso_idCurso` INT NOT NULL,
  `Centro_idCentro` INT NOT NULL,
  `Centro_nif` INT NOT NULL,
  PRIMARY KEY (`Curso_idCurso`, `Centro_idCentro`, `Centro_nif`),
  INDEX `fk_Curso_has_Centro_Centro1_idx` (`Centro_idCentro` ASC, `Centro_nif` ASC) ,
  INDEX `fk_Curso_has_Centro_Curso1_idx` (`Curso_idCurso` ASC) ,
  CONSTRAINT `fk_Curso_has_Centro_Curso1`
    FOREIGN KEY (`Curso_idCurso`)
    REFERENCES `GestionAlumnos`.`Curso` (`idCurso`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Curso_has_Centro_Centro1`
    FOREIGN KEY (`Centro_idCentro` , `Centro_nif`)
    REFERENCES `GestionAlumnos`.`Centro` (`idCentro` , `nif`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

