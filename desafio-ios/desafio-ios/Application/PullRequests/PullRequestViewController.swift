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

final class PullRequestViewController: UITableViewController {
    
    var viewModel: PullRequestViewModel!
    var repository: Repository!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = nil
        viewModel = PullRequestViewModel(repository: repository)
        self.title = repository.name!
        setupTableView()
    }
    
    private func setupTableView() {
        
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
    
    // MARK: Table view delegate ;)
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 137
    }


}
