//
//  DetailsViewController.swift
//  RecipeSearch
//
//  Created by Mohamed Hassan on 11/18/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import UIKit

class DetailsViewController: UITableViewController {
    var recipe:RecipeProtocol?
    var dataSource:[(cellIdentifier: String, count: Int, headerTitle: String?)] { get {
        return [
            (cellIdentifier: "imageCell", count: 1, headerTitle: nil),
            (cellIdentifier: "ingredientCell", count: self.recipe?.ingredients?.count ?? 0, headerTitle: "INGREDIENTS"),
            (cellIdentifier: "infoCell", count: 1, headerTitle: "INFO")
        ]}}
    @IBOutlet weak var labelPublisher: UILabel!
    @IBOutlet weak var labelSocialRank: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard recipe != nil else {
            view.alpha = 0
            return
        }
        setup()
    }

    private func setup() {
        navigationItem.title = recipe?.title
        labelPublisher.text = "Source :" + (recipe?.publisherName ?? "")
        labelSocialRank.text = "Views: \(recipe?.socialRank ?? 0)"
    }
    
    @objc private func showOriginal() {
        UIApplication.shared.open(URL(string: recipe?.sourceUrl ?? "")!, options: [:], completionHandler: nil)
    }
    
    @objc private func showInstructions() {
        UIApplication.shared.open(URL(string: recipe?.instructionsUrl ?? "")!, options: [:], completionHandler: nil)
    }
    
    // MARK: - TableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataSource[section].headerTitle
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: dataSource[indexPath.section].cellIdentifier)
        switch indexPath.section {
        case 0:
            guard let imageCell = cell as? ImageTableViewCell else {
                return cell!
            }
            imageCell.loadImage(url: recipe?.imageUrl ?? "")
            return imageCell
        case 1:
            cell?.textLabel?.text = recipe?.ingredients?[indexPath.row] ?? ""
        return cell!
        case 2:
            guard let infoCell = cell as? InfoTableViewCell else {
                return cell!
            }
            infoCell.buttonOriginal.addTarget(self, action: #selector(showOriginal), for: .touchUpInside)
            infoCell.buttonInstructions.addTarget(self, action: #selector(showInstructions), for: .touchUpInside)
            return infoCell
        default:
            return cell!
        }
    }
}
