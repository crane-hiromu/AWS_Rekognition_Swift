//
//  MainViewController.swift
//  AWS_Rekognition_Swift
//
//  Created by h.crane on 2020/03/07.
//  Copyright © 2020 h.crane. All rights reserved.
//

import UIKit

// MARK: - Controller

final class MainViewController: UIViewController {
    
    // MARK: IBActions
    
    @IBAction private func showJudgment(_ sender: UIButton) {
        let vc = JudgmentViewController.instantiate()
        vc.isAmplify = false
        present(vc, animated: true)
    }
    
    @IBAction private func showJudgmentForAmplify(_ sender: UIButton) {
        let vc = JudgmentViewController.instantiate()
        vc.isAmplify = true
        present(vc, animated: true)
    }
}
