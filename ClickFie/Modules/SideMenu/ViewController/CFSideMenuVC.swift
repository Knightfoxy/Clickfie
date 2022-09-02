//
//  CFSideMenuVC.swift
//  ClickFie
//
//  Created by Ayush Mishra on 20/05/22.
//

import UIKit

class CFSideMenuVC : CFBaseVC {
    var objBaseVC : CFBaseVC? = CFBaseVC()
    var objSideMenuVM = CFSideMenuViewModel()
    @IBOutlet private(set) weak var profileImage : UIImageView!
    @IBOutlet private(set) weak var crossImage: UIImageView!
    @IBOutlet private(set) weak var baseTableView : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.baseTableView.delegate = self
        self.baseTableView.dataSource = self
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
         crossImage.isUserInteractionEnabled = true
         crossImage.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        if (tapGestureRecognizer.view as? UIImageView) != nil {
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
            view.window!.layer.add(transition, forKey: kCATransition)
            navigationController?.popViewController(animated: true)
//            self.dismiss(animated: true, completion: nil)
//        CommonFunction.shared.navigateBack(self, "Profile", "CFHomeVC")
        }
    }
}
 extension CFSideMenuVC : UITableViewDelegate , UITableViewDataSource {
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 40
     }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenuCategeories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTVCell", for: indexPath) as? SideMenuTVCell {
        cell.categeogiesImage.image = UIImage(named: sideMenuCategeories[indexPath.row])
        cell.categeoriesLabel.text = sideCategeoriesTopics[indexPath.row]
        cell.categeoriesLabel.textColor = UIColor.red
        return cell
        } else {
            return UITableViewCell()
        }
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let vcID = objSideMenuVM.arrayOfvcID[indexPath.row].vcId
         navigateToVC("Profile", vcID)
     }

 }
