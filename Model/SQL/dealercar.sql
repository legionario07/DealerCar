
CREATE TABLE cidades (
  `cod_cidade` INT NOT NULL COMMENT '',
  `nome` CHARACTER VARYING(45) NOT NULL COMMENT '',
  `uf` CHAR(2) NOT NULL COMMENT '',
  PRIMARY KEY (`cod_cidade`)  COMMENT '')
ENGINE = InnoDB;



CREATE TABLE `clientes` (
  `cod_clientes` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `nome` CHARACTER VARYING(75) NOT NULL COMMENT '',
  `data_nasc` DATE NOT NULL COMMENT '',
  `nome_mae` CHARACTER VARYING(75) NULL COMMENT '',
  `endereco` CHARACTER VARYING(90) NOT NULL COMMENT '',
  `cpf` CHARACTER VARYING(11) NOT NULL COMMENT '',
  `rg` CHARACTER VARYING(45) NOT NULL COMMENT '',
  `telefone` CHARACTER VARYING(20) NOT NULL COMMENT '',
  `email` CHARACTER VARYING(45) NULL COMMENT '',
  `cod_cidade` INT NOT NULL COMMENT '',
  PRIMARY KEY (`cod_clientes`, `cod_cidade`)  COMMENT '',
  INDEX `fk_clientes_cidades1_idx` (`cod_cidade` ASC)  COMMENT '',
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC)  COMMENT '',
  CONSTRAINT `fk_clientes_cidades1`
    FOREIGN KEY (`cod_cidade`)
    REFERENCES `cidades` (`cod_cidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE `categorias` (
  `cod_categorias` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `descricao` CHARACTER VARYING(45) NOT NULL COMMENT '',
  `preco_diario` DOUBLE UNSIGNED NOT NULL COMMENT '',
  `preco_semanal` DOUBLE UNSIGNED NULL COMMENT '',
  `preco_mensal` DOUBLE UNSIGNED NULL COMMENT '',
  `quantidade` INT NULL COMMENT '',
  PRIMARY KEY (`cod_categorias`)  COMMENT '')
ENGINE = InnoDB;



CREATE TABLE `carros` (
  `id_carros` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `placa` CHARACTER VARYING(7) NOT NULL COMMENT '',
  `fabricante` CHARACTER VARYING(20) NOT NULL COMMENT '',
  `marca` CHARACTER VARYING(20) NULL COMMENT '',
  `ano` CHARACTER VARYING(5) NOT NULL COMMENT '',
  `modelo` CHARACTER VARYING(45) NULL COMMENT '',
  `cod_categorias` INT UNSIGNED NOT NULL COMMENT '',
  PRIMARY KEY (`id_carros`, `cod_categorias`)  COMMENT '',
  INDEX `fk_carros_categorias1_idx` (`cod_categorias` ASC)  COMMENT '',
  UNIQUE INDEX `placa_UNIQUE` (`placa` ASC)  COMMENT '',
  CONSTRAINT `fk_carros_categorias1`
    FOREIGN KEY (`cod_categorias`)
    REFERENCES `categorias` (`cod_categorias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE `funcionarios` (
  `cod_funcionarios` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `nome` CHARACTER VARYING(75) NOT NULL COMMENT '',
  `data_nasc` DATE NOT NULL COMMENT '',
  `endereco` CHARACTER VARYING(90) NULL COMMENT '',
  `telefone` CHARACTER VARYING(20) NOT NULL COMMENT '',
  `usuario` CHARACTER VARYING(8) NOT NULL COMMENT '',
  `senha` CHARACTER VARYING(8) NOT NULL COMMENT '',
  `cod_cidade` INT NOT NULL COMMENT '',
  PRIMARY KEY (`cod_funcionarios`, `cod_cidade`)  COMMENT '',
  INDEX `fk_funcionarios_cidades1_idx` (`cod_cidade` ASC)  COMMENT '',
  CONSTRAINT `fk_funcionarios_cidades1`
    FOREIGN KEY (`cod_cidade`)
    REFERENCES `cidades` (`cod_cidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



CREATE TABLE `reservas` (
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
    REFERENCES `clientes` (`cod_clientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservas_funcionarios1`
    FOREIGN KEY (`cod_funcionarios`)
    REFERENCES `funcionarios` (`cod_funcionarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservas_categorias2`
    FOREIGN KEY (`preco_diario`)
    REFERENCES `categorias` (`preco_diario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



CREATE TABLE `retiradas` (
  `cod_retiradas` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `data_retirada` DATETIME NOT NULL COMMENT '',
  `data_devolucao` DATETIME NOT NULL COMMENT '',
  `km_retirada` DOUBLE UNSIGNED NULL COMMENT '',
  `cod_clientes` INT UNSIGNED NOT NULL COMMENT '',
  `cod_funcionarios` INT NOT NULL COMMENT '',
  `placa` CHARACTER VARYING(7) NOT NULL COMMENT '',
  `preco_diario` DOUBLE UNSIGNED NOT NULL COMMENT '',
  PRIMARY KEY (`cod_retiradas`, `cod_clientes`, `cod_funcionarios`)  COMMENT '',
  INDEX `fk_retiradas_clientes1_idx` (`cod_clientes` ASC)  COMMENT '',
  INDEX `fk_retiradas_funcionarios1_idx` (`cod_funcionarios` ASC)  COMMENT '',
  INDEX `fk_retiradas_carros1_idx` (`placa` ASC)  COMMENT '',
  INDEX `fk_retiradas_categorias1_idx` (`preco_diario` ASC)  COMMENT '',
  CONSTRAINT `fk_retiradas_clientes1`
    FOREIGN KEY (`cod_clientes`)
    REFERENCES `clientes` (`cod_clientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_retiradas_funcionarios1`
    FOREIGN KEY (`cod_funcionarios`)
    REFERENCES `funcionarios` (`cod_funcionarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_retiradas_carros1`
    FOREIGN KEY (`placa`)
    REFERENCES `carros` (`placa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_retiradas_categorias1`
    FOREIGN KEY (`preco_diario`)
    REFERENCES `categorias` (`preco_diario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE `devolucoes` (
  `cod_devolucoes` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `qtde_diarias` INT UNSIGNED NULL COMMENT '',
  `valor_combustivel` DOUBLE UNSIGNED NULL COMMENT '',
  `km_devolucao` DOUBLE NOT NULL COMMENT '',
  `data_devolucao` DATETIME NULL COMMENT '',
  `valor_taxas` DOUBLE UNSIGNED NULL COMMENT '',
  `placa` CHARACTER VARYING(7) NOT NULL COMMENT '',
  PRIMARY KEY (`cod_devolucoes`)  COMMENT '',
  UNIQUE INDEX `placa_UNIQUE` (`placa` ASC)  COMMENT '',
  CONSTRAINT `fk_devolucoes_carros1`
    FOREIGN KEY (`placa`)
    REFERENCES `carros` (`placa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

