BEGIN TRANSACTION 

EXEC dbo.xsp_rpt_adh_collateral @p_user_id = N'fauzan',                      -- nvarchar(50)
                                @p_branch_code = N'1000',                  -- nvarchar(50)
                                @p_as_of_date = '2025-02-10 07:49:09', -- datetime
                                @p_cre_by = N'fauzan',                       -- nvarchar(50)
                                @p_cre_date = '2025-02-10 07:49:09',   -- datetime
                                @p_cre_ip_address = N'127.0.0.1'                -- nvarchar(15)

SELECT rad.*
FROM (
    SELECT rad.*,
           ROW_NUMBER() OVER (PARTITION BY rad.DOC_CODE ORDER BY rad.TRX_DATE DESC) AS row_num
    FROM dbo.RPT_ADH_COLLATERAL_DETAIL rad
    WHERE rad.USER_ID = 'fauzan'
) rad
WHERE rad.row_num = 1
ROLLBACK TRANSACTION

insert RPT_ADH_COLLATERAL_DETAIL dengan kondisi kalau doc_code sama, ambil semua data dengan trx_date terbaru
data dengan trx_date kecil dari trx_date terbaru maka tidak diinputkan



insert RPT_ADH_COLLATERAL_DETAIL dengan kondisi kalau doc_code sama, ambil semua data dengan trx_date terbaru
data dengan trx_date kecil dari trx_date terbaru maka tidak ditampilkan
data doc_code dan trx_date hanya ada pada RPT_ADH_COLLATERAL_DETAIL
lupakan kalau kita memiliki tabel RPT_ADH_COLLATERAL