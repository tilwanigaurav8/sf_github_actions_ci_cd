({
    myAction : function(component, event, helper) {
        component.set("v.accountDetails",[
            {label:"Name",fieldName:"Name",type:"text"},
            {label:"Phone",fieldName:"Phone",type:"Phone"}
        ]);

        var action=component.get("c.getAccounts");

        action.setParams({
            recordId:""
        });

        action.setCallback(this,function(respond){
            component.set("v.Account",respond.getReturnValue());
        });

        $A.enqueueAction(action);
    }
})