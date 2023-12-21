Create database Oficina_Mecanica;
Use OFicina_Mecanica;
create table Cliente (
id_Cliente int primary key auto_increment,
NomeCompleto varchar(100) not null,
CPF char(11) not null,
RG char(10) not null,
DataNascimento DATE not null,
Endereço VARCHAR(200) not null,
Telefone VARCHAR (15) not null,
Email VARCHAR (30),
constraint unique_CPF_Cliente unique(CPF),
constraint unique_RG_Cliente unique(RG)
);
create table Veiculo (
Id_Veiculo int primary key auto_increment,
identificacao varchar(100) not null,
Placa char(7) not null,
Registro CHAR(11) not null,
Id_Cliente int,
constraint unique_Placa_Veiculo unique(Placa),
constraint unique_Registro_Veículo unique(Registro),
constraint fk_Veiculo_Cliente Foreign Key (id_Cliente) REFERENCES Cliente(id_Cliente)
);
Create table TipoServico (
Id_TipoServico int primary key auto_increment,
DescricaoServico VARCHAR(50) not null
);
create table Mecanico (
Id_Mecanico int primary key auto_increment,
NomeCompleto_Mecanico Varchar(100) not null,
Especialidade varchar(50) not null,
Codigo int not null
);
create table Estoque (
Id_Estoque int primary key auto_increment,
LocalEstoque varchar(25),
QuantidadeEstoque int default 0
);
create table Peca (
Id_Peca int primary key auto_increment,
NomePeca varchar(100),
ValorPeca float default 0
);
create table PecaEstoque (
Id_Peca int,
Id_Estoque int,
Quantidade_PecaEstoque int default 0,
primary key (id_Estoque, Id_Peca), 
constraint fk_PecaEstoque_Peca Foreign Key (id_Peca) REFERENCES Peca(id_Peca),
constraint fk_PecaEstoque_Estoque Foreign Key (id_Estoque) REFERENCES Estoque(id_Estoque)
);
create table MaoDeObra (
Id_MaoDeObra int primary key auto_increment,
Descriçao_MaoDeObra varchar(100),
Valor_MaoDeObra Float default 0
);
create table FormaPagamento (
Id_FormaPagamento int primary key auto_increment,
Descrição VARCHAR(30) not null
);
create table OrdemServico (
Id_OrdemServico int primary key auto_increment,
Dataemissao datetime not null,
DataConclusao datetime,
Status_OrdemServiço ENUM('Aprovado', 'Aguardando Confirmação', 'Cancelado'),
Id_Mecanico int,
Id_TipoServico int,
Id_FormaPagamento int,
Id_Cliente int,
Id_Veiculo int,
constraint fk_OrdemServico_Mecanico Foreign Key (id_Mecanico) REFERENCES Mecanico(id_Mecanico),
constraint fk_OrdemServico_TipoServico Foreign Key (id_tipoServico) REFERENCES TipoServico(id_TipoServico),
constraint fk_OrdemServico_FormaPagamento Foreign Key (id_FormaPagamento) REFERENCES FormaPagamento(id_FormaPagamento),
constraint fk_OrdemServico_Cliente Foreign Key (id_Cliente) REFERENCES Cliente(id_Cliente),
constraint fk_OrdemServico_Veiculo Foreign Key (Id_Veiculo) REFERENCES Veiculo(Id_Veiculo)
);
create Table Peca_OrdemServico (
Id_Peca int,
Id_OrdemServico int, 
Quantidade Int default 0,
constraint fk_peca_OrdemServico_Peça Foreign Key (id_Peca) REFERENCES Peca(id_Peca),
constraint fk_Peca_OrdemServico_OrdemServico Foreign Key (id_OrdemServico) REFERENCES OrdemServico(Id_OrdemServico)
);
create Table MaoDeObra_OrdemServico (
Id_MaoDeObra int,
Id_OrdemServico int, 
constraint fk_MaoeObra_OrdemServiço_MaoDeObra Foreign Key (id_MaoDeObra) REFERENCES MaoDeObra(id_MaoDeObra),
constraint fk_MaoDeObra_OrdemServiço_OrdemServico Foreign Key (id_OrdemServico) REFERENCES OrdemServico(Id_OrdemServico)
);
create table Acompanhamento (
Id_Acompanhamento int primary key auto_increment,
Id_OrdemServico int,
StatusOS ENUM('Aguardando Aprovação do cliente','Em processo de concerto','Em processo de revisão','Finalizado'),
constraint fk_OrdemServico_StatusOS Foreign Key (id_OrdemServico) REFERENCES OrdemServico(id_OrdemServico)
);
show tables;
Insert into Acompanhamento (Id_OrdemServico, StatusOS) values
(3, 'Em Processo de Concerto'),
(2,'Em Processo de Revisão'),
(1, 'Finalizado');
(4, 'Aguardando Aprovação do Cliente');
 
