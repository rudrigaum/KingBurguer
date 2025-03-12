//
//  SignUpViewController.swift
//  KingBurguer
//
//  Created by Rodrigo Cerqueira Reis on 13/01/25.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController {
    
    let name: UITextField = {
        let ed = UITextField()
        ed.borderStyle = .roundedRect
        ed.placeholder = "Entre com seu nome"
        ed.translatesAutoresizingMaskIntoConstraints = false
        return ed
    }()
    
    let email: UITextField = {
        let ed = UITextField()
        ed.borderStyle = .roundedRect
        ed.placeholder = "Entre com seu e-mail"
        ed.translatesAutoresizingMaskIntoConstraints = false
        return ed
    }()
    
    let password: UITextField = {
        let ed = UITextField()
        ed.borderStyle = .roundedRect
        ed.placeholder = "Entre com sua senha"
        ed.translatesAutoresizingMaskIntoConstraints = false
        return ed
    }()
    
    let document: UITextField = {
        let ed = UITextField()
        ed.borderStyle = .roundedRect
        ed.placeholder = "Entre com seu CPF"
        ed.translatesAutoresizingMaskIntoConstraints = false
        return ed
    }()
    
    let birthday: UITextField = {
        let ed = UITextField()
        ed.borderStyle = .roundedRect
        ed.placeholder = "Entre com sua data de nascimento"
        ed.translatesAutoresizingMaskIntoConstraints = false
        return ed
    }()
    
    lazy var send: LoadingButton = {
        let btn = LoadingButton()
        btn.title = "Entrar"
        btn.titleColor = .white
        btn.backgroundColor = .red
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(sendDidTap))
        return btn
    }()
    
    var viewModel: SignUpViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(name)
        view.addSubview(email)
        view.addSubview(password)
        view.addSubview(document)
        view.addSubview(birthday)
        view.addSubview(send)
        
        let nameConstraints = [
            name.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            name.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            name.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100.0),
            name.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        let emailConstrains = [
            email.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            email.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            email.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10.0),
            email.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        let passwordConstrains = [
            password.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            password.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            password.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 10.0),
            password.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        let documentConstrains = [
            document.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            document.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            document.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 10.0),
            document.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        let birthdayConstrains = [
            birthday.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            birthday.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            birthday.topAnchor.constraint(equalTo: document.bottomAnchor, constant: 10.0),
            birthday.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        let sendConstrains = [
            send.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            send.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            send.topAnchor.constraint(equalTo: birthday.bottomAnchor, constant: 10.0),
            send.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        NSLayoutConstraint.activate(nameConstraints)
        NSLayoutConstraint.activate(emailConstrains)
        NSLayoutConstraint.activate(passwordConstrains)
        NSLayoutConstraint.activate(documentConstrains)
        NSLayoutConstraint.activate(birthdayConstrains)
        NSLayoutConstraint.activate(sendConstrains)
        
    }
    
    @objc func sendDidTap(_ sender: UIButton) {
         viewModel?.send()
    }
}

extension SignUpViewController: SignUpViewModelDelegate {
    func viewModelDidChanged(state: SignUpState) {
        switch(state) {
        case .none:
            break
        case .loading:
            // mostrar a progress
            break
        case .goToHome:
            viewModel?.goToHome()
            break
        case .error(let msg):
            let alert = UIAlertController(title: "Título", message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true)
            break
        }
    }
}
