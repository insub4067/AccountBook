//
//  DataController.swift
//  AccountBook
//
//  Created by Kim Insub on 2022/04/20.
//

import Foundation
import CoreData

class AccountDataController: ObservableObject{
    
    //define
    let container = NSPersistentContainer(name: "AccountModel")
    
    //init
    init(){
        container.loadPersistentStores{
            desc, error in
            if let error = error {
                print("FAILED TO LOAD DATA \(error.localizedDescription)")
            }
        }
    }
    
    //save
    func save(context: NSManagedObjectContext){
        do {
            try context.save()
            print("DATA SAVED")
        } catch {
            print("FAILED TO SAVE DATA")
        }
    }
    
    //CreateAccount
    func CreateAccount(name: String, balance: Int64, context: NSManagedObjectContext){
        let account = Account(context: context)
        account.id = UUID()
        account.name = name
        account.balance = balance
        account.date = Date()
        
        save(context: context)
    }
    
    //DeleteAccount
    func DeleteAccount(account: Account, context: NSManagedObjectContext){
        context.delete(account)
        do{
            try context.save()
        } catch {
            print("FAILED TO DELETE ACCOUNT")
        }
        
    }
 
    //LogOutcome
    func LogOutcome(account: Account, amount: Int64, context: NSManagedObjectContext){

        let log = Log(context: context)
        
        log.account = account
        log.account?.balance -= amount
        
        log.amount = amount
        log.date = Date()
        log.id = UUID()
        log.isOutcome = true

        save(context: context)
        
    }
    
    //LogIncome
    func LogIncome(account: Account, amount: Int64, context: NSManagedObjectContext){
        
        let log = Log(context: context)
        
        log.account = account
        log.account?.balance += amount
        
        log.amount = amount
        log.date = Date()
        log.id = UUID()
        log.isOutcome = false
        
        save(context: context)
    }

}
