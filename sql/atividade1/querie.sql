-- inserção de dados e queries
use ecommerce;

show tables;

insert into Clients (Fname, Minit, Lname, CPF, Address) 
	   values('Maria','M','Silva', 12346789, 'rua silva de prata 29, Carangola - Cidade das flores'),
		     ('Priscilla','O','Pimentel', 212121212,'rua alemeda 289, Centro - Cidade das flores'),
			 ('Sergio','F','Silva', 020200202002,'avenida alemeda vinha 1009, Centro - Cidade das flores'),
			 ('Nelson','S','França', 3939393939,'rua lareijras 861, Centro - Cidade das flores'),
			 ('Giovanna','G','Assis', 1818188181,'avenidade koller 19, Centro - Cidade das flores'),
			 ('Joao','M','Cruz', 3434343434343,'rua alemeda das flores 28, Centro - Cidade das flores');


insert into product (Pname, classification_kids, category, avaliação, size) values
							  ('PC',false,'Eletrônico','4',null),
                              ('Biblia',true,'leitura','3',null),
                              ('roupao',true,'Vestimenta','5',null),
                              ('Maquina-de-lavar',False,'Eletrônico','4',null),
                              ('Mesa',False,'Móveis','3','3x57x80'),
                              ('Banana',False,'Alimentos','2',null),
                              ('Fire Stick Amazon',False,'Eletrônico','3',null);



delete from orders where idOrderClient in  (1,2,3,4);
insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values 
							 (1, default,'compraApp',null,1),
                             (2,default,'compraApp',50,0),
                             (3,'compraSite',null,null,1),
                             (4,default,'Confirmado',150,0);

insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus) values
						 (1,5,2,null),
                         (2,5,1,null),
                         (3,6,1,null);

-- storageLocation,quantity
insert into productStorage (storageLocation,quantity) values 
							('Londrina',1000),
                            ('Londrina',500),
                            ('Porecatu',10),
                            ('Porecatu',100),
                            ('Porecatu',10),
                            ('Sao paulo',60);

-- idLproduct, idLstorage, location
insert into storageLocation (idLproduct, idLstorage, location) values
						 (1,2,'RJ'),
                         (2,6,'GO');


insert into supplier (SocialName, CNPJ, contact) values 
							('Almeida e filhos', 123456789123456,'21985474'),
                            ('Eletrônicos Silva',854519649143457,'21985484'),
                            ('Eletrônicos Valma', 934567893934695,'21975474');
                            

insert into productSupplier (idPsSupplier, idPsProduct, quantity) values
						 (1,1,500),
                         (1,2,400),
                         (2,4,633),
                         (3,3,5),
                         (2,5,10);

insert into seller (SocialName, AbstName, CNPJ, CPF, location, contact) values 
						('Eletronicos', null, 123456789456321, null, 'Londrina', 219946287),
					    ('Vendas',null,null,123456783,'Londrina', 219567895),
						('Kids World',null,456789123654485,null,'Porecatu', 1198657484);


insert into productSeller (idPseller, idPproduct, prodQuantity) values 
						 (1,6,80),
                         (2,7,10);
                         
insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values 
							 (2, default,'CompraApp',null,1);
select * from productSeller;

select count(*) from clients;
select * from clients c, orders o where c.idClient = idOrderClient;

select Fname,Lname, idOrder, orderStatus from clients c, orders o where c.idClient = idOrderClient;
select concat(Fname,' ',Lname) as Client, idOrder as Request, orderStatus as Status from clients c, orders o where c.idClient = idOrderClient;


                             
select count(*) from clients c, orders o 
			where c.idClient = idOrderClient;

select * from orders;

-- recuperação de pedido com produto associado
select * from clients c 
				inner join orders o ON c.idClient = o.idOrderClient
                inner join productOrder p on p.idPOorder = o.idOrder
		group by idClient; 
        
-- Recuperar quantos pedidos foram realizados pelos clientes?
select c.idClient, Fname, count(*) as Number_of_orders from clients c 
				inner join orders o ON c.idClient = o.idOrderClient
		group by idClient; 