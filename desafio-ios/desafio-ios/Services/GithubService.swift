//
//  GithubService.swift
//  desafio-ios
//
//  Created by Klevison Matias on 1/3/17.
//  Copyright © 2017 Arena. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Result
import Moya_ObjectMapper

enum Sort: String {
    case stars
    case forks
}

enum GithubService {
    case repositories(query: String, sort: Sort, page: Int)
    case pullRequests(repository: Repository)
}


extension GithubService: TargetType {
    
    var baseURL: URL { return URL(string: "https://api.github.com")! }
    
    var path: String {
        switch self {
            case .repositories:
                return "/search/repositories"
            case .pullRequests(let repository):
                return "/repos/\(repository.owner!.login!)/\(repository.name!)/pulls"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .repositories, .pullRequests:
                return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
            case .repositories(let query, let sort, let page):
                return ["q": query, "sort": sort.rawValue, "page": page]
            case .pullRequests:
                return nil
        }
    }
    
    var sampleData: Data { return Data() }
    
    var task: Task {
        switch self {
            case .repositories, .pullRequests:
                return .request
        }
    }
    
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
    
    static func search() -> Observable<APIResult<Search>> {
        
        return Observable.create({ (observer: AnyObserver<APIResult<Search>>) -> Disposable in
            
            let provider = MoyaProvider<GithubService>()
            provider.request(.repositories(query: "language:Java", sort: .stars, page: 1), completion: { result in
                switch result {
                    case let .success(response):
                        do {
                            let search = try response.mapObject(Search.self)
                            observer.on(.next(.success(search)))
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
