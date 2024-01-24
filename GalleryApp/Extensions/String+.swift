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
    
    var formattedDate: String? {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "MMM dd, yyyy"
        outputDateFormatter.locale = Locale(identifier: "en_us")
        if let inputDate = inputDateFormatter.date(from: self) {
            let outputDateString = outputDateFormatter.string(from: inputDate)
            return outputDateString
        } else {
            return nil
        }
    }
}
