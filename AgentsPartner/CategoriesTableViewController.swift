/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit
import RealmSwift


class CategoriesTableViewController: UITableViewController {
  
  
  let realm = try! Realm()
  // to fetch objects, you need to define which models you want
  // here you populate categories by calling objects (_:) on it, 
  // passing the class name of the model you want
  /*
   NOTE: To simplify the code required in this tutorial,
   you’ll be used try! when calling Realm methods that throw an error. 
   In your own code, you should really be using 
   try and do / catch to catch errors and handle them appropriately.
   */
  lazy var categories: Results<Category> = {  self.realm.objects(Category) }()
  var selectedCategory: Category!

  override func viewDidLoad() {
    super.viewDidLoad()
    populateDefaultCategories()
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return .Default
  }
  
  // helper method to give the user the opportunity to choose from default categories
  func populateDefaultCategories() {
    
    if categories.count == 0 {
      
      try! realm.write() {
        let defaultCategories = ["Birds", "Mammals", "Flora", "Reptiles", "Arachnids" ]
        
        for category in defaultCategories {
          let newCategroy = Category()
          newCategroy.name = category
          self.realm.add(newCategroy)
        }
      }
      
      categories = realm.objects(Category)
      
    }
    
  }
}

// MARK: - UITableViewDataSource
extension CategoriesTableViewController {
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return categories.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("CategoryCell", forIndexPath: indexPath)
    
    let category = categories[indexPath.row]
    cell.textLabel?.text = category.name
    
    return cell
  }
    
  override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath {
    selectedCategory = categories[indexPath.row]
    return indexPath
  }
}
