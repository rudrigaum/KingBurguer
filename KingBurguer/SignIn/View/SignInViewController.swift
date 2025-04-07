//
//  SignInViewController.swift
//  KingBurguer
//
//  Created by Rodrigo Cerqueira Reis on 24/09/24.
//

import Foundation
import UIKit

class SignInViewController: UIViewController {
    
    let scroll: UIScrollView = {
       let sc = UIScrollView()
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var emailTextField: TextField = {
        let emailTextField = TextField()
        emailTextField.placeholder = "Entre com seu e-mail"
        emailTextField.returnKeyType
        emailTextField.error = "E-mail invalido"
        emailTextField.failure = validation
//        ed.delegate = self
//        ed.translatesAutoresizingMaskIntoConstraints = false
        return emailTextField
    }()
    
    func validation() -> Bool {
        guard let text = emailTextField.text else { return true }
        return text.count <= 3
    }
    
    lazy var password: UITextField = {
        let ed = UITextField()
        ed.borderStyle = .roundedRect
        ed.placeholder = "Entre com sua senha"
        ed.returnKeyType = .done
        ed.delegate = self
        ed.translatesAutoresizingMaskIntoConstraints = false
        return ed
    }()
    
    lazy var send: LoadingButton = {
        let btn = LoadingButton()
        btn.title = "Entrar"
        btn.backgroundColor = .red
        btn.addTarget(self, action: #selector(sendDidTap))
        return btn
    }()
    
    lazy var register: UIButton = {
        let btn = UIButton()
        btn.setTitle("Criar Conta", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(registerDidTap), for: .touchUpInside)
        return btn
    }()
    
    var viewModel: SignInViewModel? {
        didSet {
            viewModel?.delegate = self 
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.systemBackground
        
        navigationItem.title = "Login"
        
        container.addSubview(emailTextField)
        container.addSubview(password)
        container.addSubview(register)
        container.addSubview(send)
        scroll.addSubview(container)
        view.addSubview(scroll)
        
        let scrollConstraints = [
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroll.topAnchor.constraint(equalTo: view.topAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        let heightConstraint = container.heightAnchor.constraint(equalTo: view.heightAnchor)
        heightConstraint.priority = .defaultLow
        heightConstraint.isActive = true
        
        let containerConstraints = [
            container.widthAnchor.constraint(equalTo: view.widthAnchor),
            container.topAnchor.constraint(equalTo: scroll.topAnchor),
            container.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
            container.heightAnchor.constraint(equalToConstant: 470)
        ]
        
        
        let emailConstraints = [
            emailTextField.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            emailTextField.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            emailTextField.centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: -150.0),
        ]
        
        let passwordConstrains = [
            password.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            password.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            password.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10.0),
            password.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        let sendConstraints = [
            send.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            send.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            send.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20.0),
            send.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 10.0),
            send.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        let registerConstraints = [
            register.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            register.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            register.topAnchor.constraint(equalTo: send.bottomAnchor, constant: 15.0),
            register.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        NSLayoutConstraint.activate(emailConstraints)
        NSLayoutConstraint.activate(passwordConstrains)
        NSLayoutConstraint.activate(sendConstraints)
        NSLayoutConstraint.activate(scrollConstraints)
        NSLayoutConstraint.activate(containerConstraints)
        NSLayoutConstraint.activate(registerConstraints)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func onKeyboardNotification(_ notification: Notification) {
        let visible = notification.name == UIResponder.keyboardWillShowNotification
        let keyboardframe = visible ? UIResponder.keyboardFrameEndUserInfoKey : UIResponder.keyboardFrameBeginUserInfoKey
        
        if let keyboardSize = (notification.userInfo?[keyboardframe] as? NSValue)?.cgRectValue{
            onkeyboardChanged(visible, height: keyboardSize.height)
        }
    }
    
    func onkeyboardChanged(_ visible: Bool, height: CGFloat) {
        if (!visible) {
            scroll.contentInset = .zero
            scroll.scrollIndicatorInsets = .zero
        } else {
            let contentsInsets = UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
            scroll.contentInset = contentsInsets
            scroll.scrollIndicatorInsets = contentsInsets
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(_ view: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @objc func sendDidTap(_ sender: UIButton) {
        viewModel?.send()
    }
    
    @objc func registerDidTap(_ sender: UIButton) {
        viewModel?.goToSignUp()
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField.returnKeyType == .done) {
            view.endEditing(true)
            return false
        } else {
            password.becomeFirstResponder()
        }
        return false
    }
}

extension SignInViewController: SignInViewModelDelegate {
    func viewModelDidChanged(state: SignInState) {
        switch(state) {
        case .none:
            break
        case .loading:
            send.startLoading(true)
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
