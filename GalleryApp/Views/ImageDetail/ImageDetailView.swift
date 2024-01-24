//
//  ImageDetailView.swift
//  GalleryApp
//
//  Created by Siarhei Anoshka on 24.01.24.
//

import UIKit

class ImageDetailView: UICollectionViewController {
    
    let viewModel = ImageDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideTabBar()
        let indexPath = IndexPath(item: viewModel.scrollIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    // MARK: - SetupUI
    
    private func setupCollectionView() {
        collectionView.register(ImageDetailCell.self, forCellWithReuseIdentifier: ImageDetailCell.identifier)
        collectionView.isPagingEnabled = true
    }
    
    private func hideTabBar() {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.layoutIfNeeded()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    // MARK: - Setup CollectionView data source
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photo = self.viewModel.photos[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageDetailCell.identifier, for: indexPath) as! ImageDetailCell
        cell.photo = photo
        return cell
    }
    
}

extension ImageDetailView: UICollectionViewDelegateFlowLayout {
    // swiftlint: disable line_length
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width,
                      height: view.safeAreaLayoutGuide.layoutFrame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    // swiftlint: enable line_length
    
}
