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
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: 120,
                                 height: 200)
        
        self.tabBar.backgroundColor = .white.withAlphaComponent(0.9)
        viewControllers = [
            createNavigationController(root: ImageGalleryView(collectionViewLayout: layout),
                                       title: "Photos",
                                       image: UIImage(systemName: "photo")),
            createNavigationController(root: LikedImagesView(),
                                       title: "Favorite",
                                       image: UIImage(systemName: "heart.fill"))
        ]
    }
    
    private func createNavigationController(root: UIViewController, title: String, image: UIImage?) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: root)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        return navigationController
    }
    
}
