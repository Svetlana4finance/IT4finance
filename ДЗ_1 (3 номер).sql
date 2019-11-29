ALTER TABLE actions ADD CONSTRAINT entfk FOREIGN KEY (ent_name) REFERENCES info_comp (ent_name);
ALTER TABLE actions ADD CONSTRAINT ratfk FOREIGN KEY (rating_record_id) REFERENCES rat_info (rating_record_id);
ALTER TABLE actions ADD CONSTRAINT gradefk FOREIGN KEY (grade) REFERENCES scale_EXP_task (grade)

-- Комментарий:
-- Некоторые связи не создадутся, т.к. не все таблицы существуют. Связь scale_EXP_task и action таким способом установить не удастся, т.к. в scale_EXP_task нет всех значений внешнего ключа. Имейте в виду, что роль scale_EXP_task в отношении внешнего ключа может быть разной. Также следует создать связь с таблицей credit_events.
