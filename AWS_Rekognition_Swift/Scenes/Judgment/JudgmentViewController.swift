//
//  JudgmentViewController.swift
//  AWS_Rekognition_Swift
//
//  Created by h.crane on 2020/03/07.
//  Copyright © 2020 h.crane. All rights reserved.
//

import UIKit
import AWSRekognition

// MARK: - ViewController

final class JudgmentViewController: UIViewController {
    
    // MARK: IBActions
    
    @IBAction private func didRecognizeLeft(_ sender: UIButton) {
        recognizeCelebrities(with: #imageLiteral(resourceName: "donald_0"))
    }
    @IBAction private func didRecognizeCenter(_ sender: UIButton) {
        recognizeCelebrities(with: #imageLiteral(resourceName: "donald_1"))
    }
    @IBAction private func didRecognizeRight(_ sender: UIButton) {
        recognizeCelebrities(with: #imageLiteral(resourceName: "donald_2"))
    }
    
    @IBAction private func didDetectLeft(_ sender: UIButton) {
        detectFaces(with: #imageLiteral(resourceName: "donald_0"))
    }
    @IBAction private func didDetectCenter(_ sender: UIButton) {
        detectFaces(with: #imageLiteral(resourceName: "donald_1"))
    }
    @IBAction private func didDetectRight(_ sender: UIButton) {
        detectFaces(with: #imageLiteral(resourceName: "donald_2"))
    }
    
    @IBOutlet private weak var logTextView: UITextView!
    
    // MARK: Propeties
    
    private var rekognitionObject: AWSRekognition?
    
    
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        debugPrint(#function)
    }
    
    
    // MARK: Methods
    
    private func recognizeCelebrities(with image: UIImage) {
        let rekognitionRequest = AWSRekognitionRecognizeCelebritiesRequest()
        rekognitionRequest?.image = image.convertJpegToAWSImage
        
        guard let request = rekognitionRequest else { return }
        
        rekognitionObject = AWSRekognition.default()
        rekognitionObject?.recognizeCelebrities(request) { [weak self] response, error in
            if let r = response {
                debugPrint("----success----", r)
                self?.log(text: "\(r)")
            } else if let e = error {
                debugPrint("----failure----", e)
                self?.log(text: e.localizedDescription)
            }
        }
    }
    
    private func detectFaces(with image: UIImage) {
        let facesRequest = AWSRekognitionDetectFacesRequest()
        facesRequest?.image = image.convertJpegToAWSImage
        
        guard let frequest = facesRequest else { return }
        
        rekognitionObject = AWSRekognition.default()
        rekognitionObject?.detectFaces(frequest) { [weak self] response, error in
            if let r = response {
                debugPrint("----success----", r)
                self?.log(text: "\(r)")
            } else if let e = error {
                debugPrint("----failure----", e)
                self?.log(text: e.localizedDescription)
            }
        }
    }
    
    private func log(text: String) {
        var str = text
        str = str.trimmingCharacters(in: .whitespacesAndNewlines)
        str = str.components(separatedBy: "\\n").joined()
        str = str.components(separatedBy: "\\").joined()
        str = str.components(separatedBy: ";").joined()
        
        DispatchQueue.main.async {
            self.logTextView.text = str
        }
    }
}

// MARK: - StoryboardInstantiatable

extension JudgmentViewController: StoryboardInstantiatable {}


// MARK: - Private

extension UIImage {

    var convertJpegToAWSImage: AWSRekognitionImage? {
        let rekognitionImage = AWSRekognitionImage()
        rekognitionImage?.bytes = self.jpegData(compressionQuality: 0.5)
        return rekognitionImage
    }
    
    var convertPngToAWSImage: AWSRekognitionImage? {
        let rekognitionImage = AWSRekognitionImage()
        rekognitionImage?.bytes = self.pngData()
        return rekognitionImage
    }
}
