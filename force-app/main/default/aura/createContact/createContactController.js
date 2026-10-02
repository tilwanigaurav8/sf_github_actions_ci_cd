({
    myAction : function(component, event, helper) {
        var action=component.get("c.saveCon");

        action.setParams({
            fn:component.get("v.FirstName"),
            ln:component.get("v.LastName")
        });


        action.setCallback(this,function(data){
            var state=data.getState();
            if(state=='SUCCESS'){
                component.set("v.error",'dskjn');
            }
            else{
                component.set("v.error",'dg');
            }
            
        })

        $A.enqueueAction(action);
    }
})