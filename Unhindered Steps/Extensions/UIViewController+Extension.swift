//
//  UIViewController+Extension.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 8.10.2023.
//

import UIKit

extension UIViewController {
    func presentAlert(status: AlertImage, message: String) {
        let alertVC = CustomAlertViewController(status: status, message: message)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        present(alertVC, animated: true)
    }
}
