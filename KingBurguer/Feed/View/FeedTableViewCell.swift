//
//  FeedTableViewCell.swift
//  KingBurguer
//
//  Created by Rodrigo Cerqueira Reis on 20/03/25.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    
    static let identifier = "FeedTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .systemGreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
