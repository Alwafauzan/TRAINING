begin transaction

--region eksekusi sp
exec dbo.xsp_master_trainee_result_transaction_materi_detail_update
 @p_id				= 16
,@p_value			= 0
,@p_bobot			= 100
,@p_criteria_code	= 'FIS1'
--					=
,@p_mod_date		= '2025-02-01'
,@p_mod_by			= 'dasdsa'
,@p_mod_ip_address	= 'dfsdf'

exec dbo.xsp_master_trainee_result_transaction_materi_detail_update
 @p_id				= 16
,@p_value			= 0
,@p_bobot			= 100
,@p_criteria_code	= 'FIS1'
--					=
,@p_mod_date		= '2025-02-01'
,@p_mod_by			= 'dasdsa'
,@p_mod_ip_address	= 'dfsdf'
--endregion

--region target sp yang dieksekusi
select * from MASTER_TRAINEE_RESULT_TRANSACTION_MATERI_detail where id = 41

select *
from MASTER_TRAINEE_RESULT_TRANSACTION_MATERI
where id = 16

select * from MASTER_TRAINEE_RESULT_TRANSACTION
where code = 'MTRT.2502.000004'
--endregion

rollback transaction

