-- MySQL Script generated by MySQL Workbench
-- 07/22/15 15:13:16
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`cidades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cidades` (
  `cod_cidade` INT NOT NULL COMMENT '',
  `nome` VARCHAR(45) NOT NULL COMMENT '',
  `uf` CHAR(2) NOT NULL COMMENT '',
  PRIMARY KEY (`cod_cidade`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`clientes` (
  `cod_clientes` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `nome` VARCHAR(75) NOT NULL COMMENT '',
  `data_nasc` DATE NOT NULL COMMENT '',
  `nome_mae` VARCHAR(75) NULL COMMENT '',
  `endereco` VARCHAR(90) NOT NULL COMMENT '',
  `cpf` VARCHAR(11) NOT NULL COMMENT '',
  `rg` VARCHAR(45) NOT NULL COMMENT '',
  `telefone` VARCHAR(20) NOT NULL COMMENT '',
  `email` VARCHAR(45) NULL COMMENT '',
  `cod_cidade` INT NOT NULL COMMENT '',
  PRIMARY KEY (`cod_clientes`, `cod_cidade`)  COMMENT '',
  INDEX `fk_clientes_cidades1_idx` (`cod_cidade` ASC)  COMMENT '',
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC)  COMMENT '',
  CONSTRAINT `fk_clientes_cidades1`
    FOREIGN KEY (`cod_cidade`)
    REFERENCES `mydb`.`cidades` (`cod_cidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`categorias` (
  `cod_categorias` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `descricao` VARCHAR(45) NOT NULL COMMENT '',
  `preco_diario` DOUBLE UNSIGNED NOT NULL COMMENT '',
  `preco_semanal` DOUBLE UNSIGNED NULL COMMENT '',
  `preco_mensal` DOUBLE UNSIGNED NULL COMMENT '',
  `quantidade` INT NULL COMMENT '',
  PRIMARY KEY (`cod_categorias`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`carros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`carros` (
  `id_carros` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `placa` VARCHAR(7) NOT NULL COMMENT '',
  `fabricante` VARCHAR(20) NOT NULL COMMENT '',
  `marca` VARCHAR(20) NULL COMMENT '',
  `ano` VARCHAR(5) NOT NULL COMMENT '',
  `modelo` VARCHAR(45) NULL COMMENT '',
  `cod_categorias` INT UNSIGNED NOT NULL COMMENT '',
  PRIMARY KEY (`id_carros`, `cod_categorias`)  COMMENT '',
  INDEX `fk_carros_categorias1_idx` (`cod_categorias` ASC)  COMMENT '',
  UNIQUE INDEX `placa_UNIQUE` (`placa` ASC)  COMMENT '',
  CONSTRAINT `fk_carros_categorias1`
    FOREIGN KEY (`cod_categorias`)
    REFERENCES `mydb`.`categorias` (`cod_categorias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`funcionarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`funcionarios` (
  `cod_funcionarios` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `nome` VARCHAR(75) NOT NULL COMMENT '',
  `data_nasc` DATE NOT NULL COMMENT '',
  `endereco` VARCHAR(90) NULL COMMENT '',
  `telefone` VARCHAR(20) NOT NULL COMMENT '',
  `usuario` VARCHAR(8) NOT NULL COMMENT '',
  `senha` VARCHAR(8) NOT NULL COMMENT '',
  `cod_cidade` INT NOT NULL COMMENT '',
  PRIMARY KEY (`cod_funcionarios`, `cod_cidade`)  COMMENT '',
  INDEX `fk_funcionarios_cidades1_idx` (`cod_cidade` ASC)  COMMENT '',
  CONSTRAINT `fk_funcionarios_cidades1`
    FOREIGN KEY (`cod_cidade`)
    REFERENCES `mydb`.`cidades` (`cod_cidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`reservas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`reservas` (
  `cod_reservas` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `data_retirada` DATETIME NULL COMMENT '',
  `data_devolucao` DATETIME NULL COMMENT '',
  `cod_categorias` INT UNSIGNED NOT NULL COMMENT '',
  `cod_clientes` INT UNSIGNED NOT NULL COMMENT '',
  `cod_funcionarios` INT NOT NULL COMMENT '',
  `preco_diario` DOUBLE UNSIGNED NOT NULL COMMENT '',
  PRIMARY KEY (`cod_reservas`, `cod_categorias`)  COMMENT '',
  INDEX `fk_reservas_clientes1_idx` (`cod_clientes` ASC)  COMMENT '',
  INDEX `fk_reservas_funcionarios1_idx` (`cod_funcionarios` ASC)  COMMENT '',
  INDEX `fk_reservas_categorias2_idx` (`preco_diario` ASC)  COMMENT '',
  CONSTRAINT `fk_reservas_clientes1`
    FOREIGN KEY (`cod_clientes`)
    REFERENCES `mydb`.`clientes` (`cod_clientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservas_funcionarios1`
    FOREIGN KEY (`cod_funcionarios`)
    REFERENCES `mydb`.`funcionarios` (`cod_funcionarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservas_categorias2`
    FOREIGN KEY (`preco_diario`)
    REFERENCES `mydb`.`categorias` (`preco_diario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`retiradas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`retiradas` (
  `cod_retiradas` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `data_retirada` DATETIME NOT NULL COMMENT '',
  `data_devolucao` DATETIME NOT NULL COMMENT '',
  `km_retirada` DOUBLE UNSIGNED NULL COMMENT '',
  `cod_clientes` INT UNSIGNED NOT NULL COMMENT '',
  `cod_funcionarios` INT NOT NULL COMMENT '',
  `placa` VARCHAR(7) NOT NULL COMMENT '',
  `preco_diario` DOUBLE UNSIGNED NOT NULL COMMENT '',
  PRIMARY KEY (`cod_retiradas`, `cod_clientes`, `cod_funcionarios`)  COMMENT '',
  INDEX `fk_retiradas_clientes1_idx` (`cod_clientes` ASC)  COMMENT '',
  INDEX `fk_retiradas_funcionarios1_idx` (`cod_funcionarios` ASC)  COMMENT '',
  INDEX `fk_retiradas_carros1_idx` (`placa` ASC)  COMMENT '',
  INDEX `fk_retiradas_categorias1_idx` (`preco_diario` ASC)  COMMENT '',
  CONSTRAINT `fk_retiradas_clientes1`
    FOREIGN KEY (`cod_clientes`)
    REFERENCES `mydb`.`clientes` (`cod_clientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_retiradas_funcionarios1`
    FOREIGN KEY (`cod_funcionarios`)
    REFERENCES `mydb`.`funcionarios` (`cod_funcionarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_retiradas_carros1`
    FOREIGN KEY (`placa`)
    REFERENCES `mydb`.`carros` (`placa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_retiradas_categorias1`
    FOREIGN KEY (`preco_diario`)
    REFERENCES `mydb`.`categorias` (`preco_diario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`devolucoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`devolucoes` (
  `cod_devolucoes` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `qtde_diarias` INT UNSIGNED NULL COMMENT '',
  `valor_combustivel` DOUBLE UNSIGNED NULL COMMENT '',
  `km_devolucao` DOUBLE NOT NULL COMMENT '',
  `data_devolucao` DATETIME NULL COMMENT '',
  `valor_taxas` DOUBLE UNSIGNED NULL COMMENT '',
  `placa` VARCHAR(7) NOT NULL COMMENT '',
  PRIMARY KEY (`cod_devolucoes`)  COMMENT '',
  UNIQUE INDEX `placa_UNIQUE` (`placa` ASC)  COMMENT '',
  CONSTRAINT `fk_devolucoes_carros1`
    FOREIGN KEY (`placa`)
    REFERENCES `mydb`.`carros` (`placa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
