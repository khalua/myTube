create table videos (
  id serial4 primary key,
  name varchar(50) not null,
  description text,
  url varchar(1000),
  category varchar(50),
  timestamp timestamp
)