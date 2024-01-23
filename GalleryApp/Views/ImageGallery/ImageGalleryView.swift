//
//  ImageGalleryView.swift
//  GalleryApp
//
//  Created by Siarhei Anoshka on 23.01.24.
//

import UIKit

class ImageGalleryView: UICollectionViewController {
    
    private var unsplashPhotos: [UnsplashPhoto] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NetworkManager.shared.fetchImages { [weak self] unsplashImages in
            guard let images = unsplashImages else { return }
            self?.unsplashPhotos = images
            self?.collectionView.reloadData()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NetworkManager.shared.setPageToFirst()
    }
    
    // MARK: - Setup UI
    
    private func setupCollectionView() {
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.identifier)
    }
    
    private func setupNavBar() {
        let title = UILabel()
        let textColor = UIColor(red: 128 / 256, green: 127 / 256, blue: 127 / 256, alpha: 1)
        title.text = "Photos"
        title.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        title.textColor = textColor
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
