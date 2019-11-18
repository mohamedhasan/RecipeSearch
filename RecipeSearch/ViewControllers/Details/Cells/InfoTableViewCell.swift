//
//  InfoTableViewCell.swift
//  RecipeSearch
//
//  Created by Mohamed Hassan on 11/18/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    @IBOutlet weak var buttonOriginal: UIButton!
    @IBOutlet weak var buttonInstructions: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        buttonOriginal.layer.borderWidth = 2
        buttonInstructions.layer.borderWidth = 2
        
        buttonOriginal.layer.borderColor = UIColor.black.cgColor
        buttonInstructions.layer.borderColor = UIColor.black.cgColor
    }
}
