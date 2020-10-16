//
//  UsersViewController.swift
//  AssigmentCavista
//
//  Created by Sanjay Mali on 13/10/20.
//  Copyright © 2020 theappmaker. All rights reserved.
//

import UIKit
import RealmSwift
import JGProgressHUD
class UsersViewController: UIViewController {
    var userViewModels = [UserViewModel]()
    //  tableView creation
    let tableview: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.white
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    //  tableView setup, cell register with reuse Identifier
    func setupTableView() {
        tableview.register(UserCell.self, forCellReuseIdentifier: "cellId")
        view.addSubview(tableview)
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableview.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableview.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
    }
    @objc func didTapSort(){
        let realm = try! Realm()
        let user = realm.objects(Users.self)
        self.userViewModels = user.map({return UserViewModel(user: $0)}).sorted(by: { (v1, v2) -> Bool in
            return v1.type > v2.type
        })
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
        print("didTapSort")
    }
    /*
     Fetch Users from Server.
     Fetch data from Realm database If datas saved in database
     */
    fileprivate func fetchData() {
        let realm = try! Realm()
        let user = realm.objects(Users.self)
        if user.isEmpty{
            let hud = JGProgressHUD(style: .dark)
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            Service.shared.fetchUsers { (users, err) in
                if let err = err {
                    print("Failed to fetch courses:", err)
                    return
                }
//                self.userViewModels = user.map({return UserViewModel(user: $0)})
                self.userViewModels = user.map({return UserViewModel(user: $0)}).sorted(by: { (v1, v2) -> Bool in
                    return v1.type > v2.type
                })
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                    hud.dismiss()
                }
            }
        }
//        self.userViewModels = user.map({return UserViewModel(user: $0)})
        self.userViewModels = user.map({return UserViewModel(user: $0)}).sorted(by: { (v1, v2) -> Bool in
            return v1.type > v2.type
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Users"
        setupTableView()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableFooterView = UIView()
        fetchData()
    }
}
// MARK tableView datasource method
extension UsersViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  userViewModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! UserCell
        cell.backgroundColor = UIColor.white
        cell.userViewModel = userViewModels[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = UIView(frame:  CGRect(x: 0,y: 0,width: view.frame.width,height: 100))
//        header.backgroundColor = UIColor.gray
////        header.addSubview(sortButton)
//        sortButton.center = header.center
//        return header
//
//    }
}
// MARK tableView delegate method
extension UsersViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailUserViewController()
        vc.userdetails = userViewModels[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
