//
//  SignUpViewController.swift
//  KingBurguer
//
//  Created by Rodrigo Cerqueira Reis on 13/01/25.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController {
    
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
    
    lazy var name: UITextField = {
        let ed = UITextField()
        ed.borderStyle = .roundedRect
        ed.placeholder = "Entre com seu nome"
        ed.tag = 1
        ed.returnKeyType = .next
        ed.delegate = self
        ed.translatesAutoresizingMaskIntoConstraints = false
        return ed
    }()
    
    lazy var email: UITextField = {
        let ed = UITextField()
        ed.borderStyle = .roundedRect
        ed.placeholder = "Entre com seu e-mail"
        ed.tag = 2
        ed.returnKeyType = .next
        ed.delegate = self
        ed.translatesAutoresizingMaskIntoConstraints = false
        return ed
    }()
    
    lazy var password: UITextField = {
        let ed = UITextField()
        ed.borderStyle = .roundedRect
        ed.placeholder = "Entre com sua senha"
        ed.tag = 3
        ed.returnKeyType = .next
        ed.delegate = self
        ed.translatesAutoresizingMaskIntoConstraints = false
        return ed
    }()
    
    lazy var document: UITextField = {
        let ed = UITextField()
        ed.borderStyle = .roundedRect
        ed.placeholder = "Entre com seu CPF"
        ed.tag = 4
        ed.returnKeyType = .next
        ed.delegate = self
        ed.translatesAutoresizingMaskIntoConstraints = false
        return ed
    }()
    
    lazy var birthday: UITextField = {
        let ed = UITextField()
        ed.borderStyle = .roundedRect
        ed.placeholder = "Entre com sua data de nascimento"
        ed.tag = 5
        ed.returnKeyType = .done
        ed.delegate = self
        ed.translatesAutoresizingMaskIntoConstraints = false
        return ed
    }()
    
    lazy var register: LoadingButton = {
        let btn = LoadingButton()
        btn.title = "Entrar"
        btn.titleColor = .white
        btn.backgroundColor = .red
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
        
        container.addSubview(name)
        container.addSubview(email)
        container.addSubview(password)
        container.addSubview(document)
        container.addSubview(birthday)
        container.addSubview(register)
        
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
        
        
        let nameConstraints = [
            name.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            name.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            name.topAnchor.constraint(equalTo: container.topAnchor, constant: 30),
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
        
        let registerConstraints = [
            register.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            register.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            register.topAnchor.constraint(equalTo: birthday.bottomAnchor, constant: 10.0),
            register.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        NSLayoutConstraint.activate(nameConstraints)
        NSLayoutConstraint.activate(emailConstrains)
        NSLayoutConstraint.activate(passwordConstrains)
        NSLayoutConstraint.activate(documentConstrains)
        NSLayoutConstraint.activate(birthdayConstrains)
        NSLayoutConstraint.activate(registerConstraints)
        
        NSLayoutConstraint.activate(containerConstraints)
        NSLayoutConstraint.activate(scrollConstraints)
        
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

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField.returnKeyType == .done) {
            view.endEditing(true)
            print("Save!!!")
            return false
        }
        let nextTag = textField.tag + 1
        let component = container.findViewByTag(tag: nextTag)
        
        if (component != nil) {
            component?.becomeFirstResponder()
        } else {
            view.endEditing(true)
        }
        
        return false
    }
}

extension UIView {
    func findViewByTag(tag: Int) -> UIView? {
        for subview in subviews {
            if subview.tag == tag {
                return subview
            }
        }
        return nil
    }
}
