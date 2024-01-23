//
//  ImageCell.swift
//  GalleryApp
//
//  Created by Siarhei Anoshka on 23.01.24.
//

import UIKit
import Kingfisher

class ImageCell: UICollectionViewCell {
    
    static let identifier: String = String(describing: ImageCell.self)
    
    var photo: UnsplashPhoto! {
        didSet {
            let url = photo.urls.small.asURL
            photoImageView.kf.setImage(with: url)
            let image = photo.likedByUser ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            likeButton.setImage(image, for: .normal)
        }
    }
    
    private let likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPhotoImageView()
        setupLikeButton()
    }
    
    @objc private func likeTaped() {
        self.photo.likedByUser.toggle()
    }
    
    private func setupPhotoImageView() {
        addSubview(photoImageView)
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: self.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    @objc private func updateLikeButton() {
        self.photo.likedByUser.toggle()
        let image = photo.likedByUser ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        likeButton.setImage(image, for: .normal)
    }
    
    private func setupLikeButton() {
        addSubview(likeButton)
        likeButton.addTarget(self, action: #selector(updateLikeButton), for: .touchUpInside)
        NSLayoutConstraint.activate([
            likeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            likeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
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
