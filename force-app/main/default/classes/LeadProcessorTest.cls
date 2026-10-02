@isTest
public class LeadProcessorTest {
	@testSetup
    public static void setup(){
        List<Lead> testLead = new List<Lead>();
        Lead l1=new Lead(LastName='Sample1',Status='Open - Not Contacted',Company='Metacube');
        Lead l2=new Lead(LastName='Sample2',Status='Open - Not Contacted',Company='Metacube');
        Lead l3=new Lead(LastName='Sample3',Status='Open - Not Contacted',Company='Metacube');
        testLead.add(l1);
        testLead.add(l2);
        testLead.add(l3);
        insert testLead;
    }
    
    @isTest
    public static void test(){
        Test.startTest();
        Database.executeBatch(new LeadProcessor());
        Test.stopTest();
        List<Lead> countLead=[Select Id from Lead where LeadSource='Dreamforce'];
        System.debug(countLead);
        Assert.areEqual(3,countLead.size(),'Size is not equal');
    }
}