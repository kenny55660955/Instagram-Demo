//
//  IGFeedPostTableViewCell.swift
//  PracticeInstagram
//
//  Created by Kenny on 2021/6/27.
//

import UIKit
import SDWebImage
import AVFoundation
/// Cell for primary post content
final class IGFeedPostTableViewCell: UITableViewCell {
    
    static let identifier = "IGFeedPostTableViewCell"
    
    private let postImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = nil
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var player: AVPlayer?
    private var playerLayer = AVPlayerLayer()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.addSublayer(playerLayer)
        contentView.addSubview(postImageView)
    }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = contentView.bounds
        postImageView.frame = contentView.bounds
    }
    
    func configure(with post: UserPhotoPost) {
        
        postImageView.image = UIImage(named: "test")
        // configure the cell
        
        return
        
        switch post.postType {
        case .photo:
            // shows image
            postImageView.sd_setImage(with: post.postURL, completed: nil)
        case .video:
            // load and play videos
            player = AVPlayer(url: post.postURL)
            playerLayer.player = player
            playerLayer.player?.volume = 0
            playerLayer.player?.play()
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
    }
    

    
}
