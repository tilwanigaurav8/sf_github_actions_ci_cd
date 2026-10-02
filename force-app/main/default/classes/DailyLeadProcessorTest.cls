@isTest
public class DailyLeadProcessorTest {
    
    //public static String CRON_EXP = ''
    
	@TestSetup
    public static void setup(){
        List<Lead> leadList=new List<Lead>();
        for(Integer i=1;i<=200;i++){
            Lead l = new Lead(LastName='Lead'+i,LeadSource=NULL,Company='Metacube');
            leadList.add(l);
        }
        insert leadList;
    }
    
    @isTest
    public static void test(){
		Test.startTest();
		System.schedule('My Job', '0 0 0 15 3 ? 2042', new DailyLeadProcessor());
        Test.stopTest();
        List<Lead> al = [SELECT Id,Name,LeadSource FROM Lead WHERE LeadSource='Dreamforce' LIMIT 500];
        Assert.areEqual(200,al.size(),'not equal');
    }
}