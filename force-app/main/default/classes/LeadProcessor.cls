public class LeadProcessor implements Database.Batchable<sObject>, Database.Stateful{
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT Id, Name,LeadSource from Lead');
    }
    
    public void execute(Database.BatchableContext bc, List<Lead> scope){
        List<Lead> updatedLeads = new List<Lead>();
        for(Lead l:scope){
            l.LeadSource='Dreamforce';
            updatedLeads.add(l);
        }
        update updatedLeads;
    }
    
    public void finish(Database.BatchableContext bc){
        // finish method
    }
}