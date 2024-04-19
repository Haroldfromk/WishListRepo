//
//  MakingImageView.swift
//  WishList
//
//  Created by Dongik Song on 4/11/24.
//

import Foundation
import UIKit

class MakingImageView {
    
    func makingImage (list: DataModel, scrollView: UIScrollView) {
        
        for i in 0 ..< list.images.count - 1 {
            
            let imageView = UIImageView()
            guard let url = URL(string: list.images[i]) else { return }
            // url처리 하던것을 Extension에서 URLSession으로 변경 -> Thread Checker warning 해결.
            URLSession.shared.dataTask(with: url) {
                (data, response, error) in
                if let error {
                    print(error)
                }
                guard let imageData = data else { return }
                DispatchQueue.main.async {
                    imageView.image = UIImage(data: imageData)
                }
            }.resume()
            
            let xPos = scrollView.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPos, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)

            scrollView.addSubview(imageView)
            scrollView.contentSize.width = imageView.frame.width * CGFloat(i + 1)
            
        }
    }
}
