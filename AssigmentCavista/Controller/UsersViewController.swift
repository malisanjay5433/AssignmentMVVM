//
//  UsersViewController.swift
//  AssigmentCavista
//
//  Created by Sanjay Mali on 13/10/20.
//  Copyright © 2020 theappmaker. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    var userViewModels = [UserViewModel]()
    //    tableView creation
    let tableview: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.white
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    // constraint for tableView
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
    fileprivate func fetchData() {
        Service.shared.fetchUsers { (users, err) in
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            self.userViewModels = users?.map({return UserViewModel(user: $0)}) ?? []
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Users"
        setupTableView()
        tableview.delegate = self
        tableview.dataSource = self
        fetchData()
        
    }
}
// MARK tableView datasource methid
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
}
// MARK tableView delegate methid
extension UsersViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailUserViewController()
        vc.userdetails = userViewModels[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if (segue.identifier == "DetailVC"){
//            guard let selectedPath = tableview.indexPathForSelectedRow else { return }
//            if let vc  = segue.destination as? DetailUserViewController {
//                vc.userdetails = userViewModels[selectedPath.row]
//            }
//        }
//    }
}
