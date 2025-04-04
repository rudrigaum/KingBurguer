//
//  TextField.swift
//  KingBurguer
//
//  Created by Rodrigo Cerqueira Reis on 30/03/25.
//

import Foundation
import UIKit

class TextField: UIView {
    
    lazy var editText: UITextField = {
        let editText = UITextField()
        editText.borderStyle = .roundedRect
        editText.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        editText.translatesAutoresizingMaskIntoConstraints = false
        return editText
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var placeholder: String? {
        willSet {
            editText.placeholder = newValue
        }
    }
    
    var returnKeyType: UIReturnKeyType = .next {
        willSet {
            editText.returnKeyType = newValue
        }
    }
    
    var error: String? {
        willSet {
            errorLabel.text = newValue
        }
    }
    
    var heightConstraint : NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(editText)
        addSubview(errorLabel)
        
        let editTextConstraints = [
            editText.leadingAnchor.constraint(equalTo: leadingAnchor),
            editText.trailingAnchor.constraint(equalTo: trailingAnchor),
            editText.heightAnchor.constraint(equalToConstant: 50),
        ]
        
        let errorLabelConstraints = [
            errorLabel.leadingAnchor.constraint(equalTo: editText.leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: editText.trailingAnchor),
            errorLabel.topAnchor.constraint(equalTo: editText.bottomAnchor)
        ]
        
        heightConstraint = heightAnchor.constraint(equalToConstant: 70)
        heightConstraint.isActive = true
        
        
        NSLayoutConstraint.activate(editTextConstraints)
        NSLayoutConstraint.activate(errorLabelConstraints)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
      
    }
    
    @objc func textFieldDidChanged(_ textField: UITextField) {
        if let text = textField.text {
            if text.count <= 3 {
                errorLabel.text = error
                heightConstraint.constant = 70
            } else {
                errorLabel.text = ""
                heightConstraint.constant = 50
            }
        }
        layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
