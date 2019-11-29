DROP TABLE if exists public.credit_events_task
; 
CREATE TABLE public.credit_events_task
(
  	"inn" varchar(10) NOT NULL,
	"date" date NOT NULL,
	event varchar(3) NOT NULL
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;
ALTER TABLE public.credit_events_task
    OWNER to postgres;
ALTER TABLE public.credit_events_task ADD CONSTRAINT event_con CHECK (event='dft' OR event='lqd');
copy public.credit_events_task FROM 'C:\\Users\\Public\\Data\\Data\\Risks\\credit_events_task.csv'(format csv, delimiter ';', header True)
