class Endpoints {
  var obj ={
    'getClientDetails':"https://script.google.com/macros/s/AKfycbykq3ANYlP3BGcma9AZ3uc-mV808YyWednsaaFbG8ScLRfhQp-6/exec",
    'getClientBillCounts':"https://script.google.com/macros/s/AKfycbzrv0imLQU3sbIYcpq4_WwxtSK4QO-dAnauIKpM3wKCK1vFRJc/exec",
  };

  String getEndpoint(String endpointName){
    if(obj.containsKey(endpointName)){
      return obj[endpointName];
    }
    return "Key not found";
  }
}