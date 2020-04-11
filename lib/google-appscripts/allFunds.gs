//https://script.google.com/macros/s/AKfycby71t6M6u6AGJ7RwYaDGVCRS4fH9PktvFGQjWDkm1mby97hIQlw/exec

function getSheet(){
var sheet = SpreadsheetApp.openById("16kvdYYlf69qOc2UC7quRe6dQ8wGvuHV6erqooOfHe2k");
return sheet.getSheets()[1];
}

function doGet() {
  var sheet = getSheet();
  var result={};
  var rewards = sheet.getDataRange().getValues();
  Logger.log(rewards);
  result = makeObject(rewards);
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

    for (var i =0;i<rowCount;i++)
    {
    if(j<rowCount){
    obj[multiArray[j][0]]=multiArray[j][1];
        j++;
    }
    }
  Logger.log(rowCount)
  return obj;
}