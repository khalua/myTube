create table videos (
  id serial4 primary key,
  title varchar(30) not null,
  description text,
  url varchar(100),
  category varchar(25),
  timestamp timestamp
)