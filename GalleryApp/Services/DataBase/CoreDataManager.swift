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
    
    private var likedImagesIds: [String] = []
    var images: [UnsplashPhoto] = []
    
    func fetchCDImages() {
        
    }
    
    func convertToUnsplashPhoto() {
        
    }
    
    func convertToCDUnsplashPhoto() {
        
    }
    
    func updateImages() {
        
    }
    
    func updateImagesIds() {
        
    }
}
