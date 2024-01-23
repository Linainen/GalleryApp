//
//  ImageGalleryView.swift
//  GalleryApp
//
//  Created by Siarhei Anoshka on 23.01.24.
//

import UIKit

class ImageGalleryView: UICollectionViewController {
    
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    private var unsplashPhotos: [UnsplashPhoto] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupNavBar()
        fillWithData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.layoutSubviews()
    }
        
    private func fillWithData() {
        NetworkManager.shared.fetchImages { [weak self] unsplashImages in
            guard let images = unsplashImages else { return }
            self?.unsplashPhotos = images
            self?.collectionView.reloadData()
        }
    }

    // MARK: - Setup UI
    
    private func setupCollectionView() {
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.identifier)
        collectionView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 0)
        collectionView.contentInsetAdjustmentBehavior = .automatic
    }
    
    private func setupNavBar() {
        let title = UILabel()
        title.text = "Photos"
        title.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        title.textColor = .navTitleColor
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: title)
    }
    
    // MARK: - Collection View delegates and data source

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return unsplashPhotos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photo = unsplashPhotos[indexPath.item]
        // swiftlint:disable:next force_cast
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier, for: indexPath) as! ImageCell
        cell.photo = photo
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastIndex = collectionView.numberOfItems(inSection: 0) - 1
        if indexPath.item == lastIndex {
            NetworkManager.shared.fetchImages { [weak self] unsplashImages in
                guard let images = unsplashImages else { return }
                self?.unsplashPhotos += images
                self?.collectionView.reloadData()
            }
        }
    }

}

extension ImageGalleryView: UICollectionViewDelegateFlowLayout {
    // swiftlint: disable line_length
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width / 3.5
        let height = view.frame.height / 6
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    // swiftlint: enable line_length
}
