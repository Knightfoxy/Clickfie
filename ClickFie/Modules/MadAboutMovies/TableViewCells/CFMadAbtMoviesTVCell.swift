//
//  CFMadAbtMoviesTVCell.swift
//  ClickFie
//
//  Created by Ayush Mishra on 23/05/22.
//

import UIKit

class CFMadAbtMoviesTVCell: UITableViewCell {
    var objMaMVM : CFMadAbtMoviesVM? = CFMadAbtMoviesVM()
    lazy var objBaseVC : CFBaseVC? = CFBaseVC()
    @IBOutlet private(set) weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegateSetup()
        objBaseVC?.collectionViewRegisterNib("CFMAbtMStoriesCollCell", collectionView)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
extension CFMadAbtMoviesTVCell : UICollectionViewDelegate, UICollectionViewDataSource {
    func delegateSetup() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return homeCategories.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
        }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CFMAbtMStoriesCollCell", for: indexPath) as? CFMAbtMStoriesCollCell {
            cell.moviesStoriesImage.image = UIImage(named: homeCategories[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}
