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
-- Exemplo 1: Adicionando uma nova coluna
ALTER TABLE Jogavel ADD COLUMN nivel INT DEFAULT 1;

-- Exemplo 2: Modificando o tipo de uma coluna
ALTER TABLE Jogavel MODIFY COLUMN nivel DECIMAL(3,2);

-- Exemplo 3: Removendo uma coluna
ALTER TABLE Jogavel DROP COLUMN nivel;

-- Criando uma tabela extra para exemplo
CREATE TABLE ExemploExtra (
    IdExemplo INT PRIMARY KEY,
    descricao VARCHAR(100)
);

-- Excluindo a tabela extra
DROP TABLE ExemploExtra;
```

## `INSERT`
```sql
use projetoISBD;

-- Inserindo classes base
INSERT INTO Classe (tipoClasse) VALUES 
('GUE'), -- Guerreiro
('ARQ'), -- Arqueiro
('MAG'), -- Mago
('ASS'), -- Assassino
('LAD'); -- Ladrão

-- Especializações
INSERT INTO Guerreiro (idClasse, `+resistencia`) VALUES (1, 5);
INSERT INTO Arqueiro (idClasse, `+precisao`) VALUES (2, 6);
INSERT INTO Mago (idClasse, `+magia`) VALUES (3, 7);
INSERT INTO Assassino (idClasse, `+dano`) VALUES (4, 8);
INSERT INTO Ladrao (idClasse, `+furtividade`) VALUES (5, 6);

-- EXEMPLOS DE INSERÇÃO
INSERT INTO Jogavel (nome, idade, raca, localOrigem, saldo, xpJogador, resistencia, furtividade, precisao, magia, dano, idClasse) VALUES
('Aragorn', 87, 'Dúnadan', 'Vales do Anduin', 500.00, 200, 9, 4, 8, 2, 7, 1),      -- Guerreiro (idClasse 1)
('Legolas', 2931, 'Elfo', 'Floresta das Trevas', 300.00, 180, 5, 7, 10, 3, 6, 2),  -- Arqueiro (idClasse 2)
('Arya Stark', 18, 'Humana', 'Winterfell', 150.00, 150, 6, 10, 9, 1, 8, 4),        -- Assassino (idClasse 4)
('Artorias', 200, 'Cavaleiro', 'Abismo', 0.00, 400, 10, 2, 8, 3, 9, 1),            -- Guerreiro
('Lautrec', 38, 'Assassino', 'Carim', 300.00, 200, 5, 9, 7, 1, 8, 4),              -- Assassino
('Radahn', 150, 'Demigodo', 'Caelid', 5000.00, 500, 10, 2, 9, 4, 10, 1),           -- Guerreiro
('Ranni', 120, 'Feiticeira', 'Lunaris', 2000.00, 300, 3, 8, 7, 10, 4, 3),          -- Mago (idClasse 3)
('Blaidd', 90, 'Meio-Lobo', 'Lands Between', 800.00, 250, 8, 6, 8, 2, 7, 1),       -- Guerreiro
('Boromir', 40, 'Humano', 'Gondor', 200.00, 150, 8, 3, 7, 1, 6, 5),                -- Ladrão (idClasse 5)
('Faramir', 35, 'Humano', 'Gondor', 180.00, 130, 6, 5, 9, 2, 5, 2),                -- Arqueiro
('Galadriel', 3000, 'Elfo', 'Lothlórien', 500.00, 400, 4, 7, 8, 9, 3, 3),          -- Mago
('Geralt', 98, 'Bruxo', 'Kaer Morhen', 800.00, 300, 8, 7, 9, 6, 9, 4);             -- Assassino

