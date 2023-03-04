public without sharing class VR_Util {
    
    public static VR_Util createInstance(){
        return new VR_Util();
    }
    
    public ChatGPT_Integration__mdt getChatGptIntegrationRecord(String developerName){
        ChatGPT_Integration__mdt chatGpt;
        List<ChatGPT_Integration__mdt> mDList = [SELECT Id, DeveloperName, MasterLabel, OrgId__c, Authorization__c 
        FROM ChatGPT_Integration__mdt 
        WHERE DeveloperName =: developerName 
        LIMIT 1];

        if(!mdList.isEmpty()){
            chatGpt = mDList[0];
        }

        return chatGpt;
    }
}