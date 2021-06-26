//
//  LoginViewController.swift
//  PracticeInstagram
//
//  Created by Kenny on 2021/6/26.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    private let userNameEmailField: UITextField = {
       return UITextField()
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
       return field
    }()
    
    private let termsButton: UIButton = {
       return UIButton()
    }()
    
    private let privacyButton: UIButton = {
       return UIButton()
    }()
    
    private let createAccountButton: UIButton = {
       return UIButton()
    }()
    
    private let headerView: UIView = {
       return UIView()
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubViews()
        
        view.backgroundColor = .yellow
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Assgin frames
    }
    
     // MARK: - Methods
    private func addSubViews() {
        view.addSubview(userNameEmailField)
        view.addSubview(passwordField)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(headerView)
        view.addSubview(createAccountButton)
    }
    
    @objc
    private func didTapLoginButton() {
        
    }
    
    @objc
    private func didTapTermsButton() {
        
    }
    
    @objc
    private func didTapPrivacyButton() {
        
    }
    
    @objc
    private func didTapCreateAccountButton() {
        
    }

}
