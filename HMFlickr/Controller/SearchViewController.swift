/**
 Copyright (c) 2016-present, Facebook, Inc. All rights reserved.

 The examples provided by Facebook are for non-commercial testing and evaluation
 purposes only. Facebook reserves all rights not expressly granted.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 FACEBOOK BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
 ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

import IGListKit
import UIKit

final class SearchViewController: UIViewController {

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 3)
    }()
    
    var refresher: UIRefreshControl!
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var feed: FlickrPublicFeed?
    var searchTerm = ""
    let searchToken: NSNumber = 42
    var availableFeedObjects: [FlickrImageObject] = []
    
    var filteredFeedObjects: [FlickrImageObject] {
        return availableFeedObjects.filter({ (object) -> Bool in
            guard let tagArray = object.flickrImage.tagArray else { return false }
            var searchFieldFound = false
            tagArray.forEach({ (tag) in
                if tag.lowercased().contains(searchTerm.lowercased()) { searchFieldFound = true }
            })
            return searchFieldFound
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureRefresh()
        fetchData()
    }
    
    @objc func fetchData(){
        FlickrAPIService.getFlickrPublicFeed { [unowned self] (feed, error) in
            DispatchQueue.main.async {
                self.feed = feed
                self.refresher.endRefreshing()
                guard let feedToAssign = feed, let flickrImageItems = feedToAssign.items else { return }
                self.availableFeedObjects = flickrImageItems.sorted(by: { (image1, image2) -> Bool in
                    return image1.published > image2.published
                }).map({ (flickrImage) -> FlickrImageObject in
                    return FlickrImageObject(controllerClass: SearchViewController.self, flickrImage: flickrImage)
                })
                self.adapter.reloadData(completion: nil)
            }
        }
    }
    
    func configureCollectionView(){
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    
    func configureRefresh(){
        self.refresher = UIRefreshControl()
        refresher.tintColor = UIColor.black
        refresher.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        collectionView.addSubview(refresher)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .white
    }

}

extension SearchViewController: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        let objectsToShow = (searchTerm == "") ? availableFeedObjects : filteredFeedObjects
        print(objectsToShow)
        return [searchToken] + objectsToShow
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        guard let objectToAssign = object as? FlickrImageObject else {
            if let obj = object as? NSNumber, obj == searchToken {
                let sectionController = SearchSectionController()
                sectionController.delegate = self
                return sectionController
            }
            fatalError()
        }
        let flickrItemSectionController = FlickrItemSectionController()
        flickrItemSectionController.configureWith(flickrImage: objectToAssign.flickrImage)
        return flickrItemSectionController
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }

}

extension SearchViewController: SearchSectionControllerDelegate {
    
    func searchSectionController(_ sectionController: SearchSectionController, didChangeText text: String) {
        searchTerm = text
        adapter.performUpdates(animated: true, completion: nil)
    }
}

extension FlickrImageObject: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return self.uniqueID as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? FlickrImageObject else { return false }
        return controllerClass == object.controllerClass && controllerIdentifier == object.controllerIdentifier
    }
    
}
