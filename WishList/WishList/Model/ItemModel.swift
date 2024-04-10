//
//  ItemModel.swift
//  WishList
//
//  Created by Dongik Song on 4/10/24.
//

import Foundation

struct ItemModel: Codable {
    
    let id: Int
    let title: String
    let price: Int
    let discountPercentage: Double
    
}
