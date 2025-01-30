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

-- Especializações
INSERT INTO Guerreiro (idClasse, `+resistencia`) VALUES (1, 5);    -- Bônus de resistência para guerreiros
INSERT INTO Arqueiro (idClasse, `+precisao`) VALUES (2, 6);        -- Bônus de precisão para arqueiros
INSERT INTO Mago (idClasse, `+magia`) VALUES (3, 7);               -- Bônus de magia para magos
INSERT INTO Assassino (idClasse, `+dano`) VALUES (4, 8);           -- Bônus de dano para assassinos
INSERT INTO Ladrao (idClasse, `+furtividade`) VALUES (5, 6);       -- Bônus de furtividade para ladrões

-- EXEMPLOS DE INSERÇÃO
INSERT INTO Jogavel (nome, idade, raca, localOrigem, saldo, xpJogador, resistencia, furtividade, precisao, magia, dano, idClasse) VALUES
-- Senhor dos Anéis:
('Aragorn', 87, 'Dúnadan', 'Vales do Anduin', 500.00, 200, 9, 4, 8, 2, 7, 1),      -- Guerreiro (idClasse 1)
('Legolas', 2931, 'Elfo', 'Floresta das Trevas', 300.00, 180, 5, 7, 10, 3, 6, 2), -- Arqueiro (idClasse 2)

-- Game of Thrones:
('Arya Stark', 18, 'Humana', 'Winterfell', 150.00, 150, 6, 10, 9, 1, 8, 4),        -- Assassino (idClasse 4)

-- Dark Souls:
('Artorias', 200, 'Cavaleiro', 'Abismo', 0.00, 400, 10, 2, 8, 3, 9, 1),      -- Guerreiro (idClasse 1)
('Lautrec', 38, 'Assassino', 'Carim', 300.00, 200, 5, 9, 7, 1, 8, 4),       -- Assassino (idClasse 4)

-- Elden Ring:
('Radahn', 150, 'Demigodo', 'Caelid', 5000.00, 500, 10, 2, 9, 4, 10, 1),    -- Guerreiro
('Ranni', 120, 'Feiticeira', 'Lunaris', 2000.00, 300, 3, 8, 7, 10, 4, 3),   -- Mago (idClasse 3)
('Blaidd', 90, 'Meio-Lobo', 'Lands Between', 800.00, 250, 8, 6, 8, 2, 7, 1),-- Guerreiro

-- Senhor dos Anéis:
('Boromir', 40, 'Humano', 'Gondor', 200.00, 150, 8, 3, 7, 1, 6, 1),         -- Guerreiro
('Faramir', 35, 'Humano', 'Gondor', 180.00, 130, 6, 5, 9, 2, 5, 2),         -- Arqueiro (idClasse 2)
('Galadriel', 3000, 'Elfo', 'Lothlórien', 500.00, 400, 4, 7, 8, 9, 3, 3),   -- Mago

-- The Witcher (crossover):
('Geralt', 98, 'Bruxo', 'Kaer Morhen', 800.00, 300, 8, 7, 9, 6, 9, 4);      -- Assassino

-- NPCs (NaoJogavel):
INSERT INTO NaoJogavel (nome, idade, raca, localOrigem, historia, tipoNaoJogavel) VALUES
-- Game of Thrones:
('Corvo de Três Olhos', 1000, 'Corvo Místico', 'Westeros', 'Guardião da memória do reino', 'M'), -- Mercador (M)
('Ferreiro Tobho', 60, 'Humano', 'Kings Landing', 'Forja armas com aço valiriano', 'O'),         -- Outro (O)

-- Dark Souls:
('Andre of Astora', 200, 'Gigante', 'Astora', 'Ferreiro lendário de Lordran', 'O'),
('Quelana', 1000, 'Filha do Caos', 'Izalith', 'Mestra do de fogo', 'M'),

-- Elden Ring:
('Miriel', 500, 'Tartaruga', 'Ter. Intermédias', 'Sacerdote das Vows', 'M'),
('Thops', 30, 'Humano', 'Raya Lucaria', 'Estudioso de barreiras mágicas', 'O'),

-- Senhor dos Anéis:
('Treebeard', 10000, 'Ent', 'Fangorn', 'Guardião das árvores', 'M'),
('Elrond', 6500, 'Meio-Elfo', 'Valfenda', 'Senhor de Valfenda', 'M'),

-- The Witcher:
('Vesemir', 200, 'Bruxo', 'Kaer Morhen', 'Mestre dos bruxos', 'M'),
('Zoltan', 85, 'Anão', 'Mahakam', 'Mercador de armas', 'O'),

-- Dark Souls (NPCs adicionais):
('Siegmeyer', 50, 'Humano', 'Catarina', 'Cavaleiro da cebola', 'O'),
('Quelaag', 500, 'Filha do Caos', 'Izalith', 'Irmã de Quelana', 'M');

-- Missões:
INSERT INTO Missao (xpMissao, dinheiro) VALUES
-- Game of Thrnes
(100, 200.00), -- Proteger a Muralha

-- Dark Souls:
(200, 500.00),  -- Derrotar Gwyn
(150, 300.00),  -- Reacender a Chama
(150, 300.00), -- Reacender a Chama

-- Elden Ring:
(300, 800.00),  -- Tornar-se Lorde Elden
(250, 600.00),  -- Derrotar o Elden Beast

-- Senhor dos Anéis:
(180, 400.00),  -- Destruir o Anel
(120, 250.00),  -- Defender Minas Tirith
(80, 150.00),  -- Recuperar o Anel

