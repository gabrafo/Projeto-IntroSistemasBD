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
