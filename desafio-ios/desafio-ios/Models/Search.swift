//
//  Search.swift
//  desafio-ios
//
//  Created by Klevison Matias on 1/3/17.
//  Copyright © 2017 Arena. All rights reserved.
//

import Foundation
import ObjectMapper

struct Search: Mappable {
    
    var total_count: Int?
    var incomplete_results: String?
    var repositories: [Repository]?
    
    init() {
    
    }
    
    // MARK: JSON
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        total_count <- map["total_count"]
        incomplete_results <- map["incomplete_results"]
        repositories <- map["items"]
    }
    
}
