//
//  TVCMain.swift
//  HackTheJorney2018
//
//  Created by Charly Maxter on 2/6/18.
//  Copyright © 2018 HackTheJorney. All rights reserved.
//

import UIKit

class TVCMain: UITableViewCell {
    
    @IBOutlet weak var lblTxt:UILabel!
    @IBOutlet weak var img: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func getImg(_ uri:String){
        
        if Dataholder.sharedInstance.dicImg[uri] != nil {
            img.image = Dataholder.sharedInstance.dicImg[uri]
        }else{
            let url = URL(string: uri)
            let data = try? Data(contentsOf: url!)
            img.image = UIImage(data: data!)
            Dataholder.sharedInstance.dicImg[uri] = img.image
            
        }
        
        
    }
    
}
