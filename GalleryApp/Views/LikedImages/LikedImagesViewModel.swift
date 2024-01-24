//
//  LikedImagesViewModel.swift
//  GalleryApp
//
//  Created by Siarhei Anoshka on 24.01.24.
//

import Foundation

final class LikedImagesViewModel {
    
    var photos: [UnsplashPhoto] = []
    
    func getPhotos() {
        CoreDataManager.shared.fetchCDImages()
        photos = CoreDataManager.shared.fetchUnsplashImages()
    }
}