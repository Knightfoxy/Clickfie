//
//  CFUnderProgressVC.swift
//  ClickFie
//
//  Created by Ayush Mishra on 23/06/22.
//

import UIKit

class CFUnderProgressVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipedright))
        swipeRight.direction  = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    @objc func swipedright() {
        _ = UIStoryboard(name: "Profile", bundle: nil)
        self.navigationController?.popViewController(animated: true)
    }
}
