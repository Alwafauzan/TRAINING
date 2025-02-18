BEGIN TRANSACTION

DECLARE @APPLICATION_EXTERNAL_NO VARCHAR(50) = '0003747/4/10/01/2025'

--region target sp yang dieksekusi BEFORE
SELECT  CREDIT_TERM,MOD_DATE,MOD_BY,MOD_IP_ADDRESS
FROM    APPLICATION_MAIN
WHERE   APPLICATION_EXTERNAL_NO                 = @APPLICATION_EXTERNAL_NO;
--endregion

-- region eksekusi sp
UPDATE  application_main
SET     CREDIT_TERM                             = 60
        --
        ,mod_date                               = GETDATE()
        ,mod_by                                 = 'MTN_FAUZAN'
        ,mod_ip_address                         = 'MYFORM-524188'
WHERE   APPLICATION_EXTERNAL_NO                 = @APPLICATION_EXTERNAL_NO;
-- end region eksekusi sp

--region target sp yang dieksekusi AFTER
SELECT  CREDIT_TERM,MOD_DATE,MOD_BY,MOD_IP_ADDRESS
FROM    APPLICATION_MAIN
WHERE   APPLICATION_EXTERNAL_NO                 = @APPLICATION_EXTERNAL_NO;
--endregion


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
'MTN MyForm 524188'
,'Revisi TOP - PT. VALVOLINE LUBRICANTS AND CHEMICALS INDONESIA aplikasi no. 0003747/4/10/01/2025'
,'APPLICATION_MAIN'
,'0003747/4/10/01/2025'
,null
,null
,GETDATE()
,'fauzan'
)
-- add more rows here

ROLLBACK TRANSACTION;




--------------------------------------------------------------------------------------------------

