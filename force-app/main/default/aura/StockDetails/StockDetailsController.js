({
	doInit : function(component, event, helper) {
		var StockDetail;
        var recordId=component.get('v.recordId');
        var action = component.get("c.getCompanyDetails");
        action.setParams({key : recordId});
        action.setCallback(this, function(response) {
            var state=response.getState();
            if(state=="SUCCESS"){
                StockDetail=response.getReturnValue();
                component.set("v.price",StockDetail.Price);
                component.set("v.sector",StockDetail.sector);
                component.set("v.description",StockDetail.description);
                component.set("v.cname",StockDetail.companyName);
                component.set("v.img",StockDetail.image);
                component.set("v.cr",StockDetail.ChangesPerc);
                component.set("v.web",StockDetail.website)
            }else{
                console.log('state is '+state+' something wrong reload window '+response.getError());
            }
        });
        $A.enqueueAction(action);
	}
})