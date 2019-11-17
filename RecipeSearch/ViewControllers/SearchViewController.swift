//
//  ViewController.swift
//  RecipeSearch
//
//  Created by Mohamed Hassan on 11/16/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import UIKit

protocol RecipeDisplayProtocol: class {
    func showRecipes(_ recipes: [RecipeProtocol])
    func showError(_ error:NetworkError)
}

class SearchViewController: UIViewController, RecipeDisplayProtocol {
    
    private let interactor = RecipesInteractor(dataProvider: NetworkManager.sharedInstance)
    internal var dataSource = [RecipeProtocol]()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var indicatorView:UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
        tableView.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeTableViewCell")
        let presenter = RecipesPresenter()
        presenter.viewController = self
        interactor.presenter = presenter
    }

    func loadmore() {
        if interactor.hasMore {
            interactor.loadNextPage()
            showLoading()
        }
    }
    
    func searchForRecipe(_ query:String) {
        dataSource.removeAll()
        interactor.searchRecipes(query: query)
        searchBar.resignFirstResponder()
        showLoading()
    }
    // MARK: - RecipeDisplayProtocol
    func showError(_ error:NetworkError) {
        presentError(error)
        hideLoaging()
    }
    
    func showRecipes(_ recipes: [RecipeProtocol]) {
        dataSource.append(contentsOf: recipes)
        hideLoaging()
        tableView.reloadData()
    }
}
// MARK: - Table view data source
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
      return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let recipe = dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTableViewCell.cellIdentifier) as? RecipeTableViewCell
        cell?.showRecipe(recipe)
      return cell!
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == dataSource.count - 1 {
            loadmore()
        }
    }
}
// MARK: - SearchBar Methods
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text?.count ?? 0 > 0 {
            let query = searchBar.text!
            searchForRecipe(query)
        }
    }
}
