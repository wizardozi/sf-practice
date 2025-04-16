@isTest
private class SetCaseSLATest {

    @isTest
    static void priorityHighTest() {
        Test.startTest();
        
        Case validCase = new Case(
            Priority = 'High',
            Origin = 'Web'
        );
        insert validCase;
        
        Test.stopTest();
        
        Case insertedCase = [SELECT SLA_Expiration_Date__c FROM Case WHERE Id = :validCase.Id];

        // Check that SLA_Expiration_Date__c was set (instead of using DateTime.now())
        System.assertNotEquals(null, insertedCase.SLA_Expiration_Date__c, 'SLA should be set for High priority.');
    }

    @isTest
    static void priorityMediumTest() {
        Test.startTest();
        
        Case validCase = new Case(
            Priority = 'Medium',
            Origin = 'Web'
        );
        insert validCase;
        
        Test.stopTest();
        
        Case insertedCase = [SELECT SLA_Expiration_Date__c FROM Case WHERE Id = :validCase.Id];

        System.assertNotEquals(null, insertedCase.SLA_Expiration_Date__c, 'SLA should be set for Medium priority.');
    }

    @isTest
    static void priorityLowTest() {
        Test.startTest();
        
        Case validCase = new Case(
            Priority = 'Low',
            Origin = 'Web'
        );
        insert validCase;
        
        Test.stopTest();
        
        Case insertedCase = [SELECT SLA_Expiration_Date__c FROM Case WHERE Id = :validCase.Id];

        System.assertNotEquals(null, insertedCase.SLA_Expiration_Date__c, 'SLA should be set for Low priority.');
    }

    @isTest
    static void priorityNotSetTest() {
        Test.startTest();
        
        Case validCase = new Case(Origin = 'Web');
        insert validCase;
        
        Test.stopTest();       
        
        Case insertedCase = [SELECT SLA_Expiration_Date__c FROM Case WHERE Id = :validCase.Id];

        System.assertEquals(null, insertedCase.SLA_Expiration_Date__c, 'SLA should be null because Priority set to none.');

    }
}
