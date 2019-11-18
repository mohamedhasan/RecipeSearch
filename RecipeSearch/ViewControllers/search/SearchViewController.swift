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
    var collapseDetailViewController: Bool = true
    
    private let interactor = RecipesInteractor(dataProvider: NetworkManager.sharedInstance)
    internal var dataSource = [RecipeProtocol]()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var indicatorView:UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let selectedIndex = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndex, animated: true)
        }
    }
    
    func setup() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
        let presenter = RecipesPresenter()
        presenter.viewController = self
        interactor.presenter = presenter
        searchBar.becomeFirstResponder()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recipeDetails" {
            if let navigationController = segue.destination as? UINavigationController, let detailsViewController = navigationController.viewControllers.first as? DetailsViewController, let selectedRow = tableView.indexPathForSelectedRow?.row {
                let recipe = dataSource[selectedRow]
                detailsViewController.recipe = recipe
            }
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.collapseDetailViewController = false
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
