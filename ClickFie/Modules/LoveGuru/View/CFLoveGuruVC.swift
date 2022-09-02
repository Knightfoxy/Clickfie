//
//  CFLoveGuruVC.swift
//  ClickFie
//
//  Created by Ayush Mishra on 31/05/22.
//

import UIKit

class CFLoveGuruVC: CFBaseVC {
    @IBOutlet private(set) weak var baseViewAfterBtnTap: UIView!
    @IBOutlet private(set) weak var optionBtnOutlet: UIButton!
    @IBOutlet private(set) weak var tableView: UITableView!
    @IBOutlet private(set) weak var bottomRoundView: UIView!
    @IBOutlet private(set) weak var cancelViewOutlet: UIButton!
    override func initialSetup() {
        self.baseViewAfterBtnTap.isHidden = true
        self.cancelViewOutlet.isHidden = true
        self.tableView.dataSource = self
        self.tableView.delegate = self
        registerNib("CFLoveGuruCell", tableView)
        self.bottomRoundView.frame = CGRect(x: 0 , y: 0, width: self.view.frame.width, height:100)
        self.bottomRoundView.addTopRoundedCornerToView(targetView: bottomRoundView, desiredCurve: 40)
    }
    @IBAction private func didTapLoveCalculator(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CFLoveCalculatorVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction private func didTapSideMenu(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "CFSideMenuVC") as? CFAddReviewsVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction private func didTapPostQuestion(_ sender: Any) {
    }
    @IBAction private func didTapAskLoveGuru(_ sender: Any) {
    }
    @IBAction private func didTapCancel(_ sender: Any) {
        self.baseViewAfterBtnTap.isHidden = true
        self.cancelViewOutlet.isHidden = true
        self.optionBtnOutlet.isHidden = false
    }
    @IBAction private func didTapSelectOptions(_ sender: Any) {
        self.baseViewAfterBtnTap.isHidden = false
        self.optionBtnOutlet.isHidden = true
        self.cancelViewOutlet.isHidden = false
    }
}
extension CFLoveGuruVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CFLoveGuruCell", for: indexPath)as? CFLoveGuruCell {
        return cell
        } else {
            return UITableViewCell()
        }
    }
}
