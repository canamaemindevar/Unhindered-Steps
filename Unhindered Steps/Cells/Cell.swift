//
//  Cell.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 4.06.2023.
//

import Foundation
import UIKit


class MyCell:  UICollectionViewCell {
    
    static let identier = "MyCell"
    
     let wordLabel: UILabel = {
        let sView = UILabel()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.font.withSize(10)
         sView.textAlignment = .center
         sView.numberOfLines = 0
        return sView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConts()
        addSubview(wordLabel)
        backgroundColor = .yellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConts() {
        
        wordLabel.frame = bounds
    }
}
