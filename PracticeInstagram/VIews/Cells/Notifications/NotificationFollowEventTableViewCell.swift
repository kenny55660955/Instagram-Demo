//
//  NotificationFollowEventTableViewCell.swift
//  PracticeInstagram
//
//  Created by Kenny on 2021/6/30.
//

import UIKit
protocol NotificationFollowEventTableViewCellDelegate: AnyObject {
    func didTapFollowUnFollowButton(model: UserNotification)
}

class NotificationFollowEventTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier = "NotificationLikeEventTableViewCell"
    
    weak var delegate: NotificationFollowEventTableViewCellDelegate?
    
    private var model: UserNotification?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .tertiarySystemBackground
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "@kanyWesk Followed you"
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        return button
    }()
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(label)
        contentView.addSubview(followButton)
        followButton.addTarget(self,
                               action: #selector(didTapFollowButton), for: .touchUpInside)
        configureFollow()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        followButton.setBackgroundImage(nil, for: .normal)
        label.text = nil
        profileImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageView.frame = CGRect(x: 3,
                                        y: 3,
                                        width: contentView.height-6,
                                        height: contentView.height-6)
        profileImageView.layer.cornerRadius = profileImageView.height / 2
        
        let size: CGFloat = 100
        let buttonHeight: CGFloat = 40
        followButton.frame = CGRect(x: contentView.width-5-size,
                                    y: (contentView.height-44)/2,
                                  width: size,
                                  height: buttonHeight)
        followButton.backgroundColor = .orange
        label.frame = CGRect(x: profileImageView.right,
                             y: 0,
                             width: contentView.width-size-profileImageView.width-16,
                             height: contentView.height)
    }
    // MARK: - Methods
    func configure(with model: UserNotification) {
        self.model = model
        switch model.type {
        case .like(_):
            break
        case .follow(let state):
            // configure button here
            switch state {
            case .following:
                configureFollow()
                // Show unFollow Button
            case .not_following:
                followButton.setTitle("Follow", for: .normal)
                followButton.setTitleColor(.label, for: .normal)
                followButton.layer.borderWidth = 0
                followButton.backgroundColor = .link
            
            }
            break
        }
        
        label.text = model.text
        profileImageView.sd_setImage(with: model.user.profilePhoto, completed: nil)
    }
    
    private func configureFollow() {
        
        followButton.setTitle("Unfollow", for: .normal)
        followButton.setTitleColor(.label, for: .normal)
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    @objc private func didTapFollowButton() {
        guard let model = model else {
            return
        }
        delegate?.didTapFollowUnFollowButton(model: model)
    }
}
