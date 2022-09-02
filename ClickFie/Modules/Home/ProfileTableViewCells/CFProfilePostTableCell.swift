//
//  CFProfilePostTableCell.swift
//  ClickFie
//
//  Created by Ayush Mishra on 03/05/22.
//

import UIKit
//var image2 : UIImage!
class CFProfilePostTableCell: UITableViewCell {
    // MARK: - Stored Properties
    var toggleReactionforView = false
    var displaySideOption = false
    var collImage : UIImage!
    var longGestureOnReactionBtn = UILongPressGestureRecognizer()
    // MARK: - IB OUTLETS
    @IBOutlet private(set) weak var userNameLbl: UILabel!
    @IBOutlet private(set) weak var profilePic: UIImageView!
    @IBOutlet private(set) weak var displayTime: UILabel!
    @IBOutlet private(set) weak var threeBtnOption: UIButton!
    @IBOutlet private(set) weak var likeBtnOutlet: UIButton!
    @IBOutlet private(set) weak var captionLbl: UILabel!
    @IBOutlet private(set) weak var countedCommentsLbl: UILabel!
    @IBOutlet private(set) weak var countedLikeLbl: UILabel!
    @IBOutlet private(set) weak var commentorNameLbl: UILabel!
    @IBOutlet private(set) weak var latestCommentLbl: UILabel!
    @IBOutlet private(set) weak var addCommentTF: UITextField!
    @IBOutlet private(set) weak var sideMEnuOptionView: UIView!
    @IBOutlet private(set) weak var sideOptionBtnView: UIView! // bekar
    @IBOutlet private(set) weak var collectionView: UICollectionView!
    @IBOutlet private(set) weak var reactionView: UIView!
    @IBOutlet private(set) weak var pageController : UIPageControl!
    // MARK: - LIFECYCLE METHODS
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialSettings()
        let cellNib = UINib(nibName: "CFPostImageCell" , bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "CFPostImageCell")
        longGestureOnReactionBtn = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        longGestureOnReactionBtn.minimumPressDuration = 1
        likeBtnOutlet.addGestureRecognizer(longGestureOnReactionBtn)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    // MARK: - CUSTOM METHODS
    @IBAction private func didTapReactionBtn(_ sender: Any) {
        self.toggler(reactionView)
    }
    @IBAction private func didTapLikeReactionBtn(_ sender: Any) {
        self.reactingOnPost("icReactionLove")
    }
    @IBAction private func didTapFunnyBtn(_ sender: Any) {
        self.reactingOnPost("icReactionLmao")
    }
    @IBAction private func didTapLovedItBtn(_ sender: Any) {
        self.reactingOnPost("icReactionHeartbreaker")
    }
    @IBAction private func didTapDisplayComment(_ sender: Any) {
    }
    @IBAction private func didTapSideBtnAction(_ sender: Any) {
        self.toggler(sideMEnuOptionView)
    }
    @IBAction private func didTapHappyReactionBtn(_ sender: Any) {
        self.reactingOnPost("icReactionKillerCute")
    }
    @IBAction private func didTapShareOption(_ sender: Any) {
    }
    @objc func longPress(_ sender: UILongPressGestureRecognizer) {
        self.reactionView.isHidden = false
    }    
    func displayCell(_ cellData : WelcomeElement) {
        captionLbl.text = cellData.title
        displayTime.text = cellData.createdAt
        countedLikeLbl.text = String(cellData.totalLikes)
        countedCommentsLbl.text = String(cellData.totalComments)
        userNameLbl.text = cellData.postCreatedBy2.name
        if !cellData.commentedBy.isEmpty {
        commentorNameLbl.text = cellData.commentedBy[0]
        }
        if !cellData.lastestComment.isEmpty {
        latestCommentLbl.text = cellData.lastestComment[0]
        }
    }
}
extension CFProfilePostTableCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.size.height
        let width = collectionView.frame.size.width
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CFPostImageCell", for: indexPath)as? CFPostImageCell {
           if let checkImage = collImage {
               cell.postImage.image = checkImage
           }
            return cell
        } else {
        return UICollectionViewCell()
    }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageController.currentPage = indexPath.item
    }
}
extension CFProfilePostTableCell {
    func toggler(_ view : UIView) {
        if view == reactionView {
            if toggleReactionforView {
                let likeImage = UIImage(named: "postLikeActive")
                self.likeBtnOutlet.setImage(likeImage, for: .normal)
//                self.reactionView.isHidden = false
                self.toggleReactionforView = false
            } else {
                let likeImage = UIImage(named: "postLikeInactive")
                self.likeBtnOutlet.setImage(likeImage, for: .normal)
//                self.reactionView.isHidden = true
                self.toggleReactionforView = true
            }
        } else if view == sideMEnuOptionView {
            if displaySideOption {
                self.sideMEnuOptionView.isHidden = false
                self.displaySideOption = false
            } else {
                self.sideMEnuOptionView.isHidden = true
                self.displaySideOption = true
            }
        }
    }
    func optionView() {
        if toggleReactionforView {
            let likeImage = UIImage(named: "postLikeActive")
            self.likeBtnOutlet.setImage(likeImage, for: .normal)
            self.reactionView.isHidden = false
            self.toggleReactionforView = false
        } else {
            let likeImage = UIImage(named: "postLikeInactive")
            self.likeBtnOutlet.setImage(likeImage, for: .normal)
            self.reactionView.isHidden = true
            self.toggleReactionforView = true
        }
    }
    func viewDesigning(_ view : UIView) {
        view.layer.shadowOffset = CGSize(width: 6, height: 6)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = CGFloat(3)
        view.layer.masksToBounds = false
        view.layer.cornerRadius = CGFloat(23)
    }
    func initialSettings() {
        self.toggler(reactionView)
        self.viewDesigning(reactionView)
        self.viewDesigning(sideOptionBtnView)
        self.sideMEnuOptionView.isHidden = true
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.reactionView.isHidden = true
    }
    func reactingOnPost(_ imageName : String) {
        self.reactionView.isHidden = true
        let reaction = UIImage(named: String(imageName))
        self.likeBtnOutlet.setImage(reaction, for: .normal)
    }
}
