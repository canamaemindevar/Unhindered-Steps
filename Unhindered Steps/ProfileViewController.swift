//
//  ProfileViewController.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 30.04.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    private lazy var viewModel = ProfileViewModel()
    
    //MARK: - Components
    
    private let dummyView: UIView = {
        let sView = UIView()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.layer.cornerRadius = 5
        sView.backgroundColor = .cyan
        return sView
    }()
    
    private let dummyView2: UIView = {
        let sView = UIView()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.layer.cornerRadius = 5
        sView.backgroundColor = .yellow
        return sView
    }()
    let mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let size = UIScreen.main.bounds.width
        layout.itemSize = .init(width: size/2.2, height: size/2.2)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.layer.cornerRadius = 5
        collection.backgroundColor = .clear
        collection.register(UserHabitsCollectionViewCell.self, forCellWithReuseIdentifier: UserHabitsCollectionViewCell.identifier)
        return collection
    }()
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.view = self
        viewModel.viewDidLoad()
    }
    

    func prepare() {
        view.backgroundColor = .white
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        view.addSubview(dummyView)
        view.addSubview(dummyView2)
        view.addSubview(mainCollectionView)
        let headerViewHeight = view.frame.height / 3.4
        
        NSLayoutConstraint.activate([
            dummyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dummyView.topAnchor.constraint(equalTo: view.topAnchor),
            view.trailingAnchor.constraint(equalTo: dummyView.trailingAnchor),
            dummyView.heightAnchor.constraint(equalToConstant: headerViewHeight )
        ])
        NSLayoutConstraint.activate([
            dummyView2.leadingAnchor.constraint(equalTo: dummyView.leadingAnchor),
            dummyView2.topAnchor.constraint(equalTo: dummyView.bottomAnchor),
            dummyView2.trailingAnchor.constraint(equalTo: dummyView.trailingAnchor),
            dummyView2.heightAnchor.constraint(equalToConstant: headerViewHeight / 2.5)
        ])
        NSLayoutConstraint.activate([
            mainCollectionView.leadingAnchor.constraint(equalTo: dummyView.leadingAnchor),
            mainCollectionView.topAnchor.constraint(equalTo: dummyView2.bottomAnchor),
            mainCollectionView.trailingAnchor.constraint(equalTo: dummyView.trailingAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        
        
    }

}

//MARK: - CollectionView

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.userDataChoiceArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard   let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: UserHabitsCollectionViewCell.identifier, for: indexPath) as? UserHabitsCollectionViewCell else {
            return UICollectionViewCell()
        }
        let indexPath = viewModel.userDataChoiceArr[indexPath.row]
        cell.config(image:  indexPath.name, string: indexPath.string)
        
        return cell
    }
    
    
}

extension ProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            // TODO: Arama geçmişi
            print("Arama Geçmişi")
        case 1:
            //TODO: Favoriler
            print("Favoriler")
        case 2:
            //MARK: Sık Kullanılanlar
            print("Sık kullanılanlar")
        default:
            break
        }
    }
}



struct MockUser {
    var name = "Ali Can"
    var mail = "alican@gmail.com"
    var helperName = "Veli Can"
    var helperPhone = "911"
}


