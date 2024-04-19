//
//  DataModel.swift
//  WishList
//
//  Created by Dongik Song on 4/9/24.
//

import Foundation

struct DataModel: Codable {
    
    let id: Int
    let title: String
    let description: String
    let price: Int
    let discountPercentage: Double
    let images: [String]
    
}
