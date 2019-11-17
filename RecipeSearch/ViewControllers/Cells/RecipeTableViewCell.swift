//
//  RecipeTableViewCell.swift
//  RecipeSearch
//
//  Created by Mohamed Hassan on 11/16/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import UIKit
import SDWebImage

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var recipeImage: UIImageView?
    static let cellIdentifier = "RecipeTableViewCell"
    
    func showRecipe(_ recipe: RecipeProtocol) {
        labelTitle.text = recipe.title
        recipeImage?.sd_setImage(with: URL(string: recipe.imageUrl), placeholderImage: UIImage(named: "placeHolder"), options: SDWebImageOptions.scaleDownLargeImages, completed: nil)
    }
    
}
