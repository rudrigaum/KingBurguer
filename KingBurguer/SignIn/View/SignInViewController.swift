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
        let textField = TextField()
        textField.placeholder = "Entre com seu e-mail"
        textField.returnKeyType
        textField.error = "E-mail invalido"
        textField.keyboardType = .emailAddress
        textField.bitmask = SignInForm.email.rawValue
        textField.delegate = self
        textField.failure = {
            return !(textField.text?.isEmail() ?? false)
        }
        textField.delegate = self
        return textField
    }()
    
    func validation() -> Bool {
        guard let text = emailTextField.text else { return true }
        return text.count <= 3
    }
    
    lazy var password: TextField = {
        let textField = TextField()
        textField.placeholder = "Entre com sua senha"
        textField.returnKeyType = .done
        textField.error = "Senha deve ter no mínimo 8 caracteres"
        textField.secureTextEntry = true
        textField.bitmask = SignInForm.password.rawValue
        textField.failure = {
            return (textField.text?.count ?? 0) < 8
        }
        textField.delegate = self
        return textField
    }()
    
    lazy var send: LoadingButton = {
        let btn = LoadingButton()
        btn.title = "Entrar"
        btn.backgroundColor = .red
        btn.enable(false)
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
    
    var bitmaskResult: Int = 0
    
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
        ]
        
        let sendConstraints = [
            send.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            send.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
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
        if !(visible) {
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

extension SignInViewController: TextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField.returnKeyType == .done) {
            view.endEditing(true)
            return false
        } else {
            password.gainFocus()
        }
        return false
        }
    
    func textFieldDidChanged(isValid: Bool, bitmask: Int) {
        if isValid {
            self.bitmaskResult = self.bitmaskResult | bitmask
            print("bitmaskResult is : \(self.bitmaskResult)")
        } else {
            self.bitmaskResult = self.bitmaskResult & ~bitmask
        }
        
        self.send.enable((SignInForm.email.rawValue & self.bitmaskResult != 0 ) && (SignInForm.password.rawValue & self.bitmaskResult != 0))
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
