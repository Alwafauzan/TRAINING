SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[xsp_master_materi_criteria_detail_insert]
(
	 @p_code							Nvarchar (50)
	,@p_materi_code					 	Nvarchar (50)
	,@p_bobot 							Decimal (9,6)
	,@p_criteria_name 					Nvarchar (250)
	--
	,@p_cre_date						datetime
	,@p_cre_by							nvarchar(15)
	,@p_cre_ip_address					nvarchar(15)
	,@p_mod_date						datetime
	,@p_mod_by							nvarchar(15)
	,@p_mod_ip_address					nvarchar(15)
)
as
begin 
	declare @msg nvarchar(max) ;
	begin try
		if exists (select 1 from dbo.master_materi_criteria_detail where code = @p_code)
		begin
			update 	dbo.master_materi_criteria_detail
			set 	materi_code	= @p_materi_code
					,bobot			= @p_bobot
					,criteria_name	= @p_criteria_name
					,mod_date		= @p_mod_date
					,mod_by			= @p_mod_by
					,mod_ip_address = @p_mod_ip_address
			where 	code			= @p_code;
		end
		else
		begin
			insert into dbo.master_materi_criteria_detail
				(
					 code							
					,materi_code					 	
					,bobot 							
					,criteria_name 					
					--
					,cre_date		
					,cre_by			
					,cre_ip_address	
					,mod_date		
					,mod_by			
					,mod_ip_address
				)
			values
				(   
					 @p_code							
					,@p_materi_code					 	
					,@p_bobot 							
					,@p_criteria_name 					
					--
					,@p_cre_date					
					,@p_cre_by						
					,@p_cre_ip_address				
					,@p_mod_date					
					,@p_mod_by						
					,@p_mod_ip_address				
				);
		end
	end try
	begin catch
		declare @error int ;

		set @error = @@error ;

		if (@error = 2627)
		begin
			set @msg = dbo.xfn_get_msg_err_code_already_exist() ;
		end ;

		if (len(@msg) <> 0)
		begin
			set @msg = N'V' + N';' + @msg ;
		end ;
		else if (left(error_message(), 2) = 'V;')
		begin
			set @msg = error_message() ;
		end ;
		else
		begin
			set @msg = N'E;' + dbo.xfn_get_msg_err_generic() + N';' + error_message() ;
		end ;

		raiserror(@msg, 16, -1) ;

		return ;
	end catch ;
end ;

GO
