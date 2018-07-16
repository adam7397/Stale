//
//  WardrobeTableViewController.swift
//  Stale Test
//
//  Created by Adam Bradfield on 6/27/18.
//  Copyright © 2018 Adam Bradfield. All rights reserved.
//

import UIKit

class WardrobeTableViewController: UITableViewController {
    
    var clothes = [String]()
    
        //ViewController().returncolumns()
   /**
        ["Apple", "Apricot", "Banana", "Blueberry", "Cantaloupe", "Cherry",
        "Clementine", "Coconut", "Cranberry", "Fig", "Grape", "Grapefruit",
        "Kiwi fruit", "Lemon", "Lime", "Lychee", "Mandarine", "Mango",
        "Melon", "Nectarine", "Olive", "Orange", "Papaya", "Peach",
        "Pear", "Pineapple", "Raspberry", "Strawberry"]
    **/
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return clothes.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        let clothesname = clothes[indexPath.row]
        cell.textLabel?.text = clothes[indexPath.row]
        cell.detailTextLabel?.text = "Very cool!"
    //    cell.imageView?.image = UIImage(named: clothesname)
        
        return cell
    }
 
}
