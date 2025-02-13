• IFINBAM -> Vendor : Tabel IFINBAM -> MASTER_VENDOR
• IFINAMS -> Master Public Service : Tabel IFINAMS -> MASTER_PUBLIC_SERVICE
• IFINAMS -> Master Auction : Tabel IFINAMS -> MASTER_AUCTION
• IFINAMS -> Master Insurance : IFINAMS -> INSURANCE_COMPANY
• IFINAMS -> Work Order : IFINBAM -> MASTER_VENDOR
• IFINAMS -> Realization : IFINAMS -> MASTER_PUBLIC_SERVICE
• IFINAMS -> Insurance : IFINAMS -> MASTER_INSURANCE
• IFINPROC -> Supplier Selection : IFINAMS -> MASTER_PUBLIC_SERVICE
• IFINPROC -> Quotation : IFINPROC -> QUOTATION_REVIEW_DETAIL
• IFINPROC -> Invoice Register : IFINPROC - >QUOTATION_REVIEW_DETAIL
 IFINPROC -> SUPPLIER_SELECTION_DETAIL
• IFINOPL -> Application : IFINOPL -> APPLICATION_ASSET
 IFINOPL -> AGREEMENT_ASSET
 IFINOPL -> INVOICE_DETAI


,nitku
,npwp_pusat


,@p_nitku						 nvarchar(50)  = ''
,@p_npwp_pusat					 nvarchar(50)  = ''

,@p_nitku
,@p_npwp_pusat

,nitku								= @p_nitku
,npwp_pusat							= @p_npwp_pusat




                                        type="text" class="form-control" [(ngModel)]="model.ktp_no" name="p_ktp_no"
                                        maxlength="16" #ktp_no="ngModel" pattern={{NumberOnlyPattern}} required
                                        (change)="model.ktp_no = model.ktp_no || ''">









                                        1449949507
                                        qgaau638


 0000830/4/10/11/2023

https://qaifinancing.dipostar.org/ifinancing/ifinopl/inquiry/subagreementlist/agreementdetail/%C2%A00000830.4.10.11.2023
https://qaifinancing.dipostar.org/ifinancing/ifinopl/inquiry/inquiryapplicationmain/applicationmaindetail/0000043.4.01.11.2023/banberjalan
https://qaifinancing.dipostar.org/ifinancing/ifinopl/application/banberjalanapplicationmain/applicationmaindetail/0002880.4.10.10.2024/banberjalan
https://qaifinancing.dipostar.org/ifinancing/ifinopl/billing/subchangebillingcontractsettinglist/changebillingcontractsettingdetail/0000001.4.01.11.2023/2001.OPLAA.2311.000046


app aproval == readonly
billing != readonly
inquiry app == readonly
inquiry agreement == readonly


        // "urlReportOpl":     "http://192.168.1.99:8610/api/v5_rpt_api_opl/api/",