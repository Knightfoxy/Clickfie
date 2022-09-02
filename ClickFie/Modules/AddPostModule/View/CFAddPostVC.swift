//
//  CFAddPostVC.swift
//  ClickFie
//
//  Created by Ayush Mishra on 16/05/22.
//

import UIKit
import Photos
import BSImagePicker
import FirebaseStorage

class CFAddPostVC: CFBaseVC {
    // MARK: - Stored Properties
    lazy var objAddPostViewModel : CFAddPostViewModel? = CFAddPostViewModel()
    lazy var objBaseVC : CFBaseVC? = CFBaseVC()
    var pickerController: UIImagePickerController?
    private let storage = Storage.storage().reference()
    // MARK: - IB Outlets
    @IBOutlet private(set) weak var progressView: UIView!
    @IBOutlet private(set) weak var addPicsOutlet: UIButton!
    @IBOutlet private(set) weak var progressSpinner: UIActivityIndicatorView!
    @IBOutlet private(set) weak var baseCollectionView: UICollectionView!
    @IBOutlet private(set) weak var statusLabel: UILabel!
    @IBOutlet private(set) weak var initialPicOutlet: UIImageView!
    @IBOutlet private(set) weak var captionTF: UITextField!
    // MARK: - Lifecycle Methods
    override func initialSetup() {
        objBaseVC?.collectionViewRegisterNib("CFAddPostCollectionCell", baseCollectionView)
        delegateSetUp()
        objAddPostViewModel?.showImgPlaceholder(initialPicOutlet)
        self.baseCollectionView.reloadData()
        hideKeyboardWhenTappedAround()
        objAddPostViewModel?.addPostOnApiSuccessful = { [self] in
            self.progressView.isHidden = true
            self.progressSpinner.isHidden = true
            self.statusLabel.isHidden = false
            self.statusLabel.text  = "Post Added Successfully"
            CommonFunction.shared.animatedDelayLabel(self.statusLabel)
        }
        objAddPostViewModel?.addPostOnApiFailure = {
            self.progressView.isHidden = true
            self.statusLabel.isHidden = false
            self.statusLabel.text  = "Failed , Post not added"
            CommonFunction.shared.animatedDelayLabel(self.statusLabel)
        }
    }
    // MARK: - IB Actions
    @IBAction private func backBtn(_ sender: Any) {
        CommonFunction.shared.navigateBack(self, "Profile", "CFHomeVC")
    }
    @IBAction private func addPicsBtnAction(_ sender: Any) {
        self.openPhoto()
    }
    @IBAction private func uploadPicBtn(_ sender: Any) {
        let caption = captionTF.text ?? ""
        if caption.isEmpty == true {
            statusLabel.isHidden = false
            statusLabel.text = "empty caption"
        }
        objAddPostViewModel?.onTapUpload(caption, progressView, progressSpinner, statusLabel)
    }
    // MARK: - Custom Methods
    @objc func deletePicBtn(_ sender: UIButton!) {
        self.objAddPostViewModel?.toDeleteImagePost(baseCollectionView, sender)
    }
}
extension CFAddPostVC : UITextFieldDelegate ,UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func openPhoto() {
        let imagePicker = ImagePickerController()
        presentImagePicker(imagePicker, select: { (_) in
        }, deselect: { (_) in
        }, cancel: { (_) in
        }, finish: { [self] (assets) in
            for item in 0..<assets.count {
                objAddPostViewModel?.addingSelectedImage(item, assets: assets)
            }
            self.objAddPostViewModel?.convertAssetsToImages(self.baseCollectionView)
        })
    }
    func delegateSetUp() {
        self.captionTF.delegate = self
        self.baseCollectionView.delegate = self
        self.baseCollectionView.dataSource = self
        self.progressView.isHidden = true
        self.progressSpinner.isHidden = true
        self.statusLabel.isHidden = true
    }
}
extension CFAddPostVC : UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.size.width
        return CGSize(width: width , height: 275)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (objAddPostViewModel?.numberOfItemsInSection()) ?? 0
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = baseCollectionView.dequeueReusableCell(withReuseIdentifier: "CFAddPostCollectionCell", for: indexPath) as? CFAddPostCollectionCell {
            cell.deleteBtnCell.tag = indexPath.row
            cell.postPicsImageView.image = objAddPostViewModel?.addingDataToPhotoArray(indexPath.row)
            cell.deleteBtnCell.addTarget(self, action: #selector(deletePicBtn), for: UIControl.Event.touchUpInside)
            return cell
        }
        return UICollectionViewCell()
    }
}
extension CFAddPostVC {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        statusLabel.isHidden = true
        return true
    }
}
