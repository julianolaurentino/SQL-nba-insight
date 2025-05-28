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
WHERE td.abbreviation = 'BOS';

--Listar os times que marcaram mais de 120 pontos em um jogo
SELECT
	pts_home
	,team_abbreviation_home 
	,game_date 
FROM game  
WHERE pts_home > 120
UNION 
SELECT
	pts_away 
	,team_abbreviation_away 
	,game_date 
FROM game  
WHERE pts_away  > 120
ORDER BY game_date DESC;

--Encontrar o time com mais pontos em um único jogo por temporada jogando em casa
WITH ranked_teams AS (
	SELECT
		g.team_name_home 
		,g.pts_home
		,g.season_id
		,ROW_NUMBER() OVER (PARTITION BY g.season_id ORDER BY g.pts_home DESC) AS rank
	FROM game g 
)
SELECT *
FROM ranked_teams
WHERE rank = 1
ORDER BY season_id DESC;

--Analisar a diferença média de pontos entre times em jogos
SELECT
	g.season_id
	,AVG(ABS(g.pts_home - g.pts_away)) avg_point_difference
FROM game g 
GROUP BY g.season_id 
ORDER BY g.season_id DESC;

--Encontrar os 5 times que mais pontuaram jogando fora de casa
WITH OverTeams AS(	
	SELECT 
		season_id
		,team_name_away
		,pts_away AS TotalPtsAway
		,ROW_NUMBER() OVER (PARTITION BY team_name_away ORDER BY pts_away DESC) AS rank
	FROM game
)
SELECT *
FROM OverTeams
WHERE rank <= 5
ORDER BY team_name_away


SELECT 
	season_id
	,team_name_away
	,pts_away AS TotalPtsAway
	,RANK() OVER (PARTITION BY team_name_away ORDER BY pts_away) AS rank
FROM game

--total de pontos apenas pares para times jogando em casa por temporadas
SELECT
	season_id 
	,team_name_home 
	,pts_home 
FROM game
WHERE pts_home % 2 = 0

--Listar jogos de um time específico com resultado (vitória ou derrota)
SELECT
	t.full_name AS team_name,
	strftime('%d/%m/%Y', g.game_date) AS game_date,
	g.pts_home,
	g.pts_away,
	CASE
		WHEN t.id = g.team_id_home AND g.pts_home > g.pts_away THEN 'Vitória'
		WHEN t.id = g.team_id_away AND g.pts_away > g.pts_home THEN 'Vitória'
		ELSE 'Derrota'
	END AS resultado
FROM game g
JOIN team t
	ON t.id = g.team_id_home OR t.id = g.team_id_away
WHERE t.full_name = 'Boston Celtics'
ORDER BY g.game_date DESC
LIMIT 100;

--Listar jogadores ativos em uma temporada específica
SELECT DISTINCT 
	p.full_name 
FROM player p
WHERE p.is_active = 1




