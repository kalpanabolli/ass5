create database Assessment5Db
use Assessment5Db
create schema bank
create table bank.Customer
(CId int primary key identity(1000,1),
CName nvarchar(50) not null,
CEmail nvarchar(50) not null unique,
Contact nvarchar(50) not null unique,CPwd AS RIGHT(CName, 2) + CAST(CId AS NVARCHAR(10)) + LEFT(Contact, 2) PERSISTED
);

create table bank.MailInfo 
( MailTo nvarchar(100),
MailDate date default getdate(),
MailMessage nvarchar(max)
)

create trigger TOMailInfo
on bank.Customer
after insert
as
begin
insert into bank.MailInfo (MailTo, MailMessage)
select i.CEmail, 'Your net banking Password is : ' + i.CPwd + '. It is valid up to 2 days only. Update it.'
from inserted i;
end

----inserting data into custumer

insert into bank.Customer values ( 'kalpana', 'kalpana@gmail.com', '9876543210'),( 'sindhu', 'sindhu@gmail.com', '9786457076');


select * from bank.MailInfo