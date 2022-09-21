      
 global class UpdateInactiveAccounts implements Database.Batchable<sObject>{
    
      //rg03 : Batch with scheduler that retrieve accounts without orders or reminder task and create a reminder call task for those accounts

     global Database.QueryLocator start(Database.BatchableContext info){ 

                // Request Accounts, with orders and reminder tasks that have 'Active__c' set to false
                return Database.getQueryLocator ('SELECT Id, OwnerId, (SELECT Id FROM Orders), (SELECT Id FROM Tasks WHERE Subject=\'Call\') FROM Account WHERE Active__c = false');
                } 
             
    global void execute(Database.BatchableContext info, List<Account> scope){      
        List<Task> tasksList = new List<Task>();
                
            // Add a call reminder task to every accounts that have no tasks and no orders
            for(Account acc: scope) {
                if(acc.Tasks.size() == 0 && acc.Orders.size() == 0){
                    Task reminderCall = new Task(
                        OwnerId = acc.OwnerId,
                        Priority = 'Normal',
                        ReminderDateTime = Date.today()+5,
                        Status = 'New',
                        Subject = 'Call',
                        WhatId = acc.Id
                    );
                    tasksList.add(reminderCall);
                }
            }
            insert tasksList;
        }
                
        global void finish(Database.BatchableContext info){              
        } 
}