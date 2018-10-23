create sequence hibernate_sequence start 1 increment 1;

create table albums (
	id int4 not null, 
	album_name varchar(255) not null, 
	cover int4, 
	creation_date varchar(255) not null, 
	description varchar(255), 
	user_id int4, 
	primary key (id)
);

create table photos (
	id int4 not null, 
	data bytea not null, 
	album_id int4,
	primary key (id)
);

create table users (
	id int4 not null, 
	username varchar(255) not null,
	password varchar(255) not null,
	email varchar(255) not null,
	active boolean not null,
	role varchar(255) not null,
	phone varchar(255),
	activation_code varchar(255),	 
	primary key (id)
);

alter table albums 
	add constraint albums_user_fk 
	foreign key (user_id) references users;
	
alter table photos 
	add constraint photos_album_fk 
	foreign key (album_id) references albums;