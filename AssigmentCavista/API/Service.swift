//
//  Service.swift
//  AssigmentCavista
//
//  Created by Sanjay Mali on 13/10/20.
//  Copyright © 2020 theappmaker. All rights reserved.
//

import Foundation
//import UIKit
class Service: NSObject {
    static let shared = Service()
    func fetchUsers(completion: @escaping ([Users]?, Error?) -> ()) {
        let urlString = "https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/challenge.json"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                print("Failed to fetch courses:", err)
                return
            }
            // check response
            guard let data = data else { return }
            do {
                let courses = try JSONDecoder().decode([Users].self, from: data)
                DispatchQueue.main.async {
                    completion(courses, nil)
                }
            } catch let jsonErr {
                print("Failed to decode:", jsonErr)
            }
            }.resume()
    }
}
