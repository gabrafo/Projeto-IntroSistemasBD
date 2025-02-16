-- Cria uma view que retorna o nome dos jogadores e o tipo de classe que eles pertencem
CREATE VIEW View_Jogadores_Classes AS
SELECT J.nome, C.tipoClasse
FROM Jogavel J
INNER JOIN Classe C ON J.idClasse = C.idClasse;

-- UTILIZANDO A VIEW
-- Seleciona todos os jogadores
SELECT * FROM View_Jogadores_Classes;

-- Seleciona todos os jogadores da classe Ladrão (LAD)
SELECT * FROM View_Jogadores_Classes WHERE tipoClasse = 'LAD';


-- Cria uma view que retorna as missões que ainda não foram realizadas por nenhum jogador
CREATE VIEW View_Missoes_Nao_Realizadas AS
SELECT M.idMissao, M.xpMissao, M.dinheiro
FROM Missao M
LEFT JOIN Realiza R ON M.idMissao = R.idMissao
WHERE R.idMissao IS NULL;

-- UTILIZANDO A VIEW
-- Seleciona todas as missões não realizadas
SELECT * FROM View_Missoes_Nao_Realizadas;

-- Seleciona as missões não realizadas que oferecem mais de 100 pontos de experiência
SELECT * FROM View_Missoes_Nao_Realizadas WHERE xpMissao > 100;


-- Cria uma view que retorna os itens comuns e seus preços, juntamente com o nome do vendedor (personagem não jogável)
CREATE VIEW View_Itens_Comuns_Precos AS
SELECT C.idItem, C.preco, NJ.nome AS vendedor
FROM Comum C
INNER JOIN NaoJogavel NJ ON C.idPersonagem = NJ.idPersonagem;

-- UTILIZANDO A VIEW
-- Seleciona todos os itens comuns
SELECT * FROM View_Itens_Comuns_Precos;

-- Seleciona os itens comuns com preço superior a 75.00
SELECT * FROM View_Itens_Comuns_Precos WHERE preco > 75.00;
