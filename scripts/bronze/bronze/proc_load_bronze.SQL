
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN 
	BEGIN TRY
	DECLARE @start_time DATETIME, @end_time DATETIME;
	PRINT '========================================';
	PRINT 'loading Bronze Layer';
	PRINT '========================================';
	
	SET @start_time = GETDATE()
	PRINT '-----------------------------------------';
	PRINT 'Loading CRM Tables';
	PRINT '-----------------------------------------';

	PRINT '>>Truncating table: bronze.crm_cust_info';
	truncate table  bronze.crm_cust_info
	PRINT'>>Inserting data into:crmd_prd_info';
	BULK INSERT bronze.crm_cust_info
	FROM 'D:\DataWareHouse\datasets\source-crm\cust_info.csv'
	WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	tablock
	);
	SET @end_time = GETDATE()
	PRINT '>>Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
	PRINT '>>------------------------------------------------------'


	SET @start_time = GETDATE()
	PRINT '>>Truncating table: bronze.crm_PRD_info';
	TRUNCATE TABLE bronze.crm_prd_info;
	BULK INSERT bronze.crm_prd_info
	from 'D:\DataWareHouse\datasets\source-crm\prd_info.csv'
	with(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE()
	PRINT '>>Load Duration: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+ ' seconds';
	PRINT '>>------------------------------------------------------'


	SET @start_time = GETDATE();
	print'>>Turncation table: bronze.crm_sales_details';
	TRUNCATE TABLE bronze.crm_sales_details;
	print '>> Inserting data into: bronze.crm_sales_details'
	BULK INSERT bronze.crm_sales_details
	from 'D:\DataWareHouse\datasets\source-crm\sales_details.csv'
	WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
	);
	set @end_time = GETDATE()
	PRINT '>>Load Duration: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+ ' seconds';
	PRINT '>>------------------------------------------------------'


	PRINT '-----------------------------------------';
	PRINT 'Loading ERP Tables';
	PRINT '-----------------------------------------';

	set @start_time = GETDATE()
	print'>>Turncation table: bronze.erp_loc_a101';
	TRUNCATE TABLE bronze.erp_loc_a101;
	BULK INSERT bronze.erp_loc_a101
	FROM 'D:\DataWareHouse\datasets\scource-pd\loc_a101.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	set @end_time = GETDATE()
	PRINT '>>Load Duration: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+ ' seconds';
	PRINT '>>---------------------------------------------------------------------------------------'
	set @start_time = GETDATE()
	print'>>Turncation table: bronze.erp_cust_az12';
	TRUNCATE TABLE bronze.erp_cust_az12;
	BULK INSERT bronze.erp_cust_az12
	FROM 'D:\DataWareHouse\datasets\scource-pd\cust_az12.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	set @end_time = GETDATE()
	PRINT '>>Load Duration: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+ ' seconds';
	PRINT '>>---------------------------------------------------------------------------------------'
	
	set @start_time = GETDATE()
	print'>>Turncation table: bronze.erp_px_cat_g1v2';
	TRUNCATE TABLE bronze.erp_px_cat_g1v2;
	BULK INSERT bronze.erp_px_cat_g1v2
	FROM 'D:\DataWareHouse\datasets\scource-pd\px_cat_g1v2.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	set @end_time = GETDATE()
	PRINT '>>Load Duration: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+ ' seconds';
	PRINT '>>---------------------------------------------------------------------------------------';
END TRY

BEGIN CATCH

		PRINT '==========================================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
		PRINT 'ERROR MESSAGE' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'ERROR MESSAGE' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '============================================';

END CATCH
END
