//
//  MakingImageView.swift
//  WishList
//
//  Created by Dongik Song on 4/11/24.
//

import Foundation
import UIKit

class MakingImageView {
    
    func makingImage (list: [DataModel], scrollView: UIScrollView) {
        for i in 0 ..< list[0].images.count - 1 {
            
            let imageView = UIImageView()
            let xPos = scrollView.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPos, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
            imageView.load(url: URL(string: list[0].images[i])!)
            scrollView.addSubview(imageView)
            scrollView.contentSize.width = imageView.frame.width * CGFloat(i + 1)
            
        }
    }
}
