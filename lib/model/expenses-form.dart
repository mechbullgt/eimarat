class ExpensesForm {
  String _date;
  String _purpose;
  String _payMode;
  String _amount;
  String _remarks;

  ExpensesForm(this._date, this._purpose,this._payMode,this._amount,this._remarks);

  // Method to make GET parameters.
  String toParams() {
String x = "?date=$_date&purpose=$_purpose&payMode=$_payMode&amount=$_amount&remarks=$_remarks";
    print("Params: "+x);
    return x;
  }
}