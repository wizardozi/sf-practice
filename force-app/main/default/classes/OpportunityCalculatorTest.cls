/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
public class OpportunityCalculatorTest {
    
    @isTest
    static void testTotalRevenueWithMultipleOpportunities() {
        // Create test data
        List<Opportunity> opps = new List<Opportunity>{
            new Opportunity(Name='Deal 1', Amount=1000, StageName='Closed Won', CloseDate=Date.today()),
            new Opportunity(Name='Deal 2', Amount=2000, StageName='Closed Won', CloseDate=Date.today()),
            new Opportunity(Name='Deal 3', Amount=500, StageName='Closed Lost', CloseDate=Date.today())
        };
        insert opps;
        
        // Call the method
        Decimal totalRevenue = OpportunityCalculator.getTotalRevenue(opps);
        
        // Verify results
        System.assertEquals(3500, totalRevenue, 'Total revenue should be 3500');
    }

    @isTest
    static void testTotalRevenueWithEmptyList() {
        // Call the method with an empty list
        Decimal totalRevenue = OpportunityCalculator.getTotalRevenue(new List<Opportunity>());
        
        // Verify that the result is 0
        System.assertEquals(0, totalRevenue, 'Total revenue should be 0 for an empty list');
    }

    @isTest
    static void testTotalRevenueWithNullList() {
        // Call the method with a null value
        Decimal totalRevenue = OpportunityCalculator.getTotalRevenue(null);
        
        // Verify that the result is 0
        System.assertEquals(0, totalRevenue, 'Total revenue should be 0 for a null list');
    }

    @isTest
    static void testTotalRevenueWithNullAmounts() {
        // Create Opportunities, some with null Amounts
        List<Opportunity> opps = new List<Opportunity>{
            new Opportunity(Name='Deal 1', Amount=1000, StageName='Closed Won', CloseDate=Date.today()),
            new Opportunity(Name='Deal 2', Amount=null, StageName='Closed Won', CloseDate=Date.today()),
            new Opportunity(Name='Deal 3', Amount=2000, StageName='Closed Lost', CloseDate=Date.today())
        };
        insert opps;

        // Call the method
        Decimal totalRevenue = OpportunityCalculator.getTotalRevenue(opps);
        
        // Verify that null Amounts do not break the calculation
        System.assertEquals(3000, totalRevenue, 'Total revenue should be 3000, ignoring null Amounts');
    }
}
