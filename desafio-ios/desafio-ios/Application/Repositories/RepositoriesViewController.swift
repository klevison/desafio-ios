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

final class RepositoriesViewController: UITableViewController {
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    var viewModel: RepositoriesViewModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = nil
        viewModel = RepositoriesViewModel()
        
        rx.sentMessage(#selector(viewWillAppear))
            .map { _ in }
            .bindTo(viewModel.refreshTrigger)
            .addDisposableTo(disposeBag)
                
        viewModel.isLoading
            .drive(indicatorView.rx.isAnimating)
            .addDisposableTo(disposeBag)
        
        viewModel.data
            .bindTo(tableView.rx.items(cellIdentifier: "GithubRepositoriesCellID", cellType: RepositoriesTableViewCell.self)) { _, repository, cell in
                cell.repository = repository
            }.addDisposableTo(disposeBag)
        
        tableView.rx.reachedBottom
            .drive(viewModel.loadNextPageTrigger)
            .addDisposableTo(disposeBag)
    }
 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134
    }
    
    // MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pullRequestViewController = segue.destination as? PullRequestViewController {
            if let cell = sender as? RepositoriesTableViewCell {
                pullRequestViewController.repository = cell.repository
            }
        }
    }
    
}
