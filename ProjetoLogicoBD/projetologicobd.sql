-- Desafio de Projeto - DIO
-- Construa um Projeto Lógico de Banco de Dados do Zero

CREATE TABLE Cliente (
    ClienteID INT PRIMARY KEY,
    Nome VARCHAR(100),
    CPF_CNPJ VARCHAR(20)
);

CREATE TABLE Veiculo (
    VeiculoID INT PRIMARY KEY,
    ClienteID INT,
    Modelo VARCHAR(50),
    Ano INT,
    FOREIGN KEY (ClienteID) REFERENCES Cliente(ClienteID)
);

CREATE TABLE Servico (
    ServicoID INT PRIMARY KEY,
    Descricao VARCHAR(200),
    Preco DECIMAL(10, 2)
);

CREATE TABLE Atendimento (
    AtendimentoID INT PRIMARY KEY,
    VeiculoID INT,
    ServicoID INT,
    Data DATE,
    FOREIGN KEY (VeiculoID) REFERENCES Veiculo(VeiculoID),
    FOREIGN KEY (ServicoID) REFERENCES Servico(ServicoID)
);

SELECT * FROM Cliente;
SELECT * FROM Veiculo;
SELECT * FROM Servico;
SELECT * FROM Atendimento;

SELECT Nome, Modelo, Ano
FROM Cliente c
JOIN Veiculo v ON c.ClienteID = v.ClienteID
WHERE c.CPF_CNPJ = '123123123';

SELECT a.AtendimentoID, v.Modelo, s.Descricao, s.Preco, s.Preco * 1.1 AS PrecoComTaxa
FROM Atendimento a
JOIN Veiculo v ON a.VeiculoID = v.VeiculoID
JOIN Servico s ON a.ServicoID = s.ServicoID;

SELECT Nome, Modelo, Ano
FROM Cliente c
JOIN Veiculo v ON c.ClienteID = v.ClienteID
ORDER BY Ano DESC, Nome;

SELECT c.Nome, COUNT(a.AtendimentoID) AS TotalAtendimentos
FROM Cliente c
LEFT JOIN Veiculo v ON c.ClienteID = v.ClienteID
LEFT JOIN Atendimento a ON v.VeiculoID = a.VeiculoID
GROUP BY c.Nome
HAVING TotalAtendimentos > 2;

SELECT c.Nome, v.Modelo, s.Descricao, a.Data
FROM Cliente c
JOIN Veiculo v ON c.ClienteID = v.ClienteID
JOIN Atendimento a ON v.VeiculoID = a.VeiculoID
JOIN Servico s ON a.ServicoID = s.ServicoID;