//
//  Repositories.swift
//  desafio-ios
//
//  Created by Klevison Matias on 1/3/17.
//  Copyright © 2017 Arena. All rights reserved.
//

import Foundation
import ObjectMapper

struct Repositories: Mappable {
    
    var id: Int?
    var name: String?
    var full_name: [Repositories]?
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
