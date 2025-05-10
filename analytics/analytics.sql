SELECT name FROM sqlite_master WHERE type='table';

--Lista dos 10 jogos mais recentes da temporada 2023-2024
SELECT
	game_id 
	,game_date 
	,season_id 
	,team_id_home 
	,team_id_away 
FROM game
WHERE game_date BETWEEN '2023-01-01' AND '2024-01-01'
ORDER BY game_date DESC
LIMIT 10;

--Encontrar todos os jogadores de um time específico
SELECT
	CONCAT(cpi.first_name,' ', cpi.last_name) AS Fullname
	,t.full_name as Teamname
FROM common_player_info cpi 
INNER JOIN team t ON cpi.team_id = t.id
WHERE t.full_name = 'Boston Celtics';

--numeros de jogos por temporada
SELECT  
	season_id 
	,COUNT(*) AS total_games
FROM GAME
GROUP BY season_id 
ORDER BY season_id DESC; 

--Calcular a média de pontos por um time da casa específico
SELECT
	td.abbreviation AS Team
	,AVG(g.pts_away)
	,AVG(g.pts_home)
FROM game g
INNER JOIN team_details td ON g.team_id_away = td.team_id OR g.team_id_away = td.team_id 
WHERE td.abbreviation = 'BOS'



