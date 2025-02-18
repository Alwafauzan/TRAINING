SELECT dm.ASSET_NO,doc_no,REFF_NO_1,REFF_NO_2,REFF_NO_3
-- SELECT *
FROM DOCUMENT_MAIN dm
join DOCUMENT_DETAIL on dm.CODE = DOCUMENT_DETAIL.DOCUMENT_CODE
JOIN FIXED_ASSET_MAIN ON FIXED_ASSET_MAIN.ASSET_NO = dm.ASSET_NO
WHERE dm.asset_no IN (
'4120037143',
'4120037407',
'4120037409',
'4120040691',
'4120043486',
'4120043733',
'4120038667',
'4120042814'

) and dm.DOCUMENT_TYPE = 'BPKB';

BEGIN TRANSACTION

----------------------------------------------------------------------------------------------------------------------------

DECLARE @asset_no VARCHAR(50), @reff_no_1 VARCHAR(50)
DECLARE @temp TABLE (asset_no VARCHAR(50), reff_no_1 VARCHAR(50))
INSERT INTO @temp (asset_no, reff_no_1)
VALUES ('4120037143', 	'B2230SRV'),
	   ('4120037407', 	'DN1652NT'),
	   ('4120037409', 	'DN1650NT'),
	   ('4120040691', 	'BA1350OV'),
	   ('4120043486', 	'B9100FXY'),
	   ('4120043733', 	'KT1905YW'),
	   ('4120038667', 	'B3470UKL'),
	   ('4120042814', 	'B9747PAM')

WHILE EXISTS (SELECT * FROM @temp)
BEGIN
	SELECT TOP 1 @asset_no = asset_no, @reff_no_1 = reff_no_1 FROM @temp
	UPDATE FIXED_ASSET_MAIN 
	SET reff_no_1 = @reff_no_1
	WHERE ASSET_NO IN (SELECT ASSET_NO FROM DOCUMENT_MAIN WHERE document_type = 'BPKB' AND ASSET_NO = @asset_no)
	DELETE FROM @temp WHERE asset_no = @asset_no
END

----------------------------------------------------------------------------------------------------------------------------
SELECT dm.ASSET_NO,doc_no,REFF_NO_1,REFF_NO_2,REFF_NO_3
FROM DOCUMENT_MAIN dm
join DOCUMENT_DETAIL on dm.CODE = DOCUMENT_DETAIL.DOCUMENT_CODE
JOIN FIXED_ASSET_MAIN ON FIXED_ASSET_MAIN.ASSET_NO = dm.ASSET_NO
WHERE dm.asset_no IN (
'4120037143',
'4120037407',
'4120037409',
'4120040691',
'4120043486',
'4120043733',
'4120038667',
'4120042814'
) and dm.DOCUMENT_TYPE = 'BPKB';

ROLLBACK TRANSACTION;


