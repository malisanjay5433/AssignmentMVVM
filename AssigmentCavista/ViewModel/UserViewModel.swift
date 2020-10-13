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
    let data: String
    let detailTextString: String
    let accessoryType: UITableViewCell.AccessoryType
    let dateString: String
    
    // Dependency Injection (DI)
    init(user: Users) {
        self.data = user.type ?? ""
        self.dateString = user.date ?? ""
        if user.type == "text" {
            detailTextString = "CheckOut Text Type Feed"
            accessoryType = .none
        } else {
            detailTextString = "CheckOut Photo Type Feed"
            accessoryType = .detailDisclosureButton
        }
    }
    
}
