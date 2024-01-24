//
//  UIImage+.swift
//  GalleryApp
//
//  Created by Siarhei Anoshka on 23.01.24.
//

import UIKit

extension UIImage {
    static var likeImage: UIImage? {
        let image = UIImage(systemName: "heart.fill")
        return image
    }
    
    static var dislikeImage: UIImage? {
        let image = UIImage(systemName: "heart")
        return image
    }
    static var photoImage: UIImage? {
        let image = UIImage(systemName: "photo")
        return image
    }
}
