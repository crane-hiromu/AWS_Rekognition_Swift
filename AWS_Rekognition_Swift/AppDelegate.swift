//
//  AppDelegate.swift
//  AWS_Rekognition_Swift
//
//  Created by h.crane on 2020/03/07.
//  Copyright © 2020 h.crane. All rights reserved.
//

import UIKit
import AWSCore
import Amplify
import AWSMobileClient
import AWSPredictionsPlugin

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        /// pattern1
        let predictionsPlugin = AWSPredictionsPlugin()
        try! Amplify.add(plugin: predictionsPlugin)
        try! Amplify.configure()
        ///
        
        
        /// pattern2
        let credentialsProvider = AWSCognitoCredentialsProvider(
            regionType: .USEast2,
            identityPoolId: "us-east-2:"
        )
        let configuration = AWSServiceConfiguration(
            region: .USEast2,
            credentialsProvider: credentialsProvider
        )
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        ///
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}
