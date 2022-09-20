trigger OrderTrigger on Order (after insert, after delete) {
    /*if (Trigger.isUpdate) {
        OrderTriggerHandler.orderProductsCheck(Trigger.new);
    }*/
    if (Trigger.isInsert) {
        OrderTriggerHandler.setAccountToActive(Trigger.new);
    }
    if (Trigger.isDelete) {
        OrderTriggerHandler.accountOrdersDelete(Trigger.old); 
    }
}
