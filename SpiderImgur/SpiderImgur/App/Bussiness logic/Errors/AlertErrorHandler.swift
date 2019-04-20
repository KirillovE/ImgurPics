//
//  AlertErrorHandler.swift
//  SpiderImgur
//
//  Created by Евгений Кириллов on 20/04/2019.
//  Copyright © 2019 Триада. All rights reserved.
//

import UIKit

/// Обработчик, выводящий ошибки в виде графического предупреждения
struct AlertErrorHandler: AbstractErrorHandler {
    
    func handle(_ error: Error) {
        DispatchQueue.main.async {
            guard let host = self.getTopController() else { return }
            
            let errorMessage = self.getErrorMesage(error)
            let alert = self.getAlert(with: errorMessage)
            
            host.present(alert, animated: true)
        }
    }
    
    private func getTopController() -> UIViewController? {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedController = topController.presentedViewController {
                topController = presentedController
            }
            return topController
        } else {
            return nil
        }
    }
    
    private func getErrorMesage(_ error: Error) -> String {
        if let appError = error as? AppError {
            return "Произошла " + appError.rawValue.lowercased()
        } else {
            return "Произошла неизвестная ошибка"
        }
    }
    
    private func getAlert(with text: String) -> UIAlertController {
        let alert = UIAlertController(title: "Ошибка", message: text, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(okButton)
        
        return alert
    }
    
}
