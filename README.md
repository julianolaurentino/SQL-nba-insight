# SQL-nba-analytics
Visão Geral

Este README oferece uma visão geral dos exercícios de SQL criados para praticar consultas no conjunto de dados de basquete da NBA (disponível no Kaggle). O conjunto de dados, armazenado em um banco SQLite, contém informações sobre mais de 64.000 jogos, 4.800 jogadores e 30 times, com tabelas como game, player, team e box_score. Os exercícios variam de iniciante a avançado, ajudando os usuários a praticar habilidades de SQL, como filtragem, agregação, junções e funções de janela.

## Iniciante

Listar os 10 jogos mais recentes da temporada 2023-2024: Pratique SELECT, WHERE, ORDER BY e LIMIT.


Encontrar todos os jogadores de um time específico: Aprenda a usar JOIN e filtrar com WHERE.


Contar jogos por temporada: Use GROUP BY e COUNT para agregação.

## Intermediário


Calcular a média de pontos por jogo de um jogador: Combine JOIN, AVG e GROUP BY.

Listar times que marcaram mais de 120 pontos em um jogo: Use JOIN, UNION e filtragem condicional.

## Avançado

Encontrar o jogador com mais pontos em um único jogo por temporada: Pratique funções de janela (ROW_NUMBER) e CTEs.

Analisar a diferença média de pontos entre times: Use ABS, AVG e GROUP BY para cálculos avançados.

## Exemplo de query
```sql
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
```

## Autor

- [@JulianoLaurentino](https://www.linkedin.com/in/julianolaurentinodasilva/)