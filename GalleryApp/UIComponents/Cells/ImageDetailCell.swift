//
//  ImageDetailCell.swift
//  GalleryApp
//
//  Created by Siarhei Anoshka on 24.01.24.
//

import UIKit
import Kingfisher

class ImageDetailCell: UICollectionViewCell {
    
    static let identifier = String(describing: ImageDetailCell.self)
    
    var photo: UnsplashPhoto! {
        didSet {
            let url = photo.urls.regular.asURL
            self.photoImageView.kf.indicatorType = .activity
            self.photoImageView.kf.setImage(with: url, options: [.cacheOriginalImage])
            
        }
    }
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
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
            photoImageView.heightAnchor.constraint(equalToConstant: self.frame.height * 0.5)
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
