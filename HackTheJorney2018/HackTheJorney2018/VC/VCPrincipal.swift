//
//  VCPrincipal.swift
//  HackTheJorney2018
//
//  Created by Charly Maxter on 2/6/18.
//  Copyright © 2018 HackTheJorney. All rights reserved.
//

import UIKit
import Firebase

class VCPrincipal: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var datos:[[NSDictionary]] = []

    @IBOutlet weak var collectionMain:UICollectionView!
    @IBOutlet weak var btnBosque: UIButton!
    @IBOutlet weak var btnBeach: UIButton!
    @IBOutlet weak var btnCity: UIButton!
    @IBOutlet weak var btnSk: UIButton!
    @IBOutlet weak var btnMoun: UIButton!
    
    var first: Bool = true
    
    @IBOutlet weak var viewTop: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customBtn(button: btnBosque)
        customBtn(button: btnSk)
        customBtn(button: btnCity)
        customBtn(button: btnMoun)
        customBtn(button: btnBeach)
        
        collectionMain.dataSource = self
        collectionMain.delegate = self
        menuFuera()
        if let layout = collectionMain.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }

        
        Dataholder.sharedInstance.firDataBaseRef.child("data").observeSingleEvent(of: .value, with: { (data) in
            var i = 0
            while i < 5{
                i += 1
                for (baby) in data.children {
                    let temp = baby as! DataSnapshot
                    self.datos.append(temp.value as! [NSDictionary])
                }
            }
            
            self.collectionMain.reloadData()
            
        })
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if datos.count != 0{
            return 16
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCMain", for: indexPath) as! CVCMain
        cell.weekend = "Weekend \(indexPath.row + 1)"
        if indexPath.row % 2 == 0{
            cell.indice = 0
        }else{
            cell.indice = 1
        }
        
        cell.descarga = first
        
        cell.inicio()
        cell.datos = datos[indexPath.row]
        cell.tabla.reloadData()
        
        return cell
    }
    
    @IBAction func showTop(){
        UIView.animate(withDuration: 0.4, animations: {
            self.viewTop.frame.origin.y = 0
            //self.viewAdministrator.transform = CGAffineTransform( translationX: 0.0, y: self.view.frame.height - self.viewAdministrator.frame.height)
        })
        let tap = UITapGestureRecognizer(target: self, action: #selector(menuFuera))
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func clickedBtn(){
        first = false
        menuFuera()
        self.collectionMain.reloadData()
    }
    
    @objc func menuFuera(){
        UIView.animate(withDuration: 0.4, animations: {
            self.viewTop.frame.origin.y = 0 - self.viewTop.frame.height
        })
        
    }
    
    func customBtn(button:UIButton) {
        //button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 3
       // button.layer.borderColor = UIColor.black.cgColor
    }

}
