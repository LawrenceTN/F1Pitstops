USE pitstops2021_2022;

# This query shows each team and their respective average pitstop times with outliers in the 2021 and 2022 years.
# I then added a column that shows the percenttage and actual difference. 

SELECT 
    fastestpits2022.Team,
    ROUND(AVG(fastestpits2021.Time), 2) AS 'Average Time with outliers (2021)',
    ROUND(AVG(fastestpits2022.Time), 2) AS 'Average Time with outliers (2022)',
    ROUND(ROUND(AVG(fastestpits2022.Time), 2) - ROUND(AVG(fastestpits2021.Time), 2),
            2) AS 'Difference',
	ROUND(ROUND(ROUND(AVG(fastestpits2022.Time), 2) - ROUND(AVG(fastestpits2021.Time), 2),
            2)/ROUND(AVG(fastestpits2021.Time), 2)*100 ,2)  AS 'Percent Difference'
FROM
    fastestpits2021
        INNER JOIN
    fastestpits2022 ON fastestpits2021.Team = fastestpits2022.Team
GROUP BY Team
ORDER BY Difference;

# This query shows each team and their respective average pitstop times with outliers in the 2021 and 2022 years WITHOUT outliers.
# An outlier is a value that lies outside most of the other values in a set of data and for this dataset, I have decided that 5.00+ is an outlier.
# I then added a column that shows the percenttage and actual difference. 

SELECT 
    fastestpits2022.Team,
    ROUND(AVG(fastestpits2021.Time), 2) AS 'Average Time without outliers (2021)',
    ROUND(AVG(fastestpits2022.Time), 2) AS 'Average Time without outliers (2022)',
    ROUND(ROUND(AVG(fastestpits2022.Time), 2) - ROUND(AVG(fastestpits2021.Time), 2),
            2) AS 'Difference',
	ROUND(ROUND(ROUND(AVG(fastestpits2022.Time), 2) - ROUND(AVG(fastestpits2021.Time), 2),
            2)/ROUND(AVG(fastestpits2021.Time), 2)*100 ,2)  AS 'Percent Difference'
FROM
    fastestpits2021
        INNER JOIN
    fastestpits2022 ON fastestpits2021.Team = fastestpits2022.Team
WHERE
    fastestpits2021.Time < 5.00
        AND fastestpits2022.Time < 5.00
GROUP BY Team
ORDER BY Difference;

# This set shows each 2021 Driver and their average pit times and the number of pit stops. Outliers are included.

SELECT 
    Driver AS 'Driver (2021)',
    ROUND(AVG(Time), 2) AS 'Average Pit Time',
    COUNT(Driver) AS 'Number of Pits'
FROM
    fastestpits2021
WHERE
    Driver = Driver
GROUP BY Driver;

# This set shows each 2022 Driver and their average pit times and the number of pit stops. Outliers are included.

SELECT 
    Driver AS 'Driver (2022)', 
    ROUND(AVG(Time), 2) AS 'Average Pit Time',
    COUNT(Driver) AS 'Number of Pits'
FROM
    fastestpits2022
WHERE
    Driver = Driver
GROUP BY Driver;

# Shows which driver has the most total points (Point distribution explained in README) in the 2021 season.

SELECT 
    Team AS 'Team (2021)', Driver, SUM(Points) AS 'Total Points'
FROM
    pitstops2021_2022.fastestpits2021
GROUP BY Driver
ORDER BY SUM(Points) DESC;

# Shows which driver has the most total points (Point distribution explained in README) in the 2022 season.

SELECT 
    Team AS 'Team (2022)', Driver, SUM(Points) AS 'Total Points'
FROM
    pitstops2021_2022.fastestpits2022
GROUP BY Driver
ORDER BY SUM(Points) DESC;
