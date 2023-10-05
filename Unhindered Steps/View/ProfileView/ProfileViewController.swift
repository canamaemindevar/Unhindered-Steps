//
//  ProfileViewController.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 30.04.2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    private lazy var viewModel = ProfileViewModel()

    var id: String = ""

    var networkManager: FavoritesFetchable & RecentQueriesFetchable & MostlyUsedFetchable

    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Components

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
        label.text = "yourHelper:".localized
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
        sView.backgroundColor = .systemRed
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
        layout.itemSize = .init(width: size / 2.2, height: size / 2.2)
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
        button.setTitle("updatePersonalInformation".localized, for: .normal)
        button.setImage(.init(systemName: "person"), for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.setTitleColor(.label, for: .normal)

        return button
    }()

    private let updateHelperInfoBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("updateHelperInformation".localized, for: .normal)
        button.setImage(.init(systemName: "person.2"), for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.setTitleColor(.label, for: .normal)
        return button
    }()

    private let imageView: UIImageView = {
        let iView = UIImageView()
        iView.translatesAutoresizingMaskIntoConstraints = false
        iView.contentMode = .scaleAspectFit
        iView.tintColor = .label
        iView.backgroundColor = .white
        iView.image = UIImage(named: "wheelChair")
        return iView
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.view = self
        viewModel.viewDidLoad()
    }

    override func viewDidAppear(_: Bool) {
        viewModel.viewDidAppear()
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
        view.addSubview(imageView)
        profileStackview.addArrangedSubview(nameLabel)
        profileStackview.addArrangedSubview(mailLabel)
        updateMyInfoBtn.addTarget(self, action: #selector(seguToUserEdit), for: .touchUpInside)
        updateHelperInfoBtn.addTarget(self, action: #selector(segueToHelperEdit), for: .touchUpInside)
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 120 / 2
        setupConstraints()
    }

    func setupConstraints() {
        let headerViewHeight = view.frame.height / 3.4
        let headerView2Height = headerViewHeight / 2.5
        let width = view.frame.width / 3
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 120),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 10),

        ])
        NSLayoutConstraint.activate([
            profileStackview.centerYAnchor.constraint(equalTo: dummyView.centerYAnchor),
            profileStackview.centerXAnchor.constraint(equalTo: dummyView.centerXAnchor),
            profileStackview.widthAnchor.constraint(equalToConstant: width * 2),
            profileStackview.heightAnchor.constraint(equalToConstant: headerViewHeight / 1.5),
        ])

        NSLayoutConstraint.activate([
            dummyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dummyView.topAnchor.constraint(equalTo: view.topAnchor),
            view.trailingAnchor.constraint(equalTo: dummyView.trailingAnchor),
            dummyView.heightAnchor.constraint(equalToConstant: headerViewHeight),
        ])
        NSLayoutConstraint.activate([
            dummyView2.leadingAnchor.constraint(equalTo: dummyView.leadingAnchor),
            dummyView2.topAnchor.constraint(equalTo: dummyView.bottomAnchor),
            dummyView2.trailingAnchor.constraint(equalTo: dummyView.trailingAnchor),
            dummyView2.heightAnchor.constraint(equalToConstant: headerView2Height),
        ])
        NSLayoutConstraint.activate([
            mainCollectionView.leadingAnchor.constraint(equalTo: dummyView.leadingAnchor),
            mainCollectionView.topAnchor.constraint(equalTo: dummyView2.bottomAnchor),
            mainCollectionView.trailingAnchor.constraint(equalTo: dummyView.trailingAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        NSLayoutConstraint.activate([
            updateMyInfoBtn.leadingAnchor.constraint(equalTo: dummyView2.leadingAnchor, constant: 18),
            updateMyInfoBtn.topAnchor.constraint(equalTo: dummyView2.topAnchor, constant: 0),
            updateMyInfoBtn.bottomAnchor.constraint(equalTo: dummyView2.bottomAnchor, constant: 0),
            updateMyInfoBtn.widthAnchor.constraint(equalToConstant: view.frame.width / 2.5),
        ])
        NSLayoutConstraint.activate([
            updateHelperInfoBtn.trailingAnchor.constraint(equalTo: dummyView2.trailingAnchor, constant: -18),
            updateHelperInfoBtn.topAnchor.constraint(equalTo: dummyView2.topAnchor, constant: 0),
            updateHelperInfoBtn.bottomAnchor.constraint(equalTo: dummyView2.bottomAnchor, constant: 0),
            updateHelperInfoBtn.widthAnchor.constraint(equalToConstant: view.frame.width / 2.5),
        ])
    }

    func changeValues(id: String, name: String, mail: String, helperMail: String, helperName: String) {
        nameLabel.text = name
        mailLabel.text = mail
        helperMailLabel.text = helperMail
        helperNameLabel.text = helperName
        self.id = id
    }
}

// MARK: - CollectionView

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        viewModel.userDataChoiceArr.count
    }

    func collectionView(_: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: UserHabitsCollectionViewCell.identifier, for: indexPath) as? UserHabitsCollectionViewCell else {
            return UICollectionViewCell()
        }
        let indexPath = viewModel.userDataChoiceArr[indexPath.row]
        cell.config(image: indexPath.name, string: indexPath.string)

        return cell
    }
}

