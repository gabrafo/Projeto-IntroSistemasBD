-- F1 - Recupera o nome dos jogadores e o tipo de classe que eles pertencem
SELECT J.nome, C.tipoClasse
FROM Jogavel J
INNER JOIN Classe C ON J.idClasse = C.idClasse;


-- F2 - Recupera todos os jogadores e suas missões, incluindo jogadores sem missões
SELECT J.nome, R.idMissao
FROM Jogavel J
LEFT JOIN Realiza R ON J.idPersonagem = R.idPersonagem;


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
WHERE EXISTS (SELECT * FROM Realiza R WHERE R.idPersonagem = J.idPersonagem);


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