-- NPCs (NaoJogavel):
INSERT INTO NaoJogavel (nome, idade, raca, localOrigem, historia, tipoNaoJogavel) VALUES
('Corvo de Três Olhos', 1000, 'Corvo Místico', 'Westeros', 'Guardião da memória do reino', 'M'), -- Mercador (M)
('Ferreiro Tobho', 60, 'Humano', 'Kings Landing', 'Forja armas com aço valiriano', 'O'),         -- Outro (O)
('Andre of Astora', 200, 'Gigante', 'Astora', 'Ferreiro lendário de Lordran', 'O'),
('Quelana', 1000, 'Filha do Caos', 'Izalith', 'Mestra do de fogo', 'M'),
('Siegmeyer', 50, 'Humano', 'Catarina', 'Cavaleiro da cebola', 'O'),
('Quelaag', 500, 'Filha do Caos', 'Izalith', 'Irmã de Quelana', 'M'),
('Miriel', 500, 'Tartaruga', 'Ter. Intermédias', 'Sacerdote das Vows', 'M'),
('Thops', 30, 'Humano', 'Raya Lucaria', 'Estudioso de barreiras mágicas', 'O'),
('Treebeard', 10000, 'Ent', 'Fangorn', 'Guardião das árvores', 'M'),
('Elrond', 6500, 'Meio-Elfo', 'Valfenda', 'Senhor de Valfenda', 'M'),
('Vesemir', 200, 'Bruxo', 'Kaer Morhen', 'Mestre dos bruxos', 'M'),
('Zoltan', 85, 'Anão', 'Mahakam', 'Mercador de armas', 'O');

-- Missões:
INSERT INTO Missao (xpMissao, dinheiro) VALUES
(100, 200.00),
(200, 500.00),
(150, 300.00),
(150, 300.00),
(300, 800.00),
(250, 600.00),
(180, 400.00),
(120, 250.00),
(80, 150.00),
(100, 200.00), 
(80, 150.00),
(90, 100.00),
(70, 80.00); 

-- Personagens realizando missões:
INSERT INTO Realiza (idPersonagem, idMissao) VALUES
(1, 3), -- Aragorn completa a Missão 3
(1, 1), -- Aragorn completa a Missão 1
(11, 13),-- Geralt completa a Missão 13
(2, 11), -- Legolas completa a Missão 11
(3, 12), -- Arya Stark completa a Missão 12
(4, 10), -- Artorias completa a Missão 10
(5, 6), -- Lautrec completa a Missão 6
(5, 1), -- Lautrec completa a Missão 1
(7, 2), -- Ranni completa a Missão 2
(6, 7), -- Radahn completa a Missão 7
(8, 8), -- Galadriel completa a Missão 8
(3, 9), -- Arya Stark completa a Missão 9
(9, 2), -- Boromir completa a Missão 2
(10, 4); -- Faramir completa a Missão 4

-- Itens Únicos (Unico):
INSERT INTO Unico (resistencia, dano, `+dano`, `+resistencia`, Missao_idMissao) VALUES
(25, 30, 12, 8, 3), -- Relacionado à missão 3 (realizada por Aragorn)
(10, 5, 3, 20, 4), -- Relacionado à missão 4 (realizada por Faramir)
(15, 10, 5, 15, 2), -- Relacionado à missão 2 (realizada por Ranni e Boromir)
(18, 20, 8, 10, 5), -- Relacionado à missão 5
(5, 3, 2, 5, 6), -- Relacionado à missão 6 (realizada por Lautrec)
(20, 25, 10, 5, 3), -- Relacionado à missão 3 (realizada por Aragorn)
(12, 18, 7, 6, 7), -- Relacionado à missão 7 (realizada por Radahn)
(8, 12, 5, 4, 8); -- Relacionado à missão 8 (realizada por Galadriel)

-- Itens Comuns (Comum):
INSERT INTO Comum (resistencia, dano, preco, idPersonagem) VALUES
(5, 8, 50.00, 1), -- Relacionado a Aragorn
(3, 5, 30.00, 2), -- Relacionado a Legolas
(10, 15, 100.00, 3), -- Relacionado à Arya Stark
(8, 12, 80.00, 4), -- Relacionado a Artorias
(2, 1, 10.00, 5), -- Relacionado a Lautrec
(6, 4, 40.00, 6), -- Relacionado a Radahn
(5, 8, 500.00, 2), -- Relacionado a Legolas
(7, 10, 60.00, 7), -- Relacionado à Ranni
(4, 3, 20.00, 8); -- Relacionado a Galadriel

