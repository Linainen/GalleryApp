//
//  TabBarView.swift
//  GalleryApp
//
//  Created by Siarhei Anoshka on 23.01.24.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }
    
    private func setupTabBar() {
        let galleryLayout = CustomCollectionViewFlowLayout.imageGalleryLayout
        let likedLayout = CustomCollectionViewFlowLayout.likedImagesLayout
        
        self.tabBar.backgroundColor = .white.withAlphaComponent(0.9)
        viewControllers = [
            createNavigationController(root: ImageGalleryView(collectionViewLayout: galleryLayout),
                                       title: "Photos",
                                       image: UIImage.photoImage),
            createNavigationController(root: LikedImagesView(collectionViewLayout: likedLayout),
                                       title: "Favorites",
                                       image: UIImage.likeImage)
        ]
    }
    
    private func createNavigationController(root: UIViewController, title: String, image: UIImage?) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: root)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        return navigationController
    }
    
}
