SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[xsp_master_vendor_getrow]
(
	@p_code nvarchar(50)
)
as
begin
	select	 mv.code
			,mv.company_code
			,mv.name
			,mv.address
			,mv.city_code
			,mv.province_code
			,mv.zipcode
			,mv.phone
			,mv.fax
			,vendor_type				
			,id_type					
			,id_no					
			,tax_calculation_method	
			,pkp_no					
			,id_vendor				
			,mv.service_type_code
			,mv.business_type_code
			,mv.owner_name
			,mv.owner_phone
			,mv.contact_name
			,mv.contact_position
			,mv.contact_phone
			,mv.website_address
			,mv.email
			,mv.npwp
			,mv.npwp_name
			,mv.npwp_address
			,mv.siup_no
			,mv.sku_no
			,mv.tdp_no
			,mv.remark
			,mv.is_active
			,sp.description 'province_name'
			,sc.description 'city_name'
	from	master_vendor mv
	left join ifinsys.dbo.sys_province sp on sp.code = mv.province_code 
	left join ifinsys.dbo.sys_city sc on sc.code = mv.city_code 
	where	mv.code = @p_code ;
end ;
GO
