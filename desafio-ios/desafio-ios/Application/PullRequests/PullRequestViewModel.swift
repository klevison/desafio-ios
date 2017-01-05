//
//  PullRequestViewModel.swift
//  desafio-ios
//
//  Created by Klevison Matias on 1/3/17.
//  Copyright © 2017 Arena. All rights reserved.
//

import RxCocoa

final class PullRequestViewModel {
    
    var data: Driver<[PullRequest]>
    
    init(repository: Repository) {
        data = GithubAPI.pulls(repository: repository)
            .asDriver(onErrorRecover: { error in
                return Driver.just(.failure(error))
            }).flatMapLatest { result in
                switch result {
                case .success(let pulls):
                    return Driver.just(pulls)
                case .failure(_):
                    return Driver.just([PullRequest]())
                }
        }
        
    }
    
}

