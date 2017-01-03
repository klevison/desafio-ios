//
//  GithubService.swift
//  desafio-ios
//
//  Created by Klevison Matias on 1/3/17.
//  Copyright © 2017 Arena. All rights reserved.
//

import Foundation
import Moya

enum Sort: String {
    case stars
    case forks
}

enum GithubService {
    case repositories(query: String, sort: Sort, page: Int)
}

extension GithubService: TargetType {
    
    var baseURL: URL { return URL(string: "https://api.github.com")! }
    
    var path: String {
        switch self {
        case .repositories:
            return "/search/repositories"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .repositories:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .repositories(let query, let sort, let page):
            return ["q": query, "sort": sort.rawValue, "page": page]
        }
    }
    
    var sampleData: Data { return Data() }
    
    var task: Task {
        switch self {
        case .repositories:
            return .request
        }
    }
    
}
