//
//  ListOfPlacesViewController.swift
//  TravelBoard
//
//  Created by Vineet Baid on 7/26/18.
//  Copyright © 2018 Vineet Baid. All rights reserved.
//

import UIKit

class ListOfPlacesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //TODO: Future versions will have all the places in a back-end database to allow search functionality in every locaiton. This is Version 2.0 functionality. To test this out we only picked 12 major cities
    let placesArray : [String] = ["Bangkok, Thailand", "Barcelona, Spain","Brussels, Belgium", "Dubai, U.A.E", "Ibiza, Spain", "Istanbul, Turkey", "Kuala Lumpur, Malaysia", "Las Vegas, U.S.A", "London, U.K.", "Paris, France", "Seoul, North Korea"," Singapore", "Tokyo, Japan", "New York City, U.S.A"]
    
    
    //IBOutlets:
    @IBOutlet var citiesListTable: UITableView!
    @IBOutlet var logOutOutlet: UIBarButtonItem!
    
    @IBAction func logOutButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        citiesListTable.delegate = self
        citiesListTable.dataSource = self
        self.logOutOutlet.title = "Log Out"
        

        // Do any additional setup after loading the view.
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = placesArray[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Noteworthy-Bold", size: 20.0)
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //TODO: Need to make it so that selecting something here allows you to go to the travel Board. This is where I will use the thing there. 
        <#code#>
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
