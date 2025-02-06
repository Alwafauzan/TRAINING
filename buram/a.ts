// //#region onFormSubmit
// onFormSubmit(rptForm: NgForm, isValid: boolean, print_option: any) {
//     if (!isValid) {
//       swal({
//         allowOutsideClick: false,
//         title: 'Warning',
//         text: 'Please Fill a Mandatory Field OR Format Is Invalid',
//         buttonsStyling: false,
//         confirmButtonClass: 'btn btn-warning',
//         type: 'warning'
//       }).catch(swal.noop)
//       return;
//     } else {
//       this.showSpinner = true;
//     }

//     var is_condition = '';

//     if (print_option === 'ExcelRecord'){
//       is_condition = '0';
//     }
//     else if (print_option === 'Excel'){
//       is_condition = '1';
//     }
//     else{
//       is_condition = '1';
//     }

//     this.reportData = this.JSToNumberFloats(rptForm);
//     this.reportData.p_user_id = this.userId;

//     this.reportData.p_report_name = this.model.name;
//     this.reportData.p_is_condition = is_condition;

//     const dataParam = {
//       TableName: this.model.table_name,
//       SpName: this.model.sp_name,
//       reportparameters: this.reportData
//     };

//     this.dalservice.ReportFile(dataParam, this.APIControllerReport, this.APIRouteForDownload).subscribe(res => {
//       // const parse = JSON.parse(res);
//       // if (parse.result === 1) {
//       this.showSpinner = false;
//       this.printRptNonCore(res);
//       // } else {
//       //   this.showSpinner = false;
//       //   this.swalPopUpMsg(parse.data);
//       // }
//     }, err => {
//       this.showSpinner = false;
//       const parse = JSON.parse(err);
//       this.swalPopUpMsg(parse.data);
//     });
//   }
//   //#endregion onFormSubmit