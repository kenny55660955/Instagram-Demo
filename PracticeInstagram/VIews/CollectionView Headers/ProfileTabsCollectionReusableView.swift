//
//  ProfileTabsCollectionReusableView.swift
//  PracticeInstagram
//
//  Created by Kenny on 2021/6/28.
//

import UIKit

class ProfileTabsCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "ProfileTabsCollectionReusableView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .yellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
