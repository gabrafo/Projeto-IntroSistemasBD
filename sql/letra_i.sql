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
SELECT * FROM Missao;

-- Executar o procedimento
CALL ClassificarDificuldadeMissao(3, @dificuldade);
SELECT @dificuldade AS dificuldade; -- Deve retornar "Média"

CALL ClassificarDificuldadeMissao(2, @dificuldade);
SELECT @dificuldade AS dificuldade; -- Deve retornar "Difícil"


-- ------------------------------------------------------------------------------- 
-- Consulta a experiência (xpJogador) do jogador e retorna o nível calculado.
-- -------------------------------------------------------------------------------

DELIMITER //
CREATE FUNCTION CalcularNivelJogador(
    aux_idPersonagem INT
)
RETURNS INT
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
SELECT * FROM Jogavel;

-- Calcular o nível do jogador com idPersonagem = 5
SELECT nome, CalcularNivelJogador(5) AS nivel
FROM Jogavel
WHERE idPersonagem = 5; -- Deve retornar nivel = 2

-- Teste chamando só a função
Select CalcularNivelJogador(5);


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
        END AS classificação
    FROM projetoISBD.Jogavel
    ORDER BY xpJogador DESC;
END //
DELIMITER ;

DROP PROCEDURE ClassificarJogadores; -- Exclui o procedimento

-- TESTE
-- Deve retornar uma tabela com todos os personagens jogáveis classificados de acordo com sua experiência (XP)
-- Os dados devem estar ordenados do maior para o menor (decrescente), ou seja, na ordem: 'Lendário', 'Veterano', 'Intermediário' e 'Iniciante'
CALL ClassificarJogadores();


-- ------------------------------------------------------------------------------- 
-- Retorna uma relação de itens e seus vendedores (estoque)
-- -------------------------------------------------------------------------------

DELIMITER //
CREATE PROCEDURE ListarItensComunsEVendedores()
BEGIN
    SELECT C.idItem, C.resistencia, C.dano, C.preco, N.nome AS NomeVendedor
    FROM projetoISBD.Comum C
    JOIN projetoISBD.NaoJogavel N ON C.idPersonagem = N.idPersonagem
    ORDER BY N.nome;
END //
DELIMITER ;

-- TESTE
CALL ListarItensComunsEVendedores();
