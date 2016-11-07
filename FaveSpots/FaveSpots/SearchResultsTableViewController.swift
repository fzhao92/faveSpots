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
    
    weak var handleMapSearchDelegate: HandleMapSearch?
    var mapView: MKMapView? = nil

    var searchController: UISearchController = UISearchController(searchResultsController: nil)
    let store = SearchRequestDataSource.sharedInstance
    var selectedSearchResultPlacemark: MKPlacemark?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        
        handleMapSearchDelegate = navigationController?.viewControllers.first as! POIMapViewController
        
        
        print("printing delegate \(handleMapSearchDelegate)")
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
        
        if let handleMap = handleMapSearchDelegate{
            handleMap.dropPOI(placemark: store.currentSearchResults[indexPath.row].placemark)
            print("Current view controller is \(navigationController?.viewControllers[0])")
            let _ = navigationController?.popToRootViewController(animated: true)
        }
        else {
            print("handleMap becoming nil")
        }
        
    }

    // MARK: - Search setup and functionality
    
    func setupSearchController() {
        
        searchController.searchResultsUpdater = self
        let searchBar = searchController.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for..."
        navigationItem.titleView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
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

