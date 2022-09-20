@IsTest
public with sharing class UpdateInactiveAccountsTest {
    @TestSetup
    static void makeData(){
        Account act = DataFactory.createAccount('TestAccount');
        insert act;
    }

    @IsTest
    static void updateInactiveAccountTest() {
        Account act = [SELECT Id FROM Account LIMIT 1];

        Test.startTest();
        UpdateInactiveAccounts uia = new UpdateInactiveAccounts();
        Database.executeBatch(uia);
        Test.stopTest();

        List<Task> oneTask = [SELECT WhatId FROM Task WHERE AccountId =: act.Id];
        system.assertEquals(1, oneTask.size(), 'Task created, test ok');
    }
}
