//
//  FeedViewController.swift
//  KingBurguer
//
//  Created by Rodrigo Cerqueira Reis on 18/03/25.
//

import UIKit

class FeedViewController: UIViewController {
    
    private let feedTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .cyan
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(feedTableView)
        
        let headerView = HighlightView(frame: CGRect(x: 0, y: 0, width: view.bounds.width , height: 200))
        feedTableView.tableHeaderView = headerView
        headerView.backgroundColor = .orange
        
        feedTableView.delegate = self
        feedTableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        feedTableView.frame = view.bounds
    }
}

extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.identifier, for: indexPath) as? FeedTableViewCell {
            cell.textLabel?.text = "Olá Mundo \(indexPath.section) - \(indexPath.row)"
            return cell
        }
        return UITableViewCell()
    }
    
    
}
