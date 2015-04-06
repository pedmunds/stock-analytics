/* 
share short data procedure 
-- to add imported short data to the share data
-- and link them.
-- WARNING can take up to 24 hours to run the process
-- author PE 2014
 */

--------------------------------------------------------------------
-- populate shares table with short and 
-- percentage short change per day
-- value for dates
declare @mydate datetime,
@epic varchar(20),
@id int,
@short float

while ((select count(id) from shares where shortReal is null) > 0)
begin
select top 1 @id = id, @mydate = [date], @epic = epic 
from shares where shortReal is null
order by id desc

select @short = isnull(short2,0)
FROM         short INNER JOIN
                      epic ON short.ISIN = epic.ISIN
where TIDM = @epic
and [position date] in
(
select max([position date])
FROM         short INNER JOIN
                      epic ON short.ISIN = epic.ISIN
where TIDM = @epic and [position date] <= @mydate
)

update shares
set shortReal = @short
where id = @id
set @short = 0

end

-- process value change

set @Epic = ''

While (Select Count(*) From shares Where percentChangeshortReal is NULL) > 0
Begin
    Select Top 1 @Epic = Epic  From shares Where percentChangeshortReal is NULL

update [current]
Set percentChangeshortReal = cast((ISNULL([next].[shortReal], [current].[shortReal]) - [current].[shortReal]) as decimal(18,2)) 
FROM
   shares       AS [current]
LEFT JOIN
   shares       AS [next]
      ON [next].id = (SELECT MIN(id) FROM shares WHERE id > [current].id and epic = @Epic)
WHERE [current].epic = @Epic

End

