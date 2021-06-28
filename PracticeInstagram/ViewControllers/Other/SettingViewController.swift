//
//  SettingViewController.swift
//  PracticeInstagram
//
//  Created by Kenny on 2021/6/26.
//

import UIKit
import SafariServices

struct SettingCellModel {
    let title: String
    let handler: (() -> Void)
}

// MARK: - ViewController shows user settings
final class SettingViewController: UIViewController {
    
    // MARK: - Properties
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero,
                                    style: .grouped)
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var data = [[SettingCellModel]]()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        addSubViews()
        assignDelegate()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
    }
    // MARK: - Methods
    private func addSubViews() {
        view.addSubview(tableView)
    }
    
    private func assignDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureModels() {
        
        data.append([
            SettingCellModel(title: "Log Out") { [weak self] in
                self?.didTapLogout()
            },
            SettingCellModel(title: "Invite Friend") { [weak self] in
                self?.didTapInviteFriends()
            },
            SettingCellModel(title: "Save Original Posts") { [weak self] in
                self?.didTapSaveOriginalPosts()
            }
        ])
        
        data.append([
            SettingCellModel(title: "Edit ProFile") { [weak self] in
                guard let self = self else { return }
                self.didTapEditProfile()
            },
            SettingCellModel(title: "Privacy Pofile") { [weak self] in
                guard let self = self else { return }
                self.didTapTerms(type: .privacy)
            },
            SettingCellModel(title: "Help / FeedBack") { [weak self] in
                guard let self = self else { return }
                self.didTapTerms(type: .terms)
            }
        ])
    }
    // MARK: - Button Methods
    private func didTapEditProfile() {
        let vc = EditrProfileViewController()
        vc.title = "Edit Profile"
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true, completion: nil)
    }
    private func didTapInviteFriends() {
        
    }
    private func didTapSaveOriginalPosts() {
        
    }
    
    enum SettingURLType {
        case terms, privacy, help
    }
    
    private func didTapTerms(type: SettingURLType) {
        
        let urlString: String
        
        switch type {
        case .terms:
            urlString = "https://www.instagram.com/about/legal/terms/before-january-19-2013/"
        case .privacy:
            urlString = "https://help.instagram.com/519522125107875"
        case .help:
            urlString = "https://help.instagram.com/"
        }
        
        guard let url = URL(string: urlString) else { return }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
    }
    
    private func didTapLogout() {
        let actionSheet = UIAlertController(title: "Log out",
                                            message: "Are you sure you want to log out?",
                                            preferredStyle: .alert)
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { _ in
            AuthManager.shared.logout { result in
                DispatchQueue.main.async {
                    if result {
                        let logVC = LoginViewController()
                        logVC.modalPresentationStyle = .fullScreen
                        self.present(logVC, animated: true) {
                            self.navigationController?.popToRootViewController(animated: false)
                            self.tabBarController?.selectedIndex = 0
                        }
                        
                    } else {
                        fatalError("User couldnt log out")
                    }
                }
            }
        }))
        actionSheet.popoverPresentationController?.sourceView = tableView
        actionSheet.popoverPresentationController?.sourceRect = tableView.bounds
        present(actionSheet, animated: true, completion: nil)
    }
}
// MARK: - TableViewDelegate
extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print("data: \(data.count)")
        
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("data[section].count \(data[section].count)")
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        print("IndexPath: \(indexPath)")
        /// Handle cell select
        data[indexPath.section][indexPath.row].handler()
        
    }
    
    
}
