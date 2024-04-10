//
//  AlertManager.swift
//  WishList
//
//  Created by Dongik Song on 4/11/24.
//

import Foundation
import UIKit

class AlertManager {
    
    func makingAlert (title: String, body: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: body, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        
        return alert
    }
}
