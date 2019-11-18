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
        buttonOriginal.layer.borderWidth = 1
        buttonInstructions.layer.borderWidth = 1
        buttonOriginal.layer.borderColor = UIColor.darkGray.cgColor
        buttonInstructions.layer.borderColor = UIColor.darkGray.cgColor
    }
}
