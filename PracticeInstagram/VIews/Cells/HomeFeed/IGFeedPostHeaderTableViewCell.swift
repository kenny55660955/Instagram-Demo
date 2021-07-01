//
//  IGFeedPostHeaderTableViewCell.swift
//  PracticeInstagram
//
//  Created by Kenny on 2021/6/27.
//

import UIKit
import SDWebImage

protocol IGFeedPostHeaderTableViewCellDelegate: AnyObject {
    func didTapMoreButton()
}

class IGFeedPostHeaderTableViewCell: UITableViewCell {

    static let identifier = "IGFeedPostHeaderTableViewCell"
    
    weak var delegate: IGFeedPostHeaderTableViewCellDelegate?
    
    private let profilePhotoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let usenameLabel: UILabel = {
       let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let moreButton: UIButton = {
       let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        return button
    }()
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemGreen
        contentView.addSubview(profilePhotoImageView)
        contentView.addSubview(usenameLabel)
        contentView.addSubview(moreButton)
        moreButton.addTarget(self,
                             action: #selector(didTapButton),
                             for: .touchUpInside)
    }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = contentView.height-4
        profilePhotoImageView.frame = CGRect(x: 2,
                                             y: 2,
                                             width: size,
                                             height: size)
        profilePhotoImageView.layer.cornerRadius = size / 2
        moreButton.frame = CGRect(x: contentView.width-size,
                                  y: 2,
                                  width: size,
                                  height: size)
        
        usenameLabel.frame = CGRect(x: profilePhotoImageView.right+10,
                                    y: 2,
                                    width: contentView.width-(size*2),
                                    height: contentView.height-4)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        usenameLabel.text = nil
        
        profilePhotoImageView.image = nil
    }
    
    // MARK: - Methods
    
    func configure(with model: User) {
        // configure the cell
        usenameLabel.text = model.username
        
        profilePhotoImageView.image = UIImage(systemName: "person.circle")
        
//        profilePhotoImageView.sd_setImage(with: model.profilePhoto, completed: nil)
        
    }
    
    @objc
    private func didTapButton() {
        delegate?.didTapMoreButton()
    }
    
}
