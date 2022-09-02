//
//  ViewController.swift
//  ClickFie
//
//  Created by Admin on 04/04/22.
//

import UIKit

class CFLoginVC: UIViewController, UITextFieldDelegate {
    // MARK: - Outlets
    @IBOutlet weak private(set) var phoneNumTF: UITextField!
    @IBOutlet weak private(set) var flagImage: UIImageView!
    @IBOutlet weak private(set) var countryCodeLbl: UILabel
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.phoneNumTF.delegate = self
        phoneNumTF.keyboardType = .numberPad
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        countryCodeClosure = { cCode in
            self.countryCodeLbl.text = cCode
        }
    }
    // MARK: - IB Actions
    @IBAction private func countrySheetBtn(_ sender: Any) {
        parseJSON()    // button tap to open country code sheet
    }
    @IBAction private func loginButtonAction(_ sender: Any) {
        otpSheetViewer()  // button to display otp screen next
    }
    @IBAction private func faceBookBtn(_ sender: Any) {
        // fb button to do nothing
    }
    @IBAction private func googleBtn(_ sender: Any) {
        // google button to do nothing
    }

    // MARK: - Custom Methods
    private func parseJSON() {
        guard let path = Bundle.main.path(forResource: "CountryCode", ofType: "json")
        else {
            return
        }
        let url = URL(fileURLWithPath: path)
        do {
            let jsonData = try Data(contentsOf: url)
            CountryData.shared.allCountryDataArray = try JSONDecoder().decode([CountryCodeModel].self, from: jsonData)
            print(CountryData.shared.allCountryDataArray)
        } catch let error {
            print(error)
        }
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    func otpSheetViewer() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CFOtpSheetVC")
        if let pc = vc.presentationController as? UISheetPresentationController {
            pc.detents = [.medium()]
            self.present(vc,animated: true)
        }
    }
}
