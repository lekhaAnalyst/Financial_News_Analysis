CREATE DATABASE financial_analysis;
USE financial_analysis;

SHOW TABLES;

SELECT * FROM financial_news;

SELECT * FROM financial_news
LIMIT 10;

SELECT COUNT(*) FROM financial_news;

-- How many financial news events were analyzed to understand market trends?

SELECT COUNT(*) AS total_news_events FROM financial_news;

-- Which sectors are most affected by financial news events?

SELECT sector, COUNT(*) AS total_events,
AVG(index_change_percent) AS avg_market_change FROM financial_news
GROUP BY sector
ORDER BY avg_market_change DESC;

-- What is the impact of positive, negative, and neutral news on market performance?

SELECT sentiment,
AVG(index_change_percent) AS average_market_change, COUNT(*) AS news_count
FROM financial_news GROUP BY sentiment;

-- Which financial events created the highest market impact?

SELECT market_event, impact_level, AVG(index_change_percent) AS avg_change FROM financial_news
GROUP BY market_event, impact_level ORDER BY avg_change DESC;

-- Identify the top 10 high-impact news events that influenced market movement.

SELECT headline,sector, index_change_percent, impact_level
FROM financial_news
WHERE impact_level='High'
ORDER BY index_change_percent DESC
LIMIT 10;

-- Which news sources publish the highest number of financial updates?

SELECT source, COUNT(*) AS total_articles
FROM financial_news
GROUP BY source
ORDER BY total_articles DESC;

-- What is the relationship between trading volume and market impact?

SELECT impact_level, AVG(trading_volume) AS avg_volume
FROM financial_news
GROUP BY impact_level
ORDER BY avg_volume DESC;

-- Which sectors performed positively based on financial news sentiment?

SELECT sector, AVG(index_change_percent) AS avg_performance
FROM financial_news
WHERE sentiment='Positive'
GROUP BY sector
ORDER BY avg_performance DESC;

-- Find the most negative market-moving news events?

SELECT headline, sector, index_change_percent
FROM financial_news
ORDER BY index_change_percent ASC
LIMIT 10;

-- Rank top performing news events within each sector?

SELECT * FROM ( SELECT headline, sector, index_change_percent,
RANK() OVER( PARTITION BY sector
ORDER BY index_change_percent DESC
) AS ranking FROM financial_news) x WHERE ranking <= 3;
