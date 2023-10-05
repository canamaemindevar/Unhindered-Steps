//
//  Cell.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 4.06.2023.
//

import Foundation
import UIKit

final class MyCell: UICollectionViewCell {
    static let identier = "MyCell"

    let wordLabel: UILabel = {
        let sView = UILabel()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.textAlignment = .center
        sView.numberOfLines = 0
        sView.textColor = .label
        sView.adjustsFontSizeToFitWidth = true
        return sView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConts()
        addSubview(wordLabel)
        backgroundColor = .secondarySystemFill
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConts() {
        contentView.addSubview(wordLabel)
        NSLayoutConstraint.activate([
            wordLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: wordLabel.trailingAnchor),
            bottomAnchor.constraint(equalTo: wordLabel.bottomAnchor),
            wordLabel.topAnchor.constraint(equalTo: topAnchor),
        ])
    }
}
