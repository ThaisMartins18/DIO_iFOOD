-- Criação do Banco de Dados para E-Commerce - DIO


-- drop database ecommerce;
-- create database ecommerce;
-- use ecommerce;
            
-- Criar tabela cliente
create table Clients (
    idClient int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    LName varchar(20),
    CPF char(11) not null,
    Adress varchar(30),
    constraint unique_cpf_client unique (CPF)
);

-- Criar tabela produto
create table product (
    idProduct int auto_increment primary key,
    Pname varchar(100),
    Classification_kids bool default false,
    category enum("Eletronico", "Vestimenta", "Brinquedos") not null,
    avaliacao float default 0,
    size varchar(10)
);

-- Criar tabela pagamento
create table payment (
    idClient int,
    idPayment int auto_increment,
    typePayment enum("boleto", "cartao", "cartao2"),
    limitAvailable float,
    primary key (idClient, idPayment)
);

-- Criar tabela pedido
create table orders (
    idOrder int auto_increment primary key,
    idOrderClient int,
    orderStatus enum("Cancelado", "Confirmado", "Em processamento") default "em processamento",
    orderDescription varchar(255),
    sendValue float default 10,
    paymentCash boolean default false,
    constraint fk_order_client foreign key (idOrderClient) references clients (idClient)
);

-- Criar tabela estoque
create table productStorage (
    idProdStorage int auto_increment primary key,
    storageLocation varchar(255),
    quantity int default 0
);

-- Criar tabela fornecedor
create table supplier (
    idSupplier int auto_increment primary key,
    SocialName varchar(255),
    CNPJ varchar(15) default '0',
    contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
);

-- Criar tabela vendedor
create table seller (
    idSeller int auto_increment primary key,
    SocialName varchar(255),
    AbstName varchar(255),
    CNPJ varchar(15) default '0',
    CPF char(11),
    location varchar(255),
    contact char(11) not null,
    constraint unique_cpf_seller unique (CPF),
    constraint unique_cnpj_seller unique (CNPJ)
);

-- Criar tabela produto_vendedor
create table productSeller (
    idSeller int,
    idProduct int,
    ProdQuality int default 1,
    primary key (idSeller, idProduct),
    constraint fk_product_seller foreign key (idSeller) references seller (idSeller),
    constraint fk_product_product foreign key (idProduct) references product (idProduct)
);

-- Criar tabela venda_produto
create table productOrder (
    idPOproduct int,
    idPOorder int,
    poQuality int default 1,
    poStatus enum("Disponivel", "Sem estoque") default "Disponivel",
    primary key (idPOproduct, idPOorder),
    constraint fk_productorder_product foreign key (idPOproduct) references product (idProduct),
    constraint fk_productorder_order foreign key (idPOorder) references orders (idOrder)
);

-- Criar tabela local_armazenamento
create table storageLocation (
    idProduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key (idProduct, idLstorage),
    constraint fk_store_location_product foreign key (idProduct) references product (idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productStorage (idProdStorage)
);

show tables;

-- show databases;
-- use information_schema;
-- show tables;
-- desc table_constraints;
-- desc referential_constraints;
-- select * from referential_constraints where constraint_schema = "ecommerce";


-- Inserir clientes
insert into Clients(Fname, Minit, LastName, CPF, Adress)
	values("Ana", "V", "Santos", 123456789, "Rua Janeiro  01 - São Paulo"),
		("Beatriz", "V", "Souza", 854758965, "Rua Fevereiro 02 - Rio de Janeiro"),
		("Carla", "V", "Silva", 123456789, "Rua Março 03 - Minas Gerais");

-- Inserir produtos        
insert into product(Pname, Classification_kids, category, avaliacao, size)
values
    ("Ar condicionado", false, "Eletronico", 5, null),
    ("Fone de Ouvido", false, "Eletrônico", 2, null);

-- Inserir pagamentos
insert into payment(idClient, typePayment, limitAvailable)
values
    (1, "cartao", 1000),
    (2, "boleto", 500);

-- Inserir pedidos
insert into orders(idOrderClient, orderDescription, sendValue, paymentCash)
values
    (1, "Pedido de Ana", 1200, false),
    (2, "Pedido de Beatriz", 150, true);

-- Inserir fornecedores
insert into supplier(SocialName, CNPJ, contact)
values
    ("Air Force", "123123123123123", "123123123123"),
    ("Sound Guy", "456456456465465", "456456465465");

-- Inserir vendedores
insert into seller(SocialName, CNPJ, CPF, location, contact)
values
    ("Tecnico Ar", "12312313213212", "12345678901", "Jd Alvorada", "12312312312"),
    ("Tecnico som", "45645645646545", "45645645645", "Zona Sul", "45645645645");

-- Inserir produtos de vendedores
insert into productSeller(idSeller, idProduct, ProdQuality)
values
    (1, 1, 5),
    (2, 2, 10);

-- Inserir produtos em pedidos
insert into productOrder(idPOproduct, idPOorder, poQuality)
values
    (1, 1, 2),
    (2, 2, 3);

-- Inserir localizações de estoque
insert into productStorage(storageLocation, quantity)
values
    ("Lugar 1", 50),
    ("Lugar 2", 30);

-- Inserir localizações de produtos em estoque
insert into storageLocation(idProduct, idLstorage, location)
values
    (1, 1, "Lugar 1"),
    (2, 2, "Lugar 2");


-- Quantos pedidos foram feitos por cada cliente?
SELECT c.Fname, COUNT(o.idOrder) as TotalPedidos
FROM clients c
LEFT JOIN orders o ON c.idClient = o.idOrderClient
GROUP BY c.idClient;

-- Algum vendedor também é fornecedor?
SELECT s.SocialName
FROM seller s
JOIN supplier supp ON s.CPF = supp.contact;

-- Relação de produtos fornecedores e estoques
SELECT p.Pname, supp.SocialName, ps.quantity
FROM product p
JOIN productSeller ps ON p.idProduct = ps.idProduct
JOIN seller s ON ps.idSeller = s.idSeller
JOIN supplier supp ON s.CPF = supp.contact;

-- Relação de nomes dos fornecedores e nomes dos produtos
SELECT p.Pname, supp.SocialName
FROM product p
JOIN productSeller ps ON p.idProduct = ps.idProduct
JOIN seller s ON ps.idSeller = s.idSeller
JOIN supplier supp ON s.CPF = supp.contact;