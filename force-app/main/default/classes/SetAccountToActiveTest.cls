@IsTest
public class SetAccountToActiveTest {

    @TestSetup
    static void makeData(){
        Account act = DataFactory.createAccount('TestAccount');
        insert act;
    }

    @IsTest
    static void setAccountToActiveTest(){

        //test rg 02 : active__c must be modified from false to true when an order is created for an account
        Account act = new Account();
        act = [SELECT Id, Active__c FROM Account LIMIT 1];
        

        Test.startTest();
        List<Order> orders = DataFactory.createOrders (act.Id, 1);
        insert orders;
        Test.stopTest();

        Account actRefreshed =  [SELECT Id, Active__c FROM Account WHERE Id =: act.Id];
        Boolean result = actRefreshed.Active__c;
        system.assertEquals(true, result, 'Active_c is set to true when adding an order, test ok');
    } 
}

