//
//  ViewController.swift
//  HackTheJorney2018
//
//  Created by Charly Maxter on 2/6/18.
//  Copyright © 2018 HackTheJorney. All rights reserved.
//

import UIKit
import FirebaseUI

class ViewController: UIViewController, FUIAuthDelegate {
    
    var authUI: FUIAuth!
    
    let providers: [FUIAuthProvider] = [
        FUIGoogleAuth()
        ]


    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as? UITabBarController
        navigationController?.show(vc!, sender: self)
        /*
        authUI = FUIAuth.defaultAuthUI()
        authUI.delegate = self
        authUI.providers = providers
        
        let authViewController = authUI.authViewController()
        navigationController?.pushViewController(authViewController, animated: false)
 */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if error != nil {
            print("ERROR: ", error)
        }else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as? UITabBarController
            navigationController?.show(vc!, sender: self)
            //navigationController?.pushViewController(vc!, animated: false)
        }
    }
    
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        let sourceApplication = options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String?
        if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
            return true
        }
        // other URL handling goes here.
        return false
    }


}

