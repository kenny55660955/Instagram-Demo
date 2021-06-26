//
//  HomeViewController.swift
//  PracticeInstagram
//
//  Created by Kenny on 2021/6/26.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        hanldeNotAuth()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    
    // MARK: - Methods
    private func hanldeNotAuth() {
        
        // Check auth status
        if Auth.auth().currentUser == nil {
            // Show log in
            let logVC = LoginViewController()
            logVC.modalPresentationStyle = .fullScreen
            present(logVC, animated: true, completion: nil)
        }
        
    }
    
}

