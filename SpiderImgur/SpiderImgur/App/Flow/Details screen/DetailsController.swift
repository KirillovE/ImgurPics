//
//  DetailsController.swift
//  SpiderImgur
//
//  Created by Евгений Кириллов on 21/04/2019.
//  Copyright © 2019 Триада. All rights reserved.
//

import UIKit

final class DetailsController: UIViewController, DetailsDataSource {
    
    var imageDetails: [String: String] = [:]
    var comments: [Comment] = []
    var imageURL: URL?
    
    private var imageID: String?
    private let requestFactory = FactoryAssembler().assembleRequestFactory()
    private var customView: DetailsList? {
        return viewIfLoaded as? DetailsList
    }
    
    override func viewDidLoad() {
        super .viewDidLoad()
        loadComments()
    }
    
    private func loadComments() {
        guard let imageID = imageID else { return }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        requestFactory.fetchComments(forImage: imageID) { [weak self] commentResponse in
            self?.comments = commentResponse.data
            self?.customView?.update()
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
    
}

extension DetailsController {
    
    /// Настройка контроллера
    ///
    /// - Parameter model: Модель изображения для настройки
    func configure(withModel model: ImageViewModel) {
        imageDetails["Название"] = model.title
        imageDetails["Количество просмотров"] = String(model.views)
        imageDetails["Количество добавлений в избранное"] = String(model.favoriteCount)
        imageDetails["Количество комментариев"] = String(model.commentCount)
        
        guard let description = model.description else { return  }
        imageDetails["Описание"] = description
        
        imageURL = URL(string: model.address)
        imageID = model.id
    }
    
}
