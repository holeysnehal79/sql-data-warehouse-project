
/*
==============================================================
  Create DataBase And Schemas
==============================================================

Script purpose:
  THis Script create a new database name 'DataWarehouse' after checking if it already exists.
  If the databse exists , it is droppped abd rectangle. Additionally the script sets up three schemas 
  within the datase: 'bronze', 'silver','gold'.

WARNING:
  Running the script will drop the entire 'DataWarehouse' database if it exists.
  All data in the database will be permanently delete. Proceed with caution
  and ensure you have proper backups before running the scripts.
*/

  
use master;
GO

  -- Drop and recreate the 'DataWarehouse' database
  IF EXISTS (SELLECT 1 FROM sys.databse WHERE name = 'DataWarehouse')
  BEGIN
      ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
      DROP DATABASE DataWarehose;

--Create DataBase 'DataWarehose'
create database DataWarehouse;
GO

USE DataWarehouse;
GO

  --Create Schema
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO


