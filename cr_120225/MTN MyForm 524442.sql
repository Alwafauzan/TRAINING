BEGIN TRANSACTION 
select * FROM dbo.AGREEMENT_ASSET_AMORTIZATION
where AGREEMENT_NO		= '0003378.4.10.11.2024'
and BILLING_NO			> 6

update dbo.AGREEMENT_ASSET_AMORTIZATION
set DUE_DATE			= eomonth(DUE_DATE)
	,BILLING_DATE		= eomonth(BILLING_DATE)
	,mod_date           = GETDATE()
	,mod_by             = 'MTN_FAUZAN'
	,mod_ip_address     = 'MYFORM-524188' 

where AGREEMENT_NO		= '0003378.4.10.11.2024'
and BILLING_NO			> 6

select * FROM dbo.AGREEMENT_ASSET_AMORTIZATION
where AGREEMENT_NO = '0003378.4.10.11.2024'
and BILLING_NO > 6

  INSERT INTO MTN_DATA_DSF_LOG
  ( -- columns to insert data into
   MAINTENANCE_NAME
   ,REMARK
   ,TABEL_UTAMA
   ,REFF_1
   ,REFF_2
   ,REFF_3
   ,CRE_DATE
   ,CRE_BY
  )
  VALUES
  ( -- first row: values for the columns in the list above
  'MTN MyForm 524442'
  ,'Req Revisi Billing Date dan Due Date Agr No. 0003378/4/10/11/2024 GLOBAL JET EXPRESS'
  ,'AGREEMENT_ASSET_AMORTIZATION'
  ,'0003378/4/10/11/2024'
  ,null
  ,null
  ,GETDATE()
  ,'fauzan'
  );

ROLLBACK TRANSACTION 