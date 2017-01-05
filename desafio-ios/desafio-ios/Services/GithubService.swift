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
import Alamofire
import WebLinking

enum Sort: String {
    case stars
    case forks
}

enum GithubService {
    case repositories(query: String, sort: Sort, page: Int)
    case pullRequests(repository: Repository)
}

extension GithubService: TargetType {
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
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
}
