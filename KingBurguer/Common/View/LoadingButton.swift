//
//  LoadingButton.swift
//  KingBurguer
//
//  Created by Rodrigo Cerqueira Reis on 10/03/25.
//

import Foundation
import UIKit

class LoadingButton: UIView {
    
    lazy var button: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let progress: UIActivityIndicatorView = {
        let progress = UIActivityIndicatorView()
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    var title: String? {
        willSet {
            button.setTitle(newValue, for: .normal)
        }
    }
    
    var titleColor: UIColor? {
        willSet {
            button.setTitleColor(newValue, for: .normal)
        }
    }
    
    override var backgroundColor: UIColor? {
        willSet {
            button.backgroundColor = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTarget( _ target: Any?, action: Selector) {
        button.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func enable(_ isEnabled: Bool) {
        button.isEnabled = isEnabled
        if isEnabled {
            alpha = 1
        } else {
            alpha = 0.5
        }
    }
    
    func startLoading(_ loading: Bool) {
        button.isEnabled = !loading
        if loading {
            button.setTitle("", for: .normal)
            progress.startAnimating()
            alpha = 0.5
        } else {
            button.setTitle(title, for: .normal)
            progress.stopAnimating()
            alpha = 1.0
        }
    }
    
    private func setupViews() {
        backgroundColor = .yellow
        addSubview(button)
        addSubview(progress)
        
        let buttonConstriants = [
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        let progressConstriants = [
            progress.leadingAnchor.constraint(equalTo: leadingAnchor),
            progress.trailingAnchor.constraint(equalTo: trailingAnchor),
            progress.topAnchor.constraint(equalTo: topAnchor),
            progress.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(buttonConstriants)
        NSLayoutConstraint.activate(progressConstriants)
    }
}
