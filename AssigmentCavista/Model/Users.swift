//
//  Users.swift
//  AssigmentCavista
//
//  Created by Sanjay Mali on 13/10/20.
//  Copyright © 2020 theappmaker. All rights reserved.
//

import Foundation
import RealmSwift
class Users:Object,Codable{
    @objc dynamic var id:String?
    @objc dynamic var type:String?
    @objc dynamic var date:String?
    @objc dynamic var data:String?
   
    override static func primaryKey() -> String? {
        return "id"
    }
}
