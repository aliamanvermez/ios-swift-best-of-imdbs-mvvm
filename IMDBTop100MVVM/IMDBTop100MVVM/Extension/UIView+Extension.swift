//
//  UIView+Extension.swift
//  IMDBTop100MVVM
//
//  Created by Ali Amanvermez on 2.04.2023.
//

import Foundation
import UIKit.UIView

extension UIView{
    func addSubviews(_ views: UIView...){
        views.forEach({
            addSubview($0)
        })
    }
}