-- Transações (Compra):
INSERT INTO Compra (idPersonagemJogavel, idItem, idPersonagemNaoJogavel) VALUES
(1, 3, 3),   -- Jogavel 1 (Aragorn) compra Comum 3 de NPC 3 (Andre of Astora)
(1, 1, 1),   -- Jogavel 1 (Aragorn) compra Comum 1 de NPC 1 (Corvo de Três Olhos)
(5, 3, 3),  -- Jogavel 5 (Lautrec) compra Comum 3 de NPC 3 (Andre of Astora)
(7, 5, 5),   -- Jogavel 7 (Ranni) compra Comum 5 de NPC 5 (Siegmeyer)
(9, 6, 6),   -- Jogavel 9 (Boromir) compra Comum 6 de NPC 6 (Quelaag)
(4, 4, 4),   -- Jogavel 4 (Artorias) compra Comum 4 de NPC 4 (Quelana)
(10, 7, 7),  -- Jogavel 10 (Faramir) compra Comum 7 de NPC 7 (Miriel)
(8, 8, 8);   -- Jogavel 8 (Galadriel) compra Comum 8 de NPC 8 (Thops)

-- EXEMPLOS DE RESTRIÇÃO
-- Exemplo: valor DEFAULT de "saldo"
INSERT INTO Jogavel (nome, idade, raca, localOrigem, xpJogador, resistencia, furtividade, precisao, magia, dano, idClasse) VALUES
('Solaire', 45, 'Humano', 'Astora', 300, 8, 3, 7, 4, 6, 1);

-- Exemplo: nome não pode ser repetido (UNIQUE)
-- Error Code: 1062. Duplicate entry 'Solaire' for key 'Jogavel.nome'
INSERT INTO Jogavel (nome, idade, raca, localOrigem, xpJogador, resistencia, furtividade, precisao, magia, dano, idClasse) VALUES
('Solaire', 70, 'Druida', 'Astalavista', 320, 8, 3, 7, 4, 6, 1);
```

## `UPDATE`
```sql
-- Auxiliares (ver modificações)
SELECT * FROM Jogavel;                             -- Aux do 1° update
SELECT * FROM Missao;                              -- Aux do 2° update
SELECT * FROM NaoJogavel;                          -- Aux do 3° update
SELECT * FROM Guerreiro;                           -- Aux do 4° update
SELECT C.idPersonagemJogavel, C.idItem, CO.dano    -- Aux do 5° update
FROM Compra C
INNER JOIN Comum CO ON C.idItem = CO.idItem
WHERE C.idPersonagemJogavel = 1;

-- Atualizar saldo de um jogador
UPDATE Jogavel SET saldo = saldo + 55.55 WHERE IdPersonagem = 1;

-- Atualizar experiência de missão
UPDATE Missao SET xpMissao = xpMissao + 33 WHERE IdMissao = 1;

-- Atualizar tipo de não jogável
UPDATE NaoJogavel SET tipoNaoJogavel = 'O' WHERE IdPersonagem = 1;

-- Atualizar resistência bônus do Guerreiro 1
UPDATE Guerreiro SET `+resistencia` = 10 WHERE IdClasse = 1;

-- Atualização aninhada: Aumentar o dano de todos os itens comprados por um jogador
UPDATE Comum SET dano = dano + 1 WHERE idItem IN (SELECT idItem FROM Compra WHERE IdPersonagemJogavel = 1);
```

## `DELETE`
```sql
-- Auxiliares (ver modificações)
SELECT C.idPersonagemJogavel, C.idItem, CO.dano    -- Aux do 1° delete
FROM Compra C
INNER JOIN Comum CO ON C.idItem = CO.idItem
WHERE C.idPersonagemJogavel = 1;
SELECT * FROM Realiza;                             -- Aux do 2° delete
SELECT * FROM Jogavel;                             -- Aux do 3° delete
SELECT * FROM Missao;                              -- Aux do 4° delete
SELECT * FROM NaoJogavel;                          -- Aux do 5° delete

