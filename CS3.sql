CREATE DATABASE CS3
USE CS3

SELECT * FROM Continent

SELECT * FROM Customers

SELECT * FROM [Transaction]

-- Aggregate func

--1 Display the count of customers in each region who has done the transaction in year 2020
  
select  cus.region_id,con.region_name, count(distinct cus.customer_id) as count
from [dbo].[Continent] con
    inner join [dbo].[Customers] cus
    on con.region_id = cus.region_id
    inner join [dbo].[Transaction] t
    on t.customer_id = cus.customer_id
where year(t.txn_date) = 2020
group by con.region_name, cus.region_id order by cus.region_id

-- or 

SELECT c.region_id, c.region_name, COUNT(DISTINCT t.customer_id) AS customer_count
FROM Continent c
    LEFT JOIN Customers cu ON c.region_id = cu.region_id
    LEFT JOIN [Transaction] t ON cu.customer_id = t.customer_id
WHERE YEAR(t.txn_date) = 2020
GROUP BY c.region_id, c.region_name
ORDER BY c.region_id;



--2 Display the maximum, minimum of transaction amount of each transaction type 
select txn_type, max(txn_amount) as max, min(txn_amount) as min from [dbo].[Transaction] group by txn_type

--  Joins

-- 3 Display customer id, region name and transaction amount where transaction type is deposit and transaction amount > 500

select cus.customer_id, con.region_name, t.txn_amount
from [dbo].[Continent] con
    inner join [dbo].[Customers] cus
    on con.region_id = cus.region_id
    inner join [dbo].[Transaction] t
    on t.customer_id = cus.customer_id
where t.txn_type = 'deposit' and t.txn_amount > 500

--4 Find duplicate records in a customer table.
SELECT customer_id, region_id, start_date, end_date, COUNT(*)
FROM customers
GROUP BY customer_id, region_id, start_date, end_date
HAVING COUNT(*) > 1;


--5 Display the detail of customer id, region name, transaction type and transaction amount for the minimum transaction amount in deposit

select cus.customer_id, con.region_name, t.txn_type
from [dbo].[Continent] con
    inner join [dbo].[Customers] cus
    on con.region_id = cus.region_id
    inner join [dbo].[Transaction] t
    on t.customer_id = cus.customer_id
WHERE txn_amount = (SELECT MIN(txn_amount)
FROM [dbo].[Transaction] )


--Stored Procedure

--6 Create a stored procedure to display details of customer and transaction table where transaction date is greater than Jun 2020
CREATE PROCEDURE GetCustomersTransactions (@startDate date)
AS
BEGIN
    SELECT c.customer_id, r.region_name, t.txn_date, t.txn_type, t.txn_amount
    FROM customers c
        INNER JOIN continent r ON c.region_id = r.region_id
        INNER JOIN [dbo].[Transaction] t ON c.customer_id = t.customer_id
    WHERE t.txn_date > @startDate
END

exec GetCustomersTransactions '2010-05-01'

--7 Create a stored procedure to insert a record in the region table
CREATE PROCEDURE insert_region
    (@region_id INT,
    @region_name VARCHAR(50))
AS
BEGIN
    INSERT INTO Continent
        (region_id, region_name)
    VALUES
        (@region_id, @region_name)
END

exec insert_region 6,'India'

select *
from Continent

--8 Create a stored procedure to display the details of transaction happened in specific day
CREATE PROCEDURE sp_display_transactions
    (@transactionDate DATE)
AS
BEGIN
    SELECT *
    FROM [dbo].[Transaction]
    WHERE txn_date = @transactionDate
END

exec sp_display_transactions '2020-01-01'


--User Defined Function

--9 Create a udf to add 10% of transaction amount in a table
CREATE FUNCTION add_10_percent (@amount decimal(10,2))
RETURNS decimal(10,2)
AS
BEGIN
    DECLARE @new_amount decimal(10,2)
    SET @new_amount = @amount + (@amount * 0.10)
    RETURN @new_amount
END

select *, dbo.add_10_percent(txn_amount) as updated_amount
from [dbo].[Transaction]

/* CREATE FUNCTION trnsaction_1 (@amount decimal(10,2))
RETURNS decimal(10,2)
AS
BEGIN
    RETURN  @amount * 1.10; 
END
*/


--10 Create a udf to find total of transaction amount for given transaction type
-- Assuming your database is Microsoft SQL Server

