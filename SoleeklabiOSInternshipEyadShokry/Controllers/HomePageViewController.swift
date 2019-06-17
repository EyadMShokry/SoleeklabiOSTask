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
    var letter: String = ""
    var countriesNames = [String]()
    var capitalsNames = [String]()
    @IBOutlet weak var countriesNamesTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        countriesNamesTableView.dataSource = self
        countriesNamesTableView.delegate = self
        
        fetchCountriesDataWithLitter(litter: self.letter)
        //fetchCountriesData()
        
        performUIUpdatesOnMain {
            self.countriesNamesTableView.reloadData()
        }
       
    }
    
    func fetchCountriesDataWithLitter(litter: String) {
        
        Client.shared().getCountriesNamesAndCapitals(completionHandler: {(countriesData, error) in
            if error != nil {
                self.showAuthenticationAlert(title: "Error fetching Data", message: "We didn't find any Information, be sure to connect with Internet or try again later")
            }
                
            else if let countries_data = countriesData {
                for country in countries_data{
                    if (country["name"]!.hasPrefix(litter)) {
                        self.countriesNames.append(country["name"]!)
                        self.capitalsNames.append(country["capital"]!)
                   }
                    
                }
                self.performUIUpdatesOnMain {
                    self.countriesNamesTableView.reloadData()
                    
                }
                print(self.countriesNames)
            }
        })

    }

    
    // MARK: - Reading JSON file and Parsing it
    func fetchCountriesData() {
        performUIUpdatesOnMain {
            self.activityIndicator.startAnimating()
        }
        
        Client.shared().getCountriesNamesAndCapitals(completionHandler: {(countriesData, error) in
            if error != nil {
                self.showAuthenticationAlert(title: "Error fetching Data", message: "We didn't find any Information, be sure to connect with Internet or try again later")
            }
            
            else if let countries_data = countriesData {
                for country in countries_data{
                    self.countriesNames.append(country["name"]!)
                    self.capitalsNames.append(country["capital"]!)
                    
                }
                self.performUIUpdatesOnMain {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                }
            }
        })
    }
    
    
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
        let cell = countriesNamesTableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as! CountryTableViewCell
        cell.configureCellWith(countryName: countriesNames[indexPath.row], CapitalName: capitalsNames[indexPath.row])
        
        return cell
    }

}
