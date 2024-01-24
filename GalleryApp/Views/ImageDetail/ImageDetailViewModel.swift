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
    
    func updatePhotos() {
        CoreDataManager.shared.fetchCDImages()
        photos = CoreDataManager.shared.fetchUnsplashImages()
    }
}
