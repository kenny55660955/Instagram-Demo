//
//  RegistrationViewController.swift
//  PracticeInstagram
//
//  Created by Kenny on 2021/6/26.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    // MARK: - Properties
    private let userNameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Please Type Your UserName"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
       return field
    }()
    private let userNameEmailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Please Type Email"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
       return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password..."
        field.returnKeyType = .done
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
       return field
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.layer.cornerRadius = Constants.cornerRadius
        button.layer.masksToBounds = true
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
       return button
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignDelegate()
        
        buttonAddTarget()
        
        addSubViews()
        
        view.backgroundColor = .red
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        userNameField.frame = CGRect(x: 20,
                                     y: view.safeAreaInsets.top + 100,
                                     width: view.width - 40,
                                     height: 52)
        
        userNameEmailField.frame = CGRect(x: 20,
                                          y: userNameField.bottom + 10,
                                     width: view.width - 40,
                                     height: 52)
        
        passwordField.frame = CGRect(x: 20,
                                     y: userNameEmailField.bottom + 10,
                                     width: view.width - 40,
                                     height: 52)
        
        registerButton.frame = CGRect(x: 20,
                                     y: passwordField.bottom + 10,
                                     width: view.width - 40,
                                     height: 52)
        
    }
    
    // MARK: - Methods
    private func addSubViews() {
        view.addSubview(userNameField)
        view.addSubview(userNameEmailField)
        view.addSubview(passwordField)
        view.addSubview(registerButton)
    }
    
    private func buttonAddTarget() {
        registerButton.addTarget(self,
                                 action: #selector(didTapRegister),
                                 for: .touchUpInside)
    }
    
    private func assignDelegate() {
        userNameEmailField.delegate = self
        userNameField.delegate = self
        passwordField.delegate = self
    }
    
    @objc
    private func didTapRegister() {
        passwordField.resignFirstResponder()
        userNameField.resignFirstResponder()
        userNameEmailField.resignFirstResponder()
        
        guard let email = userNameEmailField.text,!email.isEmpty,
              let useName = userNameField.text, !useName.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            return
        }
        
        AuthManager.shared.registerNewUser(userName: useName, email: email, password: password) { registered in
            DispatchQueue.main.async {
                if registered {
                    // good to go
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print("Fail")
                }
            }
        }
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameField {
            userNameEmailField.becomeFirstResponder()
        } else if textField == userNameEmailField {
            passwordField.becomeFirstResponder()
        } else {
            didTapRegister()
        }
        return true
    }
}
