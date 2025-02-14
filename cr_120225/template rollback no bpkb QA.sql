SELECT dm.ASSET_NO,doc_no,REFF_NO_1,REFF_NO_2,REFF_NO_3
-- SELECT *
FROM DOCUMENT_MAIN dm
join DOCUMENT_DETAIL on dm.CODE = DOCUMENT_DETAIL.DOCUMENT_CODE
JOIN FIXED_ASSET_MAIN ON FIXED_ASSET_MAIN.ASSET_NO = dm.ASSET_NO
WHERE dm.asset_no IN ('4120037609', '4120036702', '4120036693', '4120036694', '4120036695') and dm.DOCUMENT_TYPE = 'BPKB';

BEGIN TRANSACTION

----------------------------------------------------------------------------------------------------------------------------

DECLARE @doc_no_awal VARCHAR(50), @doc_no VARCHAR(50)
DECLARE @temp TABLE (doc_no_awal VARCHAR(50), doc_no VARCHAR(50))
INSERT INTO @temp (doc_no_awal, doc_no)
VALUES ('R-01822605', 'R01822605'),
	   ('R-01822606', 'R01822606'),
	   ('R-01822607', 'R01822607'),
	   ('R-01822614', 'R01822614'),
	   ('Q-09572141F', 'Q09572141F')

WHILE EXISTS (SELECT * FROM @temp)
BEGIN
	SELECT TOP 1 @doc_no_awal = doc_no_awal, @doc_no = doc_no FROM @temp
	UPDATE DOCUMENT_DETAIL 
	SET doc_no = @doc_no
	WHERE document_code IN (SELECT code FROM DOCUMENT_MAIN WHERE document_type = 'BPKB' AND doc_no = @doc_no_awal)
	DELETE FROM @temp WHERE doc_no_awal = @doc_no_awal
END

----------------------------------------------------------------------------------------------------------------------------
SELECT dm.ASSET_NO,doc_no,REFF_NO_1,REFF_NO_2,REFF_NO_3
FROM DOCUMENT_MAIN dm
join DOCUMENT_DETAIL on dm.CODE = DOCUMENT_DETAIL.DOCUMENT_CODE
JOIN FIXED_ASSET_MAIN ON FIXED_ASSET_MAIN.ASSET_NO = dm.ASSET_NO
WHERE dm.asset_no IN ('4120037609', '4120036702', '4120036693', '4120036694', '4120036695') and dm.DOCUMENT_TYPE = 'BPKB';

ROLLBACK TRANSACTION;
