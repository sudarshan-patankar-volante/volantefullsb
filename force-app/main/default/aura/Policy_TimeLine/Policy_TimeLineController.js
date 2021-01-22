({
	doInit : function(component, event, helper) {
        var psList;
        var recordId=component.get('v.recordId');
        var action = component.get("c.getPolicySchedule");
        action.setParams({
            "polId": recordId
        });
        action.setCallback(this, function(response) {
            var state=response.getState();
            if(state=="SUCCESS"){
                psList=response.getReturnValue();
                component.set("v.psList",psList);
            }else{
                console.log('state is '+state+' something wrong reload window '+response.getError());
            }
        });
        $A.enqueueAction(action);
    }
})