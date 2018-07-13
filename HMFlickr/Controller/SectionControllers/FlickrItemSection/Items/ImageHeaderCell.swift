//
//  ImageHeaderCell.swift
//  HMFlickr
//
//  Created by Hayden Malcomson on 2018-07-12.
//  Copyright © 2018 Hayden Malcomson. All rights reserved.
//

import UIKit

class ImageHeaderCell: UICollectionViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureWith(flickrImage: FlickrImage){
        self.authorLabel.text = flickrImage.author
    }

}
