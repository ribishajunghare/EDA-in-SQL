-- Let's look at the table

SELECT *
FROM [PROJECT 1].[dbo].[vgsales];

-- How many platform, genre and publisher are there?

SELECT COUNT(DISTINCT Platform) AS num_of_platform
FROM [PROJECT 1].[dbo].[vgsales];

SELECT COUNT(DISTINCT Genre) AS num_of_genre
FROM [PROJECT 1].[dbo].[vgsales];

SELECT COUNT(DISTINCT Publisher) AS num_of_publisher
FROM [PROJECT 1].[dbo].[vgsales];


--How many video games from each platform,genre and publisher - i.e. frequency?

SELECT COUNT(*) AS freq_platform, Platform
FROM [PROJECT 1].[dbo].[vgsales]
GROUP BY Platform
ORDER BY freq_platform DESC;

SELECT COUNT(*) AS freq_genre, Genre
FROM [PROJECT 1].[dbo].[vgsales]
GROUP BY Genre
ORDER BY freq_genre DESC;

SELECT COUNT(*) AS freq_publisher, Publisher
FROM [PROJECT 1].[dbo].[vgsales]
GROUP BY Publisher
ORDER BY freq_publisher DESC;

-- What is the highest global sales?

SELECT MAX(Global_Sales) AS highest_global_sales
FROM [PROJECT 1].[dbo].[vgsales];


-- Which video game has the highest global sales and from which platform, genre, publisher and year?

SELECT Name, Platform, Year, Genre, Publisher, Global_Sales
FROM [PROJECT 1].[dbo].[vgsales]
WHERE Global_Sales = ( SELECT MAX(Global_Sales)
                       FROM [PROJECT 1].[dbo].[vgsales]);


-- Which video game has the minimum global sales and from which platform, genre, publisher and year?

SELECT Name, Platform, Year, Genre, Publisher, Global_Sales
FROM [PROJECT 1].[dbo].[vgsales]
WHERE Global_Sales = ( SELECT MIN(Global_Sales)
                       FROM [PROJECT 1].[dbo].[vgsales]);


-- How many video games in each year?

SELECT COUNT(*) AS num_of_games, Year
FROM [PROJECT 1].[dbo].[vgsales]
GROUP BY Year
ORDER BY 1 DESC;


-- Which platform, genre and publisher has the highest global sales?

SELECT SUM(Global_Sales), Platform
FROM [PROJECT 1].[dbo].[vgsales]
GROUP BY Platform
ORDER BY SUM(Global_Sales) DESC;

SELECT SUM(Global_Sales), Genre
FROM [PROJECT 1].[dbo].[vgsales]
GROUP BY Genre
ORDER BY SUM(Global_Sales) DESC;

SELECT SUM(Global_Sales), Publisher
FROM [PROJECT 1].[dbo].[vgsales]
GROUP BY Publisher
ORDER BY SUM(Global_Sales) DESC;


-- Maximum global sales per year

WITH MaxGlobalSalesPerYear (  Year, MaxGlobalSales)
AS 
(SELECT  Year, MAX(Global_Sales) AS MaxGlobalSales
FROM [PROJECT 1].[dbo].[vgsales]
GROUP BY Year)

SELECT  a.Year, b.MaxGlobalSales
FROM vgsales AS a
JOIN MaxGlobalSalesPerYear AS b
ON a.Year = b.Year
GROUP BY a.Year, b.MaxGlobalSales
