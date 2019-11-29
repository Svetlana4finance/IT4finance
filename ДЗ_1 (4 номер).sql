SELECT distinct ent_name, grade, assign_date
FROM actions, (SELECT actions2.rating_record_id, actions2.ent_name, actions2.grade, actions2."date" as assign_date
from actions actions2
WHERE actions2."date" =
(SELECT max("date")
from actions actions2
WHERE actions2.rat_id = actions.rat_id
AND actions.date > actions2."date"))
as f
WHERE actions.rating_record_id = f.rating_record_id
AND change != 'снят'
AND change != 'приостановлен'

-- Комментарий:
-- 1. Запрос не исполняется. Как минимум проблема алиасов. 
-- 2. Логика запроса не отвечает заданию. Нужно задавать в запросе дату и тип рейтинга; запрос должен возвращать актуальные рейтинги заданного типа на заданную дату рейтинги по всем компаниям, имеющих заданный рейтинг.