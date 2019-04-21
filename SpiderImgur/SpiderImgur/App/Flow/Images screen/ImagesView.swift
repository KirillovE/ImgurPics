//
//  ImagesView.swift
//  SpiderImgur
//
//  Created by Евгений Кириллов on 21/04/2019.
//  Copyright © 2019 Триада. All rights reserved.
//

import AlamofireImage

final class ImagesView: UIView, ImageList {
    
    @IBOutlet weak var collectionView: UICollectionView!
    weak var listDataSource: ImagesDataSource?
    private let reuseID = "ImageCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCollection()
    }
    
    func update() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    private func configureCollection() {
        collectionView.register(UINib(nibName: "ImageCollectionCell", bundle: nil), forCellWithReuseIdentifier: reuseID)
        
        let spacing = CGFloat(11)
        let layout = UICollectionViewFlowLayout()
        let collectionWidth = collectionView.frame.width
        let itemWidth = collectionWidth / 2 - spacing / 2
        let itemHeight = itemWidth + 50
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
    }
    
}

extension ImagesView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return listDataSource?.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: reuseID, for: indexPath)
                as? ImageCollectionCell,
            let imageViewModel = listDataSource?.images[indexPath.row],
            let imageURL = URL(string: imageViewModel.address)
            else {
                return UICollectionViewCell()
        }
        
        let placeholderImage = UIImage(named: "logo")
        cell.imageView.af_setImage(withURL: imageURL, placeholderImage: placeholderImage)
        cell.titleLabel.text = imageViewModel.title
        
        return cell
    }
}
