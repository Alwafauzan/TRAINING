SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[xsp_master_vendor_update]
(	
	@p_code						nvarchar(50)
	,@p_company_code			nvarchar(50)
	,@p_name					nvarchar(200)
	,@p_address					nvarchar(4000)
	,@p_city_code				nvarchar(50)
	,@p_province_code			nvarchar(50)
	,@p_zipcode					nvarchar(10) = ''
	,@p_phone					nvarchar(200) = ''
	,@p_fax						nvarchar(30) = ''
	,@p_service_type_code		nvarchar(50) = ''
	,@p_business_type_code		nvarchar(50) = ''
	,@p_vendor_type				nvarchar(50) = ''
	,@p_id_type					nvarchar(50) = ''
	,@p_id_no					nvarchar(100) = ''
	,@p_tax_calculation_method	nvarchar(50) = ''
	,@p_pkp_no					nvarchar(100) = ''
	,@p_id_vendor				nvarchar(50) = ''
	,@p_owner_name				nvarchar(100) = ''
	,@p_owner_phone				nvarchar(25) = ''
	,@p_contact_name			nvarchar(100) = ''
	,@p_contact_position		nvarchar(100) = ''
	,@p_contact_phone			nvarchar(25) = ''
	,@p_website_address			nvarchar(50) = '' 
	,@p_email					nvarchar(50) = ''
	,@p_npwp					nvarchar(20) = ''
	,@p_siup_no					nvarchar(25) = ''
	,@p_sku_no					nvarchar(25) = ''
	,@p_tdp_no					nvarchar(25) = ''
	,@p_remark					nvarchar(4000)
	,@p_is_active				nvarchar(1)
	,@p_npwp_name				NVARCHAR(50) = ''
	,@p_npwp_address			NVARCHAR(4000) = ''
		--
	,@p_mod_date				datetime
	,@p_mod_by					nvarchar(15)
	,@p_mod_ip_address			nvarchar(15)
)
as
begin
	declare @msg nvarchar(max) ;

	if @p_is_active = 'T'
		set @p_is_active = '1'
	else
		set @p_is_active = '0'

	begin try
	
	if (len(@p_npwp) <> 16)
	begin 
		set @msg = 'NPWP NO Must be 16 Digits'
		raiserror (@msg,16,-1);
	end
    
	 update master_vendor
		set
			company_code			= @p_company_code
			,name					= @p_name
			,address				= @p_address
			,city_code				= @p_city_code
			,province_code			= @p_province_code
			,zipcode				= @p_zipcode
			,phone					= @p_phone
			,fax					= @p_fax
			,service_type_code		= @p_service_type_code
			,business_type_code		= @p_business_type_code
			,vendor_type			= @p_vendor_type				
			,id_type				= @p_id_type					
			,id_no					= @p_id_no					
			,tax_calculation_method	= @p_tax_calculation_method	
			,pkp_no					= @p_pkp_no					
			,id_vendor				= @p_id_vendor				
			,owner_name				= @p_owner_name
			,owner_phone			= @p_owner_phone
			,contact_name			= @p_contact_name
			,contact_position		= @p_contact_position
			,contact_phone			= @p_contact_phone
			,website_address		= @p_website_address
			,email					= @p_email
			,npwp					= @p_npwp
			,siup_no				= @p_siup_no
			,sku_no					= @p_sku_no
			,tdp_no					= @p_tdp_no
			,remark					= @p_remark
			,is_active				= @p_is_active
			,npwp_name				= @p_npwp_name
			,npwp_address			= @p_npwp_address
			--
			,mod_date				= @p_mod_date
			,mod_by					= @p_mod_by
			,mod_ip_address			= @p_mod_ip_address
	where	code					= @p_code

	-- otomatis inactive jika data di edit
	if exists (	select 1 from dbo.master_vendor 
					where code = @p_code 
					and is_active = '1')
		
	begin
		update	dbo.master_vendor 
		set		is_active	= '0'
				,status		= 'NEW'
				--
				,mod_date		= @p_mod_date		
				,mod_by			= @p_mod_by			
				,mod_ip_address	= @p_mod_ip_address
		where	code			= @p_code

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
end
GO
