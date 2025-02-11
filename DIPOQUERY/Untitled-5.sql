SELECT rad.* 
FROM ( 
    SELECT rad.*, 
           RANK() OVER (PARTITION BY rad.code ORDER BY rad.movement_date DESC) AS row_num 
    FROM ( 
        select  'fauzan' as user_name
                ,dmt.code
                ,case
                     when ast.rental_status = 'IN USE' then ast.agreement_external_no
                     else 'UNIT ' + ast.status
                 end as agreement_no
                ,case
                     when ast.rental_status = 'IN USE' then ast.client_name
                     else 'UNIT ' + ast.status
                 end as client_name
                ,dm.document_type
                ,replacement.document_no
                ,dmd.remarks
                ,convert(datetime, dmt.movement_date, 121) as movement_date
                ,convert(datetime, ama.agreement_date, 121) as agreement_date
                ,nama.name
        from    dbo.document_main dm
                left join dbo.document_movement_detail dmd on dmd.document_code = dm.code
                left join dbo.document_movement dmt on dmt.code = dmd.movement_code
                left join ifinams.dbo.asset ast on ast.code = dm.asset_no
                left join ifinopl.dbo.agreement_main ama on ama.agreement_no = ast.agreement_no
                left join dbo.fixed_asset_main fam on fam.asset_no = dm.asset_no
                outer apply (
                    select sem2.name as name
                    from ifinsys.dbo.sys_employee_main sem2
                    where sem2.code = dmt.cre_by
                ) nama
                outer apply (
                    select dmr.document_no
                    from dbo.document_movement_replacement dmr
                    where dmr.movement_code = dmt.code
                ) replacement
        where   dmt.movement_status = 'ON TRANSIT'
                and dmt.movement_location = 'BORROW CLIENT'
                and cast(dmt.movement_date as date) <= '2024-11-28'
                and dm.branch_code = case when '1000' = 'ALL' then dm.branch_code else '1000' end
    ) rad 
) rad 
WHERE rad.row_num = 1

