//
//  FeedViewController.swift
//  KingBurguer
//
//  Created by Rodrigo Cerqueira Reis on 18/03/25.
//

import UIKit

class FeedViewController: UIViewController {
    
    private let feedTableView: UITableView = {
       let tableView = UITableView()
        tableView.backgroundColor = .cyan
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(feedTableView)
        feedTableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        feedTableView.frame = view.bounds
    }
}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = "Olá Mundo \(indexPath.row)"
        return cell
    }
    
    
}
