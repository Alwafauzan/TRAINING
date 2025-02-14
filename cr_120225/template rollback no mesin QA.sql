SELECT dm.ASSET_NO,doc_no,REFF_NO_1,REFF_NO_2,REFF_NO_3
-- SELECT *
FROM DOCUMENT_MAIN dm
join DOCUMENT_DETAIL on dm.CODE = DOCUMENT_DETAIL.DOCUMENT_CODE
JOIN FIXED_ASSET_MAIN ON FIXED_ASSET_MAIN.ASSET_NO = dm.ASSET_NO
WHERE dm.asset_no IN ('4120037609', '4120036702', '4120036693', '4120036694', '4120036695') and dm.DOCUMENT_TYPE = 'BPKB';

BEGIN TRANSACTION

----------------------------------------------------------------------------------------------------------------------------

DECLARE @reff_no_3_awal VARCHAR(50), @reff_no_3 VARCHAR(50)
DECLARE @temp TABLE (reff_no_3_awal VARCHAR(50), reff_no_3 VARCHAR(50))
INSERT INTO @temp (reff_no_3_awal, reff_no_3)
VALUES ('B117337', 'B117337---'),
	   ('B117317', 'B117317---'),
	   ('B117342', 'B117342---'),
	   ('B117332', 'B117332---'),
	   ('4N15UHK3170', '4N15UHK3170---')

WHILE EXISTS (SELECT * FROM @temp)
BEGIN
	SELECT TOP 1 @reff_no_3_awal = reff_no_3_awal, @reff_no_3 = reff_no_3 FROM @temp
	UPDATE FIXED_ASSET_MAIN 
	SET reff_no_3 = @reff_no_3
	WHERE ASSET_NO IN (SELECT ASSET_NO FROM DOCUMENT_MAIN WHERE document_type = 'BPKB' AND reff_no_3 = @reff_no_3_awal)
	DELETE FROM @temp WHERE reff_no_3_awal = @reff_no_3_awal
END

----------------------------------------------------------------------------------------------------------------------------
SELECT dm.ASSET_NO,doc_no,REFF_NO_1,REFF_NO_2,REFF_NO_3
FROM DOCUMENT_MAIN dm
join DOCUMENT_DETAIL on dm.CODE = DOCUMENT_DETAIL.DOCUMENT_CODE
JOIN FIXED_ASSET_MAIN ON FIXED_ASSET_MAIN.ASSET_NO = dm.ASSET_NO
WHERE dm.asset_no IN ('4120037609', '4120036702', '4120036693', '4120036694', '4120036695') and dm.DOCUMENT_TYPE = 'BPKB';

ROLLBACK TRANSACTION;
