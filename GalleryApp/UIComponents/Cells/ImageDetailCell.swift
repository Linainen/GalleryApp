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
    var timer: Timer?
    var delegate: LikePhoto?
    var photoIndex: Int?
    
    var photo: UnsplashPhoto! {
        didSet {
            self.setupView()
        }
    }
    
    private var likes: Int {
        return photo.likedByUser ? photo.likes + 1 : photo.likes
    }
    
    private var likeImage: UIImage? {
        return photo.likedByUser ? UIImage.likeImage : UIImage.dislikeImage
    }
    
    private var likeTitle: String {
        return likes == 1 ? "like" : "likes"
    }
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let vStack: UIStackView = {
        let vstack = UIStackView()
        vstack.translatesAutoresizingMaskIntoConstraints = false
        vstack.axis = .vertical
        vstack.clipsToBounds = true
        vstack.spacing = 4
        vstack.alignment = .leading
        vstack.distribution = .equalSpacing
        vstack.layoutMargins = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6)
        vstack.isLayoutMarginsRelativeArrangement = true
        return vstack
    }()
    
    private let smallBottomVStack: UIStackView = {
        let vstack = UIStackView()
        vstack.translatesAutoresizingMaskIntoConstraints = false
        vstack.axis = .vertical
        vstack.clipsToBounds = true
        vstack.spacing = 0
        vstack.alignment = .leading
        vstack.distribution = .equalSpacing
        vstack.layoutMargins = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6)
        vstack.isLayoutMarginsRelativeArrangement = true
        return vstack
    }()
    
    private let smallTopVStack: UIStackView = {
        let vstack = UIStackView()
        vstack.translatesAutoresizingMaskIntoConstraints = false
        vstack.axis = .vertical
        vstack.clipsToBounds = true
        vstack.spacing = 12
        vstack.alignment = .leading
        vstack.distribution = .equalSpacing
        vstack.layoutMargins = UIEdgeInsets(top: 12, left: 6, bottom: 0, right: 6)
        vstack.isLayoutMarginsRelativeArrangement = true
        return vstack
    }()
    
    private let hStack: UIStackView = {
        let hstack = UIStackView()
        hstack.translatesAutoresizingMaskIntoConstraints = false
        hstack.axis = .horizontal
        hstack.clipsToBounds = true
        hstack.spacing = 12
        hstack.alignment = .center
        hstack.distribution = .equalCentering
        hstack.isLayoutMarginsRelativeArrangement = true
        return hstack
    }()
    
    private let likeButton: UIButton = {
        let btn = UIButton()
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let likeLabel: UILabel = {
        let lbl = UILabel()
        lbl.clipsToBounds = true
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let altDescriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.clipsToBounds = true
        lbl.numberOfLines = 3
        lbl.textColor = .descriptionTextColor
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let authorLabel: UILabel = {
        let lbl = UILabel()
        lbl.clipsToBounds = true
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .light)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let dateLabel: UILabel = {
        let lbl = UILabel()
        lbl.clipsToBounds = true
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .light)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupImageView()
        setupVStack()
        setupButton()
    }
    
    private func setupImageView() {
        addSubview(photoImageView)
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: self.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            photoImageView.heightAnchor.constraint(equalToConstant: self.frame.height * 0.8)
        ])
    }
    
    private func setupVStack() {
        addSubview(vStack)
        
        vStack.addArrangedSubview(smallTopVStack)
        vStack.addArrangedSubview(smallBottomVStack)
        hStack.addArrangedSubview(likeButton)
        hStack.addArrangedSubview(likeLabel)
        smallTopVStack.addArrangedSubview(hStack)
        smallTopVStack.addArrangedSubview(altDescriptionLabel)
        smallBottomVStack.addArrangedSubview(authorLabel)
        smallBottomVStack.addArrangedSubview(dateLabel)
        NSLayoutConstraint.activate([
            vStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            vStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            vStack.heightAnchor.constraint(equalToConstant: self.frame.height * 0.2)
        ])
    }
    
    private func setupView() {
        let url = photo.urls.regular.asURL
        self.photoImageView.kf.indicatorType = .activity
        self.photoImageView.kf.setImage(with: url, options: [.cacheOriginalImage])
        self.likeLabel.text = "\(likes) \(likeTitle)"
        self.altDescriptionLabel.text = photo.altDescription.capitalized
        self.authorLabel.text = "Author: \(photo.user.username)"
        self.likeButton.setBackgroundImage(self.likeImage, for: .normal)
        self.likeButton.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)
        self.dateLabel.text = "Posted on: \(photo.createdAt.formattedDate ?? "Unknown")"
    }
    
    private func setupButton() {
        self.likeButton.tintColor = .likeBtnColor
        NSLayoutConstraint.activate([
            likeButton.widthAnchor.constraint(equalToConstant: 32),
            likeButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc private func likeTapped() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { [weak self] _ in
            self?.photo.likedByUser.toggle()
            self?.delegate?.update(with: self?.photo, at: self?.photoIndex)
            if self?.photo?.likedByUser == true {
                self?.delegate?.saveToCoreData(photo: self?.photo)
            } else if self?.photo?.likedByUser == false {
                self?.delegate?.deleteFromCoreData(photo: self?.photo)
            }
            self?.likeButton.setImage(self?.likeImage, for: .normal)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
}
