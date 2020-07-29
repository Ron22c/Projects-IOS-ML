//
//  ViewController.swift
//  weather-message
//
//  Created by Ranajit Chandra on 24/02/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

import UIKit
import Firebase
import GoogleMobileAds

class ViewController: UIViewController, GADRewardBasedVideoAdDelegate {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        GADRewardBasedVideoAd.sharedInstance().delegate = self
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) {
            (Authdata, error) in
            if error == nil {
                print("Login Successful")
                self.performSegue(withIdentifier: "login", sender: self)
            } else {
                print(error!)
            }
        }
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) {
            (AuthData, error) in
            if error == nil {
                print("Successfully created user")
                self.performSegue(withIdentifier: "signup", sender: self)
            } else {
                print(error!)
            }
        }
    }
    
    @IBAction func cacheButtonPressed(_ sender: UIButton) {
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [kGADSimulatorID] as? [String]
        GADRewardBasedVideoAd.sharedInstance().load(GADRequest(),
        withAdUnitID: "ca-app-pub-6776391977517404/7392470671")
    }
    
    @IBAction func showButtonPressed(_ sender: UIButton) {
        if GADRewardBasedVideoAd.sharedInstance().isReady == true {
          GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self)
        }
    }
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
        didRewardUserWith reward: GADAdReward) {
      print("Reward received with currency: \(reward.type), amount \(reward.amount).")
    }

    func rewardBasedVideoAdDidReceive(_ rewardBasedVideoAd:GADRewardBasedVideoAd) {
      print("Reward based video ad is received.")
    }

    func rewardBasedVideoAdDidOpen(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
      print("Opened reward based video ad.")
    }

    func rewardBasedVideoAdDidStartPlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
      print("Reward based video ad started playing.")
    }

    func rewardBasedVideoAdDidCompletePlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
      print("Reward based video ad has completed.")
    }

    func rewardBasedVideoAdWillLeaveApplication(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
      print("Reward based video ad will leave application.")
    }

    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
        didFailToLoadWithError error: Error) {
      print("Reward based video ad failed to load.")
    }
    
    func rewardBasedVideoAdDidClose(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad is closed.")
        GADRewardBasedVideoAd.sharedInstance().load(GADRequest(),
          withAdUnitID: "ca-app-pub-3940256099942544/1712485313")
    }
}



//Test AppId: ca-app-pub-3940256099942544~1458002511
//Test UNIT ID: ca-app-pub-3940256099942544/1712485313



//{
//    "POKKT_SCREEN_NAME": "83916eed8a2fc5afd567ced93c1f2f86",
//    "POKKT_APP_ID": "b26277c8c81d33706179288e7bcd9847",
//    "POKKT_SEC_KEY": "04817587aa780627188b9dff0eb7757a",
//    "POKKT_THIRD_PARTY_USERID": "12345",
//    "POKKT_REWARD_NAME": "COIN",
//    "POKKT_DEBUG": true,
//    "POKKT_GDPR_APPLICABLE": false
//}
