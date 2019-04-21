//
//  DetailsView.swift
//  SpiderImgur
//
//  Created by Евгений Кириллов on 21/04/2019.
//  Copyright © 2019 Триада. All rights reserved.
//

import UIKit

final class DetailsView: UIView, DetailsList {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var listDataSource: DetailsDataSource?
    
    func update() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}
