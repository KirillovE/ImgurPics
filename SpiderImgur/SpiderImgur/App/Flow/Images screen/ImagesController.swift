//
//  ImagesController.swift
//  SpiderImgur
//
//  Created by Евгений Кириллов on 20/04/2019.
//  Copyright © 2019 Триада. All rights reserved.
//

import UIKit

final class ImagesController: UIViewController, ImagesDataSource {
    
    var images = [ImageViewModel]()
    private var nextPage = 0
    private let requestFactory = FactoryAssembler().assembleRequestFactory()
    private var customView: ImageList? {
        return viewIfLoaded as? ImageList
    }
    
    override func viewDidLoad() {
        customView?.listDataSource = self
        loadImages()
        super.viewDidLoad()
    }
    
    private func loadImages() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        requestFactory.fetchImages(page: nextPage) { [weak self] imageResponse in
            self?.images.append(contentsOf: imageResponse.images)
            self?.customView?.update()
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }

}

extension ImagesController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showComments", sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let imagesBeforeLoadingNext = images.count - 15
        if indexPath.row == imagesBeforeLoadingNext {
            nextPage += 1
            loadImages()
        }
    }
    
}
