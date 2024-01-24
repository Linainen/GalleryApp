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
    var timer: Timer?
    
    var photo: UnsplashPhoto! {
        didSet {
           let url = self.photo.urls.small.asURL
           self.userNameLabel.text = self.photo.user.username
           self.photoImageView.kf.indicatorType = .activity
           self.photoImageView.kf.setImage(with: url, options: [.cacheOriginalImage])
           self.likeButton.setImage(self.likeImage, for: .normal)
        }
    }
    
    var photoIndex: Int?
    var delegate: LikePhoto?
    
    private var likeImage: UIImage? {
        return photo.likedByUser ? UIImage.likeImage : UIImage.dislikeImage
    }
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.clipsToBounds = true
        stack.spacing = 4
        stack.alignment = .center
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return button
    }()
    
    private let userNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.clipsToBounds = true
        lbl.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 8, weight: .regular)
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPhotoImageView()
        setupViewShadow()
        setupStackView()
        setupLikeButton()
    }
    
    private func setupStackView() {
        addSubview(stackView)
        stackView.addArrangedSubview(userNameLabel)
        stackView.addArrangedSubview(likeButton)
        stackView.backgroundColor = .black.withAlphaComponent(0.5)
        stackView.layer.cornerRadius = 8
        stackView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 0),
            stackView.heightAnchor.constraint(equalTo: photoImageView.heightAnchor, multiplier: 0.17)
        ])
    }
    
    private func setupLikeButton() {
        likeButton.tintColor = .likeBtnColor
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
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
    
    // Set timer in order to forbid user to tap infinitely
    @objc private func likeButtonTapped() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] _ in
            self?.photo.likedByUser.toggle()
            self?.delegate?.update(with: self?.photo, at: self?.photoIndex)
            self?.likeButton.setImage(self?.likeImage, for: .normal)
        }
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
