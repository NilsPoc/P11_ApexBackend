public with sharing class OrderTriggerHandler {
          
    /* Fonctionnalité native : plus nécessaire 
    
    public static void orderProductsCheck (List<Order> Orders) {
        
        // rg01 : Send an error message when the order status is modified from 'draft' to 'active', if the order contains no products
        
        //sélectionner la liste des orderItems rattachés à l'order (avec un select)
        for(Order ord : orders) {
           if (ord.OrderItems.isEmpty() && ord.Status == 'Active') { 
                ord.addError('Vous devez dabord saisir un/des produits avant de modifier le statut d\'un ordre à active');
           } 
        }
    } */

    public static void setAccountToActive (List<Order> Orders) {

        //rg02: when an order is added to an account, set 'Active__c' to 'true'

        set<Id> setAccountIds = new set<Id>();

        //Add account Id in a set for each orders
        for (Order newOrder : Orders){
            setAccountIds.add(newOrder.AccountId);
        }

        // Get the list of account related to new orders
        List<Account> listOfAccounts = [SELECT Id, Active__c FROM Account WHERE Id IN :setAccountIds];

        // Check if the accounts have orders left, if true put 'Active__c' to true
        for(Account act: listOfAccounts) {      
                act.Active__c = true; 
        }
        if (listOfAccounts.size() > 0){
            update listOfAccounts;  
        }
    }

    public static void accountOrdersDelete (List<Order> Orders) {

        // rg02: After deletion of an order, we check if account got any orders left, if not 'Active__c' is set to false

        set<Id> setAccountIds = new set<Id>();

        //Add account Id in a set for each orders
        for (Order newOrder : Orders){
            setAccountIds.add(newOrder.AccountId);
        }

        // Get the list of account related to new orders
        List<Account> listOfAccounts = [SELECT Id, (SELECT Id FROM Orders) FROM Account WHERE Id IN :setAccountIds];
        List<Account> listOfAccountsUpdate = new List<Account>();

        // Check if the accounts have orders left, if not put 'Active__c' to false
        for(Account act: listOfAccounts) {      
             if(act.Orders.size() == 0){
                act.Active__c = false; 
                listOfAccountsUpdate.add(act);
           } 
        }
        if (listOfAccountsUpdate.size() > 0){
            update listOfAccountsUpdate;  
        }
    }
}