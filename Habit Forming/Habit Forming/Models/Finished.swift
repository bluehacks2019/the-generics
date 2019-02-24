//
//  Finished.swift
//  Habit Forming
//
//  Created by Gink on 23/02/2019.
//  Copyright © 2019 Team Generics. All rights reserved.
//

import Foundation
import RealmSwift

class Finished: Object {
    @objc dynamic var id = 0
    @objc dynamic var routine:Routine?
    @objc dynamic var done:Date? = nil
    @objc dynamic var journal = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
