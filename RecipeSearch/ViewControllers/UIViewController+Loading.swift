//
//  SearchViewController+Loading.swift
//  RecipeSearch
//
//  Created by Mohamed Hassan on 11/17/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import UIKit

class SpinnerViewController: UIViewController {
    var spinner = UIActivityIndicatorView(style: .large)

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0.1, alpha: 0.3)

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

extension SearchViewController {
  
    func showLoading() {
        let spinnerView = SpinnerViewController()
        addChild(spinnerView)
        spinnerView.view.frame = view.bounds
        view.addSubview(spinnerView.view)
        spinnerView.didMove(toParent: self)
    }
    
    func hideLoaging() {
        for child in self.children {
            guard child.isKind(of: SpinnerViewController.self) else {
                continue
            }
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
}
