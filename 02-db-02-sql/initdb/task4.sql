\c test_db;
UPDATE clients SET order_id=(SELECT id FROM orders WHERE name='Книга') WHERE last_name='Иванов Иван Иванович';
UPDATE clients SET order_id=(SELECT id FROM orders WHERE name='Монитор') WHERE last_name='Петров Петр Петрович';
UPDATE clients SET order_id=(SELECT id FROM orders WHERE name='Гитара') WHERE last_name='Иоганн Себастьян Бах';

SELECT * FROM clients WHERE order_id IS NOT NULL;