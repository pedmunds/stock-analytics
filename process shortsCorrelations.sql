/* 
share short data procedure 
-- to calculate pearson correlation 
-- between price and shorts and update tables
-- author PE 2014
 */

-- insert into table stats

delete from stats

insert into stats (epic)
select epic 
from shares
group by epic

update u
set u.assid = s.assid
from ud u
    inner join sale s on
        u.id = s.udid

update a
set a.Correlation = b.Correlation
from
(
SELECT epic, cast((Avg([CulminativeChangePrice] * short) - Avg([CulminativeChangePrice]) * Avg(short)) / (StDevP([CulminativeChangePrice]) * StDevP(short)) as decimal (18,2)) AS Correlation
FROM shares
--where epic = 'talk'
group by epic
having (StDevP([CulminativeChangePrice]) * StDevP(short)) > 0
) b 
inner join stats a on a.epic = b.epic

update a
set a.CorrelationReal = b.CorrelationReal
from
(
SELECT epic, cast((Avg([CulminativeChangePrice] * shortReal) - Avg([CulminativeChangePrice]) * Avg(shortReal)) / (StDevP([CulminativeChangePrice]) * StDevP(shortReal)) as decimal (18,2)) AS CorrelationReal
FROM shares
--where epic = 'talk'
group by epic
having (StDevP([CulminativeChangePrice]) * StDevP(shortReal)) > 0
) b 
inner join stats a on a.epic = b.epic