CREATE FUNCTION dbo.GetTotalAmountByType
(
    @transactionType NVARCHAR(255)
)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @totalAmount DECIMAL(10, 2);

    SELECT @totalAmount = SUM(txn_amount)
    FROM [dbo].[Transaction]
    WHERE txn_type = @transactionType;

    RETURN ISNULL(@totalAmount, 0);
END;


-- Example usage of the UDF
DECLARE @totalAmount DECIMAL(10, 2);
SET @totalAmount = dbo.GetTotalAmountByType('deposit');
PRINT 'Total amount for deposit transactions: ' + CONVERT(NVARCHAR(50), @totalAmount);


/*11 Create a table values function which comprises of the folowing columns customer_id,
region_id ,
txn_date ,
txn_type v,
txn_amount int which retrieve data from the respective table*/
CREATE FUNCTION dbo.GetCustomerTransactions
(
    @type VARCHAR(30)
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        c.customer_id,
        c.region_id,
        t.txn_date,
        t.txn_type,
        t.txn_amount
    FROM
        Customers c
    INNER JOIN
        [dbo].[Transaction] t ON c.customer_id = t.customer_id
    WHERE
        t.txn_type = @type
);


-- Example of calling the TVF
DECLARE @type VARCHAR(30) = 'deposit';

-- Use the TVF in a SELECT statement  -- ## issue 
SELECT * FROM dbo.GetCustomerTransactions(@type);



--Exception Handling

--12 Create a try catch block to print a region id and region name in a single column 
BEGIN TRY  
SELECT region_id + region_name
from Continent
END TRY  
BEGIN CATCH  
SELECT ERROR_STATE() AS ErrorState , ERROR_MESSAGE() ErrorMsg ;  
END CATCH;  
GO

--13 Create a try catch block to insert a value in continent table
BEGIN TRY
    
    INSERT INTO Continent
values(null, 'India')
    
END TRY
BEGIN CATCH
   
    PRINT 'Error: Insert failed.'
END CATCH

--Triggers 
ALTER DATABASE kunal_batch SET COMPATIBILITY_LEVEL = 130;
--14 Create a trigger to prevent deleting of a table in a database
CREATE TRIGGER tr_prevent_table_drop
ON DATABASE
FOR DROP_TABLE
AS
BEGIN
    RAISERROR ('Table drop is not allowed.', 16, 1)
    ROLLBACK;
END;

drop table Continent

--15 Create a trigger for auditing of data in a table
create table customer_audit
(
    id int identity(1,1),
    AuditData varchar(50)
)
drop table customer_audit
select *
from customer_audit
CREATE TRIGGER trg_audit 
ON customers
FOR INSERT
as begin
    Declare @id int
    select @id = customer_id
    from inserted
    insert into customer_audit
    values
        ('New customer with ID = ' + cast(@id as varchar(5)) + ' ' +'is added at')
end

insert into Customers
values(2003, 2, '2001-11-14', '2001-11-14')

drop trigger trg_audit 

select *
from customer_audit
select *
from Customers

--16 Create a trigger to prevent login of same user id in multiple page
select *
from sys.dm_exec_sessions
order by is_user_process desc
select is_user_process, original_login_name
from sys.dm_exec_sessions
order by is_user_process desc

create trigger trg_logon
on all server
for logon
as begin
    declare @LoginName varchar(50)
    set @LoginName = ORIGINAL_LOGIN()
    if(select count(*)
    from sys.dm_exec_sessions
    where
   is_user_process = 1 and original_login_name = @LoginName) > 3
   begin
        print 'Fourth connection attempt by ' +@loginName + 'Blocked'
        rollback;
    end
end

drop trigger trg_logon on all server


--Window Function

--17 Display top n customer on the basis of transaction type
SELECT *
FROM (
	SELECT *,

        DENSE_RANK () OVER ( 
			PARTITION BY txn_type
			ORDER BY txn_amount DESC
		) amount_rank
    FROM
        [dbo].[Transactions]
) t
WHERE amount_rank < 5;


--18 
BEGIN TRANSACTION
DECLARE @order_date DATE;
SET @order_date = (SELECT start_date
FROM Customers);

IF @order_date > GETDATE()
BEGIN
    ROLLBACK TRANSACTION;
    PRINT 'Transaction failed: Order date cannot be in the future';
END;
ELSE
BEGIN
    INSERT INTO Customers
        (start_date)
    SELECT start_date
    FROM Customers;

    COMMIT TRANSACTION;
END;






