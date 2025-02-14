SELECT dm.ASSET_NO,doc_no,REFF_NO_1,REFF_NO_2,REFF_NO_3
-- SELECT *
FROM DOCUMENT_MAIN dm
join DOCUMENT_DETAIL on dm.CODE = DOCUMENT_DETAIL.DOCUMENT_CODE
JOIN FIXED_ASSET_MAIN ON FIXED_ASSET_MAIN.ASSET_NO = dm.ASSET_NO
WHERE dm.asset_no IN ('4120037609', '4120036702', '4120036693', '4120036694', '4120036695') and dm.DOCUMENT_TYPE = 'BPKB';

BEGIN TRANSACTION

----------------------------------------------------------------------------------------------------------------------------

DECLARE @reff_no_1_awal VARCHAR(50), @reff_no_1 VARCHAR(50)
DECLARE @temp TABLE (reff_no_1_awal VARCHAR(50), reff_no_1 VARCHAR(50))
INSERT INTO @temp (reff_no_1_awal, reff_no_1)
VALUES ('AB8624EA', 'AB8624EA---'),
	   ('AB8625EA', 'AB8625EA---'),
	   ('AB8626EA', 'AB8626EA---'),
	   ('AB8637EA', 'AB8637EA---'),
	   ('BH8059MT', 'BH8059MT---')

WHILE EXISTS (SELECT * FROM @temp)
BEGIN
	SELECT TOP 1 @reff_no_1_awal = reff_no_1_awal, @reff_no_1 = reff_no_1 FROM @temp
	UPDATE FIXED_ASSET_MAIN 
	SET reff_no_1 = @reff_no_1
	WHERE ASSET_NO IN (SELECT ASSET_NO FROM DOCUMENT_MAIN WHERE document_type = 'BPKB' AND reff_no_1 = @reff_no_1_awal)
	DELETE FROM @temp WHERE reff_no_1_awal = @reff_no_1_awal
END

----------------------------------------------------------------------------------------------------------------------------
SELECT dm.ASSET_NO,doc_no,REFF_NO_1,REFF_NO_2,REFF_NO_3
FROM DOCUMENT_MAIN dm
join DOCUMENT_DETAIL on dm.CODE = DOCUMENT_DETAIL.DOCUMENT_CODE
JOIN FIXED_ASSET_MAIN ON FIXED_ASSET_MAIN.ASSET_NO = dm.ASSET_NO
WHERE dm.asset_no IN ('4120037609', '4120036702', '4120036693', '4120036694', '4120036695') and dm.DOCUMENT_TYPE = 'BPKB';

ROLLBACK TRANSACTION;
