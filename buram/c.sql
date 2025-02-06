-- inquiry book detail (outstanding borrow)
SELECT bt.borrow_date, mb.name, bt.estimate_return_date, btd.quantity
FROM borrow_transaction bt
JOIN master_borrower mb ON bt.borrower_code = mb.code
JOIN borrow_transaction_detail btd ON bt.code = btd.borrow_code
JOIN master_book mbk ON btd.book_code = mbk.book_code
WHERE mbk.book_code = @p_book_code


-- inquiry book detail (history)
select 
    mb.name, 
    bt.mod_date, 
	bt.estimate_return_date,
    bt.status,
    case 
        when bt.status = 'BORROW' and bt.realization_return_date is not null and getdate() > bt.estimate_return_date then 'Terjadi keterlambatan'
        when bt.status = 'BORROW' then 'Dilakukan peminjaman'
        when bt.status = 'RETURN' then 'Sudah dilakukan pengembalian'
        else 'Status tidak diketahui'
    end as remark
from 
    borrow_transaction bt 
JOIN master_borrower mb ON bt.borrower_code = mb.code
JOIN borrow_transaction_detail btd ON bt.code = btd.borrow_code
JOIN master_book mbk ON btd.book_code = mbk.book_code
WHERE mbk.book_code = @p_book_code


	select 
		 bt.borrow_date			
		,mb.name					
		,bt.estimate_return_date	
		,btd.quantity
		,case 
			when bt.estimate_return_date > bt.borrow_date then -datediff(day, bt.borrow_date, bt.estimate_return_date)
			else datediff(day, bt.borrow_date, bt.estimate_return_date)
		end as 'aging'
		,@rows_count 'rowcount'
	FROM 
		borrow_transaction bt
	JOIN 
		master_borrower mb ON bt.borrower_code = mb.code
	JOIN 
		borrow_transaction_detail btd ON bt.code = btd.borrow_code
	JOIN 
		master_book mbk ON btd.book_code = mbk.book_code
	WHERE 
		mbk.book_code = @p_book_code 
