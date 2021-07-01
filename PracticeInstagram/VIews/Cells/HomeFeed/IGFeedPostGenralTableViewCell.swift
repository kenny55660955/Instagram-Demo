//
//  IGFeedPostGenralTableViewCell.swift
//  PracticeInstagram
//
//  Created by Kenny on 2021/6/27.
//

import UIKit

/// Commends
class IGFeedPostGenralTableViewCell: UITableViewCell {
    
    static let identifier = "IGFeedPostGenralTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .yellow
    }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure() {
        // configure the cell
    }


}
