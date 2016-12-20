//
//  TableViewController.swift
//  RealmRecipes
//
//  Created by admin on 11/12/2016.
//  Copyright © 2016 Vik Nikolova. All rights reserved.
//

import UIKit
import RealmSwift

class TableViewController: UITableViewController, UISplitViewControllerDelegate {

    
    var Recipes = [Recipe]()
    
    var filteredRecipes = [Recipe]()
    
    //declare realm
    let realm: Realm = try! Realm(Realm.Configuration.defaultConfiguration.deleteRealmIfMigrationNeeded = true)
    //declare search
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Recipes"

        addRecipe()
        queryRecipes()
        
        self.splitViewController?.delegate = self
        //set table and display view visible on tablet portrait and landscape view
        self.splitViewController?.preferredDisplayMode = UISplitViewControllerDisplayMode.allVisible
        
        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false
        
        //search controller setup
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.searchBar.scopeButtonTitles = ["All", "Low Carb", "Low Fat", "High Protein"]
        searchController.searchBar.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //check if filtering is on
        if searchController.isActive && searchController.searchBar.text != ""{
            return filteredRecipes.count
        }
         return Recipes.count
    }
    

    
    func queryRecipes(){

        for recipe in realm.objects(Recipe.self) {
            Recipes.append(recipe)
            
        }
        
        tableView.reloadData()

        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : TableViewCell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TableViewCell
        let recipe : Recipe
        if searchController.isActive && searchController.searchBar.text != ""{
            recipe = filteredRecipes[indexPath.row]
        } else {
            recipe = Recipes[indexPath.row]
        }
        cell.titleLabel.text = recipe.title
        cell.labelLabel.text = recipe.label
        cell.timeLabel.text = "\(recipe.time)"
        print("\(recipe.imageURL)")
        cell.recipeImage.image = UIImage(named: recipe.imageURL)

        // Configure the cell...

        return cell
    }
    
    //unwind action
    @IBAction func unwindToRecipes(segue: UIStoryboardSegue) {
    
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let destination = segue.destination as! UINavigationController
            let index = self.tableView.indexPathForSelectedRow! as NSIndexPath

            let recipe: Recipe
            if searchController.isActive && searchController.searchBar.text != "" {
                recipe = filteredRecipes[index.row]
            } else {
                recipe = Recipes[index.row]
            }
            
            let vc = destination.viewControllers[0] as! DetailViewController
            vc.recipeTitle = recipe.title
            vc.time = "\(recipe.time)"
            vc.recipeImage = UIImage(named: recipe.imageURL)!
            self.tableView.deselectRow(at: index as IndexPath, animated: true)
        }
    }

    //show master view controller first
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    
    func addRecipe(){
        do { // save object
            try realm.write {
                realm.deleteAll()
                let recipe1 = Recipe(value: [1, "Avocado Toast", "High Protein", 10,"avocado-toast"])
                let recipe2 = Recipe(value: [2, "Veggie wrap", "Low Fat", 15 ,"veggie-wrap"])
                let recipe3 = Recipe(value: [3, "Noodles with curried coconut sauce", "Low carb", 35 ,"noodles"])
                let recipe4 = Recipe(value: [4, "Bulgur and lentil salad", "Low Fat", 60 ,"bulgur-salad"])
                let recipe5 = Recipe(value: [5, "Chickpea curry", "High Protein", 35 ,"chickpea-curry"])
                realm.add([recipe1, recipe2, recipe3, recipe4, recipe5])
                print("recipe added \(recipe1.title)")
            }
        }catch{
            //do nothing, nobody cares
        }
        
    }
    
    //helper method for search bar
    func filterContentForSearchText(searchText: String, scope: String = "All"){
        let allRecipes = realm.objects(Recipe.self)

        filteredRecipes = allRecipes.filter { recipe in
            let categoryMatch = (scope == "All") || (recipe.label == scope)
            return categoryMatch && recipe.title.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
}

extension TableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchText: searchController.searchBar.text!, scope: scope)
    }
}

extension TableViewController: UISearchBarDelegate {
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchText: searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}
