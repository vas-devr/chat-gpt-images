public with sharing class VR_ChatGptImageWrapper {

    @AuraEnabled public String prompt{get;set;}
    @AuraEnabled public Integer n{get;set;}
    @AuraEnabled public String size{get;set;}
}