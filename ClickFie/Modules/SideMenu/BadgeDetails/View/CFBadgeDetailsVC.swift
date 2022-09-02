//
//  CFBadgeDetailsVC.swift
//  ClickFie
//
//  Created by Ayush Mishra on 16/06/22.
//

import UIKit

class CFBadgeDetailsVC: CFBaseVC {

    @IBOutlet private(set) weak var tableView: UITableView!
    override func initialSetup() {
        self.initialSettings()
    }
    @IBAction private func didTapBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension CFBadgeDetailsVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     return 200
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CFBadgeDetailsTC", for: indexPath)as? CFBadgeDetailsTC {
            cell.badgeDetailsLbl.text = badgeNames[indexPath.row]
            cell.badgeImage.image = UIImage(named: badgeImages[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
extension CFBadgeDetailsVC {
    func initialSettings() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}
