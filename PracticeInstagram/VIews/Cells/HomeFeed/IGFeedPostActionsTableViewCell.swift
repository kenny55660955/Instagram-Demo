//
//  IGFeedPostActionsTableViewCell.swift
//  PracticeInstagram
//
//  Created by Kenny on 2021/6/27.
//

import UIKit

protocol IGFeedPostActionsTableViewCellDelegate: AnyObject {
    func didTapLikeButton()
    func didTapCommentButton()
    func didTapSendButton()
}

class IGFeedPostActionsTableViewCell: UITableViewCell {
    
    static let identifier = "IGFeedPostActionsTableViewCell"
    
    weak var delegate: IGFeedPostActionsTableViewCellDelegate?
    
    private let likeButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
        let image = UIImage(systemName: "heart.fill", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let commentButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
        let image = UIImage(systemName: "message", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
        let image = UIImage(systemName: "paperplane", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(likeButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(sendButton)
        
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(didTapCommentButton), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // like, comment, send
        let buttonSize = contentView.height-10
        let button = [likeButton, commentButton, sendButton]
        
        for x in 0..<button.count {
            let button = button[x]
            button.frame = CGRect(x: (CGFloat(x)*buttonSize) + (10 * CGFloat(x+1)), y: 5, width: buttonSize, height: buttonSize)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - Methods
    
    func configure(with post: UserPhotoPost) {
        
    }
    
    @objc
    private func didTapLikeButton() {
        delegate?.didTapLikeButton()
    }
    
    @objc
    private func didTapCommentButton() {
        delegate?.didTapCommentButton()
    }
    
    @objc
    private func didTapSendButton() {
        delegate?.didTapSendButton()
    }
    
}
