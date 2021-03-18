//
//  SearchResultMapViewController.swift
//  ProektMA
//
//  Created by PANCE DUBROVSKI on 12.1.21.
//  Copyright © 2021 PANCE DUBROVSKI. All rights reserved.
//

import UIKit
import MapKit

class SearchResultMapViewController: UIViewController {
    
    weak var handleMapSearchDelegate: HandleMapMovie?

    
    @IBOutlet weak var tableView: UITableView!
    
    var mapItem : [MKMapItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension SearchResultMapViewController : UITableViewDelegate,UITableViewDataSource{
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mapItem.count
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "mapCell",for: indexPath)
        cell.textLabel?.text = mapItem[indexPath.row].placemark.name
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let placemark = mapItem[indexPath.row].placemark
        
        handleMapSearchDelegate?.dropPinZoomIn(placemark: placemark)
         dismiss(animated: true, completion: nil)
        
    }
}
extension SearchResultMapViewController : UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        let searchRequest   = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchController.searchBar.text
               
           
               
               let search = MKLocalSearch(request: searchRequest)
               search.start {(response, error) in
                   guard let response = response else {
                       print("error")
                       return
                   }
                self.mapItem = response.mapItems
                self.tableView.reloadData()
                   
               }
    }
    
    
}
