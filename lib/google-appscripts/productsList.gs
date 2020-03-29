function getSheet(){
var sheet = SpreadsheetApp.openById("1cMqeppK1JRok6nkRQ0zDilAYKSuqFZ4XAEbQ1MSL0xw");
return sheet;
}

function doGet() {
  var sheet = getSheet();
  var result={};
  var allProducts = sheet.getDataRange().getValues();
  Logger.log(allProducts);
  result.productsListAPI = makeObject(allProducts);
  return ContentService.createTextOutput(JSON.stringify(result))
  .setMimeType(ContentService.MimeType.JSON)
}

function makeObject(multiArray)
{
  var sheet = getSheet();
  var j =1;
  var k =0;
  var arr=[];
  var rowCount = sheet.getLastRow();

  /* Sample 
{
  "clientNamesAPI": [
    "A",
    "b",
    "c",
    "d"
  ]
}
  */
    for (var i =0;i<rowCount;i++)
    {
    if(j<rowCount){
        arr[i]=multiArray[j][k];
        j++;
    }
    }
  Logger.log(rowCount)
  return arr;
}
