//
//  Product.swift
//  favoriteButtonApp
//
//  Created by 山崎定知 on 2021/02/25.
//

import Foundation

class Product: NSObject {
    
    var name: String
    var like: Bool
    
    init(name: String, like: Bool) {
        self.name = name
        self.like = like
    }
}
