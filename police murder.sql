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

SELECT KBS.State,PB.[Victim's race],PB.[Armed/Unarmed Status],PB.[Link to news article or photo of official document]
FROM [Police Voilence]..['2013-2021 Killings by State$'] KBS
JOIN [Police Voilence]..['2013-2021 Police Killings$'] PB
	ON PB.State = KBS.[State Abbreviation]
	WHERE [Victim's race]='Black'
	Order By State

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

SELECT [Victim's race],[Armed/Unarmed Status],State
FROM [Police Voilence]..['2013-2021 Police Killings$']
WHERE [Victim's race]='Black' and [Armed/Unarmed Status]='Unarmed/Did Not Have Actual Weapon' and State = State

SELECT State,[Total Population of Census Tract 2019 ACS 5-Year Estimates],COUNT(*) AS people_killed
FROM [Police Voilence]..['2013-2021 Police Killings$']
WHERE State = State
GROUP BY State
ORDER BY people_killed desc;

SELECT PD,[All People Killed by Police (1/1/2013-12/31/2021)],[Black People Killed by Police (1/1/2013-12/31/2021)],[White People Killed by Police (1/1/2013-12/31/2021)],[Asian People Killed by Police (1/1/2013-12/31/2021)]
FROM [Police Voilence]..['2013-2021 Killings by PD$']
WHERE State is not null and ORI is not null
ORDER BY [Asian People Killed by Police (1/1/2013-12/31/2021)] desc
	
SELECT State,[Date of Incident (month/day/year)],[Victim's age],[Victim's race],[Victim's gender],[Link to news article or photo of official document],[Cause of death],[Official disposition of death (justified or other)],[Armed/Unarmed Status] FROM [Police Voilence]..['2013-2021 Police Killings$']
WHERE [Victim's name] is not null and [Victim's race]= 'Black' and [Armed/Unarmed Status]= 'Unarmed/Did Not Have Actual Weapon' 
ORDER BY [Victim's age] asc

SELECT State,[Victim's name],[Victim's age],[Victim's race],[Victim's gender],[Link to news article or photo of official document],[Cause of death],[Official disposition of death (justified or other)],[Armed/Unarmed Status] FROM [Police Voilence]..['2013-2021 Police Killings$']
WHERE [Victim's name] is not null and [Victim's race]= 'Black'
ORDER BY [Victim's age] asc

SELECT State,[Date of Incident (month/day/year)],[Victim's age],[Victim's race],[Victim's gender],[Link to news article or photo of official document],[Cause of death],[Official disposition of death (justified or other)],[Armed/Unarmed Status],[Killed by Police 2013-21]
FROM [Police Voilence]..['2013-2021 Police Killings$']
WHERE [Victim's name] is not null and [Victim's race]= 'Black'
ORDER BY [Victim's age] asc

SELECT [Date of Incident (month/day/year)],State,[Victim's name],[Victim's age],[Victim's race],[Victim's gender],[Link to news article or photo of official document],[Cause of death],[Official disposition of death (justified or other)],[Armed/Unarmed Status] FROM [Police Voilence]..['2013-2021 Police Killings$']
WHERE [Victim's name] is not null and [Victim's race]= 'Black' and [Cause of death]='Beaten'
ORDER BY [Victim's age] asc

SELECT [Date of Incident (month/day/year)],State,[Victim's name],[Victim's age],[Victim's race],[Victim's gender],[Link to news article or photo of official document],[Cause of death],[Official disposition of death (justified or other)],[Armed/Unarmed Status] FROM [Police Voilence]..['2013-2021 Police Killings$']
WHERE [Victim's name] is not null and [Cause of death]='Beaten'
ORDER BY [Victim's age] asc

	

	
