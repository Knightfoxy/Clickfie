//
//  CFAddReviewsVC.swift
//  ClickFie
//
//  Created by Ayush Mishra on 27/05/22.
//

import UIKit

class CFAddReviewsVC: CFBaseVC {
    var objAddReviewsVM : CFAddReviewsVM? = CFAddReviewsVM()
    @IBOutlet private(set) weak var extraView: UIView!        // view to record audio
    @IBOutlet private(set) weak var submitAudioView: UIView!  // submit audio view
    @IBOutlet private(set) weak var baseView: UIView!         // base view diff views changes
    @IBOutlet private(set) weak var audioTimingLabel: UILabel!// audio timing shows on submit view
    @IBOutlet private(set) weak var writeBtnOutlet: UIButton!
    @IBOutlet private(set) weak var ratingMssgLabel: UILabel!
    @IBOutlet private(set) weak var audioTimingOnRecordingView: UILabel!
    @IBOutlet private(set) weak var submitBtnOutlet: UIButton!
    @IBOutlet private(set) weak var audioDetailsOutlet: UIButton!
    @IBOutlet private(set) weak var ratingPercentLabel: UILabel!
    @IBOutlet private(set) weak var speakBtnOutlet: UIButton!
    override func initialSetup() {
        self.baseView.isHidden = true
        objAddReviewsVM?.reviewTypeShaper(writeBtnOutlet, UIColor.black.cgColor)
        objAddReviewsVM?.reviewTypeShaper(speakBtnOutlet, UIColor.black.cgColor)
        objAddReviewsVM?.reviewTypeShaper(audioDetailsOutlet, UIColor.lightGray.cgColor)
        objAddReviewsVM?.submitButtonShaper(submitBtnOutlet)
        self.extraView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width , height: 200)
        self.submitAudioView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width , height: 200)
    }
    @IBAction private func didTapBackBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction private func didTapWriteReview(_ sender: Any) { // written review
    }
    @IBAction private func didTapSpeakReview(_ sender: Any) { // speak audio review button
        self.baseView.isHidden = false
        self.baseView.addSubview(extraView)
    }
    @IBAction private func didTapPlayAudio(_ sender: Any) {   // play audio button
    }
    @IBAction private func didTapDeleteAudio(_ sender: Any) {// cross button to delete audio
        self.extraView.isHidden = true
    }
    @IBAction private func didTapSubmitAudio(_ sender: Any) {   // submitting audio
        self.baseView.isHidden = true
    }
    @IBAction private func didTapRecordAudioBtn(_ sender: UIButton) { // recording speak
        self.baseView.addSubview(submitAudioView)
    }
}
