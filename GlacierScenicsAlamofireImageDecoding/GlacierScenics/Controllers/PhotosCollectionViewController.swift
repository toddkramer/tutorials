//
//  PhotosCollectionViewController.swift
//  GlacierScenics
//
//  Created by Todd Kramer on 1/30/16.
//  Copyright © 2016 Todd Kramer. All rights reserved.
//

import UIKit

private let photoCellIdentifier = "PhotoCell"

class PhotosCollectionViewController: UICollectionViewController {

    var photosManager: PhotosManager { return .shared }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    //MARK: - View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        registerCollectionViewCells()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        collectionView?.collectionViewLayout.invalidateLayout()
    }

    //MARK: - Collection View Setup

    func registerCollectionViewCells() {
        let nib = UINib(nibName: "PhotoCollectionViewCell", bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: photoCellIdentifier)
    }

    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosManager.photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCellIdentifier, for: indexPath) as! PhotoCollectionViewCell
        cell.configure(with: photo(at: indexPath))
        return cell
    }

    func photo(at indexPath: IndexPath) -> Photo {
        let photos = photosManager.photos
        return photos[indexPath.row]
    }

}

//MARK: - CollectionView Flow Layout

extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewSize = view.bounds.size
        let spacing: CGFloat = 0.5
        let width = (viewSize.width / 2) - spacing
        let height = (viewSize.width / 3) - spacing
        return CGSize(width: width, height: height)
    }

}
