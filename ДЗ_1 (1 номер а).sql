DROP TABLE if exists public.actions
; 
CREATE TABLE public.actions
(
Rating_record_id serial primary key,	
rat_id varchar(25) NOT NULL,
grade varchar(25) NOT NULL,
outlook varchar(25),
change varchar(25) NOT NULL,
"date" char(15) NOT NULL,
ent_name varchar(200) NOT NULL,
okpo varchar(10) NOT NULL,
ogrn varchar(15),
inn varchar(10),
finst varchar(10),
agency_id varchar(10) NOT NULL,
rat_industry varchar(20),
rat_type varchar(10) NOT NULL,
horizon varchar(10),
scale_typer varchar(50),
currency varchar(10),
backed_flag varchar(30)
)
WITH (
OIDS = FALSE
)
TABLESPACE pg_default;
ALTER TABLE public.actions
OWNER to postgres;
ALTER TABLE public.actions ADD CONSTRAINT agency_id_con CHECK (agency_id='AKM' OR agency_id ='EXP' OR agency_id ='FCH' OR agency_id ='MDS' OR agency_id ='NRA' OR agency_id ='RUS' OR agency_id ='SNP');
ALTER TABLE public.actions ADD CONSTRAINT horizon_con CHECK (horizon='LT' OR horizon='ShT');
ALTER TABLE public.actions ADD CONSTRAINT scale_typer_con CHECK (scale_typer='Isc' OR position('sc' in scale_typer) = char_length(scale_typer) - 1);
ALTER TABLE public.actions ADD CONSTRAINT currency_con CHECK (currency='Icur' OR currency='Ncur');
copy public.actions (rat_id, grade, outlook, change, "date", ent_name, okpo, ogrn, inn, finst, agency_id, rat_industry, rat_type, horizon, scale_typer, currency, backed_flag) FROM E'C:\\Users\\Public\\Data\\Data\\Risks\\ratings_task.csv' (format csv, delimiter ';', header True)

-- Комментарий:
-- Заведите привычку закрывать запросы точкой с запятой или оформляйте все одним скриптом. При автоматической проверке приходится зря тратить время на расставление знаков препинания. Актуально во всех файлах.