//
//  WebRequest.swift
//  HackTheJorney2018
//
//  Created by Charly Maxter on 2/6/18.
//  Copyright © 2018 HackTheJorney. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration
import Alamofire
import SwiftyJSON

class WebRequest: NSObject {
    static let sharedInstance:WebRequest=WebRequest()
    
    var auth_key: String!
    
    //Constants
    let OPEN_URL = "https://aofuaj1lli.execute-api.eu-west-1.amazonaws.com/Dev/auth"
    let header: HTTPHeaders = [
        "Content-Type": "application/json",
        "Authorization": "Bearer " + auth_key!
    ]
    let body : [String:String] = [
        "nickname": "needDesign",
        "email": "needDesign@now.com",
        "password": "Testeando1!"
    ]
    /*
     body
     {
     "nickname": "needDesign",
     "email": "needDesign@now.com",
     "password": "Testeando1!"
     }
     */
    
    //all Request to API
    func genericRequest(url:String,headers:[String:String], parameters:[String:String],delegate:WebRequestDelegate) {
        if isInternetAvailable(){
            
            let queue = DispatchQueue(label: "fastrack", qos: .utility, attributes: [.concurrent])
            //puesto a pelo url, body y header TODO
            Alamofire.request(OPEN_URL, method: .post, parameters: parameters,encoding: JSONEncoding(),headers: header).responseData(
                queue: queue,
                completionHandler:{
                    response in
                    //debugPrint(response)
                    if let data = response.result.value, let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                        //debugPrint(data)
                        if let dictionary = json as? [String: Any] {
                            //debugPrint(dictionary)
                            if let result = dictionary["status"] as? String {
                                delegate.WRDComunication!(result: result)
                            }
                        }
                    }
            })
        }else{
            
            let myAlert = UIAlertController(title: "No tiene internet", message: "Por favor compruebe su conexion", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { action in
                exit(0)
            })
            myAlert.addAction(okAction)
            DispatchQueue.main.async {
                UIApplication.topViewController()?.present(myAlert, animated: true, completion: nil)
            }
        }
    }
    
    
    func getPetition(_ url: String) {
        let queue = DispatchQueue(label: "aa", qos: .utility, attributes: [.concurrent])
        //puesto a pelo url, body y header TODO
        Alamofire.request(url, method: .get,encoding: JSONEncoding()).responseData(
            queue: queue,
            completionHandler:{
                response in
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    print("Data: \(utf8Text)")
                    delegate.WRDComunication!(result: utf8Text)
                }
        })
    }
    
    func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
}

@objc protocol WebRequestDelegate {
    @objc optional func WRDComunication(result:String)
}

//This extension is used to display the alert of the func genericRequest
extension UIApplication {
    
    static func topViewController(base: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(base: selected)
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        
        return base
    }
}