extension ProfileViewController: UICollectionViewDelegate {
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            networkManager.fetchRecentQueries(id: viewModel.user?.id ?? "") { response in
                switch response {
                case let .success(success):
                    DispatchQueue.main.async {
                        let targetVc = DetailViewController(array: success, user: self.viewModel.user ?? .init(id: "", username: "", mail: "", helperName: "", helperMail: "", helperPhone: ""))
                        targetVc.title = "searchHistory".localized
                        self.navigationController?.pushViewController(targetVc, animated: true)
                    }
                case let .failure(failure):
                    print(failure)
                }
            }
        case 1:
            networkManager.fetchFavorites(id: viewModel.user?.id ?? "") { response in
                switch response {
                case let .success(success):
                    DispatchQueue.main.async {
                        let targetVc = DetailViewController(array: success, user: self.viewModel.user ?? .init(id: "", username: "", mail: "", helperName: "", helperMail: "", helperPhone: ""))
                        targetVc.title = "favorites".localized
                        self.navigationController?.pushViewController(targetVc, animated: true)
                    }
                case let .failure(failure):
                    print(failure)
                }
            }
        case 2:
            networkManager.fetchMostlyUsed(id: id) { response in
                switch response {
                case let .success(success):
                    DispatchQueue.main.async {
                        let targetVc = DetailViewController(array: success, user: self.viewModel.user ?? .init(id: "", username: "", mail: "", helperName: "", helperMail: "", helperPhone: ""))
                        targetVc.title = "mostlyUsed".localized
                        self.navigationController?.pushViewController(targetVc, animated: true)
                    }
                case let .failure(failure):
                    print(failure)
                }
            }
        case 3:
            CoreDataManager.shared.deleteCoreData(with: viewModel.user?.id ?? "")

            let targetVc = LoginViewController()
            view.window?.rootViewController = targetVc
        default:
            break
        }
    }

    @objc func segueToHelperEdit() {
        let targetVc = UpdateHelperViewController()
        targetVc.id = id
        targetVc.mail = mailLabel.text ?? ""
        targetVc.username = nameLabel.text ?? ""
        navigationController?.pushViewController(targetVc, animated: true)
    }

    @objc func seguToUserEdit() {
        let targetVc = UpdateUserViewController()
        targetVc.id = id
        targetVc.helperMail = viewModel.user?.helperMail ?? ""
        targetVc.helperName = viewModel.user?.helperName ?? ""
        targetVc.helperPhone = viewModel.user?.helperPhone ?? ""
        targetVc.username = nameLabel.text ?? ""
        navigationController?.pushViewController(targetVc, animated: true)
    }
}
