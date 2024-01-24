//
//  ImageDetailView.swift
//  GalleryApp
//
//  Created by Siarhei Anoshka on 24.01.24.
//

import UIKit

class ImageDetailView: UICollectionViewController {
    
    private let viewModel = ImageDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        hideTabBar()
    }
    
    // MARK: - SetupUI
    
    private func setupCollectionView() {
        collectionView.register(ImageDetailCell.self, forCellWithReuseIdentifier: ImageDetailCell.identifier)

    }
    
    private func hideTabBar() {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    // MARK: - Setup CollectionView data source
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageDetailCell.identifier, for: indexPath) as! ImageDetailCell
        return cell
    }
    
}

extension ImageDetailView: UICollectionViewDelegateFlowLayout {
    // swiftlint: disable line_length
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width,
                      height: view.safeAreaLayoutGuide.layoutFrame.height)
    }
    // swiftlint: enable line_length
    
}
