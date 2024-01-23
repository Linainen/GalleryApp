//
//  String+.swift
//  GalleryApp
//
//  Created by Siarhei Anoshka on 23.01.24.
//

import Foundation

extension String {
    var asURL: URL? {
        return URL(string: self)
    }
}
