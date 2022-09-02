//
//  CFBaseVC.swift
//  ClickFie
//
//  Created by Ayush Mishra on 20/05/22.
//

import UIKit

class CFBaseVC: UIViewController {
    @objc func dismissKeyBoard() {
        view.endEditing(true)
    }
   @objc func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self , action: #selector(dismissKeyBoard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    func registerNib(_ cellIdentifier : String,_ baseTableView : UITableView) {
        let cellNib = UINib(nibName: cellIdentifier , bundle: nil)
        baseTableView.register(cellNib, forCellReuseIdentifier: cellIdentifier)
    }
    func collectionViewRegisterNib(_ cellIdentifier : String,_ baseCollectionView : UICollectionView) {
        let cellNib = UINib(nibName: cellIdentifier , bundle: nil)
        baseCollectionView.register(cellNib, forCellWithReuseIdentifier: cellIdentifier)
    }
    func navigateToVC(_ sbName : String,_ id : String) {
        let sb = UIStoryboard(name: sbName, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: id)
        navigationController?.pushViewController(vc, animated: true)
    }
    func otpSheetViewer(_ phoneNumber : String,_ vcId : String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "CFOtpSheetVC") as? CFOtpSheetVC else { return }
        if let pc = vc.presentationController as? UISheetPresentationController {
            pc.detents = [.medium()]
            vc.phoneNum = phoneNumber
            vc.vcId = vcId
            self.present(vc,animated: true)
        }
    }
    @objc func swipedright() {
        _ = UIStoryboard(name: "Profile", bundle: nil)
        self.navigationController?.popViewController(animated: true)
    }
}
extension CFBaseVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipedright))
        swipeRight.direction  = .right
        self.view.addGestureRecognizer(swipeRight)
        hideKeyboardWhenTappedAround()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initialSetup()
    }
}

extension CFBaseVC {
    @objc func initialSetup() {
        // Initial setup for the class, is called in view did load and View will appear.
    }
}
