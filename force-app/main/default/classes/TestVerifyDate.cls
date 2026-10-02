@isTest
public class TestVerifyDate {
	@isTest
    static void true30Days(){
        Date d1=Date.newInstance(2024,11,29);
        Date d2=Date.newInstance(2024,12,28);
        Date d3=Date.newInstance(2024,10,3);
        System.assertEquals(d2,VerifyDate.CheckDates(d1,d2));
    }
    @isTest
    static void false30Days(){
        Date d1=Date.newInstance(2024,11,29);
        Date d2=Date.newInstance(2024,12,28);
        Date d3=Date.newInstance(2024,12,31);
        System.assertEquals(d3,VerifyDate.CheckDates(d2,d1));
    }
}