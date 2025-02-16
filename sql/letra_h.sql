-- Cria um usuário chamado 'admin' com a senha 'admin123'
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin123';

-- Cria um usuário chamado 'leitor' com a senha 'leitor123'
CREATE USER 'leitor'@'localhost' IDENTIFIED BY 'leitor123';

-- Concede todas as permissões (ALL PRIVILEGES) no banco de dados 'projetoISBD' ao usuário 'admin'
GRANT ALL PRIVILEGES ON projetoISBD.* TO 'admin'@'localhost';

-- Concede permissão de leitura (SELECT) no banco de dados 'projetoISBD' ao usuário 'leitor'
GRANT SELECT ON projetoISBD.* TO 'leitor'@'localhost';

-- O usuário 'admin' pode inserir um novo jogador na tabela 'Jogavel'
INSERT INTO Jogavel (nome, idade, raca, localOrigem, saldo, xpJogador, resistencia, furtividade, precisao, magia, dano, idClasse)
VALUES ('NovoJogador', 25, 'Humano', 'SP', 100.00, 0, 10, 5, 7, 6, 8, 1);

-- O usuário 'leitor' pode consultar os jogadores na tabela 'Jogavel'
SELECT * FROM Jogavel;

-- Mostra as permissões concedidas ao usuário 'admin'
SHOW GRANTS FOR 'admin'@'localhost';

-- Mostra as permissões concedidas ao usuário 'leitor'
SHOW GRANTS FOR 'leitor'@'localhost';

-- Revoga a permissão de leitura (SELECT) no banco de dados 'projetoISBD' do usuário 'leitor'
REVOKE SELECT ON projetoISBD.* FROM 'leitor'@'localhost';

-- Revoga todas as permissões (ALL PRIVILEGES) no banco de dados 'projetoISBD' do usuário 'admin'
REVOKE ALL PRIVILEGES ON projetoISBD.* FROM 'admin'@'localhost';
