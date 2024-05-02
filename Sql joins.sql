create database sql_joins;
show databases;
use sql_joins;

create table cricket(cricket_id int auto_increment,
name varchar(50), primary key(cricket_id));

create table football(football_id int auto_increment,
name varchar(50), primary key(football_id));

insert into cricket (name)
values ('Stacy'), ('Faith'), ('Joyce'), ('Anne'), ('Kyla');

select * from cricket;

insert into football (name)
values ('Stacy'), ('Telvin'), ('Joyce'), ('Levi'), ('Nalani'), ('Nick');

select * from football;

-- inner join
select * from cricket as c inner join
football as f on c.name=f.name;

-- left join
select * from cricket as c left join
football as f on c.name=f.name;

-- right join
select * from cricket as c right join
football as f on c.name=f.name;




