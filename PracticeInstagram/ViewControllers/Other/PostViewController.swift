//
//  PostViewController.swift
//  PracticeInstagram
//
//  Created by Kenny on 2021/6/26.
//

import UIKit
/*
 Section
 - Header model
 Section
 - Post Cell model
 Section
 - Action Button Cell model
 Section
 - n Number of genral models for comments
 */

/// States of a render cell
enum PostRenderType {
    case header(provider: User)
    case primartContent(provider: UserPhotoPost)
    case actions(provider: String) // like, comment, share
    case comments(comments: [PostComment])
}
/// Model of render Post
struct PostRenderViewModel {
    let renderType: PostRenderType
}

class PostViewController: UIViewController {
    
    // MARK: - Properties
    private let model: UserPhotoPost?
    
    private var renderModels = [PostRenderViewModel]()
    
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
    init(model: UserPhotoPost?) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
         configuerModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.backgroundColor = .systemBackground
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configuerModel() {
        guard let userPostModel = self.model else {
            return
        }
        // Header
        renderModels.append(PostRenderViewModel(renderType: .header(provider: userPostModel.ower)))
        // Post
        renderModels.append(PostRenderViewModel(renderType: .primartContent(provider: userPostModel)))
        //Actions
        renderModels.append(PostRenderViewModel(renderType: .actions(provider: "")))
        //4 Comments
        var comments = [PostComment]()
        for x in 0..<4 {
            comments.append(PostComment(identifier: "123_\(x)", username: "@dave", text: "Great Post!", createDate: Date(), likes: []))
        }
        renderModels.append(PostRenderViewModel(renderType: .comments(comments: comments)))
    }
}
extension PostViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return renderModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch renderModels[section].renderType {
        case .actions(_):
            return 1
        case .comments(let comments):
            return comments.count > 4 ? 4: comments.count
        case .header(_):
            return 1
        case .primartContent(_):
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = renderModels[indexPath.section]
        
        switch model.renderType {
        case .actions(let actions):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier) as? IGFeedPostTableViewCell else { return UITableViewCell() }
            
            return cell
        case .comments(let comments):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGenralTableViewCell.identifier) as? IGFeedPostGenralTableViewCell else { return UITableViewCell() }
            
            return cell
        case .header(let user):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier) as? IGFeedPostTableViewCell else { return UITableViewCell() }
            
            return cell
        case .primartContent(let post):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier) as? IGFeedPostTableViewCell else { return UITableViewCell() }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = renderModels[indexPath.section]
        
        switch model.renderType {
        case .actions(_):
            return 60
        case .comments(_):
           return 50
        case .header(_):
            return tableView.width
        case .primartContent(_):
            return 70
        }
    }
    
}
