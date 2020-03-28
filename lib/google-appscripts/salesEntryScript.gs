function doGet(request){
    // Open Google Sheet using ID
    var sheet = SpreadsheetApp.openById("1kOyPSz-aOlTxhmUUXYSWC4wgmFlNpLcmKks0B5Kmt0s");
    var date = Utilities.formatDate(new Date(), "GMT+5:30", "dd/MM/yyyy hh:mm:ss");
    Logger.log("Date: "+date);
    var result = {"status":"SUCCESS",
    "timeStamp":date};
	
    try{
        // Get all Parameters
        var date = request.parameter.date;
        var client = request.parameter.client;
        var product = request.parameter.product;
        var quant = request.parameter.quantity;
        var bundle = request.parameter.bundlePiece;
        var rate = request.parameter.rate;
        var trans = request.parameter.trans;

        // Append data on Google Sheet
        var rowData = sheet.appendRow([date,client,product,quant,bundle,rate,trans]);  

    }catch(exc){
        // If error occurs, throw exception
        result = {"status": "FAILED", "message": exc};
    }

    // Return result
    return ContentService
    .createTextOutput(JSON.stringify(result))
    .setMimeType(ContentService.MimeType.JSON);  
}