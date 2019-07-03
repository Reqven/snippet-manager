//
//  SnippetListController.swift
//  snippet-manager
//
//  Created by Manu on 02/07/2019.
//  Copyright © 2019 Manu Marchand. All rights reserved.
//

import UIKit

class SnippetListController: UITableViewController {

    var snippets = [Snippet]()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = navigationController?.navigationBar.barTintColor
        navigationItem.searchController = searchController
        
        if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            if let backgroundview = textfield.subviews.first {
                backgroundview.backgroundColor = .white
                backgroundview.layer.cornerRadius = 10;
                backgroundview.clipsToBounds = true;
            }
        }
        
        let cancelButtonAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes , for: .normal)

        setupData()
        tableView.tableFooterView = UIView()
        setNeedsStatusBarAppearanceUpdate()
    }


    // MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snippets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "snippetCell", for: indexPath)
        let snippet = snippets[indexPath.row]
        
        cell.textLabel?.text = snippet.title
        cell.detailTextLabel?.text = snippet.content
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            self.snippets.remove(at: indexPath.row)
            self.tableView.reloadData()
            completion(true)
        }
        delete.image = UIImage(named: "delete")
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    
    // MARK: - Navigation Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if "showSnippet" == segue.identifier {
            if let indexPath = tableView.indexPathForSelectedRow {
                let snippetController = segue.destination as! SnippetController
                snippetController.snippet = snippets[indexPath.row]
            }
        }
    }
    
    
    // MARK: - Others Methods
    func setupData() {
        
        let swiftSnippet = Snippet(
            title: "TableViewController example",
            content: "override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {\n  return snippets.count\n}",
            language: "swift")
        
        let cssSnippet = Snippet(
            title: "Apple Pay CSS Buttons",
            content: "@supports (-webkit-appearance: -apple-pay-button) {\n  .apple-pay-button {\n    display: inline-block;\n    -webkit-appearance: -apple-pay-button;\n  }  .apple-pay-button-black {\n  -apple-pay-button-style: black;\n}  .apple-pay-button-white {\n    -apple-pay-button-style: white;\n  }  .apple-pay-button-white-with-line {\n    -apple-pay-button-style: white-outline;\n  }\n}",
            language: "css")
        
        let phpSnippet = Snippet(
            title: "Vegetable Class",
            content: "<?php\nclass Vegetable {\n  var $edible;\n  var $color;\n\n function __construct($edible, $color=\"green\") {\n    $this->edible = $edible;\n    $this->color = $color;\n  }\n\n  function is_edible() {\n    return $this->edible;\n   }\n\n  function what_color() {\n  return $this->color;\n  }\n}",
            language: "php")
        
        snippets.append(swiftSnippet)
        snippets.append(cssSnippet)
        snippets.append(phpSnippet)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}


//MARK: - UISearchResultsUpdating Delegate
extension SnippetListController : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        if searchText.isEmpty {
            //loadItems()
        } else {
            /*let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchText)
             items = category?.items.filter(predicate).sorted(byKeyPath: "created", ascending: false)
             tableView.reloadData()*/
        }
    }
}
