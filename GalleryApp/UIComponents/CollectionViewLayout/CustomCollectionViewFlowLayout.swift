//
//  UICollectionViewFlowLayout.swift
//  GalleryApp
//
//  Created by Siarhei Anoshka on 24.01.24.
//

import UIKit

final class CustomCollectionViewFlowLayout {
    
    static let imageGalleryLayout: UICollectionViewFlowLayout = {
        let sectionInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = sectionInsets
        return layout
    }()
    
    static let likedImagesLayout: UICollectionViewFlowLayout = {
        let sectionInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = sectionInsets
        return layout
    }()

    static let imageDetailLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()
    
}
