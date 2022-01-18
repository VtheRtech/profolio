SELECT * FROM [Police Voilence]..['2013-2021 Killings by State$']
WHERE [# Black people killed] is not null
ORDER BY 3,4

SELECT * FROM [Police Voilence]..['2013-2021 Police Killings$']
WHERE [Victim's name] is not null 
ORDER BY 3,4

SELECT * FROM [Police Voilence]..['2013-2021 Killings by PD$']
WHERE State is not null
ORDER BY [All People Killed by Police (1/1/2013-12/31/2021)] desc


SELECT * FROM [Police Voilence]..['Police Killings of Black Men$']
WHERE city is not null 
Order By [Black Men Killed by Police (1/1/2013-12/31/2021)]desc

SELECT State,[State Abbreviation],[Total Population],[Black Population],[# Black people killed] AS "Black People Killed between 2013 and 2021 by cops"
FROM [Police Voilence]..['2013-2021 Killings by State$']
WHERE [# Black people killed] IS NOT NULL 
ORDER BY [# Black people killed] desc

SELECT KBS.State,PB.[Victim's race],PB.[Armed/Unarmed Status]
FROM [Police Voilence]..['2013-2021 Killings by State$'] KBS
JOIN [Police Voilence]..['2013-2021 Police Killings$'] PB
	ON PB.State = KBS.[State Abbreviation]

CREATE VIEW armed_info AS
SELECT KBS.State,PB.[Victim's race],PB.[Armed/Unarmed Status],PB.[Link to news article or photo of official document],
FROM [Police Voilence]..['2013-2021 Killings by State$'] KBS
JOIN [Police Voilence]..['2013-2021 Police Killings$'] PB
	ON PB.State = KBS.[State Abbreviation]
	GROUP BY KBS.State,PB.[Victim's race],PB.[Armed/Unarmed Status]

SELECT [Victim's race],[Armed/Unarmed Status],State,COUNT(*) AS total_unarmed_black_people_killed
FROM [Police Voilence]..['2013-2021 Police Killings$']
WHERE [Victim's race]='Black' and [Armed/Unarmed Status]='Unarmed/Did Not Have Actual Weapon' and State = State
GROUP BY [Victim's race],[Armed/Unarmed Status],State
ORDER BY total_unarmed_black_people_killed desc;



	

	

	