insert into cliente values 
(null,'Rodrigo dos Santos', 65896547789, 1265891153, '1998-09-15', 'Rua dos Papagaios 235, Cidade das Flores', '44-12354-2214',null),
(null,'Rose M. Souza','65412398712','1265474415','1985-05-15','Rua Brasil, 136, Centro - Cidade das Flores', '44-12354-2145','Rose@gmail.com'),
(null,'Sidnei da Silva','12362355477','1457856587','1961-08-20','Rua dos Passaros, 1550, Centro - Cidade das Flores', '44-11233-1125','sidineids@gmail.com'),
(null,'Jurandir Fonseca','98745365214','1235465887','1959-03-24','Rua Valente, 569, Centro - Cidade das Flores', '44-33225-3256',null)
;
insert into veiculo values
(null, 'Chevrolet Onix (ano 2010) - Vermelho', 'MKJ3E55', '32569887778', 2),
(null, 'Ford Ka (ano 2019) - Prata', 'ATP6J88', '11336588999', 3),
(null, 'Fiat Uno (ano 2005) - Preto', 'OPU35O5', '66449985311', 1),
(null, ' Volkswagen Polo (ano 2020) - Branco', 'AVM98P6', '32659977445', 4)
;
insert into FormaPagamento (descrição) values
('Cartão de Crédito'),
('Cartão de Débito'),
('Pix'),
('Dinheiro'),
('Boleto');
insert into TipoServico (descricaoServico) values
('Concerto'),
('Revisão')
;
insert into Mecanico (NomeCompleto_Mecanico, Especialidade, Codigo) values
('Marcos dos Santos', 'Eletricista', 9784),
('Jefferson Nascimento', 'Mecânico Geral', 9874),
('Antônio Moraes', 'Suspensão', 9589),
('Diego Martins', 'Mecânico Geral', 9658)
;
insert into Pedido (DescriçãoPedido, DataSolicitação, IdCliente, IdVeiculo, IdTipoServiço) values
('Problemas nos Amortecedores', '2023-12-05', 2, 1, 1),
('Revisão Completa', '2023-12-02', 1, 3, 2),
('Problemas no Motor', '2023-05-11', 4, 3, 1),
('Problemas na Suspensão', '2023-11-30', 3, 4, 1);
insert into AvaliacaoPedido values 
(2, 1, 1, 3, 1),
(1, 3, 2, 2, 2),
(4, 3, 1, 4, 3);
insert into Estoque (LocalEstoque, QuantidadeEstoque) values
('Rio de janiro', 150),
('Rio de janiro', 400),
('São Paulo', 360),
('São Paulo', 80),
('Goiás', 95)
; 
insert into Peca (NomePeca, ValorPeca) values
('Amortecedor', 200.00),
('Coxim Dianteiro Motor', 800.00),
('Suporte De Motor Automotivo', 300.00),
('Terminal de Direção', 221.00),
('Kit de Suspensão a Rosca Slim', 1200.00)
;
insert into PecaEstoque values 
(1, 2, 30),
(2, 4, 50),
(3, 1, 100),
(4, 5, 3),
(5, 3, 15);
insert into MaoDeObra (Descriçao_MaoDeObra, Valor_MaoDeObra) values
('Concerto de Motor', 1500.00),
('Revisão Completa', 500.00),
('Concerto da Suspensão', 399.00),
('Concerto da Direção', 150.00),
('Concerto dos Amortecedores', 750.00);
Insert into OrdemServico (Id_Mecanico, Id_TipoServico, Id_Cliente, Id_Veiculo, Status_OrdemServiço, Dataemissao, DataConclusao, Id_FormaPagamento) Values
(3, 1, 2, 3, 'Aprovado','2023-11-30 07:30:05', '2023-12-02 14:15:05', 2),
(1, 2, 1, 2, 'Aprovado','2023-12-02 10:00:15', '2023-12-03 17:30:00', 3),
(2, 1, 3, 1, 'Cancelado','2023-12-05 13:20:30', null, null),
(1, 2, 4, 4, 'Aguardando Confirmação','2023-12-19 10:15:10', null, null);

