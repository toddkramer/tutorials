//
//  PhotosDataSource.swift
//  GlacierScenics
//
//  Created by Todd Kramer on 2/20/16.
//  Copyright © 2016 Todd Kramer. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class PhotosDataSource: NSObject, ASCollectionDataSource {

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PhotosDataManager.sharedManager.allPhotos().count
    }
    
    func collectionView(collectionView: ASCollectionView, nodeForItemAtIndexPath indexPath: NSIndexPath) -> ASCellNode {
        let glacierScenic = glacierScenicAtIndex(indexPath)
        return PhotoCollectionViewCellNode(glacierScenic: glacierScenic)
    }
    
    func glacierScenicAtIndex(indexPath: NSIndexPath) -> GlacierScenic {
        let photos = PhotosDataManager.sharedManager.allPhotos()
        return photos[indexPath.row]
    }

}
