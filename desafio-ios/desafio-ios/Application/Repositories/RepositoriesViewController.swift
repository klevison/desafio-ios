//
//  RepositoriesViewController.swift
//  desafio-ios
//
//  Created by Klevison Matias on 1/3/17.
//  Copyright © 2017 Arena. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class RepositoriesViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel: RepositoriesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = RepositoriesViewModel()
        viewModel.searchResult.drive(tableView.rx.items(cellIdentifier: "GithubRepositoriesCellID", cellType: UITableViewCell.self)) { row, repositorie, cell in
            cell.textLabel?.text = repositorie.full_name
        }.addDisposableTo(disposeBag)

    }
    
}
