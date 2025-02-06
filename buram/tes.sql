CREATE FUNCTION [dbo].[fn_Generate_Auto_Code]
(
	@p_table_name nvarchar(50),
	@p_branch_code nvarchar(50),
	@p_custom_prefix nvarchar(50),
	@p_year nvarchar(2),
	@p_month nvarchar(2),
	@p_run_number_length int,
	@p_delimiter nvarchar(1)
)
RETURNS nvarchar(50)
AS
BEGIN
	declare @p_unique_code nvarchar(50) ;
	declare @p_run_number nvarchar(50) ;
	declare @p_sys_document_code nvarchar(50) ;
	declare @p_run_number_only nvarchar(1) ;

	set @p_run_number_only = N'0' ;

	exec dbo.xsp_get_next_unique_code_for_table @p_unique_code = @p_unique_code output
												,@p_branch_code = @p_branch_code
												,@p_sys_document_code = @p_sys_document_code
												,@p_custom_prefix = @p_custom_prefix
												,@p_year = @p_year
												,@p_month = @p_month
												,@p_table_name = @p_table_name
												,@p_run_number_length = @p_run_number_length
												,@p_delimiter = @p_delimiter
												,@p_run_number_only = @p_run_number_only ;

	return @p_unique_code ;
END
GO


declare @code nvarchar(50) = 'A002'
select sum(quantity) as @code from borrow_transaction_detail where book_code = @code


      p_is_condition: this.model.print_option,
      // p_borrow_date: this.datePipe.transform(this.model.borrow_date, 'yyyy-MM-dd'),
      p_borrow_date: this.model.borrow_date,