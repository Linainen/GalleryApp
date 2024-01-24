//
//  ImageDetailView.swift
//  GalleryApp
//
//  Created by Siarhei Anoshka on 24.01.24.
//

import UIKit
import Kingfisher
import ProgressHUD

class ImageDetailView: UICollectionViewController {
    
    let viewModel = ImageDetailViewModel()
    var indexPath: IndexPath {
        IndexPath(item: viewModel.scrollIndex, section: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupNavBar()
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        RotationSettings.allowRotation = false
        hideTabBar()
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    // MARK: - SetupUI
    
    private func setupCollectionView() {
        collectionView.register(ImageDetailCell.self, forCellWithReuseIdentifier: ImageDetailCell.identifier)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    private func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(saveImgeToGallery))
        navigationController?.navigationBar.tintColor = .descriptionTextColor
    }
    
    private func hideTabBar() {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.layoutIfNeeded()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate { _ in
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    // MARK: - Save an image to the gallery
    
    @objc private func saveImgeToGallery() {
        viewModel.saveToImageGallery()
        ProgressHUD.showSucceed("Image saved!")
    }
    
    // MARK: - Setup CollectionView data source
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photo = self.viewModel.photos[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageDetailCell.identifier, for: indexPath) as! ImageDetailCell
        cell.photo = photo
        cell.photoIndex = indexPath.item
        return cell
    }
    
}

extension ImageDetailView: UICollectionViewDelegateFlowLayout {
    // swiftlint: disable line_length
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width, height: view.safeAreaLayoutGuide.layoutFrame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    // swiftlint: enable line_length
}
