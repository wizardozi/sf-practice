@isTest
private class AccountRevenueCalculatorTest {     

    @TestSetup
    static void setupTestData() {
        // Create Test Accounts
        Account testAccount1 = new Account(Name = 'Test Account1');
        Account testAccount2 = new Account(Name = 'Test Account2');
        Account testAccount3 = new Account(Name = 'Test Account3');
        insert new List<Account>{testAccount1, testAccount2, testAccount3};

        // Create Opportunities for Account 1 (5 Opps x $5,000 = $25,000)
        List<Opportunity> opps = new List<Opportunity>();
        for (Integer i = 0; i < 5; i++) {
            opps.add(new Opportunity(
                Name = 'Opp ' + i, 
                AccountId = testAccount1.Id, 
                Amount = 5000.00, 
                StageName = 'Closed Won', 
                CloseDate = System.today()
            ));
        }

        // Create Opportunities for Account 2 (3 Opps x $10,000 = $30,000)
        for (Integer i = 0; i < 3; i++) {
            opps.add(new Opportunity(
                Name = 'Opp ' + i, 
                AccountId = testAccount2.Id, 
                Amount = 10000.00, 
                StageName = 'Closed Won', 
                CloseDate = System.today()
            ));
        }

        // Create Opportunities for Account 3 (7 Opps x $10,000, but in 'Prospecting')
        for (Integer i = 0; i < 7; i++) {
            opps.add(new Opportunity(
                Name = 'Opp ' + i, 
                AccountId = testAccount3.Id, 
                Amount = 10000.00, 
                StageName = 'Prospecting', 
                CloseDate = System.today()
            ));
        }

        insert opps; // Insert all opportunities in bulk
    }

    @isTest
    static void positiveTest1() {
        Test.startTest();
        Database.executeBatch(new AccountRevenueCalculator());
        Test.stopTest();

        Account updatedAccount = [SELECT Id, Total_Revenue__c FROM Account WHERE Name = 'Test Account1'];
        system.assertEquals(25000.00, updatedAccount.Total_Revenue__c);
    }

    @isTest
    static void positiveTest2() {
        Test.startTest();
        Database.executeBatch(new AccountRevenueCalculator());
        Test.stopTest();

        Account updatedAccount = [SELECT Id, Total_Revenue__c FROM Account WHERE Name = 'Test Account2'];
        system.assertEquals(30000.00, updatedAccount.Total_Revenue__c);
    }

    @isTest
    static void accountNoOpportunities() {
        Test.startTest();
        Database.executeBatch(new AccountRevenueCalculator());
        Test.stopTest();

        Account updatedAccount = [SELECT Id, Total_Revenue__c FROM Account WHERE Name = 'Test Account3'];
        system.assertEquals(null, updatedAccount.Total_Revenue__c);
    }
}