Insert into Peca_OrdemServico (Id_Peca, Quantidade, Id_OrdemServico) Values 
(5, 1, 1),
(null, default, 2),
(1, 1, 3),
(null, default, 4);
Insert into maodeobra_OrdemServico (Id_MaoDeObra, Id_OrdemServico) Values 
(3, 1),
(4, 2),
(5, 3),
(2, 4);
SELECT * FROM Cliente;
SELECT Veiculo.Id_Veiculo, Veiculo.Placa, Veiculo.Identificacao, Cliente.NomeCompleto
FROM Veiculo
JOIN Cliente ON Veiculo.Id_Cliente = Cliente.Id_Cliente
WHERE Veiculo.Id_Veiculo = 1;
SELECT * FROM TipoServico;
SELECT LocalEstoque, COUNT(*) AS TotalPecas
FROM PecaEstoque
JOIN Estoque ON PecaEstoque.Id_Estoque = Estoque.Id_Estoque
GROUP BY LocalEstoque;
SELECT NomeCompleto_Mecanico, Especialidade FROM Mecanico;
SELECT OrdemServico.Id_OrdemServico, Acompanhamento.StatusOS
FROM OrdemServico
JOIN Acompanhamento ON OrdemServico.Id_OrdemServico = Acompanhamento.Id_OrdemServico;
SELECT *
FROM OrdemServico
WHERE Status_OrdemServiço = 'Aprovado';
SELECT Estoque.LocalEstoque, Peca.NomePeca, PecaEstoque.Quantidade_PecaEstoque
FROM PecaEstoque
JOIN Estoque ON PecaEstoque.Id_Estoque = Estoque.Id_Estoque
JOIN Peca ON PecaEstoque.Id_Peca = Peca.Id_Peca
WHERE Estoque.LocalEstoque = 'São Paulo';
SELECT OrdemServico.Id_OrdemServico, Cliente.NomeCompleto AS NomeCliente, Veiculo.Identificacao AS IdentificacaoVeiculo, Acompanhamento.StatusOS
FROM OrdemServico
JOIN Cliente ON OrdemServico.Id_Cliente = Cliente.Id_Cliente
JOIN Veiculo ON OrdemServico.Id_Veiculo = Veiculo.Id_Veiculo
JOIN Acompanhamento ON OrdemServico.Id_OrdemServico = Acompanhamento.Id_OrdemServico;
SELECT OS.Id_OrdemServico, OS.Dataemissao, OS.DataConclusao, OS.Status_OrdemServiço,
    C.NomeCompleto AS Cliente, V.identificacao AS Veiculo, M.NomeCompleto_Mecanico AS Mecanico,
    TS.DescricaoServico AS TipoServico, FP.Descrição AS FormaPagamento,
    SUM(PO.ValorPeca * POS.Quantidade) AS TotalPecas,
    SUM(MO.Valor_MaoDeObra) AS TotalMaoDeObra,
    SUM(PO.ValorPeca * POS.Quantidade) + SUM(MO.Valor_MaoDeObra) AS ValorTotal
FROM OrdemServico OS
    JOIN Cliente C ON OS.Id_Cliente = C.id_Cliente
    JOIN Veiculo V ON OS.Id_Veiculo = V.Id_Veiculo
    JOIN Mecanico M ON OS.Id_Mecanico = M.Id_Mecanico
    JOIN TipoServico TS ON OS.Id_TipoServico = TS.Id_TipoServico
    JOIN FormaPagamento FP ON OS.Id_FormaPagamento = FP.Id_FormaPagamento
    LEFT JOIN Peca_OrdemServico POS ON OS.Id_OrdemServico = POS.Id_OrdemServico
    LEFT JOIN Peca PO ON POS.Id_Peca = PO.Id_Peca
    LEFT JOIN MaoDeObra_OrdemServico MOOS ON OS.Id_OrdemServico = MOOS.Id_OrdemServico
    LEFT JOIN MaoDeObra MO ON MOOS.Id_MaoDeObra = MO.Id_MaoDeObra
WHERE OS.Id_OrdemServico = 2; 
SELECT OS.Id_OrdemServico, PO.Id_Peca, PO.Quantidade, P.NomePeca, P.ValorPeca,
(PO.Quantidade * P.ValorPeca) AS TotalPeca
FROM OrdemServico OS
    JOIN Peca_OrdemServico PO ON OS.Id_OrdemServico = PO.Id_OrdemServico
    JOIN Peca P ON PO.Id_Peca = P.Id_Peca
WHERE OS.Id_OrdemServico = 3; 










