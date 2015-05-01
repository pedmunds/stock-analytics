/* 
share short data procedure 
-- creates temp table to return values for
-- prices, shorts, event dates and correlations
-- copy results into spreadsheet to create charts and evaluate
-- author PE 2014
 */


declare @t TABLE (epic varchar(10), shortPrice float, 
					lowPrice float, diff float, firstshort float,
					maxshort float, shortDate datetime, shortid int,
					lowDate datetime, maxshortDate datetime,
					maxprice float, maxpriceDate datetime,
					marketcap float, pe float, eps float, beta float, CulminativeChangePrice float,
					shortReal float, correlation float, correlationReal float
					)

-- shares that where shorted with max short and then lowest later price
insert into @t (epic, shortPrice, lowPrice, firstshort, diff, maxshort, shortDate, shortid, shortreal, CulminativeChangePrice)
select b.epic, max(a.[close]) as shortPrice, min(b.[close]) as lowPrice, max(a.short) as firstshort,
cast(((max(a.[close])- min(b.[close]))/max(a.[close]))*100 as decimal(18,2)) as diff,
cast(max(MaxShort) as decimal(18,2)) as maxshort,
max(a.date) as shortDate,
max(a.id) as shortid,
max(a.shortreal) as shortreal,
cast(max(a.CulminativeChangePrice) as decimal(18,2)) as CulminativeChangePrice
--,cast(max(MaxShort) as decimal(18,2))/cast(((max(a.[close])- min(b.[close]))/max(a.[close]))*100 as decimal(18,2)) as ratio
from shares b,
(
select id, date, [close], epic, short, shortreal, CulminativeChangePrice from shares 
where id in
(
select min(id) -- orderby by date so like min(date)
from shares
where short > 0
--and epic = 'tcg'
group by epic
) 
) as a,
(
select max(short) as maxShort, epic 
from shares
group by epic
) as c
where b.epic = a.epic
and b.epic = c.epic
and b.date > a.date
--and (a.[close]*0.8) > (b.[close])
group by b.epic


-- add dates and max later price

update a
set a.lowDate = b.date
from
@t a
inner join shares b on a.epic = b.epic
where b.date > a.shortdate 
and a.lowprice = b.[close] 

update a
set a.maxshortDate = b.date
from
@t a
inner join shares b on a.epic = b.epic
where b.date > a.shortdate 
and a.maxshort = b.short 

update a
set a.maxprice = b.maxclose
from
@t a,
(select max(shares.[close]) as maxclose, t.epic from shares
inner join @t t on shares.epic = t.epic
where shares.date > t.lowDate
group by t.epic) b 
where a.epic = b.epic 

update a
set a.maxpriceDate = b.date
from
@t a
inner join shares b on a.epic = b.epic
where b.date > a.lowDate 
and a.maxprice = b.[close] 

update a
set a.marketcap=b.marketcap, a.pe=b.pe, a.eps=b.eps, a.beta=b.beta
from
@t a
inner join sharedata b on a.epic = b.epic

update a
set a.Correlation=b.Correlation, a.CorrelationReal=b.CorrelationReal
from
@t a
inner join [stats] b on a.epic = b.epic

select * from @t

--select * from shares
--where epic = 'TLPR' and cast([close] as varchar) = '336.9'

