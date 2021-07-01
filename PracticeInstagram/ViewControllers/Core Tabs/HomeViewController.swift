//
//  HomeViewController.swift
//  PracticeInstagram
//
//  Created by Kenny on 2021/6/26.
//

import UIKit
import Firebase

struct HomeFeedRenderViewModel {
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    let actions: PostRenderViewModel
    let comments: PostRenderViewModel
}

class HomeViewController: UIViewController {
    
    private var feedRenderModels = [HomeFeedRenderViewModel]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(IGFeedPostTableViewCell.self,
                           forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        tableView.register(IGFeedPostHeaderTableViewCell.self,
                           forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
        tableView.register(IGFeedPostGenralTableViewCell.self,
                           forCellReuseIdentifier: IGFeedPostGenralTableViewCell.identifier)
        return tableView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createMockModels()
        // Do any additional setup after loading the view.
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //        hanldeNotAuth()
        
    }
    
    
    // MARK: - Methods
    
    private func createMockModels() {
        let user = User(username: "@kenny",
                        bio: "",
                        name: (first: "", last: ""),
                        profilePhoto: URL(string: "https://www.google.com")!,
                        bitrhDate: Date(),
                        gender: .male,
                        count: UserCount(followers: 1, following: 1, posts: 1),
                        joinDate: Date())
        
        for x in 0...100 {
            let post = UserPhotoPost(identifier: "",
                                     postType: .photo,
                                     thumbnailImage: URL(string: "https://www.google.com")!,
                                     postURL: URL(string: "https://www.google.com")!,
                                     caption: nil,
                                     likeCount: 1,
                                     comment: [],
                                     createdData: Date(),
                                     taggedUsers: [],
                                     ower: user)
            
            var comments = [PostComment]()
            for x in 0..<2 {
                comments.append(PostComment(identifier: "\(x)",
                                            username: "@joe",
                                            text: "Hello World",
                                            createDate: Date(),
                                            likes: []))
            }
            for x in 0..<5 {
                let viewModel = HomeFeedRenderViewModel(header: PostRenderViewModel(renderType: .header(provider: user)),
                                                        post: PostRenderViewModel(renderType: .primartContent(provider: post)),
                                                        actions: PostRenderViewModel(renderType: .actions(provider: "")),
                                                        comments: PostRenderViewModel(renderType: .comments(comments: comments)))
                feedRenderModels.append(viewModel)
            }
        }
    }
    
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
// MARK: - TableView Delegate
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedRenderModels.count / 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let x = section
        let model: HomeFeedRenderViewModel
        
        if x == 0 {
            model = feedRenderModels[0]
        } else {
            let position = x % 4 == 0 ? x / 4 : ((x - (x % 4)) / 4)
            model = feedRenderModels[position]
        }
        
        let subSection = x % 4
        
        if subSection == 0 {
            //header
            return 1
            
        } else if subSection == 1 {
            //post
            return 1
        } else if subSection == 2 {
            // action
            return 1
        } else if subSection == 3 {
            // comments
            let commentModel = model.comments
            switch commentModel.renderType {
            case .comments(let comments): return comments.count > 2 ? 2: comments.count
            case .header, .actions, .primartContent: return 0

            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let x = indexPath.section
        let model: HomeFeedRenderViewModel
        
        if x == 0 {
            model = feedRenderModels[0]
        } else {
            let position = x % 4 == 0 ? x / 4 : ((x - (x % 4)) / 4)
            model = feedRenderModels[position]
        }
        
        let subSection = x % 4
        
        if subSection == 0 {
            //header
            let headerModel = model.header
            switch headerModel.renderType {
            case .header(let user):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier) as? IGFeedPostHeaderTableViewCell else { return UITableViewCell() }
                cell.configure(with: user)
                cell.delegate = self
                return cell
            case .comments, .actions, .primartContent:
                return UITableViewCell()
                
            }
            
        } else if subSection == 1 {
            //post
            let postModel = model.post
            switch postModel.renderType {
            case .primartContent(let postModel):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier) as? IGFeedPostTableViewCell else { return UITableViewCell() }
                cell.configure(with: postModel)
                return cell
            case .comments, .actions, .header:
                return UITableViewCell()
                
            }
        } else if subSection == 2 {
            // action
            let actionsModel = model.actions
            switch actionsModel.renderType {
            case .actions(let provider):
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier) as? IGFeedPostActionsTableViewCell else { return UITableViewCell() }
                cell.delegate = self
                return cell
                
            case .comments, .header, .primartContent:
                return UITableViewCell()
                
            }
            
        } else if subSection == 3 {
            // comments
            let commentModel = model.comments
            
            switch commentModel.renderType {
            case .comments(let comments):
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGenralTableViewCell.identifier) as? IGFeedPostGenralTableViewCell else { return UITableViewCell() }
                
            case .header, .actions, .primartContent:
                return UITableViewCell()
                
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let subSection = indexPath.section % 4
        
        if subSection == 0 {
            // Header
            return 70
        } else if subSection == 1 {
            // Post
            return tableView.width
            
        } else if subSection == 2 {
            // Action (like / comment)
            return 60
            
        } else if subSection == 3 {
            // Comment row
            return 50
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let subSection = section % 4
        
        return subSection == 3 ? 70 : 0
    }
}
// MARK: - IGFeedPostHeaderTableViewCell Delegate
extension HomeViewController: IGFeedPostHeaderTableViewCellDelegate {
    
    func didTapMoreButton() {
        let actionSheet = UIAlertController(title: "Post Options",
                                            message: nil,
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Report Post",  style: .destructive){ [weak self]_ in
            guard let self = self else { return }
            self.reportPost()
        })
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        present(actionSheet, animated: true, completion: nil)
    }
    
    func reportPost() {
        
    }
}

// MARK: - IGFeedPostActionsTableViewCellDelegate
extension HomeViewController: IGFeedPostActionsTableViewCellDelegate {
    func didTapLikeButton() {
        print("Like")
    }
    
    func didTapCommentButton() {
        print("Comment")
    }
    
    func didTapSendButton() {
        print("Send")
    }
    
    
}
