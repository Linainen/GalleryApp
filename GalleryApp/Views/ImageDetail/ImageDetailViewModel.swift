//
//  ImageDetailViewModel.swift
//  GalleryApp
//
//  Created by Siarhei Anoshka on 24.01.24.
//

import UIKit
import Kingfisher

final class ImageDetailViewModel: LikePhotoDelegate {
    
    var photos: Observable<[UnsplashPhoto]> = Observable([])
    
    private var photoIds: [String] {
        CoreDataManager.shared.likedImagesIds
    }
    
    var scrollIndex: Int = 0
    
    func saveToImageGallery() {
        let indexPath = IndexPath(item: scrollIndex, section: 0)
        guard let imageURL = photos.value?[indexPath.item].urls.regular.asURL else { return }
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
    
    func deleteFromCoreData(photo: UnsplashPhoto?) {
        CoreDataManager.shared.deleteFromDatabase(photo: photo)
        self.checkLikedPhotos()
    }
    
    func saveToCoreData(photo: UnsplashPhoto?) {
        CoreDataManager.shared.saveNewPhotoToCoreData(photo)
        self.checkLikedPhotos()
    }
    
    private func checkLikedPhotos() {
        guard let array = photos.value else { return }
        for (index, photo) in array.enumerated() {
            var updatedPhoto = photo
            updatedPhoto.likedByUser = photoIds.contains(photo.id) ? true : false
            photos.value?[index] = updatedPhoto
        }
    }
}
