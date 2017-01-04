//
//  PullRequest.swift
//  desafio-ios
//
//  Created by Klevison Matias on 1/4/17.
//  Copyright © 2017 Arena. All rights reserved.
//

import ObjectMapper

struct PullRequest: Mappable {
    
    var id: Int?
    var url: String?
    var body: String?
    var title: String?
    var owner: Owner?
    
    // MARK: JSON
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        url <- map["url"]
        body <- map["body"]
        title <- map["title"]
        owner <- map["user"]
    }
    
}
