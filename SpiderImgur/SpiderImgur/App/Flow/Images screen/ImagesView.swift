//
//  ImagesView.swift
//  SpiderImgur
//
//  Created by Евгений Кириллов on 21/04/2019.
//  Copyright © 2019 Триада. All rights reserved.
//

import UIKit

final class ImagesView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    private let reuseID = "ImagesCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        configureCollection()
    }
    
    private func configureCollection() {
        collectionView.register(UINib(nibName: "ImageCollectionCell", bundle: nil), forCellWithReuseIdentifier: reuseID)
        
        let spacing = CGFloat(11)
        let layout = UICollectionViewFlowLayout()
        let collectionWidth = collectionView.frame.width
        let itemWidth = collectionWidth / 2 - spacing / 2
        let itemHeight = itemWidth + 46
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
    }
    
}