-- Exclusão aninhada: Excluir todos os itens comprados por um jogador
DELETE FROM Comum WHERE idItem IN (SELECT idItem FROM Compra WHERE IdPersonagemJogavel = 1);

-- Excluir realizações de missões
DELETE FROM Realiza WHERE IdPersonagem = 1;

-- Excluir um jogador
DELETE FROM Jogavel WHERE IdPersonagem = 1;

-- Excluir uma missão
DELETE FROM Missao WHERE idMissao = 1;

-- Excluir um não jogável
DELETE FROM NaoJogavel WHERE IdPersonagem = 1;
```

## `SELECT`
```sql
-- F1 - Recupera o nome dos jogadores e o tipo de classe que eles pertencem
SELECT J.nome, C.tipoClasse
FROM Jogavel J
INNER JOIN Classe C ON J.idClasse = C.idClasse;

-- F2 - Recupera todos os jogadores e suas missões, incluindo jogadores sem missões
SELECT J.nome, M.idMissao
FROM Jogavel J
LEFT JOIN Realiza R ON J.idPersonagem = R.idPersonagem
LEFT JOIN Missao M ON R.idMissao = M.idMissao;

-- F3 - Recupera os jogadores ordenados por saldo decrescente
SELECT idPersonagem, nome, saldo
FROM Jogavel
ORDER BY saldo DESC;

-- F4 - Recupera a quantidade de jogadores por classe
SELECT idClasse, COUNT(*) AS quantidade
FROM Jogavel
GROUP BY idClasse;

-- F4 (MELHORADA) - Recupera a quantidade de jogadores por classe, mostrando o tipo de classe (GUE, ARQ, etc.)
SELECT C.tipoClasse, COUNT(*) AS quantidade
FROM Jogavel J
INNER JOIN Classe C ON J.idClasse = C.idClasse
GROUP BY C.tipoClasse;

-- F5 - Recupera as classes com mais de 5 jogadores
SELECT idClasse, COUNT(*) AS quantidade
FROM Jogavel
GROUP BY idClasse
HAVING COUNT(*) > 3;

-- F5 (MELHORADA) - Recupera as classes com mais de 5 jogadores, mostrando o tipo de classe (GUE, ARQ, etc.)
SELECT C.tipoClasse, COUNT(*) AS quantidade
FROM Jogavel J
INNER JOIN Classe C ON J.idClasse = C.idClasse
GROUP BY C.tipoClasse
HAVING COUNT(*) > 3;

-- F6 - Recupera os nomes de todos os personagens, sejam jogáveis ou não
SELECT nome FROM Jogavel
UNION
SELECT nome FROM NaoJogavel;

-- F7 - Recupera os jogadores que pertencem às classes 1 ou 2
SELECT nome, idClasse
FROM Jogavel
WHERE idClasse IN (1, 2);

-- F8 - Recupera os jogadores cujos nomes começam com 'Ra'
SELECT *
FROM Jogavel
WHERE nome LIKE 'Ra%';

-- F9 - Recupera as missões que ainda não foram realizadas por nenhum jogador
SELECT M.idMissao, M.xpMissao, M.dinheiro
FROM Missao M
LEFT JOIN Realiza R ON M.idMissao = R.idMissao
WHERE R.idMissao IS NULL;

-- F10 - Recupera os jogadores que têm saldo maior que qualquer saldo dos jogadores da classe 1
SELECT *
FROM Jogavel
WHERE saldo > ANY (SELECT saldo FROM Jogavel WHERE idClasse = 1);

-- F11 - Recupera os jogadores que têm saldo maior que todos os saldos dos jogadores da classe 1
SELECT nome, saldo
FROM Jogavel
WHERE saldo >= ALL (SELECT saldo FROM Jogavel WHERE idClasse = 1);

-- F12 - Recupera os jogadores que realizaram pelo menos uma missão
SELECT idPersonagem, nome
FROM Jogavel J
WHERE EXISTS (SELECT 1 FROM Realiza R WHERE R.idPersonagem = J.idPersonagem);

