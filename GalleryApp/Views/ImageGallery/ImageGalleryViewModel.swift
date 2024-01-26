//
//  ImageGalleryViewModel.swift
//  GalleryApp
//
//  Created by Siarhei Anoshka on 23.01.24.
//

import Foundation

final class ImageGalleryViewModel: LikePhotoDelegate {
    
    var photos: Observable<[UnsplashPhoto]> = Observable([])
    
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
                    self.photos.value?.append(newPhoto)
                } else {
                    self.photos.value?.append($0)
                }
            }
        }
    }
    
    func checkLikedPhotos() {
        guard let array = photos.value else { return }
        for (index, photo) in array.enumerated() {
            var updatedPhoto = photo
            updatedPhoto.likedByUser = photoIds.contains(photo.id) ? true : false
            photos.value?[index] = updatedPhoto
        }
    }
    
    // MARK: - LikePhotoDelegate
    
    func deleteFromCoreData(photo: UnsplashPhoto?) {
        CoreDataManager.shared.deleteFromDatabase(photo: photo)
        self.checkLikedPhotos()
    }
    
    func saveToCoreData(photo: UnsplashPhoto?) {
        CoreDataManager.shared.saveNewPhotoToCoreData(photo)
        self.checkLikedPhotos()
    }
    
}
