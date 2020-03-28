function getSheet(){
var sheet = SpreadsheetApp.openById("1s89SQvgUvzkYRcd8L6g1_wCU6DtvvmsnD1ma3soqgWU");
return sheet;
}

function doGet() {
  var sheet = getSheet();
  var result={};
  var rewards = sheet.getDataRange().getValues();
  Logger.log(rewards);
  result.clientNamesAPI = makeObject(rewards);
  return ContentService.createTextOutput(JSON.stringify(result))
  .setMimeType(ContentService.MimeType.JSON)
}

function makeObject(multiArray)
{
  var sheet = getSheet();
  var obj = {}; 
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
