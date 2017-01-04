//
//  PullRequestsViewController.swift
//  desafio-ios
//
//  Created by Klevison Matias on 1/3/17.
//  Copyright © 2017 Arena. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class PullRequestViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: PullRequestViewModel!
    var repository: Repository!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = PullRequestViewModel(repository: repository)
        
        viewModel.data.drive(tableView.rx.items(cellIdentifier: "PullRequestCellID", cellType: PullRequestTableViewCell.self)) { row, pullrequest, cell in
            cell.pullRequest = pullrequest
        }.addDisposableTo(disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            let cell = self?.tableView.cellForRow(at: indexPath) as! PullRequestTableViewCell
            let pullRequest = cell.pullRequest
            if let urlString = pullRequest?.url, let url = URL(string: urlString) {
                url.open()
            }
        }).addDisposableTo(disposeBag)
    
    }

}
