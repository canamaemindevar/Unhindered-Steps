//
//  DetailViewController.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 3.05.2023.
//

import UIKit

class DetailViewController: UIViewController {

    
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
        mailButton.setTitle("Mail At", for: [])
        return mailButton
    }()
    
    init(array: [FetchQueryResponseElement], user: UserModel) {
        self.array = array
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = view.bounds
        view.addSubview(mailButton)
        mailButton.addTarget(self, action: #selector(sendMail), for: .touchUpInside)
        NSLayoutConstraint.activate([
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: mailButton.bottomAnchor, multiplier: 5),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: mailButton.trailingAnchor, multiplier: 3),
            mailButton.heightAnchor.constraint(equalToConstant: 90),
            mailButton.widthAnchor.constraint(equalToConstant: 90)
        ])
    }
    

  

}

extension DetailViewController {
    @objc func sendMail() {
        
        
        if self.title == "Arama Geçmişi"
        {
            //TODO: arama geçmişi mail at
            NetworkManager.shared.sendMail(id: user.id ?? "", mail: user.helperMail ?? "") { response in
                switch response {
                case .success(let success):
                    print(success)
                case .failure(let failure):
                    print(failure)
                }
            }
            
        } else if self.title == "Favoriler"
        {
            //TODO: favoriler mail at
            
        } else
        {
            //TODO: sık kullanılan  mail at
        }

        
        
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      // 10
        self.array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = array[indexPath.row].word
        return cell
    }
    
    
}

extension DetailViewController: UITableViewDelegate {}

