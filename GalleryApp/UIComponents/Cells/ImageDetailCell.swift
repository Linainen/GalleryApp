//
//  ImageDetailCell.swift
//  GalleryApp
//
//  Created by Siarhei Anoshka on 24.01.24.
//

import UIKit

class ImageDetailCell: UICollectionViewCell {
    
    static let identifier = String(describing: ImageDetailCell.self)
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupImageView()
    }
    
    private func setupImageView() {
        addSubview(photoImageView)
        photoImageView.image = UIImage(systemName: "photo")
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: self.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
}
