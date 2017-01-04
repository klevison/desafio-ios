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
    
    //Nome do repositório,
    //Descrição do Repositório,
    //Número de Stars,
    //Número de Forks
    
    var id: Int?
    var name: String?
    var repoDescription: String?
    var forks: Int?
    var stars: Int?
    var owner: Owner?
    
    // MARK: JSON
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        repoDescription <- map["description"]
        owner <- map["owner"]
        forks <- map["forks_count"]
        stars <- map["stargazers_count"]
    }
    
}
