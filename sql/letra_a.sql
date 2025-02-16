-- -----------------------------------------------------
-- Schema projetoISBD
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `projetoISBD` DEFAULT CHARACTER SET utf8 ;
USE `projetoISBD` ;

-- -----------------------------------------------------
-- Table `projetoISBD`.`Classe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projetoISBD`.`Classe` (
  `idClasse` INT NOT NULL AUTO_INCREMENT,
  `tipoClasse` ENUM('LAD', 'ARQ', 'MAG', 'ASS', 'GUE') NOT NULL,
  PRIMARY KEY (`idClasse`));


-- -----------------------------------------------------
-- Table `projetoISBD`.`Jogavel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projetoISBD`.`Jogavel` (
  `idPersonagem` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(40) UNIQUE NOT NULL,
  `idade` DECIMAL(3) NOT NULL,
  `raca` VARCHAR(20) NOT NULL,
  `localOrigem` VARCHAR(20) NULL,
  `saldo` DECIMAL(8,2) DEFAULT 0.00 NOT NULL,
  `xpJogador` DECIMAL(5) DEFAULT 0.00 NOT NULL,
  `resistencia` DECIMAL(2) NOT NULL,
  `furtividade` DECIMAL(2) NOT NULL,
  `precisao` DECIMAL(2) NOT NULL,
  `magia` DECIMAL(2) NOT NULL,
  `dano` DECIMAL(2) NOT NULL,
  `idClasse` INT NOT NULL,
  PRIMARY KEY (`idPersonagem`),
  CONSTRAINT `fk_Jogavel_Classe1`
    FOREIGN KEY (`idClasse`)
    REFERENCES `projetoISBD`.`Classe` (`idClasse`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `projetoISBD`.`NaoJogavel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projetoISBD`.`NaoJogavel` (
  `idPersonagem` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(40) UNIQUE NOT NULL,
  `idade` DECIMAL(3) NOT NULL,
  `raca` VARCHAR(20) NOT NULL,
  `localOrigem` VARCHAR(20) NULL,
  `historia` VARCHAR(200) NOT NULL,
  `tipoNaoJogavel` ENUM('M', 'O') NOT NULL,
  PRIMARY KEY (`idPersonagem`));


-- -----------------------------------------------------
-- Table `projetoISBD`.`Missao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projetoISBD`.`Missao` (
  `idMissao` INT NOT NULL AUTO_INCREMENT,
  `xpMissao` DECIMAL(3) NOT NULL, 
  `dinheiro` DECIMAL(6,2) DEFAULT 0.00 NOT NULL, -- DECIMAL(6,2) permite valores até 9999.99
  PRIMARY KEY (`idMissao`));


-- -----------------------------------------------------
-- Table `projetoISBD`.`Realiza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projetoISBD`.`Realiza` (
  `idPersonagem` INT NOT NULL,
  `idMissao` INT NOT NULL,
  PRIMARY KEY (`idPersonagem`, `idMissao`),
  CONSTRAINT `fk_Jogavel_has_Missao_Jogavel`
    FOREIGN KEY (`idPersonagem`)
    REFERENCES `projetoISBD`.`Jogavel` (`idPersonagem`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Jogavel_has_Missao_Missao1`
    FOREIGN KEY (`idMissao`)
    REFERENCES `projetoISBD`.`Missao` (`idMissao`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `projetoISBD`.`Unico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projetoISBD`.`Unico` (
  `idItem` INT NOT NULL AUTO_INCREMENT,
  `resistencia` DECIMAL(2) NOT NULL,
  `dano` DECIMAL(2) NOT NULL,
  `+dano` DECIMAL(2) NOT NULL,
  `+resistencia` DECIMAL(2) NOT NULL,
  `Missao_idMissao` INT NOT NULL,
  PRIMARY KEY (`idItem`),
  CONSTRAINT `fk_Unico_Missao1`
    FOREIGN KEY (`Missao_idMissao`)
    REFERENCES `projetoISBD`.`Missao` (`idMissao`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `projetoISBD`.`Comum`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projetoISBD`.`Comum` (
  `idItem` INT NOT NULL AUTO_INCREMENT,
  `resistencia` DECIMAL(2) NOT NULL,
  `dano` DECIMAL(2) NOT NULL,
  `preco` DECIMAL(6,2) NOT NULL, -- Alterado para permitir valores até 9999.99
  `idPersonagem` INT NOT NULL,
  PRIMARY KEY (`idItem`),
  CONSTRAINT `fk_Comum_NaoJogavel1`
    FOREIGN KEY (`idPersonagem`)
    REFERENCES `projetoISBD`.`NaoJogavel` (`idPersonagem`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `projetoISBD`.`Compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projetoISBD`.`Compra` (
  `idPersonagemJogavel` INT NOT NULL,
  `idItem` INT NOT NULL,
  `idPersonagemNaoJogavel` INT NOT NULL,
  PRIMARY KEY (`idPersonagemJogavel`, `idItem`, `idPersonagemNaoJogavel`),
  CONSTRAINT `fk_jogavel`
    FOREIGN KEY (`idPersonagemJogavel`)
    REFERENCES `projetoISBD`.`Jogavel` (`idPersonagem`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comum`
    FOREIGN KEY (`idItem`)
    REFERENCES `projetoISBD`.`Comum` (`idItem`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Compra_NaoJogavel1`
    FOREIGN KEY (`idPersonagemNaoJogavel`)
    REFERENCES `projetoISBD`.`NaoJogavel` (`idPersonagem`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `projetoISBD`.`Ladrao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projetoISBD`.`Ladrao` (
  `idClasse` INT NOT NULL,
  `+furtividade` DECIMAL(2) NOT NULL,
  PRIMARY KEY (`idClasse`),
  CONSTRAINT `fk_Ladrao_Classe1`
    FOREIGN KEY (`idClasse`)
    REFERENCES `projetoISBD`.`Classe` (`idClasse`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `projetoISBD`.`Arqueiro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projetoISBD`.`Arqueiro` (
  `idClasse` INT NOT NULL,
  `+precisao` DECIMAL(2) NOT NULL,
  PRIMARY KEY (`idClasse`),
  CONSTRAINT `fk_Arqueiro_Classe1`
    FOREIGN KEY (`idClasse`)
    REFERENCES `projetoISBD`.`Classe` (`idClasse`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `projetoISBD`.`Mago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projetoISBD`.`Mago` (
  `idClasse` INT NOT NULL,
  `+magia` DECIMAL(2) NOT NULL,
  PRIMARY KEY (`idClasse`),
  CONSTRAINT `fk_Mago_Classe1`
    FOREIGN KEY (`idClasse`)
    REFERENCES `projetoISBD`.`Classe` (`idClasse`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `projetoISBD`.`Assassino`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projetoISBD`.`Assassino` (
  `idClasse` INT NOT NULL,
  `+dano` DECIMAL(2) NOT NULL,
  PRIMARY KEY (`idClasse`),
  CONSTRAINT `fk_Assassino_Classe1`
    FOREIGN KEY (`idClasse`)
    REFERENCES `projetoISBD`.`Classe` (`idClasse`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `projetoISBD`.`Guerreiro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projetoISBD`.`Guerreiro` (
  `idClasse` INT NOT NULL,
  `+resistencia` DECIMAL(2) NOT NULL,
  PRIMARY KEY (`idClasse`),
  CONSTRAINT `fk_Guerreiro_Classe1`
    FOREIGN KEY (`idClasse`)
    REFERENCES `projetoISBD`.`Classe` (`idClasse`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);
