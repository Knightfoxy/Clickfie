//
//  CFTutorialVC.swift
//  ClickFie
//
//  Created by Ayush Mishra on 16/06/22.
//

import UIKit

class CFTutorialVC: CFBaseVC {
    @IBOutlet private(set) weak var pageControl: UIPageControl!
    @IBOutlet private(set) weak var collectionView: UICollectionView!
    override func initialSetup() {
        self.delegateCalls()
    }
}
extension CFTutorialVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CFTutorialCell", for: indexPath)as? CFTutorialCell {
            cell.tutorialImage.image = UIImage(named: tutorialCategories[indexPath.row])
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}
extension CFTutorialVC {
    func delegateCalls() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
}
