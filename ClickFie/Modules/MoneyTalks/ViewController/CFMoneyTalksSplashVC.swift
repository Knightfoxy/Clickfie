//
//  CFMoneyTalksSplashVC.swift
//  ClickFie
//
//  Created by Ayush Mishra on 14/06/22.
//

import UIKit

class CFMoneyTalksSplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let sb = UIStoryboard(name: "Profile", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "CFMoneyTalksVC")
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
