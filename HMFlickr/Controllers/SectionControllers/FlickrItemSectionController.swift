//
//  FlickrItemSectionController.swift
//  HMFlickr
//
//  Created by Hayden Malcomson on 2018-07-12.
//  Copyright © 2018 Hayden Malcomson. All rights reserved.
//

import Foundation
import IGListKit

public let IMAGE_ASPECT_RATIO: CGFloat = 0.8

enum FlickrItemSectionItem {
    case header(flickrItem: FlickrImage)
    case image(image: URL?)
    case tags(tagsArray: [String])
}

final class FlickrItemSectionController: ListSectionController, UISearchBarDelegate, ListScrollDelegate {
    
    var flickrImage: FlickrImage!
    
    var flickrItemSectionDataSource: [FlickrItemSectionItem] = []
    
    func configureWith(flickrImage: FlickrImage){
        self.flickrImage = flickrImage
        self.flickrItemSectionDataSource = flickrImage.constructFlickrItemSectionDataSource()
    }
    
    override func numberOfItems() -> Int {
        return flickrItemSectionDataSource.count
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        switch flickrItemSectionDataSource[index] {
        case .header:
            return CGSize(width: collectionContext!.containerSize.width, height: 80)
        case .tags:
            return CGSize(width: collectionContext!.containerSize.width, height: 40)
        case .image:
            return CGSize(width: collectionContext!.containerSize.width, height: collectionContext!.containerSize.width * IMAGE_ASPECT_RATIO)
        }
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        switch flickrItemSectionDataSource[index] {
        case .image(let url):
            guard let cell = collectionContext?.dequeueReusableCell(of: ImageCell.self, for: self, at: index) as? ImageCell else {
                fatalError()
            }
            cell.setImage(url: url)
            return cell
        case .header(let flickrImage):
            let cell = collectionContext!.dequeueReusableCell(withNibName: "ImageHeaderCell", bundle: nil, for: self, at: index) as! ImageHeaderCell
            cell.configureWith(flickrImage: flickrImage)
            return cell
        case .tags(let tagArray):
            let cell = collectionContext!.dequeueReusableCell(withNibName: "TagsCollectionViewCell", bundle: nil, for: self, at: index) as! TagsCollectionViewCell
            cell.configureWith(tags: tagArray)
            return cell
        }
        
    }
    
    // MARK: ListScrollDelegate
    
    func listAdapter(_ listAdapter: ListAdapter, didScroll sectionController: ListSectionController) {}
    func listAdapter(_ listAdapter: ListAdapter, willBeginDragging sectionController: ListSectionController) {}
    func listAdapter(_ listAdapter: ListAdapter,
                     didEndDragging sectionController: ListSectionController,
                     willDecelerate decelerate: Bool) {}
    
}
