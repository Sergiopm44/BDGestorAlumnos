alumno-- MySQL Workbench Forward Engineering

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
  `dniA` INT NOT NULL AUTO_INCREMENT,
  `fechNa` DATE NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `telefono` INT NULL,
  `email` VARCHAR(45) NULL,
  `Curso_idCurso` INT NOT NULL,
  PRIMARY KEY (`dniA`, `Curso_idCurso`),
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
  `nif` INT NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(100) NOT NULL,
  `localidad` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  `cPostal` INT NOT NULL,
  `Telefono` INT NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`nif`))
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
  `dniP` INT NOT NULL AUTO_INCREMENT,
  `fechNa` DATE NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `telefono` INT NULL,
  `email` VARCHAR(45) NULL,
  `Departamentos_idDepartamentos` INT NOT NULL,
  PRIMARY KEY (`dniP`, `Departamentos_idDepartamentos`),
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
  `Profesores_dniP` INT NOT NULL,
  PRIMARY KEY (`Curso_idCurso`, `Profesores_dniP`),
  CONSTRAINT `fk_Curso_has_Profesores_Curso1`
    FOREIGN KEY (`Curso_idCurso`)
    REFERENCES `GestionAlumnos`.`Curso` (`idCurso`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Curso_has_Profesores_Profesores1`
    FOREIGN KEY (`Profesores_dniP`)
    REFERENCES `GestionAlumnos`.`Profesores` (`dniP`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;




-- -----------------------------------------------------
-- Table `GestionAlumnos`.`Curso_has_Centro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GestionAlumnos`.`Curso_has_Centro` (
  `Curso_idCurso` INT NOT NULL,
  `Centro_nif` INT NOT NULL,
  PRIMARY KEY (`Curso_idCurso`, `Centro_nif`),
  CONSTRAINT `fk_Curso_has_Centro_Curso1`
    FOREIGN KEY (`Curso_idCurso`)
    REFERENCES `GestionAlumnos`.`Curso` (`idCurso`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Curso_has_Centro_Centro1`
    FOREIGN KEY (`Centro_nif`)
    REFERENCES `GestionAlumnos`.`Centro` (`nif`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;