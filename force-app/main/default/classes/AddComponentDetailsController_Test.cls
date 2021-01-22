@IsTest(SeeAllData=False)
public class AddComponentDetailsController_Test {
	Public Static TestMethod Void testMenthod1(){ 
        VG_TU.policyCustomSetting();
        Account acc = VG_TU.createAccount('Customer');
        Asset__c asset=VG_TU.createAsset(acc.id);
        asset.VG_Equipments__c='Test;Test;Test;Test;Test';
        update asset;
        apexpages.currentpage().getparameters().put('Id',asset.id);
        AddComponentDetailsController acdc=new AddComponentDetailsController();
        acdc.Save();
        acdc.cancel();
    }
}