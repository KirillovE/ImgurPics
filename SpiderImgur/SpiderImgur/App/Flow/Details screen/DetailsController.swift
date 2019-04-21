//
//  DetailsController.swift
//  SpiderImgur
//
//  Created by Евгений Кириллов on 21/04/2019.
//  Copyright © 2019 Триада. All rights reserved.
//

import UIKit

final class DetailsController: UIViewController {
    
    /// Изображение для показа детальной информации
    var imageViewModel: ImageViewModel? {
        didSet {
            guard let model = imageViewModel else { return }
            details["Название"] = model.title
            details["Количество просмотров"] = String(model.views)
            details["Количество добавлений в избранное"] = String(model.favoriteCount)
            details["Количество комментариев"] = String(model.commentCount)
            
            guard let description = model.description else { return  }
            details["Описание"] = description
        }
    }
    
    private var details: [String: String] = [:]
}
