//
//  SettingViewController.swift
//  PracticeInstagram
//
//  Created by Kenny on 2021/6/26.
//

import UIKit

struct SettingCellModel {
    let title: String
    let handler: (() -> Void)
}

// MARK: - ViewController shows user settings
final class SettingViewController: UIViewController {
    
    // MARK: - Properties
    private let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 300, height: 300),
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
        view.backgroundColor = .yellow
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
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
        let section = [
            SettingCellModel(title: "Log Out", handler: { [weak self] in
                self?.didTapLogout()
            })
        ]
        data.append(section)
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        print("IndexPath: \(indexPath)")
        /// Handle cell select
        let model = data[indexPath.section][indexPath.row].handler
        didTapLogout()
    }
    
    
}
