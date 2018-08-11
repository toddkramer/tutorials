//
//  PhotoCollectionViewCell.swift
//  GlacierScenics
//
//  Created by Todd Kramer on 1/30/16. Updated 8/11/18.
//  Copyright © 2018 Todd Kramer. All rights reserved.
//

import UIKit
import Alamofire

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var captionLabel: UILabel!
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!

    weak var photosManager: PhotosManager?
    var request: Request?
    var photo: Photo!

    func configure(with photo: Photo, photosManager: PhotosManager) {
        self.photo = photo
        self.photosManager = photosManager
        reset()
        loadImage()
    }

    func reset() {
        imageView.image = nil
        request?.cancel()
        captionLabel.isHidden = true
    }

    func loadImage() {
        if let image = photosManager?.cachedImage(for: photo.url) {
            populate(with: image)
            return
        }
        downloadImage()
    }

    func downloadImage() {
        loadingIndicator.startAnimating()
        request = photosManager?.retrieveImage(for: photo.url) { image in
            self.populate(with: image)
        }
    }

    func populate(with image: UIImage) {
        loadingIndicator.stopAnimating()
        imageView.image = image
        captionLabel.text = photo.name
        captionLabel.isHidden = false
    }

}
