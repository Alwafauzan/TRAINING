		insert into dbo.rpt_adh_collateral_detail
		(
			user_id
			,doc_code
			,agreement_no
			,customer_name
			,document_name
			,document_no
			,description
			,received_date
			,trx_date
			,input_by
		)
		select	@p_user_id
				,dmt.code
				,case
					 when ast.rental_status = 'IN USE' then ast.agreement_external_no
					 else 'UNIT ' + ast.status
				 end
				,case
					 when ast.rental_status = 'IN USE' then ast.client_name
					 else 'UNIT ' + ast.status
				 end
				,dm.document_type
				,replacement.document_no--fam.doc_asset_no
				,dmd.remarks
				,dmt.movement_date--dmt.receive_date
				,ama.agreement_date
				,nama.name
		from	dbo.document_main dm
				left join dbo.document_movement_detail dmd on dmd.document_code = dm.code
				left join dbo.document_movement dmt on dmt.code = dmd.movement_code
				left join ifinams.dbo.asset ast on ast.code = dm.asset_no
				left join ifinopl.dbo.agreement_main ama on ama.agreement_no = ast.agreement_no
				left join  dbo.fixed_asset_main fam on (fam.asset_no=dm.asset_no)
				outer apply (
					select	sem2.name 'name'
					from	ifinsys.dbo.sys_employee_main sem2
					where	sem2.code = dmt.cre_by 
				)nama
				outer apply (
					select dmr.document_no 
					from dbo.document_movement_replacement dmr
					where dmr.movement_code = dmt.code
				)replacement
		where	dmt.movement_status = 'ON TRANSIT' --not in ('HOLD','CANCEL')
				and dmt.movement_location = 'BORROW CLIENT'--<> 'ENTRY'
				and cast(dmt.movement_date as date) <= @p_as_of_date
				and dm.branch_code                  = case @p_branch_code
																			when 'ALL' then dm.branch_code
																			else @p_branch_code
																		 end  ;

		--select		@jumlah_agreement_no = count(agreement_no)
		--from		dbo.rpt_adh_collateral_detail
		--group by	agreement_no ;

		--select		@jumlah_agreement_no = count(*)
		--from
		--			(
		--				select		count(agreement_no) as GroupAmount
		--				from		rpt_adh_collateral_detail
		--				group by	agreement_no
		--			) countjumlah
		--group by	GroupAmount ;

		select		@total_unit = count(user_id)
					,@jumlah_agreement_no = count(distinct agreement_no)
		from		dbo.rpt_adh_collateral_detail
		where		user_id = @p_user_id;	

		update	dbo.rpt_adh_collateral
		set		total_agreement = @jumlah_agreement_no
				,total_unit = @total_unit
		where	user_id = @p_user_id ;