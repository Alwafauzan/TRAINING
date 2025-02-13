SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--USE IFINBAM
--GO 

--ALTER TABLE IFINBAM.dbo.MASTER_VENDOR
--ADD OLD_NPWP NVARCHAR(50)
--go


ALTER PROCEDURE [dbo].[xsp_master_vendor_insert]
(
	@p_code						nvarchar(50) output
	,@p_company_code			nvarchar(50)
	,@p_name					nvarchar(200)
	,@p_address					nvarchar(4000)
	,@p_city_code				nvarchar(50)	
	,@p_city_name				nvarchar(250)	
	,@p_province_code			nvarchar(50)	
	,@p_province_name			nvarchar(250)
	,@p_zipcode					nvarchar(10)	= ''
	,@p_phone					nvarchar(200)	= ''
	,@p_vendor_type				nvarchar(50)	
	,@p_id_type					nvarchar(50)	
	,@p_id_no					nvarchar(100)	= ''
	,@p_tax_calculation_method	nvarchar(50)	= ''
	,@p_pkp_no					nvarchar(100)	= ''
	,@p_id_vendor				nvarchar(50)	= ''
	,@p_fax						nvarchar(30)	= ''
	,@p_service_type_code		nvarchar(50)	= ''
	,@p_business_type_code		nvarchar(50)	= ''
	,@p_owner_name				nvarchar(100)	= ''
	,@p_owner_phone				nvarchar(25)	= ''
	,@p_contact_name			nvarchar(100)	
	,@p_contact_position		nvarchar(100)	= ''
	,@p_contact_phone			nvarchar(25)	
	,@p_website_address			nvarchar(50)	= ''
	,@p_email					nvarchar(50)	
	,@p_npwp					nvarchar(20)	= ''
	,@p_siup_no					nvarchar(25)	= ''
	,@p_sku_no					nvarchar(25)	= ''
	,@p_tdp_no					nvarchar(25)	= ''
	,@p_remark					nvarchar(4000)
	--,@p_status					nvarchar(20)
	,@p_is_active				nvarchar(1)
	,@p_npwp_name				NVARCHAR(200)
	,@p_npwp_address			NVARCHAR(4000)
	--
	,@p_cre_date			datetime
	,@p_cre_by				nvarchar(15)
	,@p_cre_ip_address		nvarchar(15)
	,@p_mod_date			datetime
	,@p_mod_by				nvarchar(15)
	,@p_mod_ip_address		nvarchar(15)
)
as
begin
	declare @msg nvarchar(max) 
	,@year					nvarchar(4)
	,@month					nvarchar(2)
	,@prefix				nvarchar(50);

	if exists (select 1 from dbo.master_vendor where name = @p_name and id_no = @p_id_no and company_code = @p_company_code)
	begin
		set @msg = 'Vendor by name ' + @p_name + ' and ID number ' + @p_id_no + ' Already Exist ';
		raiserror(@msg, 16, -1) ;
	end
	
	set @year = substring(cast(datepart(year, @p_cre_date) as nvarchar), 3, 2) ;
	set @month = replace(str(cast(datepart(month, @p_cre_date) as nvarchar), 2, 0), ' ', '0') ;
	set @prefix = @p_company_code + 'VDR';

	exec dbo.xsp_get_next_unique_code_for_table @p_unique_code = @p_code output
												,@p_branch_code = ''
												,@p_sys_document_code = ''
												,@p_custom_prefix = 'V'
												,@p_year = @year
												,@p_month = @month
												,@p_table_name = 'MASTER_VENDOR'
												,@p_run_number_length = 5
												,@p_run_number_only = '0' ;

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
    
	insert into master_vendor
	(
		code
		,company_code
		,name
		,address
		,city_code
		,city_name
		,province_code
		,province_name
		,zipcode
		,phone
		,fax
		,service_type_code
		,business_type_code
		,vendor_type
		,id_type
		,id_no
		,tax_calculation_method
		,pkp_no
		,id_vendor
		,owner_name
		,owner_phone
		,contact_name
		,contact_position
		,contact_phone
		,website_address
		,email
		,npwp
		,siup_no
		,sku_no
		,tdp_no
		,remark
		,status
		,is_active
		,npwp_name
		,npwp_address
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
		,@p_company_code
		,@p_name
		,@p_address
		,@p_city_code
		,@p_city_name
		,@p_province_code
		,@p_province_name
		,@p_zipcode
		,@p_phone
		,@p_fax
		,@p_service_type_code
		,@p_business_type_code
		,@p_vendor_type				
		,@p_id_type					
		,@p_id_no					
		,@p_tax_calculation_method	
		,@p_pkp_no					
		,@p_id_vendor					
		,@p_owner_name
		,@p_owner_phone
		,@p_contact_name
		,@p_contact_position
		,@p_contact_phone
		,@p_website_address
		,@p_email
		,@p_npwp
		,@p_siup_no
		,@p_sku_no
		,@p_tdp_no
		,@p_remark
		,''
		,@p_is_active
		,@p_npwp_name
		,@p_npwp_address
		--
		,@p_cre_date
		,@p_cre_by
		,@p_cre_ip_address
		,@p_mod_date
		,@p_mod_by
		,@p_mod_ip_address
	)

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
