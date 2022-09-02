//
//  CFCountryCodeVC.swift
//  ClickFie
//
//  Created by Admin on 05/04/22.
//

import UIKit

var countryCodeClosure : ((_ cCode : String ,_ nationalFlag : UIImage) -> Void)?

class CFCountryCodeVC: UIViewController {
    var image : UIImage?

    // MARK: - Component Outlets
    @IBOutlet weak private(set) var countryCodeTableView: UITableView!
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.countryCodeTableView.dataSource = self
        self.countryCodeTableView.delegate = self
    }
}
extension CFCountryCodeVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CountryData.shared.allCountryDataArray.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row % 3 == 1 {
            image = UIImage(named: ImageAsset.australia.rawValue)
        } else if indexPath.row % 3 == 2 {
            image = UIImage(named: ImageAsset.china.rawValue)
         } else {
            image = UIImage(named: ImageAsset.nationalityFlagIcon.rawValue)
         }
        countryCodeClosure?(CountryData.shared.allCountryDataArray[indexPath.row].code , image! )
        self.dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = countryCodeTableView.dequeueReusableCell(withIdentifier: "CFCountryCodeTableCell", for: indexPath) as? CFCountryCodeTableCell {
            if indexPath.row % 3 == 1 {
                cell.countryImage.image = UIImage(named: ImageAsset.australia.rawValue)
            } else if indexPath.row % 3 == 2 {
                    cell.countryImage.image = UIImage(named: ImageAsset.china.rawValue)
            } else {
                cell.countryImage.image = UIImage(named: ImageAsset.nationalityFlagIcon.rawValue)
            }
            cell.countryCodeLbl.text = CountryData.shared.allCountryDataArray[indexPath.row].code
            cell.countryNameLbl.text = CountryData.shared.allCountryDataArray[indexPath.row].name
            return cell
        }
        return UITableViewCell()
    }
}
