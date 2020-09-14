create table post
(
    id int identity primary key,
    title varchar(200) not null,
    content varchar(2000) not null,
    author varchar(200) not null,
    created datetime default getdate()
);
create table comment
(
    id int identity primary key,
    postid int,
    content varchar(1000) not null,
    author varchar(200) not null,
    created datetime default getdate()
);