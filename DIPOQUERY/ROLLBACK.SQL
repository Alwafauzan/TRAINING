BEGIN TRANSACTION 

EXEC dbo.xsp_rpt_adh_collateral_backup @p_user_id = N'fauzan',                      -- nvarchar(50)
                                @p_branch_code = N'1000',                  -- nvarchar(50)
                                @p_as_of_date = '2025-02-10 07:49:09', -- datetime
                                @p_cre_by = N'fauzan',                       -- nvarchar(50)
                                @p_cre_date = '2025-02-10 07:49:09',   -- datetime
                                @p_cre_ip_address = N'127.0.0.1'                -- nvarchar(15)

SELECT * FROM dbo.RPT_ADH_COLLATERAL where USER_ID = 'fauzan'
SELECT * FROM dbo.RPT_ADH_COLLATERAL_DETAIL where USER_ID = 'fauzan'


ROLLBACK TRANSACTION



BEGIN TRANSACTION 

EXEC dbo.xsp_rpt_adh_collateral @p_user_id = N'fauzan',                      -- nvarchar(50)
                                @p_branch_code = N'1000',                  -- nvarchar(50)
                                @p_as_of_date = '2025-02-10 07:49:09', -- datetime
                                @p_cre_by = N'fauzan',                       -- nvarchar(50)
                                @p_cre_date = '2025-02-10 07:49:09',   -- datetime
                                @p_cre_ip_address = N'127.0.0.1'                -- nvarchar(15)

SELECT * FROM dbo.RPT_ADH_COLLATERAL where USER_ID = 'fauzan'

SELECT rad.*
FROM (
    SELECT rad.*,
			RANK() OVER (PARTITION BY rad.DOC_CODE ORDER BY rad.TRX_DATE DESC) AS row_num
           --ROW_NUMBER() OVER (PARTITION BY rad.DOC_CODE ORDER BY rad.TRX_DATE DESC) AS row_num
    FROM dbo.RPT_ADH_COLLATERAL_DETAIL rad
    WHERE rad.USER_ID = 'fauzan'
) rad
--WHERE rad.row_num = 1
ROLLBACK TRANSACTION







