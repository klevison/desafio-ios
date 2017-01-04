//
//  Owner.swift
//  desafio-ios
//
//  Created by Klevison Matias on 1/3/17.
//  Copyright © 2017 Arena. All rights reserved.
//

import Foundation
import ObjectMapper

struct Owner: Mappable {
    
    var id: Int!
    var login: String?
    
    // MARK: JSON
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        login <- map["login"]
    }
    
}
