//
//  ImageGalleryViewModel.swift
//  GalleryApp
//
//  Created by Siarhei Anoshka on 23.01.24.
//

import Foundation

protocol LikePhoto {
    func update(with newPhoto: UnsplashPhoto?, at index: Int?)
}

final class ImageGalleryViewModel {
    
    var photos: [UnsplashPhoto] = []
    
    func getPhotos() {
        NetworkManager.shared.fetchImages { [weak self] result in
            guard let images = result else { return }
            self?.photos += images
        }
    }
}
