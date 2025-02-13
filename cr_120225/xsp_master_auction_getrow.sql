SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[xsp_master_auction_getrow]
(
	@p_code nvarchar(50)
)
as
begin
	select	code
			,auction_name
			,contact_person_name
			,contact_person_area_phone_no
			,contact_person_phone_no
			,tax_file_type
			,tax_file_no
			,tax_file_name
			,tax_file_address
			,area_phone_no
			,phone_no
			,area_fax_no
			,fax_no
			,email
			,website
			,is_validate
			,ktp_no
	from	master_auction
	where	code = @p_code ;
end ;
GO
