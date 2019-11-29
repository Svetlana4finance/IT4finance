-- Все нижеуказанные запросы можно запускать при помощи pgAdmin 4.
-- Мы просмотрели все приложенные к заданию таблицы, ознакомились со столбцами и тем, в каких столбцах не допускаются
-- нулевые значения. Мы увидели, что в файлах в столбцах с датами стоят числовые форматы ячеек, поэтому мы изменили формат
-- на формат дат, чтобы данные при импорте отражались корректно. Кроме того, чтобы в принципе импортировать данные, мы
-- поменяли расширение двух из трех файлов с .xlsx на .csv.

-- Создадим таблицу public.ratings с заданными столбцами, предварительно удалив уже существующую версию:
DROP TABLE IF EXISTS public.ratings;

CREATE TABLE public.ratings
(
	"rat_id" integer NOT NULL,
	"grade" text NOT NULL,
	"outlook" text,
	"change" text NOT NULL,
	"date" date NOT NULL,
	"ent_name" text NOT NULL,
	"okpo" bigint NOT NULL,
	"ogrn" bigint,
	"inn" bigint,
	"finst" bigint,
	"agency_id" text NOT NULL,
	"rat_industry" text,
	"rat_type" text NOT NULL,
	"horizon" text,
	"scale_typer" text,
	"currency" text,
	"backed_flag" text
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.ratings
    OWNER to postgres;
    
-- В результате получаем таблицу с нужными нам столбцами, но не заполненную данными.
-- Импортируем в таблицу данные из задания (на MacOS файл предварительно был отправлен в папку /tmp/ во избежании проблем с
-- правами доступа.
    
COPY public.ratings FROM '/tmp/ДЗ 1/ratings_task.csv' DELIMITER ';' CSV HEADER;
	
----
-- Создадим таблицу public.credit_events с заданными столбцами, предварительно удалив уже существующую версию:
DROP TABLE IF EXISTS public.credit_events;

CREATE TABLE public.credit_events
(
	"inn" bigint NOT NULL,
	"date" date NOT NULL,
	"event" text NOT NULL
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.credit_events
    OWNER to postgres;

-- В результате получаем таблицу с нужными нам столбцами, но не заполненную данными.
-- Импортируем в таблицу данные из задания (на MacOS файл предварительно был отправлен в папку /tmp/ во избежании проблем с
-- правами доступа.
    
COPY public.credit_events FROM '/tmp/ДЗ 1/credit_events_task.csv' DELIMITER ';' CSV HEADER;

----
-- Создадим таблицу public.scale_exp с заданными столбцами, предварительно удалив уже существующую версию:
DROP TABLE IF EXISTS public.scale_exp;

CREATE TABLE public.scale_exp
(
	"grade" text NOT NULL,
	"grade_id" integer NOT NULL
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.scale_exp
    OWNER to postgres;
    
-- В результате получаем таблицу с нужными нам столбцами, но не заполненную данными.
-- Импортируем в таблицу данные из задания (на MacOS файл предварительно был отправлен в папку /tmp/ во избежании проблем с
-- правами доступа. Пожалуйста, обратите внимание, что здесь уже нужно задать ENCONDING 'WIN 1251',
-- потому что присутствуют кириллические символы:
    
COPY public.scale_exp FROM '/tmp/ДЗ 1/scale_exp_task.csv' DELIMITER ';' CSV HEADER ENCODING 'WIN 1251';

-- В результате всех запросов мы перенесли полностью данные из файлов с заданиями в библиотеку.
