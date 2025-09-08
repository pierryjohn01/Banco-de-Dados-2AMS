CREATE DATABASE LojaCarros;
USE LojaCarros;

CREATE TABLE Marca (
    id_marca INT AUTO_INCREMENT PRIMARY KEY,
    nome_marca VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Modelo (
    id_modelo INT AUTO_INCREMENT PRIMARY KEY,
    nome_modelo VARCHAR(100) NOT NULL,
    id_marca INT NOT NULL,
    ano_lancamento YEAR NOT NULL,
    FOREIGN KEY (id_marca) REFERENCES Marca(id_marca)
);

CREATE TABLE Veiculo (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    id_modelo INT NOT NULL,
    cor VARCHAR(50) NOT NULL,
    ano_fabricacao YEAR NOT NULL,
    preco DECIMAL(10,2) NOT NULL CHECK (preco > 0),
    chassi VARCHAR(17) NOT NULL UNIQUE,
    FOREIGN KEY (id_modelo) REFERENCES Modelo(id_modelo)
);

CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    email VARCHAR(100) UNIQUE,
    telefone VARCHAR(20)
);

CREATE TABLE Funcionario (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    cargo VARCHAR(50) NOT NULL
);

CREATE TABLE Venda (
    id_venda INT AUTO_INCREMENT PRIMARY KEY,
    id_veiculo INT NOT NULL,
    id_cliente INT NOT NULL,
    id_funcionario INT NOT NULL,
    data_venda DATE NOT NULL,
    valor_venda DECIMAL(10,2) NOT NULL CHECK (valor_venda > 0),
    FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_funcionario) REFERENCES Funcionario(id_funcionario)
);

CREATE TABLE Estoque (
    id_estoque INT AUTO_INCREMENT PRIMARY KEY,
    id_veiculo INT NOT NULL,
    localizacao VARCHAR(100) NOT NULL,
    quantidade INT NOT NULL CHECK (quantidade >= 0),
    data_atualizacao DATE NOT NULL,
    FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo)
);


INSERT INTO Marca (nome_marca) VALUES
('Toyota'), ('Ford'), ('Chevrolet'), ('Honda'), ('Hyundai');

INSERT INTO Modelo (nome_modelo, id_marca, ano_lancamento) VALUES
('Corolla', 1, 2010),
('Civic', 4, 2012),
('Focus', 2, 2011),
('Onix', 3, 2015),
('HB20', 5, 2016);

INSERT INTO Veiculo (id_modelo, cor, ano_fabricacao, preco, chassi) VALUES
(1, 'Prata', 2020, 85000.00, '9BWZZZ377VT004251'),
(2, 'Preto', 2019, 78000.00, '9BWZZZ377VT004252'),
(3, 'Branco', 2021, 92000.00, '9BWZZZ377VT004253'),
(4, 'Vermelho', 2022, 67000.00, '9BWZZZ377VT004254'),
(5, 'Azul', 2023, 73000.00, '9BWZZZ377VT004255');

INSERT INTO Cliente (nome, cpf, email, telefone) VALUES
('João Silva', '12345678901', 'joao@email.com', '11999999999'),
('Maria Souza', '98765432100', 'maria@email.com', '11988888888'),
('Carlos Lima', '11122233344', 'carlos@email.com', '11977777777'),
('Ana Paula', '55566677788', 'ana@email.com', '11966666666'),
('Bruno Rocha', '99988877766', 'bruno@email.com', '11955555555');

INSERT INTO Funcionario (nome, cpf, cargo) VALUES
('Carlos Mendes', '11122233344', 'Vendedor'),
('Ana Lima', '55566677788', 'Gerente'),
('Fernanda Costa', '22233344455', 'Vendedor'),
('Ricardo Alves', '33344455566', 'Financeiro'),
('Juliana Torres', '44455566677', 'Vendedor');

INSERT INTO Venda (id_veiculo, id_cliente, id_funcionario, data_venda, valor_venda) VALUES
(1, 1, 1, '2023-08-15', 85000.00),
(2, 2, 2, '2023-09-10', 78000.00),
(3, 3, 3, '2023-10-05', 92000.00),
(4, 4, 4, '2023-11-20', 67000.00),
(5, 5, 5, '2023-12-01', 73000.00);

INSERT INTO Estoque (id_veiculo, localizacao, quantidade, data_atualizacao) VALUES
(1, 'São Paulo', 3, '2023-12-01'),
(2, 'Rio de Janeiro', 2, '2023-12-01'),
(3, 'Belo Horizonte', 1, '2023-12-01'),
(4, 'Curitiba', 4, '2023-12-01'),
(5, 'Salvador', 5, '2023-12-01');


SELECT v.id_venda, c.nome AS cliente, f.nome AS funcionario, v.data_venda, v.valor_venda
FROM Venda v
JOIN Cliente c ON v.id_cliente = c.id_cliente
JOIN Funcionario f ON v.id_funcionario = f.id_funcionario
WHERE c.nome LIKE '%João%';

SELECT v.id_veiculo, m.nome_modelo, v.cor, v.preco
FROM Veiculo v
JOIN Modelo m ON v.id_modelo = m.id_modelo
WHERE m.nome_modelo LIKE '%Civic%' OR v.cor = 'Preto';

SELECT e.localizacao, m.nome_modelo, v.cor, e.quantidade
FROM Estoque e
JOIN Veiculo v ON e.id_veiculo = v.id_veiculo
JOIN Modelo m ON v.id_modelo = m.id_modelo
WHERE e.localizacao = 'São Paulo';
