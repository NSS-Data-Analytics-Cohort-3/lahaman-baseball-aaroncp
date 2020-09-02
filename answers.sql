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

--group players into 3 groups based on position.  Determine number of putout by each group.
/*select sum(po) as putouts,
case when pos = 'OF'
	then 'Outfield'
	when pos in ('SS', '1B', '2B', '3B')
	then 'Infield'
	when pos in ( 'P','C')
	then 'Battery'
	else 'Undefined'
end positions
from fielding
where yearid = 2016
group by positions*/

--avg number of strikeouts by decade since 1920
/*select date_part('decade',to_timestamp(cast(yearid as varchar),'YYYY'))*10 as decade, 
	round(sum(so::decimal)/sum(w::decimal),2)
from teams
where date_part('decade',to_timestamp(cast(yearid as varchar),'YYYY'))*10 > 1910
group by decade
order by decade desc*/
--avg number of homeruns by decade since 1920
/*select date_part('decade',to_timestamp(cast(yearid as varchar),'YYYY'))*10 as decade, 
	round(sum(hr::decimal)/sum(w::decimal),2)
from teams
where date_part('decade',to_timestamp(cast(yearid as varchar),'YYYY'))*10 > 1910
group by decade
order by decade desc*/

--player with most bases stolen in 2016 who attempted to steal at least 20 times
/*select round(sb::decimal/(sb::decimal + cs::decimal),2)*100 as success_stealing_percentage, playerid
from batting
where sb + cs <> 0
and sb + cs > 19
and yearid = 2016
group by playerid, sb, cs
order by success_stealing_percentage desc*/

--largest # of wins for a team that didn't win the world series.  
/*select teamid, yearid, w
from teams
where (teamid, yearid) not in (select teamid, yearid
				from teams
				where WSWin = 'Y'
				and yearid > 1969
				and yearid < 2017)
order by w desc*/
--Smallest # of wins for team that did win
--1981 is lowest year, but there was a strike that year.  Excluding that gives 83 in 2006
/*select teamid, yearid, w
from teams
where (teamid, yearid) in (select teamid, yearid
				from teams
				where WSWin = 'Y'
				and yearid > 1969
				and yearid < 2017
				and yearid <> 1981)
order by w asc*/
--how often did a team with the most wins for the season also win the world series.
--12 Times
--percentage is (12/46)*100 = 26.09%
/*select t.teamid, t.yearid, t.w as team_wins, t.WSWin
from teams t
where (t.yearid,t.w) in (select yearid, max(w)
		   	from teams
		   	where yearid > 1969
			and yearid < 2017
		   	group by yearid)
and WSWin = 'Y'
and t.yearid > 1969
and t.yearid < 2017*/

--what teams and parks have the top 5 highest average attendance in 2016 where more than 10 games were played
/*select sub.name as team_name, p.park_name, round(cast(h.attendance as decimal)/h.games,2) as avg_attendance
from homegames h
inner join parks p
	on p.park = h.park
inner join (select distinct teamid, name, park
			from teams) as sub
	on sub.teamid = h.team
	and sub.park = p.park_name
and year = 2016
and games > 9
order by avg_attendance desc
limit 5*/

--which manager has won the TSN Manager of the year award in both National League and American League
/*select concat(p.namefirst,' ',p.namelast) as fullname,mnl.teamid as nl_teamid, mal.teamid as al_teamid, nl_yearid,al_yearid
from (select playerid, yearid as nl_yearid 
		from awardsmanagers
		where lgid = 'NL'
	 	and awardid = 'TSN Manager of the Year') as nl
inner join (select playerid, yearid as al_yearid
				from awardsmanagers
				where lgid = 'AL'
		   		and awardid = 'TSN Manager of the Year') as al
	on nl.playerid = al.playerid
inner join people p
	on p.playerid = nl.playerid
inner join managers mnl
	on mnl.playerid = nl.playerid
	and mnl.yearid = nl_yearid
inner join managers mal
	on mal.playerid = al.playerid
	and mal.yearid = al_yearid*/