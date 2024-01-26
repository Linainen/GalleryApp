//
//  LikedImagesViewModel.swift
//  GalleryApp
//
//  Created by Siarhei Anoshka on 24.01.24.
//

import Foundation

final class LikedImagesViewModel: LikePhotoDelegate {
    
    var photos: Observable<[UnsplashPhoto]> = Observable([])
    var noImages: Observable<Bool> = Observable(nil)
    
    func getPhotos() {
        CoreDataManager.shared.fetchCDImages()
        photos.value = CoreDataManager.shared.fetchUnsplashImages()
        self.checkNoImages()
    }
    
    func checkNoImages() {
        noImages.value = photos.value?.isEmpty
    }
    
    // MARK: - LikePhotoDelegate
    
    func deleteFromCoreData(photo: UnsplashPhoto?) {
        CoreDataManager.shared.deleteFromDatabase(photo: photo)
        self.getPhotos()
        self.checkNoImages()
    }
    
}
