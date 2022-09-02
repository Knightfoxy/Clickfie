//
//  CFLoveCalculatorVC.swift
//  ClickFie
//
//  Created by Ayush Mishra on 13/06/22.
//

import UIKit

class CFLoveCalculatorVC: CFBaseVC {
    // MARK: - Stored Properties
    var objLoveGuruVM : CFLoveGuruVM? = CFLoveGuruVM()
    // MARK: - IB Outlets
    @IBOutlet private(set) weak var yourName: UITextField!
    @IBOutlet private(set) weak var endView: UIView!
    @IBOutlet private(set) weak var middleView: UIView!
    @IBOutlet private(set) weak var percentageLbl: UILabel!
    @IBOutlet private(set) weak var beforeCalculationView: UIView!
    @IBOutlet private(set) weak var afterCalculationView: UIView!
    @IBOutlet private(set) weak var yourNameAlertLbl: UILabel!
    @IBOutlet private(set) weak var crushNameAlertLbl: UILabel!
    @IBOutlet private(set) weak var crushName: UITextField!
    @IBOutlet private(set) weak var namesLbl: UILabel!
    @IBOutlet private(set) weak var calculationDisplayView: UIImageView!
    // MARK: - Lifecycle Methods
    override func initialSetup() {
        self.initialsetup()
        objLoveGuruVM?.viewCurve(endView, middleView)
        objLoveGuruVM?.fieldCurve(yourName,UIColor.systemPink.cgColor )
        objLoveGuruVM?.fieldCurve(crushName,UIColor.systemPink.cgColor )
        self.namesLbl.text = "\(yourName.text ?? "")" + "\(crushName.text ?? "")"
    }
    // MARK: - Custom Methods
    @IBAction private func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction private func didTapCalculate(_ sender: Any) {
        objLoveGuruVM?.actionOnGo(yourName, crushName, yourNameAlertLbl, crushNameAlertLbl, beforeView: beforeCalculationView, afterCalculationView)
        self.namesLbl.isHidden = false
    }
}
extension CFLoveCalculatorVC : UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.yourNameAlertLbl.isHidden = true
        self.crushNameAlertLbl.isHidden = true
        self.afterCalculationView.isHidden = true
        self.beforeCalculationView.isHidden = false
        return true
    }
    func initialsetup() {
        self.afterCalculationView.isHidden = true
        self.yourNameAlertLbl.isHidden = true
        self.crushNameAlertLbl.isHidden = true
        self.yourName.delegate = self
        self.crushName.delegate = self
    }
}
