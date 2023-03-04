public with sharing class VR_ChatGptService {

    public static VR_ChatGptService createInstance(){
        return new VR_ChatGptService();
    }

    public Map<String,Object> getImagesCalloutService(String searchImageQuery, String numberOfImages, String imageSize){
        Map<String,Object> responseMap = new Map<String,Object>();
        ChatGPT_Integration__mdt chatGptMd = VR_Util.createInstance().getChatGptIntegrationRecord(Label.VR_ChatGpt_MD_Record);
        if(chatGptMd != null){
            String authorizationToken = chatGptMd.Authorization__c;
            String orgId = chatGptMd.OrgId__c;

            Map<String,String> headerMap = new Map<String,String>();
            headerMap.put(VR_Constants.HEADER_AUTHORIZATION, 'Bearer '+ authorizationToken);
            headerMap.put(VR_Constants.HEADER_ORG_ID, orgId);
            headerMap.put(VR_Constants.HEADER_CONTENT_TYPE, VR_Constants.HEADER_APPLICATION_JSON);
            VR_ChatGptImageWrapper wrapper = new VR_ChatGptImageWrapper();
            wrapper.prompt = searchImageQuery;
            wrapper.n = Integer.valueOf(numberOfImages);
            wrapper.size = imageSize;
            String endPointUrl = 'https://api.openai.com/v1/images/generations';
            String body = JSON.serialize(wrapper);
            VR_RestUtil restUtil = VR_RestUtil.createInstance();
            System.debug('getImagesCalloutService::headerMap '+ headerMap);
            System.debug('getImagesCalloutService::endPointUrl '+ endPointUrl);
            System.debug('getImagesCalloutService::body '+ body);
            HttpRequest request = restUtil.getRequestForCallout(headerMap, endPointUrl, VR_Constants.METHOD_POST, body);
            System.debug('getImagesCalloutService::'+ request);
            HttpResponse response = restUtil.restCallout(request);
            System.debug('getImagesCalloutService::'+ response);

            if(response.getStatusCode() == 200){
                String responseBody = response.getBody();
                System.debug('getImagesCalloutService:: responseBody '+ responseBody);
                Map<String,Object> wrapperMap = (Map<String,Object>)JSON.deserializeUntyped(responseBody);
				System.debug('getImagesCalloutService:: responseWrapper '+ wrapperMap);
                responseMap.put(VR_Constants.IMAGE_RESPONSE, wrapperMap);
                System.debug('getImagesCalloutService:: responseMap '+ responseMap);
            }
        }
        return responseMap;
    }
}