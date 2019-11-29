-- Начнем с таблицы entity_info. Там мы создали новый столбец, который cделали первичным ключом, поскольку столбцы, которые
-- потенциально могли быть первичными ключами ("ent_name", "inn"), оказались ненадежны ввиду возможности их смены. 
-- Таким образом, нужно добавить новый столбец "ent_num" в исходную таблицу ratings (ACTIONS - ее название в задании). 
-- Сделаем данный столбец внешним ключом. Сначала создадим новый столбец в исходной таблице:
ALTER TABLE ratings add column "rate_num" smallint;

-- Далее заполним данный столбец присвоенными значениями из вспомогательной таблицы, созданной в Task 2:
UPDATE ratings
SET "ent_num"=entity_info."ent_num"
FROM entity_info
WHERE ratings."ent_name"=entity_info."ent_name"
  AND ratings."okpo"=entity_info."okpo"
  AND ratings."ogrn"=entity_info."ogrn"
  AND ratings."inn"=entity_info."inn"
  AND ratings."finst"=entity_info."finst";


-- Теперь присвоим полю в исходящей таблице ограничение внешнего ключа:
ALTER TABLE ratings
ADD CONSTRAINT fr_entity_key FOREIGN KEY ("ent_num") REFERENCES entity_info ("ent_num");

-- Убедимся, что полю было присвоено ограничение. Для этого попытаемся добавить в таблицу ratings новую строку с новым
-- ent_num без предварительного обновления таблицы entity_info.
INSERT INTO ratings VALUES (666999, 'yes', 'new', 'surprise', '2066-12-31', 'sunday', 666999, 666999, 666999, 666999, 'coding',
'is', 'really', 'fun', 'no', 'doubts', 'cheers', 666);

-- Получаем ошибку: ERROR:  insert or update on table "ratings" violates foreign key constraint "fr_entity_key".
-- Таким образом, ограничение присвоено корректно.



-- В таблице ratings_info мы создали новый столбец "rate_num", который сделали первичным ключом. Нужно добавить новый столбец
-- в исходную таблицу ratings и сделать его внешним ключом. Аналогично предыдущему действию:
ALTER TABLE ratings add column "rate_num" smallint;

UPDATE ratings
SET "rate_num"=ratings_info."rate_num"
FROM ratings_info
WHERE ratings."rat_id"=ratings_info."rat_id"
  AND ratings."agency_id"=ratings_info."agency_id"
  AND (ratings."rat_industry"=ratings_info."rat_industry"
    OR (ratings."rat_industry" IS NULL AND ratings_info."rat_industry" IS NULL))					
  AND (ratings."rat_type"=ratings_info."rat_type"
    OR (ratings."rat_type" IS NULL AND ratings_info."rat_type" IS NULL))
  AND (ratings."horizon"=ratings_info."horizon"
    OR (ratings."horizon" IS NULL AND ratings_info."horizon" IS NULL))
  AND (ratings."scale_typer"=ratings_info."scale_typer" 
    OR (ratings."scale_typer" IS NULL AND ratings_info."scale_typer" IS NULL))
  AND (ratings."currency"=ratings_info."currency"	 
    OR (ratings."currency" IS NULL AND ratings_info."currency" IS NULL))
  AND (ratings."backed_flag"=ratings_info."backed_flag"
    OR (ratings."backed_flag" IS NULL AND ratings_info."backed_flag" IS NULL));

-- Пожалуйста, обратите внимание, что многие из указанных полей могут быть нулевыми и различаться по данным полям, поэтому
-- мы также указываем, что значение "rate_num" должно учитывать в том числе нулевые значения в полях. Зададим ограничение
-- внешнего ключа:
ALTER TABLE ratings 
ADD CONSTRAINT fr_ratings_key FOREIGN KEY ("rate_num") REFERENCES ratings_info ("rate_num");

-- Убедимся, что полю было присвоено ограничение. Для этого попытаемся добавить в таблицу ratings новую строку с новым
-- ent_num без предварительного обновления таблицы ratings_info.
INSERT INTO ratings VALUES (666999, 'yes', 'new', 'surprise', '2066-12-31', 'sunday', 666999, 666999, 666999, 666999, 'coding',
'is', 'really', 'fun', 'no', 'doubts', 'cheers', 1, 666);

-- Получаем ошибку: ERROR:  insert or update on table "ratings" violates foreign key constraint "fr_ratings_key".
-- Таким образом, ограничение присвоено корректно.