-- The Witcher:
(100, 200.00),  -- Matar o Rei dos Caçadores
(80, 150.00),   -- Encontrar Ciri

-- Dark Souls (Missões adicionais):
(90, 100.00),   -- Resgatar Sieglinde
(70, 80.00);    -- Coletar almas de heróis

-- Personagens realizando missões:
INSERT INTO Realiza (idPersonagem, idMissao) VALUES
-- Dark Souls:
(11, 13),  -- Artorias (idPersonagem 11) realiza "Derrotar Gwyn" (idMissao 13)
(12, 14),  -- Solaire (idPersonagem 12) realiza "Reacender a Chama" (idMissao 14)

-- Elden Ring:
(13, 16),  -- Radahn (idPersonagem 13) realiza "Derrotar o Elden Beast" (idMissao 16)
(14, 15),  -- Ranni (idPersonagem 14) realiza "Tornar-se Lorde Elden" (idMissao 15)
(15, 16),  -- Malenia (idPersonagem 15) ajuda Radahn contra o Elden Beast

-- Senhor dos Anéis:
(1, 11),   -- Aragorn (idPersonagem 1) na missão "Destruir o Anel" (idMissao 11)
(5, 11),   -- Boromir (idPersonagem 5) ajuda Aragorn
(7, 12),   -- Galadriel (idPersonagem 7) na missão "Defender Minas Tirith" (idMissao 12)
(6, 17),   -- Faramir (idPersonagem 6) na missão "Defender Helms Deep" (idMissao 17)

-- The Witcher:
(8, 18),   -- Geralt (idPersonagem 8) na missão "Encontrar Ciri" (idMissao 18)

-- Game of Thrones:
(3, 19),   -- Arya Stark (idPersonagem 3) na missão "Resgatar Sieglinde" (idMissao 19)

-- Dark Souls (Missões secundárias):
(9, 20),   -- Lautrec (idPersonagem 9) na missão "Coletar Almas de Heróis" (idMissao 20)
(10, 14);  -- Blaidd (idPersonagem 10) ajuda Solaire a reacender a chama

-- Itens Únicos (Unico):
INSERT INTO Unico (resistencia, dano, `+dano`, `+resistencia`, Missao_idMissao) VALUES
-- Elden Ring:
(25, 30, 12, 8, 3),   -- Espada "Starscourge Greatsword" (Radahn)
(10, 5, 3, 20, 4),    -- Armadura "Maliketh's Armor"
(15, 10, 5, 15, 2); -- Armadura "Havel's Set"

-- Senhor dos Anéis:
(18, 20, 8, 10, 5),   -- Espada "Andúril"
(5, 3, 2, 5, 6),      -- Armadura "Mithril"
(20, 25, 10, 5, 3), -- Espada "Andúril"

-- The Witcher:
(12, 18, 7, 6, 7),    -- Espada "Aerondight"
(8, 12, 5, 4, 8);     -- Armadura "Geralt's Armor"

-- Itens Comuns (Comum):
INSERT INTO Comum (resistencia, dano, preco, idPersonagem) VALUES
-- Dark Souls:
(5, 8, 50.00, 1),    -- Estus Flask (vendido por Andre)
(3, 5, 30.00, 2),    -- Arco Curto (vendido por Quelana)

-- Elden Ring:
(10, 15, 100.00, 3), -- Golden Rune (vendido por Miriel)
(8, 12, 80.00, 4),   -- Espada de Cavaleiro (vendido por Thops)

-- Senhor dos Anéis:
(2, 1, 10.00, 5),    -- Pão Lembas (vendido por Treebeard)
(6, 4, 40.00, 6),    -- Arco Élfico (vendido por Elrond)
(5, 8, 500.00, 2),    -- Arco Élfico (Vendido por Ferreiro Tobho)

-- The Witcher:
(7, 10, 60.00, 7),   -- Adaga de Prata (vendido por Vesemir)
(4, 3, 20.00, 8);    -- Poção de Toxina (vendido por Zoltan)

-- Transações (Compra):
INSERT INTO Compra VALUES
(1, 1, 1),   -- Artorias compra Estus Flask de Andre
(5, 3, 3),   -- Ranni compra Golden Rune de Miriel
(7, 5, 5),   -- Boromir compra Pão Lembas de Treebeard
(9, 6, 6),   -- Galadriel compra Arco Élfico de Elrond
(4, 4, 4),   -- Radahn compra Espada de Cavaleiro de Thops
(10, 7, 7),  -- Geralt compra Adaga de Prata de Vesemir
(8, 8, 8);   -- Faramir compra Poção de Zoltan

-- EXEMPLOS DE RESTRIÇÃO
-- Exemplo: valor DEFAULT de "saldo"
INSERT INTO Jogavel (nome, idade, raca, localOrigem, xpJogador, resistencia, furtividade, precisao, magia, dano, idClasse) VALUES
-- Dark Souls:
('Solaire', 45, 'Humano', 'Astora', 300, 8, 3, 7, 4, 6, 1);               -- Guerreiro (idClasse 1)

-- Exemplo: nome não pode ser repetido (UNIQUE)
-- Error Code: 1062. Duplicate entry 'Solaire' for key 'Jogavel.nome'
INSERT INTO Jogavel (nome, idade, raca, localOrigem, xpJogador, resistencia, furtividade, precisao, magia, dano, idClasse) VALUES
-- Dark Souls:
('Solaire', 45, 'Humano', 'Astora', 300, 8, 3, 7, 4, 6, 1);               -- Guerreiro (idClasse 1)
```
