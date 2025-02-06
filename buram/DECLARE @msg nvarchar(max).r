DECLARE		 @msg				nvarchar(max)
			,@year				nvarchar(2)
			,@month				nvarchar(2)
			,@p_code			nvarchar(50)
			,@p_branch_code			nvarchar(50)

	set @year = substring(cast(datepart(year, GETDATE()) as nvarchar), 3, 2) ;
	set @month = replace(str(cast(datepart(month, GETDATE()) as nvarchar), 2, 0), ' ', '0') ;

	declare @p_unique_code nvarchar(50) ;

	exec dbo.xsp_get_next_unique_code_for_table @p_unique_code = @p_code output
												,@p_branch_code = @p_branch_code
												,@p_sys_document_code = N''
												,@p_custom_prefix = 'FAUD'
												,@p_year = @year
												,@p_month = @month
												,@p_table_name = 'AUDIT_JOURNAL'
												,@p_run_number_length = 6
												,@p_delimiter = '.'
												,@p_run_number_only = N'0' ;