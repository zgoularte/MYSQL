use CLEAN_INGA
go

create table dbo.CIDADES(
	COD_CIDADE int identity(1,1) not null,
		CIDADE varchar(100) null,
		ESTADO varchar(100) null,
	constraint PK_CIDADES primary key(COD_CIDADE)
);
go

create table dbo.EMBALAGENS(
		COD_EMBALAGEM int identity(1,1) not null,
		DESCRICAO varchar(50) not null,
	constraint PK_EMBALAGENS primary key(COD_EMBALAGEM)
);
go

create table dbo.FRAGANCIAS(
		COD_FRAGANCIA int identity(1,1) not null,
		DESCRICAO varchar(50) not null,
	constraint PK_FRAGANCIAS primary key(COD_FRAGANCIA)
);
go

create table dbo.TAMANHOS(
		COD_TAMANHO int identity(1,1) not null,
		DESCRICAO varchar(50) not null,
	constraint PK_TAMANHOS primary key(COD_TAMANHO)
);
go

create table dbo.TIPOS(
		COD_TIPO int identity(1,1) not null,
		DESCRICAO varchar(50) not null,
	constraint PK_TIPOS primary key(COD_TIPO)
);
go

create table dbo.VENDEDORES(
		MATRICULA varchar(5) not null,
		NOME varchar(200) not null,
		PERC_COMISSAO float not null,
		DATA_ADMISSAO date not null,
		DE_FERIAS bit not null,
	constraint PK_VENDEDORES primary key(MATRICULA)
);
go

create table dbo.ENDERECOS(
		CEP varchar(8) not null,
		LOGRADOURO varchar(150) not null,
		BAIRRO varchar(100) not null,
		COD_CIDADE int not null,
	constraint PK_ENDERECOS primary key(CEP)
);
go

alter table dbo.ENDERECOS
add constraint FK_CIDADES foreign key(COD_CIDADE) references dbo.CIDADES(COD_CIDADE);
go

create table dbo.CLIENTES(
		CPF varchar(11) not null,
		NOME varchar(100) null,
		CEP varchar (8) null,
		NUMERO varchar(10) null,
		DATA_DE_NASCIMENTO date not null,
		SEXO char(1) not null,
		TELEFONE_RESIDENCIAL varchar(11) null,
		TELEFONE_COMERCIAL varchar(11) null,
		TELEFONE_CELULAR varchar(11) null,
		ATIVO bit null,
	constraint PK_CLIENTES primary key(CPF)
);
go

alter table dbo.CLIENTES add constraint FK_ENDERECOS foreign key(CEP) 
references dbo.ENDERECOS(CEP) on update cascade;
go

create table dbo.PRODUTOS(
		COD_PRODUTO varchar(10) not null,
		NOME varchar(200) not null,
		COD_EMBALAGEM int not null,
		COD_TAMANHO int not null,
		COD_TIPO int not null,
		COD_FRAGANCIA int null,
		PRECO numeric(10, 2) not null,
		QUANTIDADE int not null,
	constraint PK_PRODUTOS primary key(COD_PRODUTO)
);
go

alter table dbo.PRODUTOS add constraint FK_EMBALAGENS foreign key(COD_EMBALAGEM)
references dbo.EMBALAGENS(COD_EMBALAGEM);
go

alter table dbo.PRODUTOS add constraint FK_FRAGANCIAS foreign key(COD_FRAGANCIA)
references dbo.FRAGANCIAS(COD_FRAGANCIA);
go

alter table dbo.PRODUTOS add constraint FK_TAMANHOS foreign key(COD_TAMANHO)
references dbo.TAMANHOS(COD_TAMANHO);
go

alter table dbo.PRODUTOS add constraint FK_TIPOS foreign key(COD_TIPO)
references dbo.TIPOS(COD_TIPO);
go

create table dbo.VENDAS(
		NUMERO int identity(1,1) not null,
		CPF varchar(11) not null,
		MATRICULA varchar(5) not null,
		[DATA] date not null,
		IMPOSTO float not null,
	constraint PK_VENDAS primary key(NUMERO)
);
go

alter table dbo.VENDAS add constraint FK_CLIENTES foreign key(CPF)
references dbo.CLIENTES(CPF) on update cascade;
go

alter table dbo.VENDAS add constraint FK_VENDEDORES foreign key(MATRICULA)
references dbo.VENDEDORES(MATRICULA) on update cascade;
go

create table dbo.ITENS_VENDAS(
		NUMERO int not null,
		COD_PRODUTO varchar(10) not null,
		QUANTIDADE int not null,
		PRECO float not null,
	constraint PK_ITENS_VENDAS primary key (NUMERO, COD_PRODUTO)
);
go

alter table dbo.ITENS_VENDAS with check add constraint FK_PRODUTOS foreign key(COD_PRODUTO)
references dbo.PRODUTOS(COD_PRODUTO)
on update cascade;
go

alter table dbo.ITENS_VENDAS with check add constraint FK_VENDAS foreign key(NUMERO)
references dbo.VENDAS(NUMERO);
go