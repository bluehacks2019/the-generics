//
//  Routine.swift
//  Habit Forming
//
//  Created by Gink on 23/02/2019.
//  Copyright © 2019 Team Generics. All rights reserved.
//
import Foundation
import RealmSwift

class Routine: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var color = 1
    @objc dynamic var frequency = 1 //unknown
    @objc dynamic var duration = 1//minutes
    @objc dynamic var visibility = "Private"
    @objc dynamic var alarm = "Alert"
    @objc dynamic var lifetime = 1
    @objc dynamic var journalEnabled = false
    @objc dynamic var focusEnabled = true
    @objc dynamic var started:Date? = nil

    override static func primaryKey() -> String? {
        return "id"
    }
}
