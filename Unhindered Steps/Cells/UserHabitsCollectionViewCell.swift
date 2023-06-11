//
//  UserHabitsCollectionViewCell.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 2.05.2023.
//

import UIKit

class UserHabitsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "UserHabitsCollectionViewCell"
    

    
    //MARK: - Component
    private let image: UIImageView = {
        let sView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.contentMode = .scaleAspectFit
        sView.tintColor = .label
        return sView
    }()
    private let label: UILabel = {
        let sView = UILabel()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.font.withSize(20)
        sView.textColor = .label
        return sView
    }()
    
    //MARK: - Life cycle
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.prepare()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func config(image: String, string: String) {
        self.image.image = .init(systemName: image)
        
        self.label.text = string
    }
    
    //MARK: - Funcs
    
    private func prepare() {
        contentView.addSubview(image)
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            image.heightAnchor.constraint(equalToConstant: frame.height),
            image.widthAnchor.constraint(equalToConstant: frame.width)
        ])
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: image.centerXAnchor),
            label.topAnchor.constraint(equalTo: image.bottomAnchor)
        ])
    }
}


