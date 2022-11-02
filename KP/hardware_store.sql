DROP DATABASE IF EXISTS hardware_store;
CREATE DATABASE hardware_store;
USE hardware_store;


DROP TABLE IF EXISTS article;
CREATE TABLE article(
	id SERIAL PRIMARY KEY,
    article_numbers VARCHAR(32)
);

INSERT INTO article (article_numbers) VALUES
	('A00001'),
	('A00002'),
	('A00003'),
	('A00004'),
	('A00005'),
	('A00006'),
	('A00007'),
	('A00008'),
	('A00009'),
	('A00010'),
	('A00011'),
	('A00012'),
	('A00013'),
	('A00014'),
	('A00015'),
	('A00016'),
	('A00017'),
	('A00018'),
	('A00019'),
	('A00020'),
	('A00021'),
	('A00022');

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs(
	id SERIAL PRIMARY KEY,
    name_catalogs VARCHAR(255)
);

INSERT INTO catalogs (name_catalogs) VALUES
	('Стройматериалы'),
	('Инструмент'),
	('Сантехника'),
	('Новинки');


DROP TABLE IF EXISTS categories;
CREATE TABLE categories (
	id SERIAL PRIMARY KEY, -- так и не понял в каких случаях нужно писать PRIMARY KEY
	id_catalogs BIGINT UNSIGNED NOT NULL,
	name_categories VARCHAR(255),
    	
	FOREIGN KEY (id_catalogs) REFERENCES catalogs(id)
);

INSERT INTO categories (id_catalogs, name_categories) VALUES
	(1, 'Стеновые и фасадные материалы'),
	(1, 'Сухие строительные смеси'),
	(1, 'Теплоизоляция и шумоизоляция'),
	(1, 'Металлопрокат'),
	(2, 'Ручной инструмент'),
	(2, 'Электроинструмент'),
	(2, 'Спецодежда и средства защиты'),
	(2, 'Газовое и сварочное оборудование'),
	(2, 'Измерительные инструменты'),
	(3, 'Смесители и душевое оборудование'),
	(3, 'Раковины, пьедесталы и комплектующие'),
	(3, 'Ванны и экраны'),
	(3, 'Полотенцесушители и комплектующие'),
	(3, 'Унитазы и инсталляции');


DROP TABLE IF EXISTS list;
CREATE TABLE list (
	id SERIAL PRIMARY KEY, -- так и не понял в каких конкретно случаях нужно писать PRIMARY KEY
	id_categories BIGINT UNSIGNED NOT NULL COMMENT 'Номер в каталоге',
	article_number BIGINT UNSIGNED NOT NULL COMMENT 'Артикул',
	name VARCHAR(255) COMMENT 'Название',
	brand VARCHAR(255) COMMENT 'Бренд',
	country VARCHAR(255) COMMENT 'Страна производитель',
	size_weight VARCHAR(255) COMMENT 'размер (мм) / вес (кг)',
	power VARCHAR(50) COMMENT 'Мощность', -- не уверен в правильности выбора типа данных, часть строк будут без данных
	status VARCHAR(50) COMMENT 'YES or NO',
    price DECIMAL (11,2) COMMENT 'Цена',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,	

	FOREIGN KEY (id_categories) REFERENCES categories(id),
	FOREIGN KEY (article_number) REFERENCES article(id)
);

INSERT INTO list
	(id_categories, article_number, name, brand, country, size_weight, power, status, price)
