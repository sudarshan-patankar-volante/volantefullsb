({
	downloadAllTaxes : function(component, event, helper) {
        var status;
        var recordId=component.get('v.recordId');
        var url='/sfdcpage/'+encodeURIComponent('/apex/VG_Download_All_Taxes?Id=')+recordId;
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": url
        });
        urlEvent.fire();            
        //$A.enqueueAction(action);
        /*var recordId=component.get('v.recordId');
        var url='/VFP/s/sfdcpage/'+encodeURIComponent('/apex/VG_Download_All_Taxes?Id=')+recordId;
        window.open(url,'_blank');*/
    },
    
    doInit : function(component, event, helper) {
        var recordId=component.get('v.recordId');
        var url='/VFP/s/sfdcpage/'+encodeURIComponent('/apex/VG_Download_All_Taxes?Id=')+recordId;
        component.set("v.url",url);
    }
})