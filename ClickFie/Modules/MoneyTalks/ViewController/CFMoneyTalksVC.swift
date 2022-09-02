//
//  CFMoneyTalksVC.swift
//  ClickFie
//
//  Created by Ayush Mishra on 14/06/22.
//

import UIKit

class CFMoneyTalksVC: UIViewController {
    // MARK: - IB OUTLETS
    @IBOutlet private(set) weak var circularView3: UIView!
    @IBOutlet private(set) weak var circularView2: UIView!
    @IBOutlet private(set) weak var circularView1: UIView!
    // MARK: - LIFECYCLE METHOS
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - CUSTOM METHODS
    @IBAction private func didTapBack(_ sender: Any) {
        let sb = UIStoryboard(name: "Profile", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CFHomeVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
