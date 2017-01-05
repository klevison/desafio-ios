//
//  Search.swift
//  desafio-ios
//
//  Created by Klevison Matias on 1/3/17.
//  Copyright © 2017 Arena. All rights reserved.
//

import Foundation
import ObjectMapper

class Search: Mappable {
    
    var total_count: Int?
    var repositories: [Repository]?
    var page: Int?
    var nextPage: Int?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        total_count <- map["total_count"]
        repositories <- map["items"]
    }
    
}
