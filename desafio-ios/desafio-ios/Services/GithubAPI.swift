//
//  GithubAPI.swift
//  desafio-ios
//
//  Created by Klevison Matias on 1/5/17.
//  Copyright © 2017 Arena. All rights reserved.
//

import Foundation
import RxSwift
import Moya_ObjectMapper
import Moya

struct GithubAPI {
    
    static func pulls(repository: Repository) -> Observable<APIResult<[PullRequest]>> {
        
        return Observable.create({ (observer: AnyObserver<APIResult<[PullRequest]>>) -> Disposable in
            
            let provider = MoyaProvider<GithubService>()
            provider.request(.pullRequests(repository: repository), completion: { result in
                switch result {
                case let .success(response):
                    do {
                        let pulls = try response.mapArray(PullRequest.self)
                        observer.on(.next(.success(pulls)))
                        observer.on(.completed)
                    } catch {
                        observer.on(.error(error))
                    }
                case let .failure(error):
                    observer.on(.error(error))
                }
            })
            
            return Disposables.create()
        })
        
    }
    
    static func search(page: Int) -> Observable<Search> {
        
        return Observable.create({ (observer: AnyObserver<Search>) -> Disposable in
            
            let provider = MoyaProvider<GithubService>()
            provider.request(.repositories(query: "language:Java", sort: .stars, page: page), completion: { result in
                switch result {
                case let .success(response):
                    do {
                        let search = try response.mapObject(Search.self)
                        
                        if let urlResponse = response.response as? HTTPURLResponse {
                            let nextURI = urlResponse.findLink(relation: "next")?.uri
                            let queryItems = nextURI.flatMap(URLComponents.init)?.queryItems
                            let nextPage = queryItems?
                                .filter { $0.name == "page" }
                                .flatMap { $0.value }
                                .flatMap { Int($0) }
                                .first
                            
                            search.nextPage = nextPage
                            search.page = page
                        }
                        observer.on(.next(search))
                        observer.on(.completed)
                    } catch {
                        observer.on(.error(error))
                    }
                case let .failure(error):
                    observer.on(.error(error))
                }
            })
            
            return Disposables.create()
        })
        
    }
    
}
