BEGIN TRANSACTION 
		select		AGREEMENT_DEPOSIT_MAIN.CODE
					,AGREEMENT_DEPOSIT_MAIN.BRANCH_NAME
					,convert(varchar(30), dh.transaction_date, 103) 'transaction_date'
					,convert(varchar(30), isnull(da.allocation_value_date,isnull(ct.cashier_value_date, isnull(dmv.move_date,isnull(pt.payment_value_date, drv.revenue_date)))), 103) 'value_date'
					,dh.SOURCE_REFF_CODE
					,dh.AGREEMENT_NO
					,am.client_name
					,AGREEMENT_DEPOSIT_MAIN.DEPOSIT_TYPE			
					,dh.orig_currency_code	
					,dh.orig_amount			
					,dh.base_amount
					,AGREEMENT_DEPOSIT_MAIN.DEPOSIT_AMOUNT
					,BANK_ACCOUNT_NO
					,IFINFIN.dbo.CASHIER_TRANSACTION.BRANCH_BANK_NAME		
					--,dh.exch_rate				
					--,dh.source_reff_code			
					--,dh.source_reff_name
					--,isnull(ct.invoice_external_no,da.invoice_external_no) 'invoice_external_no'
					--,isnull(ct.invoice_name,da.invoice_name) 'invoice_name'
					--,isnull(ct.invoice_type, da.invoice_type) 'invoice_type'
			--from	dbo.agreement_deposit_history dh with (nolock)
			from IFINFIN.dbo.CASHIER_TRANSACTION 
			left join ifinopl.dbo.AGREEMENT_DEPOSIT_HISTORY dh
			on dh.AGREEMENT_NO = CASHIER_TRANSACTION.AGREEMENT_NO
			left join dbo.agreement_main am with (nolock) on (am.agreement_no = dh.agreement_no)
			outer apply
			(
				select	cashier_value_date
						,invoice_name
						,invoice_type
						,inv.invoice_external_no
				from	ifinfin.dbo.cashier_transaction ct --with (nolock) on (ct.code = sh.source_reff_code) 
						left join ifinfin.dbo.cashier_received_request crr with (nolock) on (crr.process_reff_code = ct.code)
						left join ifinopl.dbo.invoice inv with (nolock) on (inv.invoice_no						   = crr.invoice_no)
				where	ct.code = dh.source_reff_code
			) ct
			outer apply
			(
				select		top 1
							allocation_value_date
							,invoice_name
							,invoice_type
							,inv.invoice_external_no
				from		ifinfin.dbo.deposit_allocation da with (nolock) --on (da.code = sh.source_reff_code)
							left join ifinfin.dbo.deposit_allocation_detail dad with (nolock) on (dad.deposit_allocation_code = da.code)
							left join ifinfin.dbo.cashier_received_request crr2 with (nolock) on (crr2.code					  = dad.received_request_code)
							left join ifinopl.dbo.invoice inv with (nolock) on (inv.invoice_no								  = crr2.invoice_no)
				where		da.code			= dh.source_reff_code
							and dad.is_paid = '1'
				order by	dad.base_amount desc
			) da
			left join ifinfin.dbo.deposit_move dmv with (nolock)  on (dmv.code = dh.source_reff_code) 
			left join ifinfin.dbo.payment_request pr with (nolock) on (pr.payment_source_no = dh.source_reff_code)
			left join ifinfin.dbo.payment_transaction pt with (nolock) on (pt.code = pr.payment_transaction_code)
			left join ifinfin.dbo.deposit_revenue drv with (nolock) on (drv.code = dh.source_reff_code)
			left join dbo.AGREEMENT_DEPOSIT_MAIN on AGREEMENT_DEPOSIT_MAIN.CODE = dh.AGREEMENT_DEPOSIT_CODE
			where dh.TRANSACTION_DATE = '12/31/2024'
			and cashier_trx_date ='2024-12-31'
			and IFINFIN.dbo.CASHIER_TRANSACTION.BRANCH_BANK_NAME = 'BANK HSBC'
			and BANK_ACCOUNT_NO = '001377811070'
ROLLBACK TRANSACTION 