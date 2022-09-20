public with sharing class batchScheduler implements schedulable{

    public void execute(Schedulablecontext sc)
           {
            UpdateInactiveAccounts acc = new UpdateInactiveAccounts();
            Database.executeBatch(acc);
           }

           //Setup>develop>apex classes> schedule apex
 
 }