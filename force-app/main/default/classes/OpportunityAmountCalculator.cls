public class OpportunityAmountCalculator {
    public static Map<Id, Decimal> calculateAmount() {
        Map<Id,Decimal> accIdToAmount = new Map<Id,Decimal>();
        Integer count = 0;
        for(AggregateResult agg : [SELECT AccountId, SUM(Amount) totalAmount FROM Opportunity WHERE AccountId != null GROUP BY AccountId
        ]) {                        
            accIdToAmount.put((Id) agg.get('AccountId'), (Decimal) agg.get('totalAmount'));
            
        }

        return accIdToAmount;
    }
}