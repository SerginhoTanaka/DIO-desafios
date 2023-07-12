INSERT INTO Veiculo (idRevisao, Placa) VALUES
(1, 'ABC123'),
(2, 'XYZ789'),
(3, 'DEF456');

INSERT INTO Clientes (idVeiculo) VALUES
(1),
(2),
(3);

INSERT INTO PessoaFisica (Nome, CPF, Endereco, Contato) VALUES
('John Doe', '12345678901', '123 Main St', '9876543210'),
('Jane Smith', '98765432109', '456 Elm St', '1234567890'),
('Mike Johnson', '45678901234', '789 Oak Ave', '5678901234');

INSERT INTO PessoaJuridica (RazaoSocial, CNPJ, Endereco, Contato) VALUES
('ABC Company', '12345678901234', '789 Oak Ave', '4567890123'),
('XYZ Corporation', '98765432109876', '321 Pine St', '8901234567'),
('EFG Industries', '45678901234567', '567 Maple Rd', '1234509876');

INSERT INTO Conserto (Descricao) VALUES
('Repair engine'),
('Replace brake pads'),
('Change oil filter');


INSERT INTO Revisao (Descricao) VALUES
('Oil change'),
('Tire rotation'),
('Alignment check');


INSERT INTO Mecanico (Nome, Endereco, Especialidade) VALUES
('John Smith', '123 Main St', 'Engine Specialist'),
('Jane Doe', '456 Elm St', 'Brake Specialist'),
('David Johnson', '789 Oak Ave', 'Tire Specialist');


INSERT INTO EqpMecanicos (idMecanico) VALUES
(1),
(2),
(3);


INSERT INTO OdServico (DataEmissao, ValorServico, ValorPeca, ValorTotal, Status, DataConclusao) VALUES
('2023-07-10', 100.00, 50.00, 150.00, 'CONCLUIDO', '2023-07-11'),
('2023-07-11', 75.00, 30.00, 105.00, 'EM ANDAMENTO', NULL),
('2023-07-12', 120.00, 40.00, 160.00, 'AGUARDANDO', NULL);


INSERT INTO ReferenciaPrecos (idOdServico) VALUES
(1),
(2),
(3);


INSERT INTO Autorizacao (Autorizado, idClientes, idVeiculo, idOdServico) VALUES
(TRUE, 1, 1, 1),
(FALSE, 2, 2, 2),
(TRUE, 3, 3, 3);

INSERT INTO Pecas (Descricao, Valor) VALUES
('Spark Plugs', 10.00),
('Brake Pads', 20.00),
('Oil Filter', 5.00);


INSERT INTO OsPecas (idPecas, idOdServico) VALUES
(1, 1),
(2, 2),
(3, 3);


INSERT INTO Servicos (Descricao, Valor) VALUES
('Engine Tune-up', 50.00),
('Brake Inspection', 25.00),
('Tire Rotation', 30.00);


INSERT INTO OsServicos (idServicos, idOdServico) VALUES
(1, 1),
(2, 2),
(3, 3);


--Selects 

SELECT PF.Nome AS PessoaFisica_Nome, PJ.RazaoSocial AS PessoaJuridica_RazaoSocial
FROM Veiculo V
JOIN Clientes C ON V.idVeiculo = C.idVeiculo
LEFT JOIN PessoaFisica PF ON C.idClientes = PF.idClientes
LEFT JOIN PessoaJuridica PJ ON C.idClientes = PJ.idClientes;

SELECT V.Placa, COUNT(*) AS NumConsertos
FROM Veiculo V
JOIN Conserto C ON V.idVeiculo = C.idVeiculo
GROUP BY V.Placa
HAVING NumConsertos = (SELECT MAX(NumConsertos) FROM (SELECT V2.idVeiculo, COUNT(*) AS NumConsertos FROM Veiculo V2 JOIN Conserto C2 ON V2.idVeiculo = C2.idVeiculo GROUP BY V2.idVeiculo) AS Subquery);


SELECT AVG(ValorServico) AS AvgValorServico, AVG(ValorPeca) AS AvgValorPeca
FROM OdServico
WHERE ValorTotal > 200;


SELECT M.Nome
FROM Mecanico M
JOIN EqpMecanicos EM ON M.idMecanico = EM.idMecanicos
WHERE M.Especialidade = 'Engine Specialist';


SELECT V.Placa, CASE WHEN PF.Nome IS NOT NULL THEN PF.Nome ELSE PJ.RazaoSocial END AS Cliente_Nome
FROM OdServico OS
JOIN Veiculo V ON OS.idOdServico = V.idVeiculo
JOIN Clientes C ON V.idVeiculo = C.idVeiculo
LEFT JOIN PessoaFisica PF ON C.idClientes = PF.idClientes
LEFT JOIN PessoaJuridica PJ ON C.idClientes = PJ.idClientes
WHERE OS.ValorTotal > (SELECT AVG(ValorTotal) FROM OdServico);


