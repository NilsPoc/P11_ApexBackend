public with sharing class DataFactory {

    public static Account createAccount(String actName) {
            
        Account act = new Account();
        act.Name = actName;
        act.Active__c = false;
        return act;
    }
  
    public static List<Order> createOrders (String accountId, Integer ordsNumber){
            List<Order> ordsList = new List<Order>();
                for(Integer i=0; i < ordsNumber; i++) {
                    Order ord = new Order (AccountId = accountId, Pricebook2Id = Test.getStandardPricebookId(), Status = 'Draft', EffectiveDate = Date.today()+30);
                    ordsList.add(ord);
                }
                return ordsList;
    }

    public static Product2 createProduct(String prodName, String familyName) {
        
        return new Product2(Name= prodName, Family= familyName);
    }

    public static PricebookEntry createPricebook (String product2Id, Double unitPrice) {
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = product2Id,
            UnitPrice = unitPrice,
            IsActive = true
        );
        return pbe;
    }

    public static List<OrderItem> createOrderItems (List<Order> ordsList, Map<String, String> data) {
        List<OrderItem> orderItems = new List<OrderItem>(); 
        for (Order ord: ordsList) {
        OrderItem oi1 = new OrderItem(OrderId = ord.Id, Product2ID = data.get('Product2Id'), PricebookEntryId = data.get('PricebookEntryId'), Quantity=10, UnitPrice = 150);
        orderItems.add(oi1);
        }
        return orderItems;
    } 
 
}
