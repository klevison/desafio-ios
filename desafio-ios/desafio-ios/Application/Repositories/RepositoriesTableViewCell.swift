//
//  RepositoriesTableViewCell.swift
//  desafio-ios
//
//  Created by Klevison Matias on 1/3/17.
//  Copyright © 2017 Arena. All rights reserved.
//

import UIKit
import Haneke

final class RepositoriesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var userAvatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    var repository: Repository? {
        didSet {
            if let name = repository?.name {
                repoNameLabel.text = name
            }
            if let repoDescription = repository?.repoDescription {
                descriptionLabel.text = repoDescription
            }
            if let forks = repository?.forks {
                forksLabel.text = "\(forks)"
            }
            if let stars = repository?.stars {
                starsLabel.text = "\(stars)"
            }
            if let login = repository?.owner?.login {
                usernameLabel.text = login
            }
            if let urlString = repository?.owner?.avatarURLString, let url = URL(string: urlString) {
                userAvatarImageView.hnk_setImage(from: url)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        userAvatarImageView.image = nil
    }
    
}
