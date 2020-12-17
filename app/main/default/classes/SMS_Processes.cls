global class SMS_Processes

{

  webservice static String processSms(String phNumber, String smsBody, Boolean test){

    String accountSid = 'AC0b8bc69ea8fbb5fbc43f375751569e2b';
    String token = 'ac333b712d7fef0c5f5377c86f0d0c30';
    String fromPhNumber = '+19706987326';
    String returnMsg='';

    if (test)
    {
        accountSid = 'AC0b8bc69ea8fbb5fbc43f375751569e2b';
        token = 'ac333b712d7fef0c5f5377c86f0d0c30';
        fromPhNumber = '+19706987326';
    }


    HttpRequest req = new HttpRequest();

    req.setEndpoint('https://api.twilio.com/2010-04-01/Accounts/'+accountSid+'/SMS/Messages.json');

    req.setMethod('POST');

    String VERSION  = '3.2.0';

    req.setHeader('X-Twilio-Client', 'salesforce-' + VERSION);

    req.setHeader('User-Agent', 'twilio-salesforce/' + VERSION);

    req.setHeader('Accept', 'application/json');

    req.setHeader('Accept-Charset', 'utf-8');

    req.setHeader('Authorization','Basic '+EncodingUtil.base64Encode(Blob.valueOf(accountSid+':' +token)));

    req.setBody('To='+EncodingUtil.urlEncode(phNumber,'UTF-8')+'&From='+EncodingUtil.urlEncode(fromPhNumber,'UTF-8')+'&Body='+smsBody);

    Http http = new Http();

    HTTPResponse res = http.send(req);

    System.debug(res.getBody());

    if(res.getStatusCode()==201)
    {
        returnMsg = 'Success';
    }
    else
    {

        returnMsg = 'Message Failed To Send';
        returnMsg = res.getBody();
    }

    return returnMsg;

   }


   @future(callout = true)
  webservice static void processPIN_Sms(String phNumber, String smsBody){

    String accountSid = 'AC0b8bc69ea8fbb5fbc43f375751569e2b';
    String token = 'ac333b712d7fef0c5f5377c86f0d0c30';
    String fromPhNumber = '+19706987326';
    String returnMsg='';

    HttpRequest req = new HttpRequest();

    req.setEndpoint('https://api.twilio.com/2010-04-01/Accounts/'+accountSid+'/SMS/Messages.json');

    req.setMethod('POST');

    String VERSION  = '3.2.0';

    req.setHeader('X-Twilio-Client', 'salesforce-' + VERSION);

    req.setHeader('User-Agent', 'twilio-salesforce/' + VERSION);

    req.setHeader('Accept', 'application/json');

    req.setHeader('Accept-Charset', 'utf-8');

    req.setHeader('Authorization','Basic '+EncodingUtil.base64Encode(Blob.valueOf(accountSid+':' +token)));

    req.setBody('To='+EncodingUtil.urlEncode(phNumber,'UTF-8')+'&From='+EncodingUtil.urlEncode(fromPhNumber,'UTF-8')+'&Body='+smsBody);

    Http http = new Http();

    HTTPResponse res = http.send(req);

    System.debug(res.getBody());


   }


}