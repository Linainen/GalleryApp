//
//  ImageDetailViewModel.swift
//  GalleryApp
//
//  Created by Siarhei Anoshka on 24.01.24.
//

import UIKit
import Kingfisher

final class ImageDetailViewModel {
    
    var photos: [UnsplashPhoto] = []
    
    private var photoIds: [String] {
        CoreDataManager.shared.likedImagesIds
    }
    
    var scrollIndex: Int = 0
    
    func saveToImageGallery() {
        let indexPath = IndexPath(item: scrollIndex, section: 0)
        guard let imageURL = photos[indexPath.item].urls.regular.asURL else { return }
        let resourse = KF.ImageResource(downloadURL: imageURL)
        KingfisherManager.shared.retrieveImage(with: resourse, options: nil, progressBlock: nil, downloadTaskUpdated: nil) { result in
            switch result {
            case .success(let image):
                let normImage = image.image as UIImage
                UIImageWriteToSavedPhotosAlbum(normImage, nil, nil, nil)
            case .failure(_):
                return
            }
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
    
    private func checkLikedPhotos() {
        for (index, photo) in photos.enumerated() {
            var updatedPhoto = photo
            updatedPhoto.likedByUser = photoIds.contains(photo.id) ? true : false
            photos[index] = updatedPhoto
        }
    }
}
