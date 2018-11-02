//
//  CharacterTableViewCell.swift
//  Promises
//
//  Created by federico mazzini on 02/11/2018.
//  Copyright © 2018 Lateral View. All rights reserved.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var characterImage :UIImageView!
    @IBOutlet weak var nameLabel :UILabel!
    @IBOutlet weak var bioLabel :UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
