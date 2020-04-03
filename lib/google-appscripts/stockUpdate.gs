// https://script.google.com/macros/s/AKfycbxyjnv0aGJiFmCrDt6TQ84TvXGkScrqsKiGtDgMlbXk5DaRSZg/exec

function getSheet(){
var sheet = SpreadsheetApp.openById("1Gj9jNbsFJ_2SlADrutmLh2IkCcXdUj_2Sx14tJASAp4");
return sheet.getSheets()[1];
}

function doGet() {
  var sheet = getSheet();
  var result={};
  var rewards = sheet.getDataRange().getValues();
  Logger.log(rewards);
  result.stockUpdateAPI = makeObject(rewards);
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

/* Sample OutPut

{
  "stockUpdateAPI": {
    "Benq Monitor 22\"": 0,
    "Bosch Blade 14\"": 13,
    "Bosch Blade 4\"": 24,
    "Cement ACC": 239,
    "Cement Ultratech": 168,
    "Cover Block": 0,
    "Cut Press Tagadi": 87.79,
    "Divs Blade Black 4\"": 392,
    "Divs Blade Green 14\"": 19,
    "Dr.Fixit LW+ 1L": 9,
    "Dr.Fixit LW+ 5L": 1,
    "Drill Bit Set": 0,
    "Freemans 5m Tape": 5,
    "HariOm TMT 10mm Fe500-D": 2559.1499999999996,
    "HariOm TMT 12mm Fe500-D": 1476.3999999999996,
    "HariOm TMT 16mm Fe500-D": -68.25,
    "HariOm TMT 8mm Fe500-D": 5406.200000000001,
    "HDMI Cable Local": 1,
    "Himgiri S-Ply 30kg": 10,
    "LWC 5L": 14,
    "RPR 2.5\" Nails": 50,
    "RPR 2\" Nails": 111.53999999999999,
    "RPR 3\" Nails": 50,
    "RPR Binding Wire": 134.12,
    "RPR Mochi Nails 1/2\"": 1,
    "Ruby Blade Black 4\"": 100,
    "Samsung FM Plus": 0,
    "Screw Driver Set": 0,
    "Surya Gold Handle Hammer": 4,
    "TAPARIA SD Set 802": 6,
    "Tape CENTIFLEX 3m": 10,
    "Tape CENTIFLEX 5m": 10,
    "Tape Hi Wide 5m": 10,
    "Tape PLASTICA 15M": 4,
    "Tape PLASTICA 30M": 5,
    "Transportation": 998,
    "Woodstock PF S-Ply 30 Kg ": 10
  }
}

*/
