//
//  RealmFiller.swift
//  Habit Forming
//
//  Created by Joaquin Jacinto on 23/02/2019.
//  Copyright © 2019 Team Generics. All rights reserved.
//

import UIKit
import RealmSwift

class DBManager {
    private var realm: Realm
    static let db = DBManager()
    
    private init() {
        realm = try! Realm()
    }
    
    /*func getDataFromDB() -> Results<Item> {
        let results = Results<Route> = realm.objects(Item.self)
        return results
    }*/
    
    func clearAll() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func insert(object: Routine){
        try! realm.write {
            realm.add(object, update:true)

        }
    }
    
    func insert(object: Finished){
        try! realm.write {
            realm.add(object, update:true)
        }
    }
    
    func delete(object: Routine) {
        try! realm.write {
            realm.delete(object)
        }
    }
    
    func delete(object: Finished){
        try! realm.write {
            realm.delete(object)
        }
    }
    
    func getRoutines() -> Results<Routine>{
        return realm.objects(Routine.self)
    }
    
    func getFinished(rt: Routine) -> Results<Finished>{
        return realm.objects(Finished.self).filter("routine = %@", rt)
    }
    
    func countRoutines() -> Int{
        return realm.objects(Routine.self).count
    }
    
    func routineId() -> Int{
        return (realm.objects(Routine.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
    
    func finishedId() -> Int{
        return (realm.objects(Finished.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
}
