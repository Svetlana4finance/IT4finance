DROP TABLE if exists public.scale_EXP_task
;
CREATE TABLE public.scale_EXP_task
(
  	grade varchar(15) NOT NULL UNIQUE,
	grade_id integer NOT NULL PRIMARY KEY	
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;
ALTER TABLE public.scale_EXP_task
    OWNER to postgres;
copy public.scale_EXP_task FROM 'C:\\Users\\Public\\Data\\Data\\Risks\\scale_EXP_task.csv'(format csv, delimiter ';', header True,encoding 'WIN 1251')