-- AND - Recupera os jogadores da classe 1 com saldo maior que 50
SELECT idPersonagem, nome, idClasse, saldo
FROM Jogavel
WHERE idClasse = 1 AND saldo > 50;

-- OR - Recupera os jogadores da classe 1 ou da classe 2
SELECT idPersonagem, nome, idClasse
FROM Jogavel
WHERE idClasse = 1 OR idClasse = 2;

-- NOT - Recupera os jogadores que não pertencem à classe 1
SELECT idPersonagem, nome, idClasse
FROM Jogavel
WHERE NOT idClasse = 1;

-- BETWEEN - Recupera os jogadores com saldo entre 50 e 100
SELECT idPersonagem, nome, saldo
FROM Jogavel
WHERE saldo BETWEEN 0 AND 100;
```

## `VIEW`
```sql
-- Cria uma view que retorna o nome dos jogadores e o tipo de classe que eles pertencem
CREATE VIEW View_Jogadores_Classes AS
SELECT J.nome, C.tipoClasse
FROM Jogavel J
INNER JOIN Classe C ON J.idClasse = C.idClasse;

-- Seleciona todos os jogadores da classe Ladrão (LAD)
SELECT * FROM View_Jogadores_Classes WHERE tipoClasse = 'LAD';

-- Cria uma view que retorna as missões que ainda não foram realizadas por nenhum jogador
CREATE VIEW View_Missoes_Nao_Realizadas AS
SELECT M.idMissao, M.xpMissao, M.dinheiro
FROM Missao M
LEFT JOIN Realiza R ON M.idMissao = R.idMissao
WHERE R.idMissao IS NULL;

-- Seleciona as missões não realizadas que oferecem mais de 100 pontos de experiência
SELECT * FROM View_Missoes_Nao_Realizadas WHERE xpMissao > 100;

-- Cria uma view que retorna os itens comuns e seus preços, juntamente com o nome do vendedor (personagem não jogável)
CREATE VIEW View_Itens_Comuns_Precos AS
SELECT C.idItem, C.preco, NJ.nome AS vendedor
FROM Comum C
INNER JOIN NaoJogavel NJ ON C.idPersonagem = NJ.idPersonagem;

-- Seleciona os itens comuns com preço superior a 75.00
SELECT * FROM View_Itens_Comuns_Precos WHERE preco > 75.00;
```

## `USER`
```sql
-- Cria um usuário chamado 'admin' com a senha 'admin123'
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin123';

-- Cria um usuário chamado 'leitor' com a senha 'leitor123'
CREATE USER 'leitor'@'localhost' IDENTIFIED BY 'leitor123';

-- Concede todas as permissões (ALL PRIVILEGES) no banco de dados 'projetoISBD' ao usuário 'admin'
GRANT ALL PRIVILEGES ON projetoISBD.* TO 'admin'@'localhost';

-- Concede permissão de leitura (SELECT) no banco de dados 'projetoISBD' ao usuário 'leitor'
GRANT SELECT ON projetoISBD.* TO 'leitor'@'localhost';

-- Revoga a permissão de leitura (SELECT) no banco de dados 'projetoISBD' do usuário 'leitor'
REVOKE SELECT ON projetoISBD.* FROM 'leitor'@'localhost';

-- Revoga todas as permissões (ALL PRIVILEGES) no banco de dados 'projetoISBD' do usuário 'admin'
REVOKE ALL PRIVILEGES ON projetoISBD.* FROM 'admin'@'localhost';

-- O usuário 'admin' pode inserir um novo jogador na tabela 'Jogavel'
INSERT INTO Jogavel (nome, idade, raca, localOrigem, saldo, xpJogador, resistencia, furtividade, precisao, magia, dano, idClasse)
VALUES ('NovoJogador', 25, 'Humano', 'SP', 100.00, 0, 10, 5, 7, 6, 8, 1);

-- O usuário 'leitor' pode consultar os jogadores na tabela 'Jogavel'
SELECT * FROM Jogavel;

-- Mostra as permissões concedidas ao usuário 'admin'
SHOW GRANTS FOR 'admin'@'localhost';

-- Mostra as permissões concedidas ao usuário 'leitor'
SHOW GRANTS FOR 'leitor'@'localhost';
```

## `PROCEDURE`
```sql
-- -------------------------------------------------------------------------
-- Classifica uma missão como 'Fácil', 'Média' ou 'Difícil' com base na experiência (XP) que concede.
-- -------------------------------------------------------------------------

DELIMITER //
CREATE PROCEDURE ClassificarDificuldadeMissao(
    IN aux_idMissao INT,
    OUT dificuldade VARCHAR(20)
)
BEGIN
    DECLARE aux_xpMissao DECIMAL(3);

    -- Obtém o XP da missão
    SELECT xpMissao INTO aux_xpMissao
    FROM Missao
    WHERE idMissao = aux_idMissao;

    -- Classifica a dificuldade usando CASE WHEN
    SET dificuldade = CASE
        WHEN aux_xpMissao <= 50 THEN 'Fácil' -- Classifica a missão como 'Fácil' caso o XP for menor ou igual a 50
        WHEN aux_xpMissao BETWEEN 51 AND 150 THEN 'Média' -- Classifica a missão como 'Média' caso o XP estiver entre 51 e 150
        ELSE 'Difícil' -- Classifica como 'Difícil' caso nenhum dos casos anteriores for verdadeiro
    END;
END //
DELIMITER ;

DROP PROCEDURE ClassificarDificuldadeMissao; -- Exclui o procedimento

-- TESTE 
-- Inserir missões para teste
-- Atenção, caso o script referente à letra c já tiver sido executado a inserção destes valores irá gerar erro!
INSERT INTO Missao (idMissao, xpMissao, dinheiro) VALUES (3, 30, 20.00); -- Fácil
INSERT INTO Missao (idMissao, xpMissao, dinheiro) VALUES (4, 100, 80.00); -- Média

-- Executar o procedimento
CALL ClassificarDificuldadeMissao(3, @dificuldade);
SELECT @dificuldade AS dificuldade; -- Deve retornar "Fácil" (para o dado inserido acima) / Deve retornar "Média" (para o dado inserido no script referente à letra c)

CALL ClassificarDificuldadeMissao(4, @dificuldade);
SELECT @dificuldade AS dificuldade; -- Deve retornar "Média" (para o dado inserido acima e para o dado inserido no script referente à letra c)

-- ------------------------------------------------------------------------------- 
-- Consulta a experiência (xpJogador) do jogador e retorna o nível calculado.
-- -------------------------------------------------------------------------------

