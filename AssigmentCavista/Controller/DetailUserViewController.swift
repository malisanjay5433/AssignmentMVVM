//
//  DetailUserViewController.swift
//  AssigmentCavista
//
//  Created by Sanjay Mali on 14/10/20.
//  Copyright © 2020 theappmaker. All rights reserved.
//

import UIKit
import SDWebImage
class DetailUserViewController: UIViewController {
    var userdetails:UserViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setupView()
    }
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
//    Creation of discription label
    let descriptionLable: UILabel = {
        let label = UILabel()
        label.text = "Day 1"
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
//    Creation of date label
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Day 1"
        label.textColor = UIColor.orange
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
//    Creation of ImageView 
    let descriptionImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
// Set up all the constraints required for the label and images.
//  populate details.
    private func setupView() {
        self.view.addSubview(cellView)
        self.cellView.addSubview(dateLabel)
         NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.view.topAnchor, constant:0),
            cellView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0),
            cellView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant:0),
            cellView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        dateLabel.anchor(top:cellView.topAnchor,left: cellView.leftAnchor,right: cellView.rightAnchor,paddingTop:100,paddingLeft: 16,paddingRight: 16)
        dateLabel.text = "Date : \(userdetails?.dateString ?? "")"
        if userdetails?.type.lowercased() == "text" {
            cellView.addSubview(descriptionLable)
            descriptionLable.anchor(top:cellView.topAnchor,left: cellView.leftAnchor,right: cellView.rightAnchor,paddingTop:125,paddingLeft: 16,paddingRight: 16)
            descriptionLable.text = userdetails?.imageOrString
        }
        else if userdetails?.type.lowercased() == "image"{
            cellView.addSubview(descriptionImage)
            descriptionImage.anchor(top:cellView.topAnchor,left: cellView.leftAnchor,bottom:cellView.bottomAnchor, right: cellView.rightAnchor,paddingTop:130, paddingLeft: 16, paddingBottom:200,paddingRight: 16)
//            descriptionImage.sd_setImage(with:URL(string:userdetails?.imageOrString ?? "")
//            descriptionImage.sd_setImage(with:URL(string:userdetails?.imageOrString, placeholderImage: UIImage(named:"download"), options:nil,completed: nil))
            descriptionImage.sd_setImage(with: URL(string:userdetails!.imageOrString), placeholderImage: UIImage(named: "download"))
        }
    }
}
