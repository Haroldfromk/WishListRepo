//
//  CoreManager.swift
//  WishList
//
//  Created by Dongik Song on 4/19/24.
//

import Foundation
import CoreData
import UIKit

class CoreManager {
    
    func saveData (model: DataModel, paramContext: NSManagedObjectContext) {
        
        let newItem = Lists(context: paramContext)
        newItem.id = Int64(model.id)
        newItem.title = model.title
        newItem.price = Int64(model.price)
        newItem.discountPercentage = model.discountPercentage
        
    }

}
