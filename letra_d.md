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
SET SQL_SAFE_UPDATES = 0;
UPDATE Comum SET dano = dano + 1 WHERE idItem IN (SELECT idItem FROM Compra WHERE IdPersonagemJogavel = 1);
SET SQL_SAFE_UPDATES = 1;
-- Atualização aninhada: Aumentar o dano de todos os itens comprados por um jogador
UPDATE Comum c
JOIN Compra cp ON c.idItem = cp.idItem
SET c.dano = c.dano + 1
WHERE cp.IdPersonagemJogavel = 1;
```