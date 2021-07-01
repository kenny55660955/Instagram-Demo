//
//  ProfileTabsCollectionReusableView.swift
//  PracticeInstagram
//
//  Created by Kenny on 2021/6/28.
//

import UIKit

protocol ProfileTabsCollectionReusableViewDelegate: AnyObject {
    func didTapGridButtonTab()
    func didTapTaggedButtonTab()
}

class ProfileTabsCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "ProfileTabsCollectionReusableView"
    
    weak var delegate: ProfileTabsCollectionReusableViewDelegate?
    
    private let gridButton: UIButton = {
       let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .systemBlue
        button.setBackgroundImage(UIImage(named: "logo"), for: .normal)
        return button
    }()
    
    private let taggedButton: UIButton = {
       let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .secondarySystemBackground
        button.setBackgroundImage(UIImage(named: "logo"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        addSubview(gridButton)
        addSubview(taggedButton)
        
        gridButton.addTarget(self, action: #selector(didTapGridButton),
                             for: .touchUpInside)
        taggedButton.addTarget(self, action: #selector(didTapTaggedButton),
                               for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        superview?.layoutSubviews()
        
        let size = height - (Constant.padding * 2)
        let gridButtonX = ((width/2)-size) / 2
        
        gridButton.frame = CGRect(x: gridButtonX,
                                  y: Constant.padding,
                                    width: size,
                                    height: size)
        
        taggedButton.frame = CGRect(x: gridButtonX + (width/2),
                                    y: Constant.padding,
                                    width: size,
                                    height: size)
        
    }
    
    @objc private func didTapGridButton() {
        gridButton.tintColor = .systemBlue
        taggedButton.tintColor = .lightGray
        delegate?.didTapGridButtonTab()
    }
    
    @objc private func didTapTaggedButton() {
        gridButton.tintColor = .lightGray
        taggedButton.tintColor = .systemBlue
        delegate?.didTapTaggedButtonTab()
    }
}
extension ProfileTabsCollectionReusableView {
    
    struct Constant {
        static let padding: CGFloat = 8
    }
}
