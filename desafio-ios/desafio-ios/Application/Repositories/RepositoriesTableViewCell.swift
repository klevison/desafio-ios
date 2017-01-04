//
//  RepositoriesTableViewCell.swift
//  desafio-ios
//
//  Created by Klevison Matias on 1/3/17.
//  Copyright © 2017 Arena. All rights reserved.
//

import UIKit

final class RepositoriesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var repoNameLabel: UILabel!
    
    var repository: Repository? {
        didSet {
            if let fullName = repository?.full_name {
                repoNameLabel.text = fullName
            }
        }
    }
    
}
