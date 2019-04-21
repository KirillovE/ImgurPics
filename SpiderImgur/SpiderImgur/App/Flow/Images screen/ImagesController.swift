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
        requestFactory.fetchImages(page: 0) { [weak self] imageResponse in
            self?.images = imageResponse.images
            self?.customView?.update()
        }
    }

}

extension ImagesController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showComments", sender: nil)
    }
    
}
