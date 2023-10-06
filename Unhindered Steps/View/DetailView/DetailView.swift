//
//  DetailView.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 3.05.2023.
//

import UIKit

final class DetailView: UIViewController {
    private lazy var viewModel = DetailViewModel()
    var array: [FetchQueryResponseElement]
    var user: UserModel

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemBackground
        tableView.separatorColor = .systemGray
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.layer.cornerRadius = 0

        return tableView
    }()

    private let mailButton: UIButton = {
        let mailButton = UIButton()
        mailButton.translatesAutoresizingMaskIntoConstraints = false
        mailButton.setImage(UIImage(systemName: "mail.stack"), for: [])
        mailButton.setTitle("sendMail".localized, for: [])
        mailButton.setTitleColor(.systemBlue, for: [])
        return mailButton
    }()

    init(array: [FetchQueryResponseElement], user: UserModel) {
        self.array = array
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }

    func setup() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.frame = view.bounds
        view.addSubview(mailButton)
        mailButton.addTarget(self, action: #selector(viewModel.sendMail), for: .touchUpInside)
        NSLayoutConstraint.activate([
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: mailButton.bottomAnchor, multiplier: 8),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: mailButton.trailingAnchor, multiplier: 2),
            mailButton.heightAnchor.constraint(equalToConstant: 120),
            mailButton.widthAnchor.constraint(equalToConstant: 120),
        ])
    }
}

extension DetailView: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        array.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = array[indexPath.row].word
        return cell
    }
}
