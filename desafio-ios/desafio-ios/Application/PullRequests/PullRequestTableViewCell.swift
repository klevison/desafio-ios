//
//  PullRequestTableViewCell.swift
//  desafio-ios
//
//  Created by Klevison Matias on 1/4/17.
//  Copyright © 2017 Arena. All rights reserved.
//

import UIKit
import Haneke

final class PullRequestTableViewCell: UITableViewCell {

    @IBOutlet weak var pullResquestTitleLabel: UILabel!
    @IBOutlet weak var pullRequestBodyLabel: UILabel!
    @IBOutlet weak var avatarUserImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    
    var pullRequest: PullRequest? {
        didSet {
            if let body = pullRequest?.body {
                pullRequestBodyLabel.text = body
            }
            if let title = pullRequest?.title {
                pullResquestTitleLabel.text = title
            }
            if let owner = pullRequest?.owner, let userName = owner.login {
                userNameLabel.text = userName
            }
            if let urlString = pullRequest?.owner?.avatarURLString, let url = URL(string: urlString) {
                avatarUserImageView.hnk_setImage(from: url)
            }
        }
    }

}
