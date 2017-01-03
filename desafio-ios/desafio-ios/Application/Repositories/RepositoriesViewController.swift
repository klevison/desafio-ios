//
//  RepositoriesViewController.swift
//  desafio-ios
//
//  Created by Klevison Matias on 1/3/17.
//  Copyright © 2017 Arena. All rights reserved.
//

import UIKit
import Moya_ObjectMapper
import Moya

final class RepositoriesViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let provider = RxMoyaProvider<GithubService>()
        provider.request(.repositories(query: "language:Java", sort: .stars, page: 1))
            .mapObject(Search.self)
            .subscribe { event -> Void in
                print(event)
            }.addDisposableTo(disposeBag)
    
    }
    
}
