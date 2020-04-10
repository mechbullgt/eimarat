class FeedbackForm {
  String _date;
  String _clientName;
  String _productName;
  String _quantity;
  String _bundlePiece;
  String _rate;
  String _transHamali;

  FeedbackForm(this._date, this._clientName,this._productName,this._quantity, this._bundlePiece,this._rate,this._transHamali);

  // Method to make GET parameters.
  String toParams() {
String x = "?date=$_date&client=$_clientName&product=$_productName&quantity=$_quantity&bundlePiece=$_bundlePiece&rate=$_rate&trans=$_transHamali";
    print("Params: "+x);
    return x;
  }
}