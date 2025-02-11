SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[xsp_document_storage_detail_insert]
(
	@p_id					  bigint = 0 output
	,@p_document_storage_code nvarchar(50)
	,@p_document_code		  nvarchar(50)
	--
	,@p_cre_date			  datetime
	,@p_cre_by				  nvarchar(15)
	,@p_cre_ip_address		  nvarchar(15)
	,@p_mod_date			  datetime
	,@p_mod_by				  nvarchar(15)
	,@p_mod_ip_address		  nvarchar(15)
)
as
begin
	declare @msg nvarchar(max) ;

-- fauzan 11/02/2025 buat validasi biar ketika status document_storage = 'POST' gabisa diinsert
	if exists(
	select	1
	from	document_storage ds
	where	ds.code = @p_document_storage_code
			and ds.storage_status = 'POST'
	)
	BEGIN
		SET @msg = 'cannot insert data because status already POST';
		RAISERROR(@msg, 16, -2);
	END;

	begin try
		insert into document_storage_detail
		(
			document_storage_code
			,document_code
			--
			,cre_date
			,cre_by
			,cre_ip_address
			,mod_date
			,mod_by
			,mod_ip_address
		)
		select	@p_document_storage_code
				,@p_document_code
				--
				,@p_cre_date
				,@p_cre_by
				,@p_cre_ip_address
				,@p_mod_date
				,@p_mod_by
				,@p_mod_ip_address
-- fauzan 11/02/2025 buat validasi biar ketika status document_storage = 'POST' gabisa diinsert
		-- where	not exists (
		-- 				select	1
		-- 				from	document_storage ds
		-- 				where	ds.code = @p_document_storage_code
		-- 						and ds.storage_status = 'POST'
		-- 			) ;

		set @p_id = @@identity ;
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

