({
    doInit : function(component, event, helper) {
        component.set("v.Folder", true);
    },
    getFiles : function(component, event, helper) {
        var idx = event.currentTarget.dataset.folder;
        var recordId=component.get('v.recordId');
        var action = component.get("c.getPolicyAttachments");
        action.setParams({
            "fName": idx,
            "polid": recordId
            
        });
        action.setCallback(this, function(response) {
            
            var state=response.getState();
            if(state=="SUCCESS"){
                var ListAtt=new Array();
                ListAtt=response.getReturnValue();
                if(ListAtt.length==0){
                    component.set("v.Folder", false);
                    component.set("v.File", false);
                    component.set("v.btn", true);
                    component.set("v.noFile", true);
                }else{
                    component.set("v.AttList", ListAtt);
                    component.set("v.Folder", false);
                    component.set("v.File", true);
                    component.set("v.noFile", false);
                    component.set("v.btn", true);
                }
            }else{
                alert('state is '+state+' something wrong reload window '+response.getError());
            }
        });
        $A.enqueueAction(action);
        
    },
    goBack : function(component, event, helper) {
        component.set("v.Folder", true);
        component.set("v.File", false);
        component.set("v.noFile", false);
        component.set("v.btn", false);
    },
    downloadFile : function(component, event, helper) {
        var idx = event.target.id;
        console.log(idx);
        var action = component.get("c.getAttachment");
        action.setParams({
            "attid": idx
        });
        action.setCallback(this, function(response) {
            var state=response.getState();
            
            if(state=="SUCCESS"){
                var att=response.getReturnValue();
                saveAs(att.body,att.Name);
            }else{
                alert('state is '+state+' something wrong reload window '+response.getError());
            }
        });
        $A.enqueueAction(action);
    }
    
})