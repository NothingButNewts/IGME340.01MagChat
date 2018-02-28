//
//  themeTableVC.swift
//  Magneto-1
//
//  Created by Student on 1/30/18.
//  Copyright © 2018 Isaac Walerstein & Peter Woodsum. All rights reserved.
//

import UIKit

class themeTableVC: UITableViewController {

    var themes = ["Common", "Video Games", "Fantasy"]
    var selectedTheme = "Common"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        print(selectedTheme)
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
