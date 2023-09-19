public with sharing class AccountTriggerHandler {
    public AccountTriggerHandler() {
        // constructor
    }

    public void onBeforeInsert(List<Account> newAccounts) {
    }

    public void onAfterInsert(List<Account> newAccounts) {
        Set<Id> accIds = new Set<Id>();
        // get the ids of the accounts to be processed
        for (Account account : newAccounts) {
            if(account.AccountRank__c != null) {
                accIds.add(account.Id);
            }
        }
        // get the contacts for the accounts to be processed
        List<Contact> contacts = [SELECT Id, AccountId FROM Contact WHERE AccountId IN :accIds];

        List<Contact> contactsToUpdate = new List<Contact>();
        for(Contact contact : contacts) {
            // if the account is in the set of accounts to be processed
            if(accIds.contains(contact.AccountId)) {
                // update the contact
                contact.AccountRank__c = contact.Account.AccountRank__c;
                // add the contact to the list of contacts to be updated
                contactsToUpdate.add(contact);
            }
        }
        // update the contacts
        update contactsToUpdate;
    }

    public void onBeforeUpdate(Map<Id, Account> newAccounts, Map<Id, Account> oldMap) {
    }

    public void onAfterUpdate(List<Account> newAccounts, Map<Id, Account> oldMap) {
        Set<Id> accIds = new Set<Id>();
        // get the ids of the accounts to be processed
        for (Account account : newAccounts) {
            if(account.AccountRank__c != null 
                && account.AccountRank__c != oldMap.get(account.Id).AccountRank__c) {
                // add the account to the set of accounts to be processed
                accIds.add(account.Id);
            }
        }
        // get the contacts for the accounts to be processed
        List<Contact> contacts = [SELECT Id, AccountId, Account.AccountRank__c FROM Contact WHERE AccountId IN :accIds];

        List<Contact> contactsToUpdate = new List<Contact>();
        for(Contact contact : contacts) {
            // if the account is in the set of accounts to be processed
            if(accIds.contains(contact.AccountId)) {
                // update the contact
                contact.AccountRank__c = contact.Account.AccountRank__c;
                // add the contact to the list of contacts to be updated
                contactsToUpdate.add(contact);
            }
        }
        // update the contacts
        update contactsToUpdate;
    }

    public void onBeforeDelete(List<Account> oldAccounts) {
        for (Account account : oldAccounts) {
            // account.Name = 'Test';
        }
    }

    public void onAfterDelete(List<Account> oldAccounts) {
        for (Account account : oldAccounts) {
            // account.Name = 'Test';
        }
    }

    public void onUndelete(List<Account> oldAccounts) {
        for (Account account : oldAccounts) {
            // account.Name = 'Test';
        }
    }

    public void onAfterUndelete(List<Account> newAccounts) {
        for (Account account : newAccounts) {
            // account.Name = 'Test';
        }
    }

}