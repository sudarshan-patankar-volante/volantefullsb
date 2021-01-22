@IsTest(SeeAllData=False)
public class VG_ReviseGentiumStepsController2_Test {
	public static testmethod void TesMethod1(){ 
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');      
        Policy__c pol=VG_TU.createPolicy('Gentium',acc.id);
        Policy_Schedule__c ps=VG_Tu.createPolicySchedule(pol.id);
        ps.Product__c='Scheme';
        Update ps;
        VG_Policy_Schedule_Asset__c psa=VG_TU.createPolicyScheduleAsset(ps.id);
        
        ApexPages.currentPage().getParameters().put('PSID', ps.id);
        ApexPages.currentPage().getParameters().put('MTAType', 'Revision of Cover');
        ApexPages.currentPage().getParameters().put('MTAStartDate', String.ValueOf(Date.newInstance(2017, 12, 18)));
       
        VG_ReviseGentiumStepsController2 gsc=new VG_ReviseGentiumStepsController2();
        gsc.BrokeragePrecent=10;
        gsc.sumGWP=2000;
        gsc.CCAmount=2000;
        gsc.IPTPrecent=10.2;
        gsc.FeeIncome=2000;
        gsc.Levies=2000;
        gsc.summaryCalc();
        gsc.fileName='test';
        gsc.fileBody=blob.valueOf('Scheme Name,Binder Ref,Policy No,Transaction Type,Bordereax Date,Policy Cover Start Date,Policy Cover End Date,Transaction Effective date,Insured Name,Date of Birth,Address,Address2,Address3,Postcode,Country,Vehicle Make,Vehicle Model,Vehicle Type,Registration Plate,Sub broker,Coverage,Currency,Sum Insured,Deductible,Gross Written Premium,Brokerage,Tax on Premium,CH Commission,Payment Terms,Payment Ref\nSafari & Tourism Insurance Brokers,B1307 C150291,B122BW0186217-M06/2017/8677,New,01-10-2018,01-10-2018,30-09-2019,01-10-2018,Seburu Investments (PTY) Ltd,04-06-1971,1 The Street,The Road,Durban,X123MWO,South Africa,Land Rover,Defender,Cars,ABCDEF1,BILL BS NSURANCE,Motor,USD,318551,5000,15927.55,796.38,3185.51,4778.27,Annual,Test');
        gsc.gotostep6();
        gsc.gotostep7();
        gsc.finish();
        gsc.BrokeragePrecent=0;
        gsc.summaryCalc();
        gsc.fileBody=null;
        gsc.gotostep6();
        gsc.fileBody=blob.valueOf('Sche,Binder Ref,Policy No,Transaction Type,Bordereax Date,Policy Cover Start Date ,Policy Cover End Date,Transaction Effective date,Insured Name,Date of Birth,Address,Address2,Address3,Postcode,Country,Vehicle Make,Vehicle Model,Vehicle Type,Registration Plate,Sub broker,Coverage,Currency,Sum Insured ,Deductible,Gross Written Premium,Brokerage,Tax on Premium,CH Commission,Payment Terms,Payment Ref\nSafari & Tourism Insurance Brokers,B1307 C150291,B122BW0186217-M06/2017/8677,New,01-10-2018,01-10-2018,30-09-2019,01-10-2018,Seburu Investments (PTY) Ltd,04-06-1971,1 The Street,The Road,Durban,X123MWO,South Africa,Land Rover,Defender,Cars,ABCDEF1,BILL BS NSURANCE,Motor,USD,318551,5000,15927.55,796.38,3185.51,4778.27,Annual,Test');
        gsc.gotostep6();
        gsc.fileBody=blob.valueOf('Scheme Name,Binder Ref,Policy No,Transaction Type,Bordereax Date,Policy Cover Start Date,Policy Cover End Date,Transaction Effective date,Insured Name,Date of Birth,Address,Address2,Address3,Postcode,Country,Vehicle Make,Vehicle Model,Vehicle Type,Registration Plate,Sub broker,Coverage,Currency,Sum Insured,Deductible,Gross Written Premium,Brokerage,Tax on Premium,CH Commission,Payment Terms,Payment Ref\nSafari & Tourism Insurance Brokers,B1307 C150291,B122BW0186217-M06/2017/8677,New,01-101-2018,01-10-2018,30-09-2019,01-10-2018,Seburu Investments (PTY) Ltd,04-06-1971,1 The Street,The Road,Durban,X123MWO,South Africa,Land Rover,Defender,Cars,ABCDEF1,BILL BS NSURANCE,Motor,USD,318551,5000,15927.55,796.38,3185.51,4778.27,Annual,Test');
        gsc.gotostep6();
        gsc.Cancel();
        gsc.gotostep5();
    }
}