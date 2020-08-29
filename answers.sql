--range of years in the database
/*SELECT min(debut), max(finalgame)
	FROM public.people;*/
	
--name and height of shortest player, how many games played, team he played for
/*select distinct(concat(p.namefirst, ' ', p.namelast)) as name, p.height, a.g_all as games_played, t.name
from people p
inner join appearances a
on p.playerid = a.playerid
inner join teams t
on a.teamid = t.teamid
order by p.height asc
limit 1;*/

--find all players who played at Vanderbilt, their total MLB salary
/*select p.playerid, concat(p.namefirst, ' ', p.namelast) as name, sum(sa.salary) as sum_salary
from people p
left join collegeplaying cp
on p.playerid = cp.playerid
inner join schools sc
on cp.schoolid = sc.schoolid
left join salaries sa
on p.playerid = sa.playerid
where lower(sc.schoolname) like 'vanderbilt%'
group by p.playerid
order by sum_salary desc nulls last*/