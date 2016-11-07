//
//  SearchResultsTableViewController.swift
//  FaveSpots
//
//  Created by Forrest Zhao on 11/5/16.
//  Copyright © 2016 ForrestApps. All rights reserved.
//

import UIKit
import MapKit


class SearchResultsTableViewController: UITableViewController {

    var searchController: UISearchController? = nil
    let store = SearchRequestDataSource.sharedInstance
    var selectedSearchResultPlacemark: MKPlacemark?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return store.currentSearchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath)
        let selectedItem = store.currentSearchResults[indexPath.row]
        cell.textLabel?.text = selectedItem.placemark.name
        cell.detailTextLabel?.text = selectedItem.parseAddress(selectedItem: selectedItem.placemark)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSearchResultPlacemark = store.currentSearchResults[indexPath.row].placemark
        performSegue(withIdentifier: "showMapNav", sender: nil)
    }

    // MARK: - Search setup and functionality
    
    func setupSearchController() {
        let searchTable = storyboard!.instantiateViewController(withIdentifier: "SearchResultsTable") as! SearchResultsTableViewController
        searchController = UISearchController(searchResultsController: searchTable)
        searchController?.searchResultsUpdater = searchTable
        let searchBar = searchController?.searchBar
        searchBar?.sizeToFit()
        searchBar?.placeholder = "Search for..."
        navigationItem.titleView = searchController?.searchBar
        searchController?.hidesNavigationBarDuringPresentation = false
        searchController?.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMapNav" {
            let dest: UINavigationController = segue.destination as!UINavigationController
            let targetController = dest.topViewController as! POIMapViewController
            if let selectedPlacemark = selectedSearchResultPlacemark {
                targetController.POIPin = selectedPlacemark
            }
        }
        
    }

}

extension SearchResultsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print("In search results updating delegate method")
        guard let searchTerm = searchController.searchBar.text else{ return }
        store.searchFor(placeRelatedTerm: searchTerm)
        tableView.reloadData()
    }
}

