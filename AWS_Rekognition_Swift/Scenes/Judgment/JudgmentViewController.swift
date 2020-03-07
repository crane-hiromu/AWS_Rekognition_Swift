//
//  JudgmentViewController.swift
//  AWS_Rekognition_Swift
//
//  Created by admin on 2020/03/07.
//  Copyright © 2020 h.crane. All rights reserved.
//

import UIKit
import AWSRekognition

// MARK: - ViewController

final class JudgmentViewController: UIViewController {
    
    // MARK: IBActions
    
    @IBAction private func didTapLeft(_ sender: UIButton) {
        judge(with: #imageLiteral(resourceName: "donald_0"))
    }
    @IBAction private func didTapCenter(_ sender: UIButton) {
        judge(with: #imageLiteral(resourceName: "donald_1"))
    }
    @IBAction private func didTapRight(_ sender: UIButton) {
        judge(with: #imageLiteral(resourceName: "donald_2"))
    }
    
    
    // MARK: Propeties
    
    private var rekognitionObject: AWSRekognition?
    
    
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        debugPrint(#function)
    }
    
    
    // MARK: Methods
    
    private func judge(with image: UIImage) {
        rekognitionObject = AWSRekognition.default()
        
        let rekognitionImage = AWSRekognitionImage()
        rekognitionImage?.bytes = image.jpegData(compressionQuality: 0.5)
        
        let rekognitionRequest = AWSRekognitionRecognizeCelebritiesRequest()
        rekognitionRequest?.image = rekognitionImage
        
        guard let request = rekognitionRequest else { return }
        
        rekognitionObject?.recognizeCelebrities(request) { result, error in
            if let r = result {
                debugPrint("----success----", r)
            
            } else if let e = error {
                debugPrint("----failure----", e)
            
            }
        }
    }
}

// MARK: - StoryboardInstantiatable

extension JudgmentViewController: StoryboardInstantiatable {}
