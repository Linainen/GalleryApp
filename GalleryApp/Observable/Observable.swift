//
//  Observable.swift
//  GalleryApp
//
//  Created by Siarhei Anoshka on 25.01.24.
//

import Foundation

final class Observable<T> {
    
    var value: T? {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T?) {
        self.value = value
    }
    
    private var listener: ((T?) -> Void)?
    
    func bind(_ listener: @escaping (T?) -> Void) {
        listener(value)
        self.listener = listener
    }
    
}
