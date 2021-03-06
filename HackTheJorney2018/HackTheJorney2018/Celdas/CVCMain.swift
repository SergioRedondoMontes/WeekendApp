//
//  CVCMain.swift
//  HackTheJorney2018
//
//  Created by Charly Maxter on 2/6/18.
//  Copyright © 2018 HackTheJorney. All rights reserved.
//

import UIKit

class CVCMain: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tabla: UITableView!
    
    var datos: [NSDictionary] = []
    var indice: Int = 0
    var descarga = true
    
    var weekend:String = "WEEKEND PATO!"
    
    func inicio(){
        tabla.delegate = self
        tabla.dataSource = self
    }
    
    func cargarTabla(){
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("ROWS: ", datos.count)
        return datos.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TVCDate", for: indexPath) as! TVCDate
            cell.lblTop.text = weekend
            return cell
        }else{
            print("DATA: ", datos)
            //let cell = tableView.dequeueReusableCell(withIdentifier: "TVCMain") as! TVCMain
            let cell = tableView.dequeueReusableCell(withIdentifier: "TVCMain", for: indexPath) as! TVCMain
            //cell.backgroundColor = UIColor.blue
            cell.lblTxt.text = datos[indexPath.row - 1]["destino"] as? String
            //cell.lblTxt.backgroundColor = UIColor.green
            let arrImg:[String] = datos[indexPath.row - 1]["img"] as! [String]
            if indice == 0{
                if descarga {
                    //0
                    cell.getImg(arrImg[0])
                }else{
                    //2
                    cell.getImg(arrImg[2])
                }
            }else{
                if descarga {
                    //1
                    cell.getImg(arrImg[1])
                }else{
                    //3
                    cell.getImg(arrImg[3])
                }
            }
            
            let dicPrice: [String:Double] = (datos[indexPath.row - 1]["precio"] as? [String:Double])!
            var sum = dicPrice["hotel"]! + dicPrice["vuelo"]!
            
            cell.lblPrice.text = "\(sum)$"
            
            return cell
        }
    }
}
