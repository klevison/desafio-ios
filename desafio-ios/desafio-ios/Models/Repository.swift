//
//  Repositorie.swift
//  desafio-ios
//
//  Created by Klevison Matias on 1/3/17.
//  Copyright © 2017 Arena. All rights reserved.
//

import Foundation
import ObjectMapper

struct Repository: Mappable {
    
    var id: Int?
    var name: String?
    var full_name: String?
    var owner: Owner?
    
    // MARK: JSON
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        full_name <- map["full_name"]
        owner <- map["owner"]
    }
    
}


struct PullRequest: Mappable {
    
    var id: Int?
    var url: String?
    var body: String?
    
    // MARK: JSON
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        url <- map["url"]
        body <- map["body"]
    }
    
}
