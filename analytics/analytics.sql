SELECT name FROM sqlite_master WHERE type='table';

--Listar os 10 jogos mais recentes da temporada 2023-2024
SELECT
	game_id 
	,game_date 
	,season_id 
	,team_id_home 
	,team_id_away 
FROM game
WHERE game_date BETWEEN '2023-01-01' AND '2024-01-01'
ORDER BY game_date DESC
LIMIT 100