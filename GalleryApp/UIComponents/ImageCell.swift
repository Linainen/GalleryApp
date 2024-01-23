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
            ImageCell.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseInOut) {
                let url = self.photo.urls.small.asURL
                self.photoImageView.kf.setImage(with: url)
                self.likeButton.setImage(self.likeImage, for: .normal)
                self.layoutIfNeeded()
            }
        }
    }
    
    private var likeImage: UIImage? {
        return photo.likedByUser ? UIImage.likeImage : UIImage.dislikeImage
    }
    
    private let likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPhotoImageView()
        setupLikeButton()
        setupViewShadow()
    }
    
    private func setupPhotoImageView() {
        addSubview(photoImageView)
        photoImageView.clipsToBounds = true
        photoImageView.layer.cornerRadius = 8
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: self.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    @objc private func likeButtonTapped() {
        self.photo.likedByUser.toggle()
        self.likeButton.setImage(self.likeImage, for: .normal)
    }
    
    private func setupLikeButton() {
        addSubview(likeButton)
        likeButton.tintColor = .likeBtnColor
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            likeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            likeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
    }
    
    private func setupViewShadow() {
        self.layer.shadowRadius = 6
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
}
