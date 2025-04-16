public  class SetCaseSLAHelper {    
    public static void setSLA(List<Case> newCases) {                        
        for(Case c : newCases) {
            
            if (c.Priority == 'High') {
                c.SLA_Expiration_Date__c = DateTime.now().addHours(48);
            } else if (c.Priority == 'Medium') {
                c.SLA_Expiration_Date__c = DateTime.now().addHours(72);
            } else if (c.Priority == 'Low') {
                c.SLA_Expiration_Date__c = DateTime.now().addHours(120);
            } else if (c.Priority == 'None'){
                c.SLA_Expiration_Date__c = null;  // ✅ Explicitly set to NULL
            }
                     
        }       
    }
}