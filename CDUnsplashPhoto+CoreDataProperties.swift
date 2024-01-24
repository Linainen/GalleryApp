//
//  CDUnsplashPhoto+CoreDataProperties.swift
//  GalleryApp
//
//  Created by Siarhei Anoshka on 24.01.24.
//
//

import Foundation
import CoreData

extension CDUnsplashPhoto {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUnsplashPhoto> {
        return NSFetchRequest<CDUnsplashPhoto>(entityName: "CDUnsplashPhoto")
    }

    @NSManaged public var id: String!
    @NSManaged public var createdAt: String!
    @NSManaged public var smallUrl: String!
    @NSManaged public var regularUrl: String!
    @NSManaged public var username: String!
    @NSManaged public var altDescription: String!
    @NSManaged public var likes: Int32

}

extension CDUnsplashPhoto: Identifiable {

}
