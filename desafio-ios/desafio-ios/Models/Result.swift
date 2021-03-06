//
//  Result.swift
//  desafio-ios
//
//  Created by Klevison Matias on 1/3/17.
//  Copyright © 2017 Arena. All rights reserved.
//

import Foundation

enum APIResult<T> {
    
    case success(T)
    case failure(Error)
    
}
