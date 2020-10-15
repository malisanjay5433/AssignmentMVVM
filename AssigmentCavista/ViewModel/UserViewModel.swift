//
//  UserViewModel.swift
//  AssigmentCavista
//
//  Created by Sanjay Mali on 13/10/20.
//  Copyright © 2020 theappmaker. All rights reserved.
//

import Foundation
import UIKit

struct UserViewModel {
    let type: String
    let dateString: String
    let imageOrString:String
    // Dependency Injection (DI)
    init(user: Users) {
        self.type = user.type ?? ""
        self.dateString = user.date ?? ""
        if user.type == "text" {
            self.imageOrString = user.data ?? ""
        } else {
           self.imageOrString = user.data ?? ""
        }
        
    }
}
