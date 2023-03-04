public with sharing class VR_RestUtil {
    
    public static VR_RestUtil createInstance(){
        return new VR_RestUtil();
    }

    public HttpRequest getRequestForCallout(Map<String,String> requestHeaders, String endPointUrl, String methodType, String body){
        HttpRequest request = new HttpRequest();
        if(!requestHeaders.isEmpty()){
            System.debug('VR_RestUtil::getRequestForCallout: requestHeaders ' + requestHeaders);
            for(String header : requestHeaders.keySet()){
                System.debug('VR_RestUtil::getRequestForCallout:header ' + header);
                request.setHeader(header, requestHeaders.get(header));
            }
            request.setBody(body);
            request.setEndpoint(endPointUrl);
            request.setMethod(methodType);
        }
        return request;
    }

    public HttpResponse restCallout(HttpRequest request){
        Http http = new Http();
        HttpResponse response = http.send(request);

        return response;
    }
}