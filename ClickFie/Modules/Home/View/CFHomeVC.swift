//
//  CFProfileVC.swift
//  ClickFie
//
//  Created by Ayush Mishra on 29/04/22.
//

import UIKit

class CFHomeVC: CFBaseVC {
    // MARK: - Stored Properties
    var objCFHomeVM = CFHomeVM()
    var allPostData : [WelcomeElement] = []
    // MARK: - IB OUTLET
    @IBOutlet weak private(set) var baseTableView: UITableView!
    // MARK: - LIFECYCLE METHODS
    override func initialSetup() {
//        self.baseTableView.reloadData()
        navigationController?.isNavigationBarHidden = true
        self.delegateSetup()
        objCFHomeVM.getAllPostDataApiCall()
        imageDownloadSuccessClosure = { successImage in
            testImage = successImage
            self.baseTableView.reloadData()
        }
        objCFHomeVM.getProfileData = { [self] data in
            allPostData = data
            self.baseTableView.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        objCFHomeVM.getAllPostDataApiCall()
        self.baseTableView.reloadData()
    }
    // MARK: - IB ACTIONS
    @IBAction private func sideMenu(_ sender: Any) {
        let sb = UIStoryboard(name: "Profile", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CFSideMenuVC")
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction private func searchBtn(_ sender: Any) {
    }
    @IBAction private func homeLeaderBoard(_ sender: Any) {
        navigateToVC("profile", "CFUnderProgressVC")
    }
    @IBAction private func addPostAction(_ sender: Any) {
        navigateToVC("Profile", "CFAddPostVC")
    }
    // MARK: - Custom Methods
    @objc func navigateToFeatures(_ feature: Int ) {
        switch feature {
        case 0 :
            navigateToVC("Profile", "CFMadAbtMoviesVC")
        case 1 :
            navigateToVC("Profile", "CFLoveGuruVC")
        case 2 :
            navigateToVC("Profile", "CFMoneyTalksSplashVC")
        case 3 :
            navigateToVC("Profile", "CFFunfieSplash")
        case 4 :
            navigateToVC("Profile", "CFUnderProgressVC")
        default :
            break
        }
    }
}
extension CFHomeVC : UITableViewDelegate , UITableViewDataSource {
    func delegateSetup() {
        baseTableView.delegate = self
        baseTableView.dataSource = self
        registerNib("CFProfileTVCell",baseTableView)
        registerNib("CFProfilePostTableCell",baseTableView)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return allPostData.count
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 120
        } else {
            return 675
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = baseTableView.dequeueReusableCell(withIdentifier: "CFProfileTVCell", for: indexPath)as? CFProfileTVCell {
                cell.onDidSelectItem = { index in
                    self.navigateToFeatures(index)
                }
                return cell
            }
        } else {
            if let cell = baseTableView.dequeueReusableCell(withIdentifier: "CFProfilePostTableCell", for: indexPath)as? CFProfilePostTableCell {
                cell.displayCell(allPostData[indexPath.row])
                if let checkImage = testImage {
                cell.collImage = checkImage
                }
                return cell
            }
        }
        return UITableViewCell()
    }
}
