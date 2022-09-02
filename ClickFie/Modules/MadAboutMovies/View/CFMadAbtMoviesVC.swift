//
//  CFMadAbtMoviesVC.swift
//  ClickFie
//
//  Created by Ayush Mishra on 23/05/22.
//

import UIKit

class CFMadAbtMoviesVC : CFBaseVC {
    @IBOutlet private(set) weak var baseTableView: UITableView!
    static let id = "Profile"
    override func initialSetup() {
        self.setupDelegates()
        registerNib("CFMadAbtMoviesTVCell", baseTableView)
    }
    @objc func swipedRight() {
        _ = UIStoryboard(name: "Profile", bundle: nil)
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction private func sideMenuBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "CFSideMenuVC") as? CFAddReviewsVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction private func addReviewsBtn(_ sender: Any) {
        self.addReviewsSheetViewer()
    }
}
extension CFMadAbtMoviesVC : UITableViewDataSource , UITableViewDelegate {
    func setupDelegates() {
        self.baseTableView.dataSource = self
        self.baseTableView.delegate = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 80
        }
        return 675
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = baseTableView.dequeueReusableCell(withIdentifier: "CFMadAbtMoviesTVCell", for: indexPath) as? CFMadAbtMoviesTVCell {
            return cell
        }
        return UITableViewCell()
    }
    func addReviewsSheetViewer() {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "CFAddReviewsVC") as? CFAddReviewsVC else { return }
        if let pc = vc.presentationController as? UISheetPresentationController {
            pc.detents = [.medium()]
            self.present(vc,animated: true)
        }
    }
}
