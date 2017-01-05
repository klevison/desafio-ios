//
//  RepositoriesViewModel.swift
//  desafio-ios
//
//  Created by Klevison Matias on 1/3/17.
//  Copyright © 2017 Arena. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Action

final class RepositoriesViewModel {
    
    let loadNextPageTrigger = PublishSubject<Void>()
    let refreshTrigger = PublishSubject<Void>()
    let isLoading: Driver<Bool>
    let data: Observable<[Repository]>
    private let action: Action<Int, Search>
    private let disposeBag = DisposeBag()
    
    init() {
        action = Action { page in
            return GithubAPI.search(page: page)
        }
        
        isLoading = action.executing.asDriver(onErrorJustReturn: false)
        data = action.elements
            .scan([]) { repositories, search in
                if let repos = search.repositories {
                    return search.page == 1 ? repos : repositories + repos
                } else {
                    return [Repository]()
                }
            }.startWith([])
        
        refreshTrigger
            .map { _ in 1 }
            .bindTo(action.inputs)
            .addDisposableTo(disposeBag)
        
        loadNextPageTrigger
            .withLatestFrom(action.elements)
            .flatMap { $0.nextPage.map { Observable.of($0) } ?? Observable.empty() }
            .bindTo(action.inputs)
            .addDisposableTo(disposeBag)

    }
    
}
