-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema happyhousegpj
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema happyhousegpj
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `happyhousegpj` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `happyhousegpj` ;

-- -----------------------------------------------------
-- Table `happyhousegpj`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhousegpj`.`user` (
  `iduser` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NULL DEFAULT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `addr` VARCHAR(45) NULL DEFAULT NULL,
  `findpwdkey` VARCHAR(45) NOT NULL,
  `addrcert` VARCHAR(1) NULL DEFAULT 'N',
  `sidoAddr` VARCHAR(45) NOT NULL,
  `gugunAddr` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`iduser`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `happyhousegpj`.`admin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhousegpj`.`admin` (
  `iduser` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`iduser`),
  CONSTRAINT `admin_FK_iduser`
    FOREIGN KEY (`iduser`)
    REFERENCES `happyhousegpj`.`user` (`iduser`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `happyhousegpj`.`sidocode`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhousegpj`.`sidocode` (
  `sidoCode` VARCHAR(10) NOT NULL,
  `sidoName` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`sidoCode`),
  UNIQUE INDEX `sidoName` (`sidoName` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `happyhousegpj`.`dongcode`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhousegpj`.`dongcode` (
  `dongCode` VARCHAR(10) NOT NULL,
  `sidoName` VARCHAR(30) NULL DEFAULT NULL,
  `gugunName` VARCHAR(30) NULL DEFAULT NULL,
  `dongName` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`dongCode`),
  INDEX `sidoName` (`sidoName` ASC) VISIBLE,
  CONSTRAINT `dongcode_ibfk_1`
    FOREIGN KEY (`sidoName`)
    REFERENCES `happyhousegpj`.`sidocode` (`sidoName`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `happyhousegpj`.`baseaddress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhousegpj`.`baseaddress` (
  `no` INT NOT NULL AUTO_INCREMENT,
  `sidoName` VARCHAR(30) NULL DEFAULT NULL,
  `gugunName` VARCHAR(30) NULL DEFAULT NULL,
  `dongName` VARCHAR(30) NULL DEFAULT NULL,
  `dongCode` VARCHAR(10) NULL DEFAULT NULL,
  `lat` VARCHAR(20) NULL DEFAULT NULL,
  `lng` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`no`),
  INDEX `dongCode` (`dongCode` ASC) VISIBLE,
  CONSTRAINT `baseaddress_ibfk_1`
    FOREIGN KEY (`dongCode`)
    REFERENCES `happyhousegpj`.`dongcode` (`dongCode`))
ENGINE = InnoDB
AUTO_INCREMENT = 3597
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `happyhousegpj`.`community`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhousegpj`.`community` (
  `idx` INT NOT NULL AUTO_INCREMENT,
  `iduser` VARCHAR(45) NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `content` VARCHAR(100) NOT NULL,
  `regitime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idx`))
ENGINE = InnoDB
AUTO_INCREMENT = 24
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `happyhousegpj`.`cummunityreply`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhousegpj`.`cummunityreply` (
  `idx` INT NOT NULL,
  `iduser` VARCHAR(45) NOT NULL,
  `content` VARCHAR(100) NOT NULL,
  `regitime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `no` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`no`),
  INDEX `idx` (`idx` ASC) VISIBLE,
  INDEX `iduser` (`iduser` ASC) VISIBLE,
  CONSTRAINT `cummunityreply_ibfk_1`
    FOREIGN KEY (`idx`)
    REFERENCES `happyhousegpj`.`community` (`idx`),
  CONSTRAINT `cummunityreply_ibfk_2`
    FOREIGN KEY (`iduser`)
    REFERENCES `happyhousegpj`.`user` (`iduser`))
ENGINE = InnoDB
AUTO_INCREMENT = 27
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `happyhousegpj`.`file_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhousegpj`.`file_info` (
  `commu_idx` INT NULL DEFAULT NULL,
  `savefolder` VARCHAR(45) NOT NULL,
  `originfile` VARCHAR(45) NOT NULL,
  `savefile` VARCHAR(100) NOT NULL,
  INDEX `commu_idx` (`commu_idx` ASC) VISIBLE,
  CONSTRAINT `file_info_ibfk_1`
    FOREIGN KEY (`commu_idx`)
    REFERENCES `happyhousegpj`.`community` (`idx`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `happyhousegpj`.`guguncode`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhousegpj`.`guguncode` (
  `gugunCode` VARCHAR(10) NOT NULL,
  `gugunName` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`gugunCode`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `happyhousegpj`.`houseinfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhousegpj`.`houseinfo` (
  `aptCode` INT NOT NULL,
  `aptName` VARCHAR(50) NULL DEFAULT NULL,
  `dongCode` VARCHAR(10) NULL DEFAULT NULL,
  `dongName` VARCHAR(30) NULL DEFAULT NULL,
  `buildYear` INT NULL DEFAULT NULL,
  `jibun` VARCHAR(30) NULL DEFAULT NULL,
  `lat` VARCHAR(30) NULL DEFAULT NULL,
  `lng` VARCHAR(30) NULL DEFAULT NULL,
  `img` VARCHAR(50) NULL DEFAULT NULL,
  `visited` INT NULL DEFAULT '0',
  PRIMARY KEY (`aptCode`),
  INDEX `dongCode` (`dongCode` ASC) VISIBLE,
  CONSTRAINT `houseinfo_ibfk_1`
    FOREIGN KEY (`dongCode`)
    REFERENCES `happyhousegpj`.`dongcode` (`dongCode`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `happyhousegpj`.`notice`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhousegpj`.`notice` (
  `idx` INT NOT NULL AUTO_INCREMENT,
  `iduser` VARCHAR(45) NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `content` TEXT NOT NULL,
  `regitime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idx`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `happyhousegpj`.`qanda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhousegpj`.`qanda` (
  `iduser` VARCHAR(45) NULL DEFAULT NULL,
  `q_no` INT NOT NULL AUTO_INCREMENT,
  `q_title` VARCHAR(45) NOT NULL,
  `q_content` TEXT NULL DEFAULT NULL,
  `answer` TEXT NULL DEFAULT NULL,
  `regtime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`q_no`),
  INDEX `iduser` (`iduser` ASC) VISIBLE,
  CONSTRAINT `qanda_ibfk_1`
    FOREIGN KEY (`iduser`)
    REFERENCES `happyhousegpj`.`user` (`iduser`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `happyhousegpj`.`userinterest`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhousegpj`.`userinterest` (
  `idx` INT NOT NULL AUTO_INCREMENT,
  `iduser` VARCHAR(45) NOT NULL,
  `dongcode` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idx`),
  INDEX `userinterest_iduser_fk_idx` (`iduser` ASC) VISIBLE,
  INDEX `userinterest_dongcode_fk` (`dongcode` ASC) VISIBLE,
  CONSTRAINT `userinterest_dongcode_fk`
    FOREIGN KEY (`dongcode`)
    REFERENCES `happyhousegpj`.`dongcode` (`dongCode`),
  CONSTRAINT `userinterest_iduser_fk`
    FOREIGN KEY (`iduser`)
    REFERENCES `happyhousegpj`.`user` (`iduser`))
ENGINE = InnoDB
AUTO_INCREMENT = 28
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
