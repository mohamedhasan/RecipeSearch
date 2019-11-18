//
//  SplitViewController.swift
//  RecipeSearch
//
//  Created by Mohamed Hassan on 11/18/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import UIKit

class SplitViewController: UISplitViewController, UISplitViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }

    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool
    {
        guard let navigationController = primaryViewController as? UINavigationController,
            let controller = navigationController.topViewController as? SearchViewController
        else {
            return true
        }
        return controller.collapseDetailViewController
    }
    
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController, ontoPrimaryViewController primaryViewController: UIViewController) -> Bool {
        return false
    }
}
