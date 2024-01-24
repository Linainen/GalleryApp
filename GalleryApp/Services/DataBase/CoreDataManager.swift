//
//  CoreDataManager.swift
//  GalleryApp
//
//  Created by Siarhei Anoshka on 23.01.24.
//

import UIKit
import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var likedImagesIds: [String] {
        var array: [String] = []
        images.forEach {
            array.append($0.id)
        }
        return array
    }
    
    private var images: [CDUnsplashPhoto] = []
//    {
//        didSet {
//            self.updateImagesIds()
//        }
//    }
    
    func fetchCDImages() {
        do {
            let request = CDUnsplashPhoto.fetchRequest() as NSFetchRequest<CDUnsplashPhoto>
            self.images = try context.fetch(request)
        } catch {
            fatalError("CoreData crash")
        }
    }
    
    func fetchUnsplashImages() -> [UnsplashPhoto] {
        var images: [UnsplashPhoto] = []
        self.images.forEach {
            let newPhoto = self.convertToUnsplashPhoto($0)
            images.append(newPhoto)
        }
        return images
    }
    
    func deleteFromDatabase(photo: UnsplashPhoto?) {
        guard let photo = photo else { return }
        images.forEach {
            if $0.id == photo.id {
                self.context.delete($0)
                self.saveContext()
                self.fetchCDImages()
            }
        }
    }
    
    func saveNewPhotoToCoreData(_ photo: UnsplashPhoto) {
        let likedPhoto = CDUnsplashPhoto(context: self.context)
        likedPhoto.id = photo.id
        likedPhoto.altDescription = photo.altDescription
        likedPhoto.createdAt = photo.createdAt
        likedPhoto.likes = Int32(photo.likes)
        likedPhoto.username = photo.user.username
        likedPhoto.regularUrl = photo.urls.regular
        likedPhoto.smallUrl = photo.urls.small
        self.saveContext()
        self.fetchCDImages()
    }
    
    private func convertToUnsplashPhoto(_ photo: CDUnsplashPhoto) -> UnsplashPhoto {
        let user = User(username: photo.username)
        let urls = URLS(regular: photo.regularUrl,
                        small: photo.smallUrl)
        let newPhoto = UnsplashPhoto(
            id: photo.id,
            createdAt: photo.createdAt,
            altDescription: photo.altDescription,
            urls: urls,
            likes: Int(photo.likes),
            user: user,
            likedByUser: true
        )
        return newPhoto
    }
    
//    private func updateImagesIds() {
//        self.likedImagesIds.removeAll()
//        images.forEach { [weak self] in
//            self?.likedImagesIds.append($0.id)
//        }
//    }
    
    private func saveContext() {
        do {
            try self.context.save()
        } catch {
            fatalError("Error saving context")
        }
    }
}
