//
//  ViewController.swift
//  HMFlickr
//
//  Created by Hayden Malcomson on 2018-07-12.
//  Copyright © 2018 Hayden Malcomson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        FlickrAPIService.getFlickrPublicFeed(completion: { (feedResponse, error) in
            print(feedResponse,error)
        })
    }



}

