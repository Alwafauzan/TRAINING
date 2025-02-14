SELECT dm.ASSET_NO,doc_no,REFF_NO_1,REFF_NO_2,REFF_NO_3
-- SELECT *
FROM DOCUMENT_MAIN dm
join DOCUMENT_DETAIL on dm.CODE = DOCUMENT_DETAIL.DOCUMENT_CODE
JOIN FIXED_ASSET_MAIN ON FIXED_ASSET_MAIN.ASSET_NO = dm.ASSET_NO
WHERE dm.asset_no IN (
'4120039700',
'4120040170') and dm.DOCUMENT_TYPE = 'BPKB';

BEGIN TRANSACTION

----------------------------------------------------------------------------------------------------------------------------

DECLARE @asset_no VARCHAR(50), @reff_no_2 VARCHAR(50)
DECLARE @temp TABLE (asset_no VARCHAR(50), reff_no_2 VARCHAR(50))
INSERT INTO @temp (asset_no, reff_no_2)
VALUES ('4120039700', 'MHKB3BA1JNK084279'),
	   ('4120040170', 'MK2KSWMDNNJ000581')

WHILE EXISTS (SELECT * FROM @temp)
BEGIN
	SELECT TOP 1 @asset_no = asset_no, @reff_no_2 = reff_no_2 FROM @temp
	UPDATE FIXED_ASSET_MAIN 
	SET reff_no_2 = @reff_no_2
	WHERE ASSET_NO IN (SELECT ASSET_NO FROM DOCUMENT_MAIN WHERE document_type = 'BPKB' AND ASSET_NO = @asset_no)
	DELETE FROM @temp WHERE asset_no = @asset_no
END

----------------------------------------------------------------------------------------------------------------------------
SELECT dm.ASSET_NO,doc_no,REFF_NO_1,REFF_NO_2,REFF_NO_3
FROM DOCUMENT_MAIN dm
join DOCUMENT_DETAIL on dm.CODE = DOCUMENT_DETAIL.DOCUMENT_CODE
JOIN FIXED_ASSET_MAIN ON FIXED_ASSET_MAIN.ASSET_NO = dm.ASSET_NO
WHERE dm.asset_no IN (
'4120039700',
'4120040170') and dm.DOCUMENT_TYPE = 'BPKB';

ROLLBACK TRANSACTION;
