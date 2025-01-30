# Projeto Prático - Introdução a Sistemas de Banco de Dados.

## Modelagem relacional
![Imagem do diagrama relacional do banco de dados](https://github.com/gabrafo/Projeto-IntroSistemasBD/blob/main/imgs/modelagem-bd.png)

## `CREATE TABLE`
```sql
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
  `idade` INTEGER NOT NULL,
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
  `idade` INTEGER NOT NULL,
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
  `dinheiro` DECIMAL(6,2) DEFAULT 0.00 NOT NULL,
  PRIMARY KEY (`idMissao`));
-- DECIMAL(6,2) permite valores até 9999.99

-- -----------------------------------------------------
-- Table `projetoISBD`.`Realiza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projetoISBD`.`Realiza` (
  `idPersonagem` INT NOT NULL,
  `idMissao` INT NOT NULL,
  PRIMARY KEY (`idPersonagem`, `idMissao`),
  INDEX `fk_Jogavel_has_Missao_Missao1_idx` (`idMissao` ASC) VISIBLE,
  INDEX `fk_Jogavel_has_Missao_Jogavel_idx` (`idPersonagem` ASC) VISIBLE,
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
  `preco` DECIMAL(5,2) NOT NULL,
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
  CONSTRAINT `fk_Ladrao_Classe10`
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
  CONSTRAINT `fk_Ladrao_Classe11`
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
  CONSTRAINT `fk_Ladrao_Classe12`
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
  CONSTRAINT `fk_Ladrao_Classe13`
    FOREIGN KEY (`idClasse`)
    REFERENCES `projetoISBD`.`Classe` (`idClasse`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);
```

## `ALTER TABLE` e `DROP TABLE`
```sql
-- Exemplo 1: Adicionar uma nova coluna
ALTER TABLE Jogavel ADD COLUMN nivel INT DEFAULT 1;

-- Exemplo 2: Modificar o tipo de uma coluna
ALTER TABLE Jogavel MODIFY COLUMN nivel DECIMAL(3,2);

-- Exemplo 3: Remover uma coluna
ALTER TABLE Jogavel DROP COLUMN nivel;

-- Criar uma tabela extra para exemplo
CREATE TABLE ExemploExtra (
    IdExemplo INT PRIMARY KEY,
    descricao VARCHAR(100)
);

-- Excluir a tabela extra
DROP TABLE ExemploExtra;
```

## `INSERT`
```sql
use projetoISBD;

-- Inserindo classes base
INSERT INTO Classe (tipoClasse) VALUES 
('GUE'), -- Guerreiro (Ex: Aragorn, Jon Snow)
('ARQ'), -- Arqueiro (Ex: Legolas, Theon Greyjoy)
('MAG'), -- Mago (Ex: Gandalf, Melisandre)
('ASS'), -- Assassino (Ex: Arya Stark, Patches de Dark Souls)
('LAD'); -- Ladrão (Ex: Tyrion Lannister, Lautrec de Dark Souls)

-- Especializações com "+ atributos"
INSERT INTO Guerreiro (idClasse, `+resistencia`) VALUES (1, 5);    -- Bônus de resistência para guerreiros
INSERT INTO Arqueiro (idClasse, `+precisao`) VALUES (2, 6);        -- Bônus de precisão para arqueiros
INSERT INTO Mago (idClasse, `+magia`) VALUES (3, 7);               -- Bônus de magia para magos
INSERT INTO Assassino (idClasse, `+dano`) VALUES (4, 8);           -- Bônus de dano para assassinos
INSERT INTO Ladrao (idClasse, `+furtividade`) VALUES (5, 6);       -- Bônus de furtividade para ladrões

INSERT INTO Jogavel (nome, idade, raca, localOrigem, saldo, xpJogador, resistencia, furtividade, precisao, magia, dano, idClasse) VALUES
-- Senhor dos Anéis:
('Aragorn', 87, 'Dúnadan', 'Vales do Anduin', 500.00, 200, 9, 4, 8, 2, 7, 1),      -- Guerreiro (idClasse 1)
('Legolas', 2931, 'Elfo', 'Floresta das Trevas', 300.00, 180, 5, 7, 10, 3, 6, 2), -- Arqueiro (idClasse 2)

-- Game of Thrones:
('Arya Stark', 18, 'Humana', 'Winterfell', 150.00, 150, 6, 10, 9, 1, 8, 4);        -- Assassino (idClasse 4)

-- Exemplo: valor DEFAULT de "saldo"
INSERT INTO Jogavel (nome, idade, raca, localOrigem, xpJogador, resistencia, furtividade, precisao, magia, dano, idClasse) VALUES
-- Dark Souls:
('Solaire', 45, 'Humano', 'Astora', 300, 8, 3, 7, 4, 6, 1);               -- Guerreiro (idClasse 1)

-- Exemplo: nome não pode ser repetido (UNIQUE)
-- Error Code: 1062. Duplicate entry 'Solaire' for key 'Jogavel.nome'
INSERT INTO Jogavel (nome, idade, raca, localOrigem, xpJogador, resistencia, furtividade, precisao, magia, dano, idClasse) VALUES
-- Dark Souls:
('Solaire', 45, 'Humano', 'Astora', 300, 8, 3, 7, 4, 6, 1);               -- Guerreiro (idClasse 1)

-- NPCs (NaoJogavel):
INSERT INTO NaoJogavel (nome, idade, raca, localOrigem, historia, tipoNaoJogavel) VALUES
-- Game of Thrones:
('Corvo de Três Olhos', 1000, 'Corvo Místico', 'Westeros', 'Guardião da memória do reino', 'M'), -- Mercador (M)
('Ferreiro Tobho', 60, 'Humano', 'Kings Landing', 'Forja armas com aço valiriano', 'O'),         -- Outro (O)

-- Dark Souls:
('Andre of Astora', 200, 'Gigante', 'Astora', 'Ferreiro lendário de Lordran', 'O');

-- Missões:
INSERT INTO Missao (xpMissao, dinheiro) VALUES
(100, 200.00), -- Missão: "Proteger a Muralha" (Game of Thrones)
(150, 300.00), -- Missão: "Reacender a Chama" (Dark Souls)
(80, 150.00);  -- Missão: "Recuperar o Um Anel" (Senhor dos Anéis)

-- Personagens realizando missões:
INSERT INTO Realiza (idPersonagem, idMissao) VALUES
(1, 1), -- Aragorn na missão "Proteger a Muralha"
(3, 3); -- Arya Stark na missão "Recuperar o Um Anel"

-- Itens Únicos (Unico):
INSERT INTO Unico (resistencia, dano, `+dano`, `+resistencia`, Missao_idMissao) VALUES
(20, 25, 10, 5, 3), -- Espada "Andúril" (Senhor dos Anéis) - Vinculada à missão 3
(15, 10, 5, 15, 2); -- Armadura "Havel's Set" (Dark Souls) - Vinculada à missão 2

-- Itens Comuns (Comum):
INSERT INTO Comum (resistencia, dano, preco, idPersonagem) VALUES
(5, 8, 500.00, 2),    -- Arco Élfico (Vendido por Ferreiro Tobho)
(10, 3, 300.00, 3);   -- Adaga de Aço Valiriano (Vendido por Andre of Astora)

-- Transações (Compra):
INSERT INTO Compra VALUES
(2, 1, 2), -- Legolas compra Arco Élfico de Ferreiro Tobho
(3, 2, 3); -- Arya compra Adaga de Andre of Astora
```
