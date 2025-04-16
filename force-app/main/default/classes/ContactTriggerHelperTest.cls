
@isTest
private class ContactTriggerHelperTest {
    
    @isTest
    static void myUnitTest() {
        // TO DO: implement unit test
        Contact existingContact = new Contact(FirstName = 'Test', LastName = 'Case1', Email = 'testcase@example.com');
        insert existingContact;
        
        Test.startTest();
        Contact duplicateContact = new Contact(FirstName = 'Test', LastName = 'Case2', Email = 'testcase@example.com');

        Database.SaveResult result = Database.insert(duplicateContact, false);
        Test.stopTest();
        
        // Assert: Verify that an error was added (meaning the trigger worked)
        System.assert(!result.isSuccess(), 'Duplicate Contact should have been blocked.');
        System.assertEquals(1, result.getErrors().size(), 'There should be one error.');
        System.assertEquals('Duplicate Contact found.', result.getErrors()[0].getMessage());
        
    }
}