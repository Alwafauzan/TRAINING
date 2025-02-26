SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[xsp_master_insurance_update]
(
	@p_code							 nvarchar(50)
	,@p_insurance_no				 nvarchar(50)
	,@p_insurance_name				 nvarchar(250)
	,@p_contact_person_name			 nvarchar(250)
	,@p_contact_person_area_phone_no nvarchar(4)
	,@p_contact_person_phone_no		 nvarchar(15)
	,@p_insurance_type				 nvarchar(10)  
	,@p_tax_file_type				 nvarchar(10) 
	,@p_tax_file_no					 nvarchar(50)  = NULL
	,@p_tax_file_name				 nvarchar(250) = NULL
	,@p_tax_file_address			 nvarchar(250) = NULL
	,@p_insurance_business_unit		 nvarchar(12)
	,@p_area_phone_no				 nvarchar(4)
	,@p_phone_no					 nvarchar(25)
	,@p_area_fax_no					 nvarchar(4)
	,@p_fax_no						 nvarchar(25)
	,@p_email						 nvarchar(100) = null
	,@p_website						 nvarchar(100) = null
	,@p_is_validate					 nvarchar(1)
	--
	,@p_mod_date					 datetime
	,@p_mod_by						 nvarchar(15)
	,@p_mod_ip_address				 nvarchar(15)
)
as
begin
	declare @msg nvarchar(max) ;
	if @p_is_validate = 'T'
			set @p_is_validate = '1'
		else
			set @p_is_validate = '0'
	begin try
		update	master_insurance
		set		insurance_no					= @p_insurance_no
				,insurance_name					= UPPER(@p_insurance_name)
				,contact_person_name			= UPPER(@p_contact_person_name)
				,contact_person_area_phone_no	= @p_contact_person_area_phone_no
				,contact_person_phone_no		= @p_contact_person_phone_no
				,insurance_type					= @p_insurance_type
				,tax_file_type					= @p_tax_file_type
				,tax_file_no					= @p_tax_file_no
				,tax_file_name					= UPPER(@p_tax_file_name)
				,tax_file_address				= @p_tax_file_address
				,insurance_business_unit		= @p_insurance_business_unit
				,area_phone_no					= @p_area_phone_no
				,phone_no						= @p_phone_no
				,area_fax_no					= @p_area_fax_no
				,fax_no							= @p_fax_no
				,email							= lower(@p_email)
				,website						= lower(@p_website)
				,is_validate					= @p_is_validate
				--
				,mod_date						= @p_mod_date
				,mod_by							= @p_mod_by
				,mod_ip_address					= @p_mod_ip_address
		where	code							= @p_code ;
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
			set @msg = 'V' + ';' + @msg ;
		end ;
		else
		begin
			if (error_message() like '%V;%' or error_message() like '%E;%')
			begin
				set @msg = error_message() ;
			end
			else 
			begin
				set @msg = 'E;' + dbo.xfn_get_msg_err_generic() + ';' + error_message() ;
			end
		end ;

		raiserror(@msg, 16, -1) ;

		return ;
	end catch ;	
end ;




GO
