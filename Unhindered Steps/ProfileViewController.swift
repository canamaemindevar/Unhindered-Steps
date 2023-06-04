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
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .monospacedDigitSystemFont(ofSize: 25, weight: .heavy)
        return label
    }()
    private let mailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    private let helperLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 20)
        label.textColor = .black
        label.text = "Yardımcın:"
        return label
    }()
    private let helperNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    private let helperMailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    private let profileStackview: UIStackView = {
        let sView = UIStackView()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.layer.cornerRadius = 5
        sView.axis = .vertical
        sView.distribution = .fillProportionally
        sView.alignment = .center
        return sView
    }()
    private let helperStackview: UIStackView = {
        let sView = UIStackView()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.layer.cornerRadius = 5
        sView.axis = .vertical
        sView.distribution = .fillProportionally
        sView.alignment = .center
        return sView
    }()
    
    private let dummyView: UIView = {
        let sView = UIView()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.layer.cornerRadius = 5
        sView.backgroundColor = .systemYellow
        return sView
    }()
    
    private let dummyView2: UIView = {
        let sView = UIView()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.layer.cornerRadius = 5
        sView.backgroundColor = .clear
        return sView
    }()
    private let mainCollectionView: UICollectionView = {
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
    
    private let updateMyInfoBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Kişisel Bilgilerimi Güncelle", for: .normal)
        button.setImage(.init(systemName: "person"), for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.setTitleColor(.label, for: .normal)
        
        return button
    }()
    
    private let updateHelperInfoBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Yardımcı Bilgilerimi Güncelle", for: .normal)
        button.setImage(.init(systemName: "person.2"), for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.setTitleColor(.label, for: .normal)
        return button
    }()
   

    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = .checkmark
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .label
        iv.image = UIImage(named: "wheelChair")
        return iv
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.view = self
        viewModel.viewDidLoad()
    }
    

    func prepare() {
        
        view.backgroundColor = .systemBackground
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        
        view.addSubview(dummyView)
        view.addSubview(dummyView2)
        view.addSubview(mainCollectionView)
        view.addSubview(updateMyInfoBtn)
        view.addSubview(updateHelperInfoBtn)
        view.addSubview(profileStackview)
     //   view.addSubview(helperStackview)
        view.addSubview(imageView)
        profileStackview.addArrangedSubview(nameLabel)
        profileStackview.addArrangedSubview(mailLabel)
//        helperStackview.addArrangedSubview(helperLabel)
//        helperStackview.addArrangedSubview(helperNameLabel)
//        helperStackview.addArrangedSubview(helperMailLabel)
        
        updateMyInfoBtn.addTarget(self, action:  #selector(seguToUserEdit), for: .touchUpInside)
        updateHelperInfoBtn.addTarget(self, action: #selector(segueToHelperEdit), for: .touchUpInside)
        let headerViewHeight = view.frame.height / 3.4
        let headerView2Height =  headerViewHeight / 2.5
        let width = view.frame.width / 3
        NSLayoutConstraint.activate([
          
            imageView.widthAnchor.constraint(equalToConstant: width),
            imageView.heightAnchor.constraint(equalToConstant: headerViewHeight / 1.5),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 4)
            
        ])

        NSLayoutConstraint.activate([
            profileStackview.centerYAnchor.constraint(equalTo: dummyView.centerYAnchor),
            profileStackview.centerXAnchor.constraint(equalTo: dummyView.centerXAnchor),
            profileStackview.widthAnchor.constraint(equalToConstant: width),
            profileStackview.heightAnchor.constraint(equalToConstant: headerViewHeight / 1.5)
        ])
//        NSLayoutConstraint.activate([
//
//            helperStackview.widthAnchor.constraint(equalToConstant: width),
//            helperStackview.heightAnchor.constraint(equalToConstant: headerViewHeight / 1.5),
//            view.trailingAnchor.constraint(equalTo: helperStackview.trailingAnchor),
//            helperStackview.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 7)
//
//        ])

        
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
            dummyView2.heightAnchor.constraint(equalToConstant: headerView2Height)
        ])
        NSLayoutConstraint.activate([
            mainCollectionView.leadingAnchor.constraint(equalTo: dummyView.leadingAnchor),
            mainCollectionView.topAnchor.constraint(equalTo: dummyView2.bottomAnchor),
            mainCollectionView.trailingAnchor.constraint(equalTo: dummyView.trailingAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            updateMyInfoBtn.leadingAnchor.constraint(equalTo: dummyView2.leadingAnchor, constant: 18),
            updateMyInfoBtn.topAnchor.constraint(equalTo: dummyView2.topAnchor, constant: 0),
            updateMyInfoBtn.bottomAnchor.constraint(equalTo: dummyView2.bottomAnchor, constant: 0),
            updateMyInfoBtn.widthAnchor.constraint(equalToConstant: view.frame.width / 2.5)
        ])
        NSLayoutConstraint.activate([
            updateHelperInfoBtn.trailingAnchor.constraint(equalTo: dummyView2.trailingAnchor, constant: -18),
            updateHelperInfoBtn.topAnchor.constraint(equalTo: dummyView2.topAnchor, constant: 0),
            updateHelperInfoBtn.bottomAnchor.constraint(equalTo: dummyView2.bottomAnchor, constant: 0),
            updateHelperInfoBtn.widthAnchor.constraint(equalToConstant: view.frame.width / 2.5)
        ])
        
    }
    
    func changeValues(name: String, mail: String, helperMail: String, helperName: String) {
        nameLabel.text = name
        mailLabel.text = mail
        helperMailLabel.text = helperMail
        helperNameLabel.text = helperName
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

            
            NetworkManager.shared.fetchRecentQueries(id: viewModel.user?.id ?? "") { response in
                switch response {
                case .success(let success):
                    DispatchQueue.main.async {
                        let vc = DetailViewController(array: success,user: self.viewModel.user ?? .init(id: "", username: "", mail: "", helperName: "", helperMail: "", helperPhone: ""))
                        vc.title = "Arama Geçmişi"
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                case .failure(let failure):
                    print(failure)
                }
            }

        case 1:
            //TODO: Favoriler
            print("Favoriler")

            NetworkManager.shared.fetchFavorites(id: viewModel.user?.id ?? "") { response in
                switch response {
                case .success(let success):
                    
                    DispatchQueue.main.async {
                        
                        let vc = DetailViewController(array: success, user: self.viewModel.user ?? .init(id: "", username: "", mail: "", helperName: "", helperMail: "", helperPhone: ""))
                        vc.title = "Favoriler"
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                case .failure(let failure):
                    print(failure)
                }
            }

        case 2:
            //MARK: Sık Kullanılanlar
            
            
            //TODO: change endppint
            print("Sık kullanılanlar")
            NetworkManager.shared.fetchFavorites(id: viewModel.user?.id ?? "") { response in
                switch response {
                case .success(let success):
                    
                    DispatchQueue.main.async {
                        var array: [FetchQueryResponseElement] = []
                        success.forEach { response in
                            array.append(response)
                        }
                        
                        let vc = DetailViewController(array: array , user: self.viewModel.user ?? .init(id: "", username: "", mail: "", helperName: "", helperMail: "", helperPhone: ""))
                        vc.title = "Sık kullanılanlar"
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                case .failure(let failure):
                    print(failure)
                }
            }
        case 3:
            CoreDataManager.shared.deleteCoreData(with: viewModel.user?.id ?? "")
            
           let vc = LoginViewController()
            self.view.window?.rootViewController = vc
            
           
            
        default:
            break
        }
    }
    
    @objc func segueToHelperEdit() {
        
        let vc = UpdateHelperViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func seguToUserEdit() {
        let vc = UpdateUserViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}



