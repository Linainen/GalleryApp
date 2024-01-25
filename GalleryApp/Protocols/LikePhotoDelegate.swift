//
//  LikePhotoProtocol.swift
//  GalleryApp
//
//  Created by Siarhei Anoshka on 25.01.24.
//

import Foundation

protocol LikePhotoDelegate: AnyObject {
    func saveToCoreData(photo: UnsplashPhoto?)
    func deleteFromCoreData(photo: UnsplashPhoto?)
}

extension LikePhotoDelegate {
    func saveToCoreData(photo: UnsplashPhoto?) {}
    func deleteFromCoreData(photo: UnsplashPhoto?) {}
}
