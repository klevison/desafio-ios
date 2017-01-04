//
//  RepositoriesViewModel.swift
//  desafio-ios
//
//  Created by Klevison Matias on 1/3/17.
//  Copyright © 2017 Arena. All rights reserved.
//

import Foundation
import RxCocoa

final class RepositoriesViewModel {
    
    var searchResult: Driver<[Repository]>
    
    init() {
        searchResult = GithubService.search()
            .asDriver(onErrorRecover: { error in
                return Driver.just(.failure(error))
            }).flatMapLatest { result in
                switch result {
                case .success(let search):
                    if let repositories = search.repositories {
                        return Driver.just(repositories)
                    }
                    return Driver.just([Repository]())
                case .failure(_):
                    return Driver.just([Repository]())
                }
        }
    }
    
}
