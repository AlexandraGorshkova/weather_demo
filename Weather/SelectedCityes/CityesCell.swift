//
//  CityesCell.swift
//  Weather
//
//  Created by Alexandra Gorshkova on 22/01/2019.
//  Copyright © 2019 Alexandra Gorshkova. All rights reserved.
//

import UIKit

class CityesCell: UITableViewCell {

    
    @IBOutlet weak var start: UILabel!
    @IBOutlet weak var end: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var temperature: UILabel!
   
    @IBOutlet weak var imege: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
