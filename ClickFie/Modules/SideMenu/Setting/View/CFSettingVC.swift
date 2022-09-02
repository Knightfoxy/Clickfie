//
//  CFSettingVC.swift
//  ClickFie
//
//  Created by Ayush Mishra on 14/06/22.
//

import UIKit

class CFSettingVC: CFBaseVC {
    override func initialSetup() {
    }
    @IBAction private func didTapSideMenu(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "CFSideMenuVC") as? CFAddReviewsVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction private func switchToVisibility(_ sender: Any) {
    }
    @IBAction private func didTapLogout(_ sender: Any) {
        CommonFunction.shared.sessionExpire()
        navigationController?.popToRootViewController(animated: true)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let landingScrene = storyboard.instantiateViewController(withIdentifier:"CFLoginVC" )
            let navigationController = UINavigationController(rootViewController: landingScrene)
            setRoot(viewController: navigationController)
    }
    @IBAction private func didTapFAQ(_ sender: Any) {
        navigateToVC("Profile", "CFUnderProgressVC")
    }
    @IBAction private func didTapPrivacyPolicy(_ sender: Any) {
        navigateToVC("Profile", "CFUnderProgressVC")
    }
    @IBAction private func didTapInviteFriends(_ sender: Any) {
        navigateToVC("Profile", "CFUnderProgressVC")
    }
    @IBAction private func didTapProfileVisibility(_ sender: Any) {
        navigateToVC("Profile", "CFUnderProgressVC")
    }
    @IBAction private func didTapChangeNumber(_ sender: Any) {
        navigateToVC("Profile", "CFUnderProgressVC")
    }
    @IBAction private func didTapBlockedUser(_ sender: Any) {
        navigateToVC("Profile", "CFUnderProgressVC")
    }
    @IBAction private func didTapRatingApp(_ sender: Any) {
        navigateToVC("Profile", "CFUnderProgressVC")
    }
    func setRoot(viewController : UIViewController) {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let sceneDelegate = windowScene.delegate as? SceneDelegate
            else {
                return
            }
            sceneDelegate.window?.rootViewController = viewController
            sceneDelegate.window?.makeKeyAndVisible()
        }
}
