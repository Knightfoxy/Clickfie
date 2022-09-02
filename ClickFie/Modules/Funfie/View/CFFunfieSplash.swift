//
//  CFFunfieSplash.swift
//  ClickFie
//
//  Created by Ayush Mishra on 13/06/22.
//

import UIKit

class CFFunfieSplash: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline : .now() + 1.0) {
            let storyboard = UIStoryboard(name: "Profile", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "CFFunfieWelcomeVC")
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
