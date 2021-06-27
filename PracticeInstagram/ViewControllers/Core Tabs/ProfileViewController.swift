//
//  ProfileViewController.swift
//  PracticeInstagram
//
//  Created by Kenny on 2021/6/26.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    // MARK: - Property
    private var collectionView: UICollectionView?
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        layout.itemSize = CGSize(width: view.width / 3, height: view.width / 3)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        guard let collectionView = collectionView else { return }
        view.addSubview(collectionView)
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSettingButton))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    @objc private func didTapSettingButton() {
        let vc = SettingViewController()
        vc.title = "Setting"
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
