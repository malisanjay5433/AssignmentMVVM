//
//  Service.swift
//  AssigmentCavista
//
//  Created by Sanjay Mali on 13/10/20.
//  Copyright © 2020 theappmaker. All rights reserved.
//

import Foundation
import RealmSwift
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
                let users = try JSONDecoder().decode([Users].self, from: data)
                do {
                    let realm = try Realm()
                    realm.beginWrite()
                    for x in users {
                        let user = Users()
                        user.date = x.date
                        user.data = x.data
                        user.id = x.id
                        user.type = x.type
                        realm.add(user, update: Realm.UpdatePolicy.modified)
                    }
                    try! realm.commitWrite()
                    print("Successfully Saved in Realm.....")
                } catch {
                    print(error.localizedDescription)
                }
                
                DispatchQueue.main.async {
                    completion(users, nil)
                    print()
                }
            } catch let jsonErr {
                print("Failed to decode:", jsonErr)
            }
        }.resume()
    }
}
