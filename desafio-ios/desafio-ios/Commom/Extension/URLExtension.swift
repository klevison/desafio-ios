//
//  URLExtension.swift
//  desafio-ios
//
//  Created by Klevison Matias on 1/4/17.
//  Copyright © 2017 Arena. All rights reserved.
//

import Foundation
import UIKit

extension URL {

    func open(options: [String : Any] = [:]) {
        if #available(iOS 10, *) {
            UIApplication.shared.open(self, completionHandler: nil)
        } else {
            UIApplication.shared.openURL(self)
        }
    }
    
}
