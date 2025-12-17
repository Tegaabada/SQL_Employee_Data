USE [SQL DB]
GO

SELECT [EmpID]
      ,[EmpFname]
      ,[EmpLname]
      ,[Department]
      ,[Project]
      ,[Address]
      ,[DOB]
      ,[Gender]
  FROM [dbo].['Employee Info$']

GO


DELETE FROM [dbo].['Employee Info$']
WHERE GENDER IS NULL;

ALTER TABLE [dbo].['Employee Info$']
alter column DOB DATE;

-- Q1: Write a query to fetch the EmpFname from the EmployeeInfo table in the upper case and use the ALIAS name as EmpName.

SELECT UPPER(EmpFname) AS [EmpName]
FROM [Employee Info];

-- Q2: Write a query to fetch the number of employees working in the department ‘HR’.


SELECT COUNT (*) AS [Employee Count]
from [dbo].[Employee Info]
WHERE [Department] = 'HR';



-- Q3: Write a query to get the current date.

SELECT cast( GETDATE() AS date) AS [Current Date];

-- Q4: Write a query to retrieve the first four characters of  EmpLname from the EmployeeInfo table.

SELECT LEFT (EmpLname, 4) AS FirstFourChars
FROM [Employee Info];

-- Q5: Write a query to fetch only the place name(string before brackets) from the Address column of EmployeeInfo table.

SELECT  LEFT(Address, CHARINDEX('(', Address) -1) AS [Place Name]
FROM [Employee Info];

-- Q6: Write a query to create a new table that consists of data and structure copied from the other table.

SELECT *
INTO [Newtable]
from [dbo].[Employee Info];

-- This created a new table joining both tables into it using join via emplyee ID

SELECT ei.[EmpID], EI.[EmpFname],EI.[EmpLname],EI.[Department],
EI.[Project],EI.[DOB],
EP.[EmpPosition],EP.[DateOfJoining],EP.[Salary]
INTO [New Emplyee Table]
FROM [Employee Info] ei
JOIN [dbo].[Employee position2] ep ON ei.[EmpID] = ep.[EmpID];

-- Q7: Write q query to find all the employees whose salary is between 50000 to 100000.

SELECT EP.[EmpID],
EI.[EmpFname] + ' ' + EI.[EmpLname] AS FULLNAME
FROM [dbo].[Employee position2] EP
JOIN [dbo].[Employee Info] EI ON EP.[EmpID] = EI.[EmpID]
WHERE EP.[Salary] BETWEEN 50000 AND 100000;

-- Q8: Write a query to find the names of employees that begin with ‘S’

SELECT [EmpFname]
FROM [dbo].[Employee Info]
WHERE [EmpFname] LIKE 'S%';

-- Q9: Write a query to fetch top N records.
-- TOP 5
SELECT TOP (5) *
FROM [dbo].[Employee position2]
ORDER BY [Salary] DESC;

--TOP 10
SELECT TOP 10 PERCENT *
FROM [dbo].[Employee position2]
ORDER BY [Salary] DESC;
-- Q10: Write a query to retrieve the EmpFname and EmpLname in a single column as “FullName”. The first name and the last name must be separated with space.

SELECT [EmpFname] + ' ' + [EmpLname] AS FULLNAME
FROM [dbo].[Employee Info];

-- Q11: Write a query find number of employees whose DOB is between 02/05/1970 to 31/12/1995 and are grouped according to gender

SELECT COUNT ([EmpID])
FROM [dbo].[Employee Info]
WHERE [DOB] BETWEEN '1970/05/02' AND '1995/12/31';

-- Q12: Write a query to fetch all the records from the EmployeeInfo table ordered by EmpLname in descending order and Department in the ascending order.

SELECT *
FROM [dbo].[Employee Info]
ORDER BY [EmpLname];

-- Q13: Write a query to fetch details of employees whose EmpLname ends with an alphabet ‘A’ and contains five alphabets.

SELECT *
FROM [dbo].[Employee Info]
WHERE [EmpLname] LIKE '%A'
AND LEN([EmpLname])= 5;

-- Q14: Write a query to fetch details of all employees excluding the employees with first names, “Sanjay” and “Sonia” from the EmployeeInfo table.

SELECT * FROM [dbo].[Employee Info]
WHERE [EmpFname] NOT IN ('Sanjay', 'Sonia')


SELECT * FROM [dbo].[Employee Info]
WHERE [EmpFname] != 'Sanjay' AND [EmpFname] != 'Sonia'

-- Q15: Write a query to fetch details of employees with the address as “DELHI(DEL)”

SELECT * FROM [dbo].[Employee Info]
WHERE [Address] = 'DELHI(DEL)';

-- Q16: Write a query to fetch all employees who also hold the managerial position.


SELECT * FROM [dbo].[Employee position2]
WHERE [EmpPosition] = 'Manager';

--This query used the Join function

SELECT 
ei.[EmpFname] + ' ' + ei.[EmpLname] AS FULLNAME, ep.*
FROM [dbo].[Employee position2] ep
JOIN [dbo].[Employee Info] EI ON EP.[EmpID] = EI.[EmpID]
WHERE [EmpPosition] = 'Manager';

-- Q17: Write a query to fetch the department-wise count of employees sorted by department’s count in ascending order

SELECT [Department],COUNT([EmpID]) AS EmployeeCount
from [dbo].[Employee Info]
GROUP BY Department
ORDER BY EmployeeCount ASC;

-- Q18: Write a query to fecth Male employees in HR department


SELECT * FROM [dbo].[Employee Info]
WHERE [Gender] = 'M' AND [Department] = 'HR';

-- Q19: Write a SQL query to retrieve employee details from EmployeeInfo table who have a date of joining in the EmployeePosition table
-- Option 1

SELECT * FROM [dbo].[Employee Info] EI
WHERE EXISTS (
    SELECT 1
    FROM [dbo].[Employee position2] EP
    WHERE EP.EmpID = EI.EmpID
      AND EP.DateOfJoining IS NOT NULL)

-- Option 2:

SELECT EI.*
FROM [dbo].[Employee Info] EI
LEFT JOIN [dbo].[Employee position2] EP ON EI.EmpID = EP.EmpID
WHERE EP.DateOfJoining IS NOT NULL;


-- Q20: Write a query to retrieve two minimum and maximum salaries from the EmployeePosition table

SELECT Salary
FROM (SELECT TOP 2 Salary
    FROM [dbo].[Employee position2]
    ORDER BY Salary ASC) AS MinSalaries

UNION

SELECT Salary
FROM (SELECT TOP 2 Salary
    FROM [dbo].[Employee position2]
    ORDER BY Salary DESC) AS MaxSalaries;

-- End of Queries


