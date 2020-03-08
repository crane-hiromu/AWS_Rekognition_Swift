# AWS_Rekognition_Swift

## Description

It is a demo of AWS Rekognition.

You have to read [[Swift] AWS Amplify Rekognitionを使って顔認識させる](https://qiita.com/H_Crane/items/b621ad401b55b75eb97c).

## Pattern

### 1. AWS Amplify

#### ① Podfile

```
pod 'Amplify'
pod 'AmplifyPlugins'
pod 'AWSPluginsCore'
pod 'CoreMLPredictionsPlugin'
pod 'AWSPredictionsPlugin'
pod 'AWSMobileClient', '~> 2.12.2'
```

#### ② Setup

```.swift
import Amplify
import AWSMobileClient
import AWSPredictionsPlugin

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let apiPlugin = AWSPredictionsPlugin()
        do {
            try Amplify.add(plugin: apiPlugin)
            try Amplify.configure()
        } catch {
            print("Failed to configure Amplify \(error)")
        }

        return true
}
```

#### ③ Request

```.swift
import Amplify
guard let path = Bundle.main.path(forResource: name, ofType: "jpg") else { return }
let url = URL(fileURLWithPath: path)

_ = Amplify.Predictions.identify(type: .detectEntities, image: url, listener: { [weak self] event in
    switch event {
    case .completed(let result):
        debugPrint("----completed----", "\(result)")

    case .failed(let error):
        debugPrint("----failed----", error.errorDescription)

    case .notInProcess, .inProcess, .unknown:
        debugPrint("----other----", event.description)
    }
})
```



### 2. Default

#### ① Podfile

```
pod 'AWSRekognition'
```

#### ② Setup

```.swift
import UIKit
import AWSCore

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let credentialsProvider = AWSCognitoCredentialsProvider(
            regionType: .USEast2,
            identityPoolId: "xxxxxx" // set your pool id
        )
        let configuration = AWSServiceConfiguration(
            region: .USEast2,
            credentialsProvider: credentialsProvider
        )
        AWSServiceManager.default().defaultServiceConfiguration = configuration

        return true
    }
}
```

#### ③ Request

```.swift
import AWSRekognition

private func detectFaces(with image: UIImage) {
    let image: UIImage = /* image literal */

    let rekognitionImage = AWSRekognitionImage()
    rekognitionImage?.bytes = image.jpegData(compressionQuality: 0.5)

    guard let frequest = facesRequest else { return }

    rekognitionObject = AWSRekognition.default()
    rekognitionObject?.detectFaces(frequest) { response, error in
        if let r = response {
            debugPrint("----success----", r)

        } else if let e = error {
            debugPrint("----failure----", e)

        }
    }
}
```

## Content

You can check API of Rekognition like that.

<img width="1805" alt="68747470733a2f2f71696974612d696d6167652d73746f72652e73332e61702d6e6f727468656173742d312e616d617a6f6e6177732e636f6d2f302f3137353234322f34636363373732342d303463352d323339622d636437652d6563393366643165323534322e706e67" src="https://user-images.githubusercontent.com/24838521/76168391-b9f2ee00-61b2-11ea-9a9e-9e7c35683d9b.png">
