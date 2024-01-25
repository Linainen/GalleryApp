//
//  ImageGalleryViewModel.swift
//  GalleryApp
//
//  Created by Siarhei Anoshka on 23.01.24.
//

import Foundation

final class ImageGalleryViewModel {
    
    var photos: [UnsplashPhoto] = []
    
    private var photoIds: [String] {
        CoreDataManager.shared.likedImagesIds
    }
    
    func getPhotos() {
        CoreDataManager.shared.fetchCDImages()
        NetworkManager.shared.fetchImages { [weak self] result in
            guard let images = result, let self = self else { return }
            images.forEach {
                if self.photoIds.contains($0.id) {
                    var newPhoto = $0
                    newPhoto.likedByUser = true
                    self.photos.append(newPhoto)
                } else {
                    self.photos.append($0)
                }
            }
        }
    }
    
    func checkLikedPhotos() {
        for (index, photo) in photos.enumerated() {
            var updatedPhoto = photo
            updatedPhoto.likedByUser = photoIds.contains(photo.id) ? true : false
            photos[index] = updatedPhoto
        }
    }
    
    func deleteFromCoreData(_ photo: UnsplashPhoto?) {
        CoreDataManager.shared.deleteFromDatabase(photo: photo)
        self.checkLikedPhotos()
    }
    
    func saveToCoreData(_ photo: UnsplashPhoto?) {
        CoreDataManager.shared.saveNewPhotoToCoreData(photo)
        self.checkLikedPhotos()
    }
}
