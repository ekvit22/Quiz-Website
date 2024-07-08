use oop_final;

drop table if exists users;

create table users
(
    id            int auto_increment primary key,
    user_name     varchar(16)  not null unique,
    first_name    VARCHAR(32)  not null,
    last_name     varchar(32)  not null,
    password_hash varchar(256) not null,
    image         varchar(1024) default '/images/profile/default.jpg' null,
    about         text         not null,
    type enum ('admin', 'user') not null,
    is_deleted    tinyint(1) default 0  not null
);

-- Sample Users
INSERT INTO users (user_name, first_name, last_name, password_hash, image, about, type) VALUES ('realtia', 'Tia', 'Alkhazishvili', 'e99a18c428cb38d5f260853678922e03', 'NO_IMAGE', 'My name is Tia and I am a hacker and vigilante.', 'admin');
INSERT INTO users (user_name, first_name, last_name, password_hash, image, about, type) VALUES ('vazzu', 'Vasiko', 'Vazagaevi', 'a141c47927929bc2d1fb6d336a256df4', 'NO_IMAGE', 'Hello Everyone!', 'user');
INSERT INTO users (user_name, first_name, last_name, password_hash, image, about, type) VALUES ('bero', 'Gio', 'Beridze', '7a9470ecb8f55cf9f670f88b0743f9a8', 'NO_IMAGE', 'Hello Everyone!', 'user');
INSERT INTO users (user_name, first_name, last_name, password_hash, image, about, type) VALUES ('elene', 'Elene', 'Kvitsiani', '286876e9fe857d4e8c07c90c2f2de841', 'NO_IMAGE', 'Hello Everyone!', 'user');
