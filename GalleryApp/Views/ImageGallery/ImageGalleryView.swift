//
//  ImageGalleryView.swift
//  GalleryApp
//
//  Created by Siarhei Anoshka on 23.01.24.
//

import UIKit
import ProgressHUD

protocol LikePhoto {
    func update(with newPhoto: UnsplashPhoto?, at index: Int?)
    func saveToCoreData(photo: UnsplashPhoto?)
    func deleteFromCoreData(photo: UnsplashPhoto?)
}

extension LikePhoto {
    func update(with newPhoto: UnsplashPhoto?, at index: Int?) {}
    func saveToCoreData(photo: UnsplashPhoto?) {}
    func deleteFromCoreData(photo: UnsplashPhoto?) {}
}

class ImageGalleryView: UICollectionViewController {

    private var viewModel = ImageGalleryViewModel()
    private var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupNavBar()
        fillWithData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTabBar()
        viewModel.checkLikedPhotos()
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
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
        title.text = "Photos"
        title.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        title.textColor = .navTitleColor
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: title)
    }
    
    private func setupTabBar() {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Collection View delegates and data source

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
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastIndex = collectionView.numberOfItems(inSection: 0) - 1
        if indexPath.item == lastIndex {
            ProgressHUD.animationType = .circleRotateChase
            ProgressHUD.colorAnimation = .progressAnimationColor
            ProgressHUD.show()
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { [weak self] _ in
                self?.viewModel.getPhotos()
                DispatchQueue.main.async { [weak self] in
                    self?.collectionView.reloadData()
                    ProgressHUD.dismiss()
                }
            }
        }
    }

}

// MARK: - LikePhoto Protocol Delegates

extension ImageGalleryView: LikePhoto {

    func update(with newPhoto: UnsplashPhoto?, at index: Int?) {
        guard let photo = newPhoto, let index = index else { return }
        self.viewModel.photos[index].likedByUser = photo.likedByUser
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    func saveToCoreData(photo: UnsplashPhoto?) {
        guard let photo = photo else { return }
        CoreDataManager.shared.saveNewPhotoToCoreData(photo)
    }
    
    func deleteFromCoreData(photo: UnsplashPhoto?) {
        CoreDataManager.shared.deleteFromDatabase(photo: photo)
        self.viewModel.checkLikedPhotos()
        DispatchQueue.main.async { [weak self] in
            self?.collectionView?.reloadData()
        }
    }
    
}

extension ImageGalleryView: UICollectionViewDelegateFlowLayout {
    // swiftlint: disable line_length
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var width: CGFloat = 0
        var height: CGFloat = 0
        
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
