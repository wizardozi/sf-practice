public class HighValueOpportunityFinder {
    public static List<String> getHighValueOpportunities() {
        List<String> highValueOpps = new List<String>();
        for(Opportunity opp : [SELECT Name, Amount FROM Opportunity WHERE Amount != null AND Amount > 50000]) {
            highValueOpps.add(opp.Name);
        }
        return highValueOpps; 
    }
}
