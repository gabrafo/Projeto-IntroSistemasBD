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
END //
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
END //
DELIMITER ;

-- Teste de Trigger
INSERT INTO Jogavel (nome, idade, raca, localOrigem, saldo, xpJogador, resistencia, furtividade, precisao, magia, dano, idClasse)
VALUES ('GuerreiroLendario', 35, 'Orc', 'Montanhas Sombrias', 200.00, 50.00, 7, 5, 8, 2, 9, 2);

UPDATE Jogavel 
SET xpJogador = 30.00 
WHERE nome = 'GuerreiroLendario';


-- -----------------------------------------------
-- Trigger que atualiza automaticamente o saldo de um personagem Jogavel após uma compra
-- -----------------------------------------------

DELIMITER //
CREATE TRIGGER AtualizarSaldoAposCompra
AFTER INSERT ON Compra
FOR EACH ROW
BEGIN
    DECLARE preco_item DECIMAL(6,2);

    -- Obtém o preço do item comprado
    SELECT preco INTO preco_item
    FROM Comum
    WHERE idItem = NEW.idItem;

    -- Atualiza o saldo do jogador que fez a compra
    UPDATE Jogavel
    SET saldo = saldo - preco_item
    WHERE idPersonagem = NEW.idPersonagemJogavel;
END //
DELIMITER ;

-- TESTE
-- Verificando saldo do personagem 1
SELECT idPersonagem, nome, saldo 
FROM Jogavel 
WHERE idPersonagem = 1;

-- Verificando preço do item Comum 3
SELECT idItem, preco 
FROM Comum 
WHERE idItem = 3;

-- Realizando Compra com o personagem Não Jogavel 4
INSERT INTO Compra (idPersonagemJogavel, idItem, idPersonagemNaoJogavel)
VALUES (1, 3, 4);
```