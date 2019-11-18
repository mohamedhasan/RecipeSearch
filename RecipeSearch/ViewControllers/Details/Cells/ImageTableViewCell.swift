//
//  ImageTableViewCell.swift
//  RecipeSearch
//
//  Created by Mohamed Hassan on 11/18/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import UIKit
import SDWebImage

class ImageTableViewCell: UITableViewCell {
    @IBOutlet weak var recipeImage: UIImageView!
    
    func loadImage(url: String) {
        recipeImage.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeHolder"), options: SDWebImageOptions.scaleDownLargeImages, completed: nil)
    }
}
