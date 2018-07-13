//
//  TagsCollectionViewCell.swift
//  HMFlickr
//
//  Created by Hayden Malcomson on 2018-07-12.
//  Copyright © 2018 Hayden Malcomson. All rights reserved.
//

import UIKit

class TagsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var specialisationCollectionView: UICollectionView!
    
    var tags: [String] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        let specialisationCell = UINib(nibName: "TagCell", bundle: nil)
        specialisationCollectionView.register(specialisationCell, forCellWithReuseIdentifier: "TagCell")
        specialisationCollectionView.delegate = self
        specialisationCollectionView.dataSource = self
        specialisationCollectionView.contentInset.left = 4
        specialisationCollectionView.contentInset.right = 4
    }
    
    func configureWith(tags: [String]){
        self.tags = tags
        specialisationCollectionView.reloadData()
    }
    
}

extension TagsCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as? TagCell {
            cell.configureWith(text: tags[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let heightDim = specialisationCollectionView.bounds.size.height
        let widthDim = tags[indexPath.row].getWidthBoundsForStringOfSize(fontSize: 20, heightDim: heightDim, horizontalPadding: 20).width
        return CGSize(width: widthDim, height: heightDim)
    }
    
}
