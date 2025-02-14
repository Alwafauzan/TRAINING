DECLARE @asset_no CURSOR;
SET @asset_no = CURSOR FOR
SELECT asset_no FROM dbo.AGREEMENT_ASSET WHERE FA_REFF_NO_01 IN ('L8231NF','B9537PXA','L8063NF','L8064NF')

OPEN @asset_no
DECLARE @asset_no_var VARCHAR(50)
FETCH NEXT FROM @asset_no INTO @asset_no_var

WHILE @@FETCH_STATUS = 0
BEGIN
  -- Insert rows into table 'TableName'
  INSERT INTO MTN_DATA_DSF_LOG
  ( -- columns to insert data into
   MAINTENANCE_NAME
   ,REMARK
   ,TABEL_UTAMA
   ,REFF_1
   ,REFF_2
   ,REFF_3
   ,CRE_DATE
   ,CRE_BY
  )
  VALUES
  ( -- first row: values for the columns in the list above
  'MTN MyForm 522791'
  ,'Revisi billing date untuk kontrak 0002983/4/38/10/2024'
  ,'APPLICATION_MAIN'
  ,@asset_no_var
  ,null
  ,null
  ,GETDATE()
  ,'fauzan'
  );

  FETCH NEXT FROM @asset_no INTO @asset_no_var
END

CLOSE @asset_no
DEALLOCATE @asset_no


SELECT *
FROM MTN_DATA_DSF_LOG;