DELIMITER //
CREATE FUNCTION CalcularNivelJogador(
    aux_idPersonagem INT
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE aux_xpJogador DECIMAL(5);  -- Experiência do jogador
    DECLARE nivel INT DEFAULT 1;   -- Nível inicial
    DECLARE xpNecessario INT DEFAULT 100;  -- XP necessário para o próximo nível

    -- 1. Obter a experiência do jogador
    SELECT xpJogador INTO aux_xpJogador
    FROM Jogavel
    WHERE idPersonagem = aux_idPersonagem;

    -- 2. Calcular o nível usando WHILE
    WHILE aux_xpJogador >= xpNecessario DO
        SET nivel = nivel + 1;  -- Incrementar o nível
        SET aux_xpJogador = aux_xpJogador - xpNecessario;  -- Subtrair XP gasto
        SET xpNecessario = xpNecessario + 50;  -- Aumentar XP necessário para o próximo nível
    END WHILE;

    -- 3. Retornar o nível calculado
    RETURN nivel;
END //
DELIMITER ;

DROP FUNCTION CalcularNivelJogador; -- Exclui a função

-- TESTE
-- Inserir um jogador com 350 pontos de experiência
-- Atenção, caso o script referente à letra c já tiver sido executado a inserção deste valor irá gerar erro!
INSERT INTO Jogavel(idPersonagem, nome, idade, raca, localOrigem, saldo, xpJogador, resistencia, furtividade, precisao, magia, dano, idClasse)
VALUES (5, 'Legolas', 200, 'Elfo', 'Floresta', 50.00, 300.00, 8, 10, 15, 5, 10, 2);

-- Calcular o nível do jogador com idPersonagem = 5
SELECT nome, CalcularNivelJogador(5) AS nivel
FROM Jogavel
WHERE idPersonagem = 5; -- Deve retornar nivel = 2 (para o dado inserido acima e para o dado inserido no script referente à letra c)

-- ------------------------------------------------------------------------------- 
-- Retorna uma classificação para cada jogador (Jogável) de acordo com a quantidade
-- da sua experiência (XP)
-- -------------------------------------------------------------------------------

DELIMITER //
CREATE PROCEDURE ClassificarJogadores()
BEGIN
    SELECT 
        idPersonagem,
        nome,
        xpJogador,
        CASE 
            WHEN xpJogador >= 350 THEN 'Lendário' -- Classificação para xp acima ou igual a 350
            WHEN xpJogador >= 200 THEN 'Veterano' -- Classificação para xp entre 200 e 349
            WHEN xpJogador >= 50 THEN 'Intermediário' -- Classificação para xp entre 50 e 199
            ELSE 'Iniciante' -- Classificação para xp abaixo de 50
        END AS classificacao
    FROM projetoISBD.Jogavel
    ORDER BY xpJogador DESC;
END //
DELIMITER ;

DROP PROCEDURE ClassificarJogadores; -- Exclui o procedimento

-- TESTE
-- Deve retornar uma tabela com todos os personagens jogáveis classificados de acordo com sua experiência (XP)
-- Os dados devem estar ordenados do maior para o menor (decrescente), ou seja, na ordem: 'Lendário', 'Veterano', 'Intermediário' e 'Iniciante'
CALL ClassificarJogadores();
```
## `TRIGGERS`
```sql
-- -----------------------------------------------
-- Trigger que impede que seja inserido um saldo negativo para o personagem Jogavel
-- -----------------------------------------------

DELIMITER //
CREATE TRIGGER before_insert_jogavel
BEFORE INSERT ON Jogavel
FOR EACH ROW
BEGIN
    IF NEW.saldo < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O saldo do personagem não pode ser negativo.';
    END IF;
END;
//
DELIMITER ;

-- Teste de Trigger
INSERT INTO Jogavel (nome, idade, raca, localOrigem, saldo, xpJogador, resistencia, furtividade, precisao, magia, dano, idClasse)
VALUES ('HeróiSombrio', 30, 'Elfo', 'Floresta Encantada', -50.00, 10.00, 5, 4, 6, 3, 7, 1);

-- -----------------------------------------------
-- Trigger que impede redução da experiência (xp) do personagem Jogavel
-- -----------------------------------------------

DELIMITER //
CREATE TRIGGER before_update_xpJogador
BEFORE UPDATE ON Jogavel
FOR EACH ROW
BEGIN
    IF NEW.xpJogador < OLD.xpJogador THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Não é permitido reduzir a experiência do jogador.';
    END IF;
END;
//
DELIMITER ;

-- Teste de Trigger
INSERT INTO Jogavel (nome, idade, raca, localOrigem, saldo, xpJogador, resistencia, furtividade, precisao, magia, dano, idClasse)
VALUES ('GuerreiroLendario', 35, 'Orc', 'Montanhas Sombrias', 200.00, 50.00, 7, 5, 8, 2, 9, 2);

UPDATE Jogavel 
SET xpJogador = 30.00 
WHERE nome = 'GuerreiroLendario';

-- -----------------------------------------------
-- Trigger que impede exclusão de missão em andamento
-- -----------------------------------------------

DELIMITER //
CREATE TRIGGER before_delete_missao
BEFORE DELETE ON Missao
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM Realiza WHERE idMissao = OLD.idMissao) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Não é possível excluir uma missão que está sendo realizada por um personagem.';
    END IF;
END;
//
DELIMITER ;

-- Teste de Trigger
INSERT INTO Realiza (idPersonagem, idMissao) VALUES (3, 2); -- Supondo que o personagem ID 3 e a missão de id 2 existem

DELETE FROM Missao WHERE idMissao = 2;
```
