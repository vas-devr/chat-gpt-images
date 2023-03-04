public with sharing class VR_ChatGptController {

    @AuraEnabled
    public static Map<String,Object> getImages(String imageQueryString, String numberOfImages, String imageSize){
        Map<String,Object> responseMap = new Map<String,Object>();
        try {
            responseMap.putAll(VR_ChatGptService.createInstance().getImagesCalloutService(imageQueryString, numberOfImages, imageSize));    
            responseMap.put(VR_Constants.SUCCESS, true);
        } catch (Exception e) {
            responseMap.put(VR_Constants.SUCCESS, false);
            responseMap.put(VR_Constants.MESSAGE, 'Something went wrong. Please try again later');
            System.debug('getImages::'+responseMap);
            System.debug('getImages:: '+ e.getMessage() + ' Stack:: '+ e.getStackTraceString() + ' Cause:: '+ e.getCause());
        }
        
        System.debug('getImages:: '+ responseMap);
        return responseMap;
    }
    
}