//
//  HomePageViewController.swift
//  SoleeklabiOSInternshipEyadShokry
//
//  Created by Eyad Shokry on 5/23/19.
//  Copyright © 2019 Eyad. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class HomePageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Variables Diclaration
    var countriesNames = [String]()
    var capitalsNames = [String]()
    @IBOutlet weak var countriesNamesTableView: UITableView!

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        countriesNamesTableView.dataSource = self
        countriesNamesTableView.delegate = self
        
        fetchCountriesData()
        
        performUIUpdatesOnMain {
            self.countriesNamesTableView.reloadData()
        }
       
    }
    
    // MARK: - Reading JSON file and Parsing it
    func fetchCountriesData() {
        Client.shared().getCountriesNamesAndCapitals(completionHandler: {(countriesData, error) in
            if error != nil {
                self.showAuthenticationAlert(title: "Error fetching Data", message: "We didn't find any Information, be sure to connect with Internet or try again later")
            }
            
            else if let countries_data = countriesData {
                for country in countries_data{
                    self.countriesNames.append(country["name"]!)
                    self.capitalsNames.append(country["capital"]!)
                    
                }
                print(self.countriesNames)
                print(self.capitalsNames)
                
            }
        })
    }
    
    
//    func getJsonFromUrl(){
//        let url = URL(string: COUNTRIES_URL)
//        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) -> Void in
//            if let error = error { print(error); return}
//            do {
//                if let countriesArray = try JSONSerialization.jsonObject(with: data!) as? [[String:String]] {
//                    for country in countriesArray {
//                        self.countries_names.append(country["name"]!)
//                    }
//                }
//            } catch {print(error)}
//            OperationQueue.main.addOperation {
//                self.countriesNamesTableView.reloadData()
//            }
//        }).resume()
//    }
    
    // MARK: - Logout method
    @IBAction func onClickLogoutButton(_ sender: UIBarButtonItem) {
        if(Auth.auth().currentUser != nil){
            do {
                try Auth.auth().signOut()
                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "root")
                present(viewController!, animated: true, completion: nil)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }

}


extension HomePageViewController {
    
    // MARK: - TableView methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = countriesNamesTableView.dequeueReusableCell(withIdentifier: "country", for: indexPath) as! CountryTableViewCell
        cell.configureCellWith(countryName: countriesNames[indexPath.row], CapitalName: capitalsNames[indexPath.row])
        
        return cell
    }

}
