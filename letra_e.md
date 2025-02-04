```sql
-- Auxiliares (ver modificações)
SELECT C.idPersonagemJogavel, C.idItem, CO.dano    -- Aux do 1° delete
FROM Compra C
INNER JOIN Comum CO ON C.idItem = CO.idItem
WHERE C.idPersonagemJogavel = 1;
SELECT * FROM Realiza;                             -- Aux do 2° delete
SELECT * FROM Jogavel;                             -- Aux do 3° delete
SELECT * FROM Missao;                              -- Aux do 4° delete
SELECT * FROM NaoJogavel;                          -- Aux do 5° e 6° delete

-- Exclusão aninhada: Excluir todos os itens comprados por um jogador
SET SQL_SAFE_UPDATES = 0;
DELETE FROM Comum WHERE idItem IN (SELECT idItem FROM Compra WHERE IdPersonagemJogavel = 1);
SET SQL_SAFE_UPDATES = 1;
-- Exclusão aninhada: Excluir todos os itens comprados por um jogador
DELETE c 
FROM Comum c
JOIN Compra cp ON c.idItem = cp.idItem
WHERE cp.IdPersonagemJogavel = 1;


-- Excluir realizações de missões
DELETE FROM Realiza WHERE IdPersonagem = 1;


-- Excluir um jogador
DELETE FROM Jogavel WHERE IdPersonagem = 1;


-- Excluir uma missão
DELETE FROM Missao WHERE idMissao = 1;


-- Excluir um não jogável com item Comum (ERRO - Restrict)
DELETE FROM NaoJogavel WHERE IdPersonagem = 1;


-- Excluir um não jogável que não possui item Comum
DELETE FROM NaoJogavel WHERE IdPersonagem = 9;
```