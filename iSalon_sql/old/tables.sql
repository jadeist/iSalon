# Reinicio
drop database if exists iSalon;
create database iSalon;
use iSalon;


# Creación

drop table if exists horarios;
create table horarios (
	id int not null auto_increment,
	nombre nvarchar(300) not null default 'SIN ASIGNAR',
	horaInicio int not null,
	horaFinal int not null,
	dia int not null default 0,
	color nvarchar(10) not null default '#000000',
	
	primary key (id)
);

drop table if exists salones;
create table salones(
	id int not null auto_increment,
	nombre nvarchar(250) not null,
	
	primary key (id)
);

drop table if exists grupoHorarios;
create table grupoHorarios(
	id int not null AUTO_INCREMENT,
	color nvarchar(10) not null default '#000000',
	
	primary key (id)
);

drop table if exists grupos;
create table grupos(
	id int not null AUTO_INCREMENT,
	nombre nvarchar(250) not null unique, 
	
	primary key (id)
);

drop table if exists usuarios;
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

drop table if exists menuContent;
create table menuContent(
	id int not null primary key,
	name nvarchar(100) not null,
	icon nvarchar(100) not null default '',
	link nvarchar(200) not null default '#',
	target nvarchar(200) not null default 'content',
	priority int not null default 0,
	active int not null default 0
);

drop table if exists messages;
create table messages(
	id int not null auto_increment,
	message nvarchar(1000),
	fecha timestamp default CURRENT_TIMESTAMP(),
	
	primary key(id)
);

drop table if exists catMenuContent;
create table catMenuContent(
	idRelMenuUsr int not null primary key AUTO_INCREMENT,
	idMenu int not null,
	typeUsr int not null,

	foreign key (idMenu) references menuContent(id)
);

drop table if exists catHorarioSalon;
create table catHorarioSalon(
	id int not null auto_increment,
	idHor int not null,
	idSal int not null,
	
	primary key (id),
	foreign key (idHor) references horarios(id),
	foreign key (idSal) references salones(id)
);

drop table if exists catHorarioGrupo;
create table catHorarioGrupo (
	id int not null auto_increment,
	idHor int not null,
	idGrp int not null,
	
	primary key (id),
	foreign key (idHor)	references horarios(id),
	foreign key (idGrp)	references grupos(id)
);

drop table if exists catGrupoUsuario;
create table catGrupoUsuario(
	id int not null AUTO_INCREMENT,
	idUsr int not null,
	idGrp int not null,
	
	primary key (id),
	foreign key (idUsr) references usuarios(id),
	foreign key (idGrp) references grupos(id)
);