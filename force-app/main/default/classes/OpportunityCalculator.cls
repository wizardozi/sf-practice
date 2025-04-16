public class OpportunityCalculator {
    
    public static Decimal getTotalRevenue(List<Opportunity> opps) {
        // Implement logic here
        Decimal totalAmount = 0;
        if(opps == null || opps.isEmpty()) {
            return totalAmount;
        }
        for(opportunity op : opps) {
            if (op.Amount != null) {                
                totalAmount += op.Amount;
            }
        }
        return totalAmount;
    }
}