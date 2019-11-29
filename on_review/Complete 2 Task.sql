-- Создадим таблицу для выноса информации о РЕЙТИНГЕ:
DROP TABLE IF EXISTS public.ratings_info;

CREATE TABLE public.ratings_info
(
   "rate_num" smallint NOT NULL,
   "rat_id" smallint NOT NULL,
   "agency_id" text NOT NULL,
   "rat_industry" text,
   "rat_type" text,
   "horizon" text,
   "scale_typer" text,
   "currency" text,
   "backed_flag" text,
    CONSTRAINT rate_key PRIMARY KEY ("rate_num")
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.ratings_info
    OWNER to postgres;

-- Из таблицы public.ratings (в задании, начиная с пункта 2, она именуется ACTIONS) вынесем необходимую информацию.
-- Кроме того, заметим, что в номинально выносимых из таблицы ratings данных нет первичного ключа (данные в любом столбце
-- повторяются в тех или иных строках), поэтому мы дополнительно создали столбец "rate_num":
INSERT INTO ratings_info SELECT COUNT(*) OVER (ORDER BY "rat_id", "agency_id", "rat_industry", "rat_type", "horizon", 
"scale_typer", "currency", "backed_flag") as rate_num,
"rat_id", "agency_id", "rat_industry", "rat_type", "horizon", "scale_typer", "currency", "backed_flag"
FROM (SELECT DISTINCT "rat_id", "agency_id", "rat_industry", "rat_type", "horizon", "scale_typer", "currency", "backed_flag"
FROM ratings)
AS my_ratings_help;

-- Создадим таблицу для выноса информации о РЕЙТИНГУЕМОМ ЛИЦЕ:
DROP TABLE IF EXISTS public.entity_info;

CREATE TABLE public.entity_info
(
   "ent_num" smallint NOT NULL,
   "ent_name" text,
   "okpo" bigint,
   "ogrn" bigint,
   "inn" bigint,
   "finst" bigint,
    CONSTRAINT entity_key PRIMARY KEY ("ent_num")
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.entity_info
    OWNER to postgres;

-- Из таблицы public.ratings (в задании, начиная с пункта 2, она именуется ACTIONS) вынесем необходимую информацию.
-- Кроме того, заметим, что в номинально выносимых из таблицы ratings уже есть первичный ключ "ent_name". Однако "ent_name",
-- как и, например, "inn", является ненадежным первичным ключом, поскольку могут изменяться с течением времени. Поэтому мы
-- создадим новый первичный ключ "ent_num":
INSERT INTO entity_info SELECT COUNT(*) OVER (ORDER BY "ent_name", "okpo", "ogrn", "inn", "finst") AS "ent_num",
"ent_name", "okpo", "ogrn", "inn", "finst"
FROM (SELECT DISTINCT "ent_name", "okpo", "ogrn", "inn", "finst" FROM ratings)
AS my_entity_help;

