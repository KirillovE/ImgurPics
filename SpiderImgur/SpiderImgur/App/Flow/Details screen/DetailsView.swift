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
    
    private let reuseID = "CommentCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        setImage()
    }
    
    func update() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func setImage() {
        guard let url = listDataSource?.imageURL else { return }
        imageView.af_setImage(withURL: url)
    }
    
}

extension DetailsView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Детальная информация"
        case 1:
            return "Комментарии"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return listDataSource?.imageDetails.count ?? 0
        case 1:
            return listDataSource?.comments.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseID) else { return UITableViewCell() }
        
        switch indexPath.section {
        case 0:
            let detail = listDataSource?.imageDetails.dropFirst(indexPath.row).first
            cell.textLabel?.text = detail?.value
            cell.detailTextLabel?.text = detail?.key
        case 1:
            let comment = listDataSource?.comments[indexPath.row]
            cell.textLabel?.text = comment?.comment
            cell.detailTextLabel?.text = comment?.author
        default:
            break
        }
        
        return cell
    }
}
