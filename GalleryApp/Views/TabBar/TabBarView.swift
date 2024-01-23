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
        
        let sectionInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = sectionInsets
        
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
