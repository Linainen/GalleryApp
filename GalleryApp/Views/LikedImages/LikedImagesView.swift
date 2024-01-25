//
//  LikedImagesView.swift
//  GalleryApp
//
//  Created by Siarhei Anoshka on 23.01.24.
//

import UIKit
import ProgressHUD
import Kingfisher

class LikedImagesView: UICollectionViewController {
    
    private var viewModel = LikedImagesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        fillWithData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupRotationSettings()
        setupTabBar()
        fillWithData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if viewModel.checkNoImages() {
            ProgressHUD.colorBannerTitle = .descriptionTextColor
            ProgressHUD.colorAnimation = .likeBtnColor
            ProgressHUD.showError("Empty", image: .noImages, interaction: true, delay: 1.5)
        }
    }
    
    // MARK: - Layout settings
    
    private func setupUI() {
        setupRotationSettings()
        setupCollectionView()
        setupNavBar()
        setupTabBar()
    }
    
    private func setupRotationSettings() {
        RotationSettings.allowRotation = true
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
    
    // MARK: - Fill collection view with data
    
    private func fillWithData() {
        viewModel.getPhotos()
        DispatchQueue.main.async { [weak self] in
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
        title.text = "Favorites"
        title.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        title.textColor = .navTitleColor
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: title)
    }
    
    private func setupTabBar() {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Setup Collection View Delegates and Data Source
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photo = viewModel.photos[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier, for: indexPath) as! ImageCell
        cell.delegate = self
        cell.photoIndex = indexPath.item
        cell.photo = photo
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let layout = CustomCollectionViewFlowLayout.imageDetailLayout
        let imageDetailVC = ImageDetailView(collectionViewLayout: layout)
        imageDetailVC.viewModel.photos = self.viewModel.photos
        imageDetailVC.viewModel.scrollIndex = indexPath.item
        navigationController?.pushViewController(imageDetailVC, animated: true)
    }

}

    // MARK: - LikePhoto protocol implementation

extension LikedImagesView: LikePhotoDelegate {
    
    func deleteFromCoreData(photo: UnsplashPhoto?) {
        self.viewModel.deleteFromCoreData(photo: photo)
        self.fillWithData()
    }
    
}

    // MARK: - UICollectionViewDelegateFlowLayout

extension LikedImagesView: UICollectionViewDelegateFlowLayout {
    // swiftlint: disable line_length
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var width: CGFloat = .zero
        var height: CGFloat = .zero
        
        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            width = view.frame.width / 3.5
            height = view.frame.height / 6
        } else if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .compact {
            width = view.frame.width / 6
            height = view.frame.height / 3.5
        } else if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .compact {
            width = view.frame.width / 6
            height = view.frame.height / 4
        } else {
            width = view.frame.width / 6
            height = view.frame.height / 5
        }
        
        return CGSize(width: width, height: height)
    }
    // swiftlint: enable line_length
}
