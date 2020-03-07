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
        present(vc, animated: true)
    }
    
    @IBAction private func showPhoto(_ sender: UIButton) {
        
    }
    
    @IBAction private func showVideo(_ sender: UIButton) {
        
    }
}
