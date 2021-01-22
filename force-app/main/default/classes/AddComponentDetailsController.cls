Public Class AddComponentDetailsController{
    public String assId{get;set;}
    public List<ComponentWrapper> compList{get;set;}
    public AddComponentDetailsController(){
        assId=apexpages.currentpage().getparameters().get('Id');
        Asset__c ass=[select id,Name,VG_Equipments__c from Asset__c where id=:assId limit 1];
        String[] equips;
        compList=new List<ComponentWrapper>();
        if(ass.VG_Equipments__c != null){
            equips=ass.VG_Equipments__c.split(';');
            System.debug('16-01::'+equips);
            for(Integer i=0;i<equips.size();i++){
                ComponentWrapper cw=new ComponentWrapper();
                cw.compName=equips[i];
                cw.para1='';
                cw.para2='';
                cw.para3='';
                compList.add(cw);
            }
            System.debug('16-01::'+compList);
        }
    }
    public PageReference Save(){
        Asset__c tmpass=new Asset__c();
        tmpass.id=assId;
        String compDetails='';
        if(compList.size()>1)
            compDetails='S_NO | Component Name | Parameter1 | Parameter2 | Parameter3\n';
        Integer i=1;
        for(ComponentWrapper cw:compList){
            compDetails+=i+'.'+cw.compName+';'+cw.para1+';'+cw.para2+';'+cw.para3+'\n';
            i++;
        }
        tmpass.VG_Component_Details__c=compDetails;
        update tmpass;
        return new PageReference('/'+assId);
    }
    public PageReference cancel(){
        return new PageReference('/'+assId);
    }
    public Class ComponentWrapper{
        public String compName{get;set;}
        public String para1{get;set;}
        public String para2{get;set;}
        public String para3{get;set;}
    }
}