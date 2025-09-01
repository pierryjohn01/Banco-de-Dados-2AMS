create database mercado;
use mercado;

create table clientes(
id_clientes int auto_increment primary key,
nome varchar (100) not null,
endereco varchar(150) not null,
telefone varchar(20) not null,
cep varchar(10) not null,
sexo char(1) check (sexo in ('m', 'f'),
email varchar (100) unique,
rg varchar (15) unique,
cpf varchar(14) umique,
),

create table produtos
