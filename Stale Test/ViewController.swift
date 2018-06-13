//
//  ViewController.swift
//  Stale Test
//
//  Created by Adam Bradfield on 6/11/18.
//  Copyright © 2018 Adam Bradfield. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController {
    
    var wardrobedb: Connection!
    
    let wardrobe = Table("wardrobe")
    
    let id = Expression<Int64>("id")
    let name = Expression<String>("name")
    let style = Expression<String>("style")
    let weight = Expression<String>("weight")
    let pattern = Expression<String>("pattern")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("wardrobe").appendingPathExtension("sqlite3")
            let wardrobedb = try Connection(fileUrl.path)
            self.wardrobedb = wardrobedb
        } catch {
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createTable() {
        print("CREATE TAPPED")
        
        let createTable = self.wardrobe.create { (table) in
            table.column(self.id, primaryKey: true)
            table.column(self.name)
            table.column(self.style)
            table.column(self.weight)
            table.column(self.pattern, defaultValue: "no")
        }
        
        do {
            try self.wardrobedb.run(createTable)
            print("Created Table")
        } catch {
            print(error)
        }
    }
    
    @IBAction func insertItem(){
        print("Save Tapped")
        let alert = UIAlertController(title: "Insert Item", message: nil, preferredStyle: .alert)
        alert.addTextField { (tf) in tf.placeholder = "Name" }
        alert.addTextField { (tf) in tf.placeholder = "Style" }
        alert.addTextField { (tf) in tf.placeholder = "Weight" }
        alert.addTextField { (tf) in tf.placeholder = "Pattern" }
        let action = UIAlertAction(title: "Submit", style: .default) { (_) in
            guard let name = alert.textFields?[0].text,
                let style = alert.textFields?[1].text,
                let weight = alert.textFields?[2].text,
                let pattern = alert.textFields?[3].text
                else { return }
            print(name)
            print(style)
            print(weight)
            print(pattern)
            
        let insertItem = self.wardrobe.insert(self.name <- name, self.style <- style, self.weight <- weight, self.pattern <- pattern)
            
        do {
            try self.wardrobedb.run(insertItem)
            print("inserted id: \(rowid)")
        } catch {
        print("insertion failed: \(error)")
        }
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    @IBAction func listItems() {
        print("List Tapped")
        
        do {
            let items = try self.wardrobedb.prepare(self.wardrobe)
            for item in items {
                print("ItemID: \(item[self.id]), name: \(item[self.name]), style: \(item[self.style]), weight: \(item[self.weight]), pattern: \(item[self.pattern])")
            }
        } catch {
            print(error)
        }
    }
    
    @IBAction func update(){
       print("Update Tapped")
        let alert = UIAlertController(title: "Update Item", message: nil, preferredStyle: .alert)
        alert.addTextField { (tf) in tf.placeholder = "Item ID" }
        alert.addTextField { (tf) in tf.placeholder = "Style" }
        alert.addTextField { (tf) in tf.placeholder = "Weight" }
        alert.addTextField { (tf) in tf.placeholder = "Pattern" }
        let action = UIAlertAction (title: "Submit", style: .default) { (_) in
            guard let itemIDString = alert.textFields?[0].text,
                let itemID = Int64(itemIDString),
                let style = alert.textFields?[1].text,
                let weight = alert.textFields?[2].text,
                let pattern = alert.textFields?[3].text
                else { return }
            print(itemIDString)
     //     print(name)
            print(style)
            print(weight)
            print(pattern)
            
            let item = self.wardrobe.filter(self.id == itemID)
            let updateItem = item.update(self.style <- style)
            do {
                try self.wardrobedb.run(updateItem)
            } catch {
                print(error)
            }
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func delete(){
        print("Delete Tapped")
        let alert = UIAlertController(title: "Delete Item", message: nil, preferredStyle: .alert)
        alert.addTextField { (tf) in tf.placeholder = "Item ID" }
        let action = UIAlertAction (title: "Submit", style: .default) { (_) in
            guard let itemIDString = alert.textFields?[0].text,
                let itemID = Int64(itemIDString)
            else { return }
            print(itemIDString)
            
            let item = self.wardrobe.filter(self.id == itemID)
            let deleteItem = item.delete()
            do {
                try self.wardrobedb.run(deleteItem)
            } catch {
                print(error)
            }
        }
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
}

}
