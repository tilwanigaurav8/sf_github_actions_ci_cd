public class DailyLeadProcessor implements Schedulable{
    public void execute(SchedulableContext sc){
        List<Lead> leadList = [SELECT Id,Name,LeadSource FROM Lead WHERE LeadSource=NULL LIMIT 200];
        List<Lead> leadL = new List<Lead>();
        for(Lead l:leadList){
            l.LeadSource = 'Dreamforce';
            leadL.add(l);
        }
        update leadL;
    }
}