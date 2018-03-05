//
//  themeTableVC.swift
//  Magneto-1
//
//  Created by Student on 1/30/18.
//  Copyright © 2018 Isaac Walerstein & Peter Woodsum. All rights reserved.
//

import UIKit
import Foundation

class themeTableVC: UITableViewController {
    
    static let shared = themeTableVC()
    var themes = ["Common", "Video Games", "Fantasy", "School", "Social"]
    let themesKey = "themesKey"
    var selectedTheme = "Common"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    public func saveDeaultsData() {
        print("Saving to defaults")
        let defaults = UserDefaults.standard
        defaults.set(selectedTheme, forKey: themesKey)
    }
    
    public func readDefaultsData(){
        let defaults = UserDefaults.standard
        if defaults.string(forKey: themesKey) != nil {
            selectedTheme = defaults.string(forKey: themesKey) as String!
        }
        else {
            selectedTheme = "Common"
        }
        if let temp = defaults.object(forKey: themesKey){
            selectedTheme = temp as! String
        }
        else {
            print("No data")
            selectedTheme = "Common"
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return themes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = themes[indexPath.row]
        
        return cell
    }

    @IBAction func cancelTapped(sender: AnyObject){
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        selectedTheme = themes[indexPath.row]
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