VALUES
	(1, 1, 'Газобетон Ytong 75х250х625 мм D500', 'Ytong', ' ', '75х250х625', ' ', 'YES', 90.23),
	(1, 2, 'Кирпич рядовой Мстера полнотелый М150 250х120х65 мм 1NF', 'Мстера', ' ', '250х120х65', ' ', 'YES', 27.9),
	(1, 3, 'Пазогребневая плита ВОЛМА влагостойкая 667х500х80 мм пустотелая', 'ВОЛМА', ' ', '667х500х80', ' ', 'YES', 261),
	(2, 4, 'Штукатурка гипсовая Knauf Ротбанд 30 кг', 'Knauf', ' ', '30', ' ', 'YES', 495),
	(2, 5, 'Пескобетон (ЦПС) М300 Dauer 40 кг', 'Dauer', ' ', '40', ' ', 'NO', 278),
	(3, 6, 'Шумоизоляция Rockwool Акустик Баттс 50х600х1000 мм 6 кв.м', 'Rockwool', ' ', '50х600х1000', ' ', 'YES', 1463),
	(4, 7, 'Труба профильная 40х20х2 мм прямоугольная 3 м', ' ', ' ', '40х20х2', ' ', 'YES', 99),
	(5, 8, 'Рулетка Hesler с автостопом магнитная 5 м x 19 мм', 'Hesler', 'Китай', '5х19', ' ', 'YES', 287),
	(5, 9, 'Рулетка Gross с автостопом 5 м x 25 мм', 'Gross', 'Китай', '5х25', ' ', 'NO', 629),
	(6, 10, 'Фен строительный электрический Интерскол ФЭ-2000ЭМ (385.0.1.00) 2000 Вт', 'Интерскол', 'РФ', ' ', 2000, 'YES', 3660),
	(6, 11, 'Лобзик электрический Makita 4329 450 Вт', 'Makita', 'Япония', ' ', 450, 'YES', 4991),
	(7, 12, 'Перчатки 4 нити с ПВХ покрытием черные', ' ', 'РФ', 'XS', ' ', 'YES', 39),
	(8, 13, 'Электроды Esab МР-3 d3 мм 1 кг', 'Esab', 'РФ', '1', ' ', 'NO', 718),
	(8, 14, 'Редуктор пропановый Redius БПО-5-3', 'Redius', 'РФ', '0,4', ' ', 'YES', 1175),
	(9, 15, 'Уровень лазерный ADA CUBE mini Basic Edition (А00461)', 'ADA', 'Китай', '0,25', ' ', 'YES', 3290),
	(10, 16, 'Смеситель для раковины CORSA DECO Wave однорычажный с поворотным изливом', 'CORSA DECO', ' ', 160, ' ', 'YES', 699),
	(10, 17, 'Смеситель для ванны CORSA DECO Wave с длинным изливом однорычажный с лейкой', 'CORSA DECO', ' ', 300, ' ', 'YES', 1999),
	(11, 18, 'Раковина SANTERI Pro 560 мм', 'SANTERI', ' ', 560, ' ', 'YES', 1621),
	(11, 19, 'Пьедестал SANTERI Версия/Соната/Pro', 'SANTERI', ' ', ' ', ' ', 'YES', 1205),
	(12, 20, 'Ванна стальная ANTIKA 170х70x40 см с ножками', 'ANTIKA', ' ', '1700х700x400', ' ', 'YES', 8369),
	(13, 21, 'Полотенцесушитель электрический MyFrea ЭК М 500х500 мм М-образный', 'MyFrea', ' ', '500х500', ' ', 'YES', 2779),
	(14, 22, 'Унитаз-компакт GESSO Home de luxe W102 с косым выпуском c сиденьем пластик', 'GESSO', ' ', '780х350х620', ' ', 'YES', 4790);


DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    email VARCHAR(120) UNIQUE,
 	password_hash VARCHAR(100),
	phone BIGINT UNSIGNED UNIQUE
  
	-- INDEX users_firstname_lastname_idx(firstname, lastname)
) COMMENT = 'Покупатели';

INSERT INTO users (firstname, lastname, email, password_hash, phone) VALUES
	('Геннадий', 'Иванов', 'delphia75@example.org', '076d3cc7f27b732e3ca1840cc3a68edb229e4a98', '79890826303'),
	('Наталья', 'Смирнова', 'gottlieb.esta@example.org', '6bcc0fd4f80ab9dbaf2e5366f619bf34fa677e07', '79323069901'),
	('Александр', 'Кузнецов', 'ftorphy@example.com', '5ab693a3e78ee1dd4ff09b9383f0cb6d6d79b5d0', '79267821683'),
	('Сергей', 'Попов', 'cremin.krystina@example.com', '5cbef431a00a17e6d34170a18a8403f4911305ae', '79498047003'),
	('Иван', 'Соколов', 'ray.maggio@example.com', 'f565e15447cc150f56dbe47f5719d894107930c1', '79765057536'),
	('Мария', 'Васильева', 'kturner@example.net', '155cc98b38a3499b78a95657bb3943b812d04d3e', '79863220151'),
	('Евгений', 'Новиков', 'cassin.john@example.org', '8bc45675119575bb749c0cd32f9311f34b0c803e', '79384791165');

 
DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles` (
	users_id BIGINT UNSIGNED NOT NULL UNIQUE,
    gender CHAR(1),
    birthday DATE,
    created_at DATETIME DEFAULT NOW(),
    hometown VARCHAR(100),
	
    FOREIGN KEY (users_id) REFERENCES users(id)
);

INSERT INTO profiles (users_id, gender, birthday, hometown) VALUES
	('1', 'М', '1990-10-05', 'СПб'),
	('2', 'Ж', '1984-11-12', 'Москва'),
	('3', 'М', '1985-05-20', 'Москва'),
	('4', 'М', '1988-02-14', 'Новгород'),
	('5', 'М', '1998-01-12', 'СПб'),
	('6', 'Ж', '1992-08-29', 'Казань'),
	('7', 'М', '1992-08-29', 'Ростов');


/*DROP TABLE IF EXISTS orders;
CREATE TABLE orders(
	id SERIAL,
    user_id BIGINT UNSIGNED NOT NULL,
    list_id BIGINT UNSIGNED NOT NULL,
    status VARCHAR(50) COMMENT 'Выполнен или Нет',
	total INT UNSIGNED DEFAULT 1 COMMENT 'Количество заказанных товарных позиций',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (list_id) REFERENCES list(id)
);

INSERT INTO orders (user_id, list_id) VALUES
	(3, 5),
	(4, 7),
	(4, 21),
	(7, 21);*/


DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (user_id) REFERENCES users(id)
) COMMENT = 'Заказы';

INSERT INTO orders (user_id) VALUES
	(3),
	(4),
	(4),
	(7);


DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
    id SERIAL PRIMARY KEY,
    order_id BIGINT UNSIGNED NOT NULL,
    list_id BIGINT UNSIGNED NOT NULL,
    total INT UNSIGNED DEFAULT 1 COMMENT 'Количество заказанных товарных позиций',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (list_id) REFERENCES list(id)
) COMMENT = 'Состав заказа';

INSERT INTO orders_products (order_id, list_id, total) VALUES
	(1, 5, 5),
	(1, 6, 10),
	(1, 21, 3),
	(2, 7, 10),
	(3, 11, 3),
	(3, 20, 10),
	(4, 1, 3),
	(4, 21, 1);


DROP TABLE IF EXISTS cart;
CREATE TABLE cart(
	id SERIAL,
    list_id BIGINT UNSIGNED NOT NULL,
    count BIGINT UNSIGNED NOT NULL,

	FOREIGN KEY (list_id) REFERENCES list(id)
);
 
INSERT INTO cart (list_id, count) VALUES
	(4, 5),
	(5, 2),
	(7, 10),
	(21, 1);


DROP TABLE IF EXISTS new_products;
CREATE TABLE new_products(
	id SERIAL,
	list_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

	FOREIGN KEY (list_id) REFERENCES list(id)
);

INSERT INTO new_products (list_id) VALUES
	(2),
	(8);


DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts (
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	list_id BIGINT UNSIGNED NOT NULL,
	discount FLOAT UNSIGNED COMMENT 'Величина скидки от 0.0 до 1.0',
	started_at DATETIME,
	finished_at DATETIME,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (list_id) REFERENCES list(id)
) COMMENT = 'Скидки';

INSERT INTO discounts (user_id, list_id, discount, started_at, finished_at) VALUES
	(3, 5, 8.5, '2022-10-15 12:00:00', '2022-11-01 12:00:00'),
	(6, 2, 10.0, '2022-10-15 12:00:00', '2022-11-01 12:00:00');










