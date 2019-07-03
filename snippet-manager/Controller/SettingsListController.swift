//
//  SettingsListController.swift
//  snippet-manager
//
//  Created by Manu on 02/07/2019.
//  Copyright © 2019 Manu Marchand. All rights reserved.
//

import UIKit
import Highlightr

class SettingsListController: UITableViewController {

    @IBOutlet var syntaxHighlightSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }    
}


class SettingsLanguageListController: UITableViewController {
    
    var defaultLanguage = 0
    var highlightr : Highlightr!
    let textStorage = CodeAttributedString()
    var supportedLanguages = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        highlightr = textStorage.highlightr
        supportedLanguages = highlightr.supportedLanguages().sorted()
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return supportedLanguages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "languageCell", for: indexPath)
        let theme = supportedLanguages[indexPath.row]
        
        cell.textLabel?.text = theme
        cell.accessoryType = (defaultLanguage == indexPath.row) ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defaultLanguage = indexPath.row
        tableView.reloadData()
    }
}


class SettingsThemeListController: UITableViewController {
    
    var defaultTheme = 0
    var highlightr : Highlightr!
    let textStorage = CodeAttributedString()
    var availableThemes = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        highlightr = textStorage.highlightr
        availableThemes = highlightr.availableThemes()
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableThemes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "themeCell", for: indexPath)
        let theme = availableThemes[indexPath.row]
        
        cell.textLabel?.text = theme
        cell.accessoryType = (defaultTheme == indexPath.row) ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defaultTheme = indexPath.row
        tableView.reloadData()
    }
}
