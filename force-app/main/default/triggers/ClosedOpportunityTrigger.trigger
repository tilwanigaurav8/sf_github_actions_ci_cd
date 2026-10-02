trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
	List<Task> newTask = new List<Task>();
    for(Opportunity opp:Trigger.new){
        Task n = new Task();
        if(Trigger.isInsert){
            if(opp.StageName=='Closed Won'){
                n.Subject = 'Follow Up Test Task';
                n.WhatId = opp.Id;
                newTask.add(n);
            }
        }
        if(Trigger.isUpdate){
            if(opp.StageName=='Closed Won' && Trigger.oldMap.get(opp.Id).StageName!='Closed Won'){
                n.Subject = 'Follow Up Test Task';
                n.WhatId = opp.Id;
                newTask.add(n);
            }
        }
    }
    insert as User newTask;
}