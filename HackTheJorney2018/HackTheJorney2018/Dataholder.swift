//
//  Dataholder.swift
//  HackTheJorney2018
//
//  Created by Charly Maxter on 2/6/18.
//  Copyright © 2018 HackTheJorney. All rights reserved.
//


import UIKit
import Firebase

class Dataholder: NSObject {
    
    static let sharedInstance:Dataholder=Dataholder()
    
    var healthAvailable: Bool = false
    
    var firDataBaseRef:DatabaseReference!
    
    func initFirebase(){
        FirebaseApp.configure()
        firDataBaseRef=Database.database().reference()
    }
}
