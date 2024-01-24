//
//  UnsplashPhoto.swift
//  GalleryApp
//
//  Created by Siarhei Anoshka on 23.01.24.
//

import Foundation

struct UnsplashPhoto: Decodable {
    let id: String
    let createdAt: String
    let altDescription: String
    let urls: URLS
    let likes: Int
    let user: User
    var likedByUser: Bool
}

struct User: Decodable {
    let username: String
}

struct URLS: Decodable {
    let regular: String
    let small: String
}
