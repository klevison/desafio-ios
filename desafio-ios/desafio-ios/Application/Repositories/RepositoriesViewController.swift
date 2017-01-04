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

final class RepositoriesViewController: BaseViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var viewModel: RepositoriesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = RepositoriesViewModel()
        viewModel.searchResult.drive(tableView.rx.items(cellIdentifier: "GithubRepositoriesCellID", cellType: RepositoriesTableViewCell.self)) { row, repository, cell in
            cell.repository = repository
        }.addDisposableTo(disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            self?.performSegue(withIdentifier: "PullsSegueID", sender: self?.tableView.cellForRow(at: indexPath))
        }).addDisposableTo(disposeBag)
        
        tableView.rx.setDelegate(self)
            .addDisposableTo(disposeBag)
    }
    
    // MARK: Table view delegate ;)
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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
