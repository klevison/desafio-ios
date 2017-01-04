//
//  PullRequestTableViewCell.swift
//  desafio-ios
//
//  Created by Klevison Matias on 1/4/17.
//  Copyright © 2017 Arena. All rights reserved.
//

import UIKit

final class PullRequestTableViewCell: UITableViewCell {

    @IBOutlet weak var pullResquestTitleLabel: UILabel!
    
    
    var pullRequest: PullRequest? {
        didSet {
            if let title = pullRequest?.body {
                pullResquestTitleLabel.text = title
            }
        }
    }

}
