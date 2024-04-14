create database olympic_events;

-- 1. Write an sql query to find in which sport or event China had won the highest medals?
select Event,count(Medal)
from olympic_events.athlete_events
where team = 'China' 
and Medal <> 'NA'
group by Event
order by count(Medal) desc;
-- myfindings: Short Track Skating Men's 5,000 metres

-- 2. Which sport or event was played most consequently in winter olympic games
select Event,count(Event)
from olympic_events.athlete_events
where season = 'Winter'
group by Event
order by count(Event)desc;
-- myfindings: Men's Ice Hockey

-- 3. Write an sql query to find details of all countries which have won most silver and gold medals and atleast 1 bronze medal
select team,sum(Silver),
            sum(Gold),
            sum(Bronze)
from(
select *,
      case Medal when 'Silver' then 1 else 0 end as Silver,
      case Medal when 'Gold' then 1 else 0 end as Gold,
      case Medal when 'Bronze' then 1 else 0 end as Bronze
      from olympic_events.athlete_events
) innert
group by Team
having sum(Bronze) >0
order by sum(silver)desc;

-- 4. Which player has the maximum number of silver
select Name,
       sum(Silver)
from(
select *,
      case Medal when 'Silver' then 1 else 0 end as Silver
from olympic_events.athlete_events ) innert
group by Name
order by sum(Silver) desc;
-- myfindings: Several number of players tied

-- 5. Which sport has minimum events
select Sport,Count(*)
from olympic_events.athlete_events
group by Sport
order by count(*);
-- myfindings: Motoboating, Roque, Basque Pelota all with 1 event

-- 6. Which year has minimum events
select year,count(Event)
from olympic_events.athlete_events
group by year
order by count(Event);
-- myfindings: 1896

