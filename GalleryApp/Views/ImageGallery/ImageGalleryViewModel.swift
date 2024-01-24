//
//  ImageGalleryViewModel.swift
//  GalleryApp
//
//  Created by Siarhei Anoshka on 23.01.24.
//

import Foundation

final class ImageGalleryViewModel {
    
    var photos: [UnsplashPhoto] = []
    var photoIds: [String] {
        CoreDataManager.shared.fetchCDImages()
        return CoreDataManager.shared.likedImagesIds
    }
    
    func getPhotos() {
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
            if photoIds.contains(photo.id) {
                var updatedPhoto = photo
                updatedPhoto.likedByUser = true
                photos[index] = updatedPhoto
            }
        }
    }
}
