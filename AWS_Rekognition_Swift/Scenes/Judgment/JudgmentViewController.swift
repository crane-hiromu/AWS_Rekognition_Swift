//
//  JudgmentViewController.swift
//  AWS_Rekognition_Swift
//
//  Created by h.crane on 2020/03/07.
//  Copyright © 2020 h.crane. All rights reserved.
//

import UIKit
import AWSRekognition
import Amplify

// MARK: - ViewController

final class JudgmentViewController: UIViewController {
    
    // MARK: Properties
    
    var isAmplify = false
    
    private var tops: [UIButton] {
        return [leftTopBtn, middleTopBtn, rightTopBtn]
    }
    private var middles: [UIButton] {
        return [leftCenterBtn, middleCenterBtn, rightCenterBtn]
    }
    private var bottoms: [UIButton] {
        return [leftBottomBtn, middleBottomBtn, rightBottomBtn]
    }
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var leftTopBtn: UIButton!
    @IBOutlet private weak var leftCenterBtn: UIButton!
    @IBOutlet private weak var leftBottomBtn: UIButton!
    
    @IBOutlet private weak var middleTopBtn: UIButton!
    @IBOutlet private weak var middleCenterBtn: UIButton!
    @IBOutlet private weak var middleBottomBtn: UIButton!
    
    @IBOutlet private weak var rightTopBtn: UIButton!
    @IBOutlet private weak var rightCenterBtn: UIButton!
    @IBOutlet private weak var rightBottomBtn: UIButton!
    
    @IBOutlet private weak var logTextView: UITextView!
    
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
    
    @IBAction private func didDetectEntitiesLeft(_ sender: Any) {
        detectEntitiesByAmplify(with: "donald_0")
    }
    @IBAction private func didDetectEntitiesCenter(_ sender: Any) {
        detectEntitiesByAmplify(with: "donald_1")
    }
    @IBAction private func didDetectEntitiesRight(_ sender: Any) {
        detectEntitiesByAmplify(with: "donald_2")
    }
    
    
    // MARK: Propeties
    
    private var rekognitionObject: AWSRekognition?
    
    
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 画面を共通で使っているので、ボタンを出しわけしている
        if isAmplify {
            tops.forEach { $0.isHidden = true }
            middles.forEach { $0.isHidden = true }
        } else {
            bottoms.forEach { $0.isHidden = true }
        }
    }
}

// MARK: - Private

private extension JudgmentViewController {
    
    func recognizeCelebrities(with image: UIImage) {
        logTextView.text = "wait for response..."
        
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
    
    func detectFaces(with image: UIImage) {
        logTextView.text = "wait for response..."
        
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
    
    func detectEntitiesByAmplify(with name: String) {
        logTextView.text = "wait for response..."
        
        guard let path = Bundle.main.path(forResource: name, ofType: "jpg") else { return }
        let url = URL(fileURLWithPath: path)
                
        _ = Amplify.Predictions.identify(type: .detectEntities,
                                         image: url,
                                         listener: { [weak self] event in
                
            switch event {
            case .completed(let result):
                debugPrint("----completed----", "\(result)")
                self?.log(text: "\(result)")
            case .failed(let error):
                debugPrint("----failed----", error.errorDescription)
                self?.log(text: error.errorDescription)
            case .notInProcess, .inProcess, .unknown:
                debugPrint("----other----", event.description)
                self?.log(text: event.description)
            }
        })
    }
    
    func log(text: String) {
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
