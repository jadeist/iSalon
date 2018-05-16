# Reinicio
drop database if exists iSalon;
create database iSalon;
use iSalon;

drop table if exists cathorariogrupo;
drop table if exists catGrupoUsuario;
drop table if exists catHorarioSalon;
drop table if exists catMenuContent;
drop table if exists usuarios;
drop table if exists horarios;
drop table if exists salones;
drop table if exists grupoHorarios;
drop table if exists grupos;
drop table if exists usuarios;
drop table if exists menuContent;



# Creación

create table horarios (
	id int not null auto_increment,
	nombre nvarchar(300) not null default 'SIN ASIGNAR',
	horaInicio int not null,
	horaFinal int not null,
	dia int not null default 0,
	color nvarchar(10) not null default '#000000',
	
	primary key (id)
);

create table salones(
	id int not null auto_increment,
	nombre nvarchar(250) not null,
	
	primary key (id)
);

create table grupoHorarios(
	id int not null AUTO_INCREMENT,
	color nvarchar(10) not null default '#000000',
	
	primary key (id)
);

create table grupos(
	id int not null AUTO_INCREMENT,
	nombre nvarchar(250) not null unique, 
	
	primary key (id)
);

create table usuarios(
	id int not null primary key auto_increment,
	username nvarchar(250) unique not null,
	name nvarchar(250) not null default 'SIN NOMBRE',
	pass int not null,
	tipo int not null default 0
);
# 0 - alumno
# 1 - profesor
# 2 - prefecto
# 3 - administrador

create table menuContent(
	id int not null primary key,
	name nvarchar(100) not null,
	icon nvarchar(100) not null default '',
	link nvarchar(200) not null default '#',
	target nvarchar(200) not null default 'content',
	priority int not null default 0,
	active int not null default 0
);

create table catMenuContent(
	idRelMenuUsr int not null primary key AUTO_INCREMENT,
	idMenu int not null,
	typeUsr int not null,

	foreign key (idMenu) references menuContent(id)
);

create table catHorarioSalon(
	id int not null auto_increment,
	idHor int not null,
	idSal int not null,
	
	primary key (id),
	foreign key (idHor) references horarios(id),
	foreign key (idSal) references salones(id)
);

create table catHorarioGrupo (
	id int not null auto_increment,
	idHor int not null,
	idGrp int not null,
	
	primary key (id),
	foreign key (idHor)	references horarios(id),
	foreign key (idGrp)	references grupos(id)
);

create table catGrupoUsuario(
	id int not null AUTO_INCREMENT,
	idUsr int not null,
	idGrp int not null,
	
	primary key (id),
	foreign key (idUsr) references usuarios(id),
	foreign key (idGrp) references grupos(id)
);