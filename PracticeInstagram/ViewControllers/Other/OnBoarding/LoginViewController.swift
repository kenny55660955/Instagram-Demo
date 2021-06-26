//
//  LoginViewController.swift
//  PracticeInstagram
//
//  Created by Kenny on 2021/6/26.
//
import SafariServices
import UIKit

class LoginViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    // MARK: - Properties
    private let userNameEmailField: UITextField = {
        let field = UITextField()
        field.placeholder = "UserName or Email..."
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
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.layer.cornerRadius = Constants.cornerRadius
        button.layer.masksToBounds = true
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
       return button
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms of Service", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.layer.cornerRadius = Constants.cornerRadius
        button.layer.masksToBounds = true
        button.setTitleColor(.gray, for: .normal)
       return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.layer.cornerRadius = Constants.cornerRadius
        button.layer.masksToBounds = true
        button.setTitleColor(.gray, for: .normal)
        return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("New User? Create an Account", for: .normal)
       return button
    }()
    
    private let headerView: UIView = {
        let header = UIView()
        header.clipsToBounds = true
        header.backgroundColor = .red
        let backgroundImageView = UIImageView(image: UIImage(named: "gradient"))
        header.addSubview(backgroundImageView)
       return header
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.addTarget(self,
                              action: #selector(didTapLoginButton),
                              for: .touchUpInside)
        
        createAccountButton.addTarget(self,
                              action: #selector(didTapCreateAccountButton),
                              for: .touchUpInside)
        
        termsButton.addTarget(self,
                              action: #selector(didTapTermsButton),
                              for: .touchUpInside)
        
        privacyButton.addTarget(self,
                              action: #selector(didTapPrivacyButton),
                              for: .touchUpInside)
        
        userNameEmailField.delegate = self
        passwordField.delegate = self
        
        addSubViews()
        
        view.backgroundColor = .yellow
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Assgin frames
        
        headerView.frame = CGRect(x: 0,
                                  y: 0.0,
                                  width: view.width,
                                  height: view.height / 3.0)
        
        userNameEmailField.frame = CGRect(x: 25,
                                          y: headerView.bottom + 40,
                                          width: view.width - 50,
                                          height: 52.0)
        passwordField.frame = CGRect(x: 25,
                                          y: userNameEmailField.bottom + 10,
                                          width: view.width - 50,
                                          height: 52.0)
        
        loginButton.frame = CGRect(x: 25,
                                   y: passwordField.bottom + 10,
                                   width: view.width - 50,
                                   height: 52.0)
        
        createAccountButton.frame = CGRect(x: 25,
                                   y: loginButton.bottom + 10,
                                   width: view.width - 50,
                                   height: 52.0)
        
        termsButton.frame = CGRect(x: 10,
                                   y: view.height - view.safeAreaInsets.bottom - 100,
                                   width: view.width - 20,
                                   height: 50)
        privacyButton.frame = CGRect(x: 10,
                                   y: view.height - view.safeAreaInsets.bottom - 50,
                                   width: view.width - 20,
                                   height: 50)
        
        configureHeaderView()
    }
    
     // MARK: - Methods
    private func configureHeaderView() {
        guard headerView.subviews.count == 1 else { return }
        
        guard let backgroundView = headerView.subviews.first else { return }
        
        backgroundView.frame = headerView.bounds
        
        let imageView = UIImageView(image: UIImage(named: "logo"))
        headerView.addSubview(imageView)
        
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0,
                                 y: view.safeAreaInsets.top,
                                 width: headerView.width,
                                 height: headerView.height - view.safeAreaInsets.top)
    }
    
    private func addSubViews() {
        view.addSubview(userNameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(headerView)
        view.addSubview(createAccountButton)
    }
    
    @objc
    private func didTapLoginButton() {
        passwordField.resignFirstResponder()
        userNameEmailField.resignFirstResponder()
        
        guard let userNameEmail = userNameEmailField.text, !userNameEmail.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
            return
        }
    }
    
    @objc
    private func didTapTermsButton() {
        guard let url = URL(string: "https://www.instagram.com/about/legal/terms/before-january-19-2013/") else { return }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
    }
    
    @objc
    private func didTapPrivacyButton() {
        guard let url = URL(string: "https://help.instagram.com/519522125107875") else { return }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
    }
    
    @objc
    private func didTapCreateAccountButton() {
        let vc = RegistrationViewController()
        present(vc, animated: true, completion: nil)
    }

}
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameEmailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            didTapLoginButton()
        }
        return true
    }
}
