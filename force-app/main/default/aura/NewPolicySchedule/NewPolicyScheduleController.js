({
    handleClick : function(component, event, helper) {	
        var recordId=component.get('v.recordId'); 
        var status=component.get("v.record.fields.Policy_Status__c.value"); 
        if(status!='Booked'){
            var url='/sfdcpage/'+encodeURIComponent('/apex/VG_EdisonPS_Ins1?id=')+recordId
            var urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({
                "url": url
            });
            urlEvent.fire();
            
        }else{
            var url='/sfdcpage/'+encodeURIComponent('/apex/VG_EdisonPS_Ins1?id=')+recordId
            var urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({
                "url": url
            });
            urlEvent.fire();
        }
    },
    doInit : function(component, event, helper) {
        var status;
        var recordId=component.get('v.recordId');
        var action = component.get("c.getPolicyStatus");
        action.setParams({
            "polId": recordId
        });
        action.setCallback(this, function(response) {
            var state=response.getState();
            if(state=="SUCCESS"){
                status=response.getReturnValue();
                if(status=='Booked'){
                    component.set("v.mta", false);
                    component.set("v.ps", true);
                }else{     
                    component.set("v.mta", true);
                    component.set("v.ps", false);
                }
            }else{
                alert('state is '+state+' something wrong reload window');
            }
        });
        $A.enqueueAction(action);
    }
    
})