-- 6. Скрипты характерных выборок (SELECT, включающие группировки, JOIN'ы, вложенные запросы):

-- количество товаров по стране-производителю, с исключением товаров без указания страны-производителя

SELECT country, count(article_number) AS 'Количество'
FROM list
WHERE country != ' '
GROUP BY country;

-- соответственно наоборот - количество товаров без указания страны-производителя

SELECT country AS 'страна-производитель не определена', count(article_number)
FROM list
WHERE country = ' '
GROUP BY country;

-- клиенты из определенного города

SELECT firstname, lastname
FROM users u
JOIN profiles p ON (u.id = p.users_id AND p.hometown = 'Москва')
GROUP BY p.users_id
ORDER BY p.users_id;

-- покупатель больше всех сделавший заказов

SELECT firstname, lastname -- count(o.user_id)
FROM users u
WHERE id = (
  SELECT user_id 
  FROM orders o 
  GROUP BY user_id
  ORDER BY count(*) DESC
  LIMIT 1
);

-- --------------------------------------------------------------------------------------------

-- 7. Представления (минимум 2)

-- представление которое выводит название name товарной позиции из таблицы list
-- и артикульный номер из таблицы article

DROP VIEW IF EXISTS show_article;
CREATE VIEW show_article AS
SELECT a.article_numbers AS 'артикул', l.name AS 'Название товара' 
FROM list l 
JOIN 
article a 
WHERE l.article_number = a.id;

SELECT *
FROM show_article;

-- представление которое выводит название name товарной позиции из таблицы list
-- и его номер из таблицы new_products, собственно показывает что за продукт в таблице Новинки

DROP VIEW IF EXISTS show_new_products;
CREATE VIEW show_new_products AS
SELECT l.name AS 'Название товара', l.brand 
FROM list l 
JOIN 
new_products n 
WHERE l.article_number = n.list_id;

SELECT *
FROM show_new_products;

-- тоже самое в дополнении с третьей таблицей - article.

DROP VIEW IF EXISTS show_new_products_2;
CREATE VIEW show_new_products_2 AS
SELECT a.article_numbers AS 'артикул', l.name AS 'Название товара', l.brand
FROM list l 
JOIN 
new_products n 
JOIN
article a
WHERE l.article_number = n.list_id AND l.article_number = a.id;

SELECT *
FROM show_new_products_2;

-- 8. Хранимая процедура / функция / триггер (на выбор, 1 шт.);

-- Создать хранимую процедуру, которая отобразит информацию о совершенных заказах,
-- стоимость которых выше числа, заданного в аргументе.

DROP PROCEDURE IF EXISTS info_orders;
DELIMITER //

CREATE PROCEDURE info_orders (arg int)

BEGIN
    SELECT a.article_numbers AS 'артикул', l.name AS 'Название товара', l.price 
	FROM list l 
	JOIN 
	orders_products op
	JOIN
	article a
	WHERE op.list_id = l.id AND l.price > arg AND l.article_number = a.id;
END //
DELIMITER ; 

CALL info_orders(4000);











-- максимальная цена товара
SELECT name 
FROM list l
WHERE price = (SELECT max(price) FROM list)


-- вывод строки с пропущенным эллементом
SELECT * 
FROM list l
WHERE name LIKE 'Ванна с__льная ANTIKA 170х70x40 см с ножками'
-- WHERE name LIKE 'Ванна с%льная ANTIKA 170х70x40 см с ножками'

 
-- вывод имени с наибольшим id 
SELECT firstname, id
FROM users u 
ORDER BY id
DESC LIMIT 1
 

-- вывод товаров с артикулом выше 15 и средней ценой

SELECT l.article_number, AVG(l.price)
FROM list l
WHERE l.article_number > 15
GROUP BY l.article_number

























 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
