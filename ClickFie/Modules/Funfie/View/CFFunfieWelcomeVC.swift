//
//  CFFunfieWelcomeVC.swift
//  ClickFie
//
//  Created by Ayush Mishra on 13/06/22.
//

import UIKit

class CFFunfieWelcomeVC: CFBaseVC {

    override func initialSetup() {
    }
    @IBAction private func didTapPlayBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CFFunfieChangeTargetVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
