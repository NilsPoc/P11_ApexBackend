@IsTest
public with sharing class AccountOrdersDeleteTest {
    
    @TestSetup
    static void makeData(){
        Account act = DataFactory.createAccount('TestAccount');
        insert act;

        Product2 prod2 = DataFactory.createProduct('TestProduct', 'TestFamily');
        insert prod2;

        PricebookEntry pbe = DataFactory.createPricebook (prod2.Id, 1020);
        insert pbe;

        List<Order> orders = DataFactory.createOrders (act.Id, 1);
        insert orders;

        List<OrderItem> ordItems = DataFactory.createOrderItems (orders, new Map<String, String>{'Product2ID'=>prod2.Id, 'PricebookEntryId'=>pbe.Id});
        insert ordItems;
    }

    
    @IsTest
    static void deleteOrdersTest() {
      
        //test rg 02(2) : when an order is deleted, if no orders remain an account's active__c must be set to false
        Account act = [SELECT Id, Active__c FROM Account LIMIT 1];

        Order ord = [SELECT Id FROM Order WHERE AccountId =: act.Id];

        Test.startTest();
        Delete ord;
        Test.stopTest();
   
        Account actRefreshed = [SELECT Id, Active__c FROM Account WHERE Id =: act.Id];
        Boolean result = actRefreshed.Active__c;
        system.assertEquals(false, result, 'Active_c is set to false with order delete, test ok');

    }

}
