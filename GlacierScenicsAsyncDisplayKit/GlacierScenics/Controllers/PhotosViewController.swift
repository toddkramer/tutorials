//
//  PhotosCollectionViewController.swift
//  GlacierScenics
//
//  Created by Todd Kramer on 1/30/16.
//  Copyright © 2016 Todd Kramer. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class PhotosViewController: UIViewController {

    var collectionView: ASCollectionView!
    var photosDataSource = PhotosDataSource()
    
    //MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        
        coordinator.animateAlongsideTransition({ (context) -> Void in
            self.collectionView.frame.size = self.view.frame.size
            self.collectionView.reloadData()
            }, completion: nil)
    }
    
    //MARK: - Collection View

    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        collectionView = ASCollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.blackColor()
        collectionView.asyncDataSource = photosDataSource
        view.addSubview(collectionView)
        collectionView.reloadData()
    }
    
}
