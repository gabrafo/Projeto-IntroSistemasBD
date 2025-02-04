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
('Legolas', 293, 'Elfo', 'Floresta das Trevas', 300.00, 180, 5, 7, 10, 3, 6, 2),   -- Arqueiro (idClasse 2)
('Arya Stark', 18, 'Humana', 'Winterfell', 150.00, 150, 6, 10, 9, 1, 8, 4),        -- Assassino (idClasse 4)
('Artorias', 200, 'Cavaleiro', 'Abismo', 0.00, 400, 10, 2, 8, 3, 9, 1),            -- Guerreiro 
('Lautrec', 38, 'Assassino', 'Carim', 300.00, 200, 5, 9, 7, 1, 8, 4),              -- Assassino
('Radahn', 150, 'Demigodo', 'Caelid', 5000.00, 500, 10, 2, 9, 4, 10, 1),           -- Guerreiro
('Ranni', 120, 'Feiticeira', 'Lunaris', 2000.00, 300, 3, 8, 7, 10, 4, 3),          -- Mago (idClasse 3)
('Blaidd', 90, 'Meio-Lobo', 'Lands Between', 800.00, 250, 8, 6, 8, 2, 7, 1),       -- Guerreiro
('Boromir', 40, 'Humano', 'Gondor', 200.00, 150, 8, 3, 7, 1, 6, 5),                -- Ladrão (idClasse 5)
('Faramir', 35, 'Humano', 'Gondor', 180.00, 130, 6, 5, 9, 2, 5, 2),                -- Arqueiro
('Galadriel', 300, 'Elfo', 'Lothlórien', 500.00, 400, 4, 7, 8, 9, 3, 3),           -- Mago
('Geralt', 98, 'Bruxo', 'Kaer Morhen', 800.00, 300, 8, 7, 9, 6, 9, 4);             -- Assassino


-- NPCs (NaoJogavel):
INSERT INTO NaoJogavel (nome, idade, raca, localOrigem, historia, tipoNaoJogavel) VALUES
('Corvo de Três Olhos', 100, 'Corvo Místico', 'Westeros', 'Guardião da memória do reino', 'M'),  -- Mercador (M)
('Ferreiro Tobho', 60, 'Humano', 'Kings Landing', 'Forja armas com aço valiriano', 'O'),         -- Outro (O)
('Andre of Astora', 200, 'Gigante', 'Astora', 'Ferreiro lendário de Lordran', 'O'),
('Quelana', 143, 'Filha do Caos', 'Izalith', 'Mestra do de fogo', 'M'),
('Siegmeyer', 50, 'Humano', 'Catarina', 'Cavaleiro da cebola', 'O'),
('Quelaag', 500, 'Filha do Caos', 'Izalith', 'Irmã de Quelana', 'M'),
('Miriel', 500, 'Tartaruga', 'Ter. Intermédias', 'Sacerdote das Vows', 'M'),
('Thops', 30, 'Humano', 'Raya Lucaria', 'Estudioso de barreiras mágicas', 'O'),
('Treebeard', 125, 'Ent', 'Fangorn', 'Guardião das árvores', 'M'),
('Elrond', 650, 'Meio-Elfo', 'Valfenda', 'Senhor de Valfenda', 'M'),
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
(11, 13),-- Galadriel completa a Missão 13
(2, 11), -- Legolas completa a Missão 11
(3, 12), -- Arya Stark completa a Missão 12
(5, 6), -- Lautrec completa a Missão 6
(5, 1), -- Lautrec completa a Missão 1
(7, 2), -- Ranni completa a Missão 2
(6, 7), -- Radahn completa a Missão 7
(8, 8), -- Blaidd completa a Missão 8
(3, 9), -- Arya Stark completa a Missão 9
(9, 2), -- Boromir completa a Missão 2
(10, 4); -- Faramir completa a Missão 4


-- Itens Únicos (Unico):
INSERT INTO Unico (resistencia, dano, `+dano`, `+resistencia`, Missao_idMissao) VALUES
(25, 30, 12, 8, 3), -- Relacionado à missão 3
(10, 5, 3, 20, 4), -- Relacionado à missão 4
(15, 10, 5, 15, 2), -- Relacionado à missão 2
(18, 20, 8, 10, 5), -- Relacionado à missão 5
(5, 3, 2, 5, 6), -- Relacionado à missão 6
(20, 25, 10, 5, 3), -- Relacionado à missão 3
(12, 18, 7, 6, 7), -- Relacionado à missão 7
(8, 12, 5, 4, 8); -- Relacionado à missão 8


-- --------------------------------------------------------------
-- Trigger para verificar se o personagem não jogável inserido na tabela Comum
-- é realmente de um mercador
-- -------------------------------------------------------------- 
DELIMITER //
CREATE TRIGGER VerificarVendedorMercador
BEFORE INSERT ON Comum
FOR EACH ROW
BEGIN
    DECLARE tipoNPC ENUM('M', 'O');  -- Tipo do personagem não jogável

    -- Obtém o tipo do personagem não jogável
    SELECT tipoNaoJogavel INTO tipoNPC
    FROM projetoISBD.NaoJogavel
    WHERE idPersonagem = NEW.idPersonagem;

    -- Verifica se o personagem não é um mercador ('M')
    IF NOT tipoNPC = 'M' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Apenas mercadores podem vender itens';
    END IF;
END //
DELIMITER ;

