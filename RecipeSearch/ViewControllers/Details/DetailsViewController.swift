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
        var sections = [
            (cellIdentifier: "imageCell", count: 1, headerTitle: nil),
            (cellIdentifier: "infoCell", count: 1, headerTitle: "INFO")]
        if self.recipe?.ingredients?.count ?? 0 > 0 {
         sections.insert((cellIdentifier: "ingredientCell", count: self.recipe?.ingredients?.count ?? 0, headerTitle: "INGREDIENTS"), at: 1)
        }
        return sections
        }}
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

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setup() {
        navigationItem.title = recipe?.title
        labelPublisher.text = "Source: " + (recipe?.publisherName ?? "")
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
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.font = UIFont.boldSystemFont(ofSize: 22.0)
            header.textLabel?.textColor = UIColor.black
            header.textLabel?.text = dataSource[section].headerTitle
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataSource[section].headerTitle
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = dataSource[indexPath.section].cellIdentifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        switch identifier {
        case "imageCell":
            guard let imageCell = cell as? ImageTableViewCell else {
                return cell!
            }
            imageCell.loadImage(url: recipe?.imageUrl ?? "")
            return imageCell
        case "ingredientCell":
            cell?.textLabel?.textColor = .darkGray
            cell?.textLabel?.text = recipe?.ingredients?[indexPath.row] ?? ""
        return cell!
        case "infoCell":
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
