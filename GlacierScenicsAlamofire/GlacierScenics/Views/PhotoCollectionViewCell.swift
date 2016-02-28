//
//  PhotoCollectionViewCell.swift
//  GlacierScenics
//
//  Created by Todd Kramer on 1/30/16.
//  Copyright © 2016 Todd Kramer. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var captionLabel: UILabel!
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet var blurView: UIVisualEffectView!
    
    var request: Request?
    var glacierScenic: GlacierScenic!

    func configure(glacierScenic: GlacierScenic) {
        self.glacierScenic = glacierScenic
        reset()
        loadImage()
    }

    func reset() {
        imageView.image = nil
        request?.cancel()
        blurView.hidden = true
    }

    func loadImage() {
        if let image = PhotosDataManager.sharedManager.cachedImage(glacierScenic.photoURLString) {
            populateCell(image)
            return
        }
        loadingIndicator.startAnimating()
        downloadImage()
    }

    func downloadImage() {
        request = PhotosDataManager.sharedManager.getNetworkImage(glacierScenic.photoURLString, completion: { (image) -> Void in
            guard let image = image else { return }
            self.populateCell(image)
        })
    }

    func populateCell(image: UIImage) {
        loadingIndicator.stopAnimating()
        imageView.image = image
        captionLabel.text = glacierScenic.name
        blurView.hidden = false
    }

}