-- Itens Comuns (Comum):
INSERT INTO Comum (resistencia, dano, preco, idPersonagem) VALUES
(5, 8, 50.00, 1), -- Relacionado a Corvo de Três Olhos
(8, 12, 80.00, 4), -- Relacionado a Quelana
(6, 4, 40.00, 6), -- Relacionado a Quelaag
(7, 10, 60.00, 7), -- Relacionado a Miriel
(4, 40, 75.00, 9), -- Relacionado a Treebeard
(9, 20, 35.00, 10); -- Relacionado a Elrond


-- --------------------------------------------------------------
-- Trigger para verificar se o personagem não jogável inserido na tabela Compra
-- é realmente de um mercador ou se ele está relacionado ao item
-- -------------------------------------------------------------- 
DELIMITER //
CREATE TRIGGER VerificarMercadorEEstoque
BEFORE INSERT ON Compra
FOR EACH ROW
BEGIN
    DECLARE tipoNPC ENUM('M', 'O');  -- Tipo do personagem não jogável (mercador ou outro)
    DECLARE itemExiste INT;  -- Variável para verificar se o item está no estoque

    -- Verifica se o personagem não jogável é um mercador
    SELECT tipoNaoJogavel INTO tipoNPC
    FROM projetoISBD.NaoJogavel
    WHERE idPersonagem = NEW.idPersonagemNaoJogavel;

    -- Se o personagem não for um mercador, bloqueia a compra
    IF NOT tipoNPC = 'M' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Apenas mercadores podem vender itens na tabela Compra';
    END IF;

    -- Verifica se o mercador tem o item em estoque
    SELECT COUNT(*) INTO itemExiste
    FROM projetoISBD.Comum
    WHERE idItem = NEW.idItem AND idPersonagem = NEW.idPersonagemNaoJogavel;

    -- Se o item não estiver no estoque do mercador, bloqueia a compra
    IF itemExiste = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: O mercador não possui esse item em estoque';
    END IF;
END //
DELIMITER ;

-- Transações (Compra):
INSERT INTO Compra (idPersonagemJogavel, idItem, idPersonagemNaoJogavel) VALUES
(1, 1, 1),   -- Jogavel 1 (Aragorn) compra Comum 1 de NPC 1 (Corvo de Três Olhos)
(9, 3, 6),   -- Jogavel 9 (Boromir) compra Comum 3 de NPC 6 (Quelaag)
(4, 2, 4),   -- Jogavel 4 (Artorias) compra Comum 2 de NPC 4 (Quelana)
(6, 4, 7),   -- Jogavel 6 (Radahn) compra Comum 4 de NPC 7 (Miriel)
(2, 5, 9),   -- Jogavel 2 (Legolas) compra Comum 5 de NPC 9 (Treebeard)
(10, 4, 7);  -- Jogavel 10 (Faramir) compra Comum 7 de NPC 7 (Miriel)


-- EXEMPLOS DE RESTRIÇÃO
-- Exemplo (Trigger): Relacionamento com personagens não jogáveis do tipo Outro ('O')
INSERT INTO Comum (resistencia, dano, preco, idPersonagem) VALUES
(4, 3, 20.00, 8), -- Relacionado a Thops
(3, 5, 30.00, 2), -- Relacionado a Ferreiro Tobho
(10, 15, 100.00, 3), -- Relacionado à Andre of Astora
(5, 8, 500.00, 2), -- Relacionado a Ferreiro Tobho
(2, 1, 10.00, 5); -- Relacionado a Siegmeyer


-- Exemplos (Trigger): Relacionamento com personagens não jogáveis do tipo Outro ('O')
-- ou que não tenha o item especificado
-- 1 -> Tentativa de inserir um personagem não jogável que seja Outro ('O')
INSERT INTO Compra (idPersonagemJogavel, idItem, idPersonagemNaoJogavel) VALUES
(8, 8, 8),   -- Jogavel 8 (Blaidd) compra Comum 8 de NPC 8 (Thops) - Outro
(1, 3, 3),   -- Jogavel 1 (Aragorn) compra Comum 3 de NPC 3 (Andre of Astora) - Outro
(7, 5, 5),   -- Jogavel 7 (Ranni) compra Comum 5 de NPC 5 (Siegmeyer) - Outro
(5, 3, 3);  -- Jogavel 5 (Lautrec) compra Comum 3 de NPC 3 (Andre of Astora) - Outro

-- 2 -> Tentativa de inserir um personagem não jogável que não tenha o item
INSERT INTO Compra (idPersonagemJogavel, idItem, idPersonagemNaoJogavel) VALUES
(5, 3, 1); -- Jogavel 5 (Lautrec) compra Comum 3 de NPC 1 (Corvo de Três Olhos) - Não possui item


-- Exemplo: valor DEFAULT de "saldo"
INSERT INTO Jogavel (nome, idade, raca, localOrigem, xpJogador, resistencia, furtividade, precisao, magia, dano, idClasse) VALUES
('Solaire', 45, 'Humano', 'Astora', 300, 8, 3, 7, 4, 6, 1);


-- Exemplo: nome não pode ser repetido (UNIQUE)
-- Error Code: 1062. Duplicate entry 'Solaire' for key 'Jogavel.nome'
INSERT INTO Jogavel (nome, idade, raca, localOrigem, xpJogador, resistencia, furtividade, precisao, magia, dano, idClasse) VALUES
('Solaire', 70, 'Druida', 'Astalavista', 320, 8, 3, 7, 4, 6, 1);
```
