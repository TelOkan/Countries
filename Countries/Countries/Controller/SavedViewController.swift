//
//  SavedViewController.swift
//  deneme2
//
//  Created by Okan on 24.02.2022.
//

import UIKit

class SavedViewController: UIViewController {
   
    var helperTools = HelperTools()
    var favoriteCountries : [DataCarrier] = []
    var indexNumber : Int?
    var countryNo = [Int]()
    @IBOutlet weak var tableViewFav: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableViewFav.delegate = self
        tableViewFav.dataSource = self
        countryNo.removeAll() //if i dont clear countryNo here , details screen will be workins as wrongly. Because i am working with indexNumber.
        favoriteCountries = DataCarrier.shared.filter({$0.isFavorite!.contains("T")}) //i am asking here i have favorite countries ?
        helperTools.arrangmentTableview(tableView: tableViewFav)
    }
  
    @IBAction func favButtonPressed(_ sender: UIButton) {
        let buttonNo = sender.tag
        
       if (DataCarrier.shared[buttonNo].isFavorite == "True"){ // to delete countries which is added favorite.
            DataCarrier.shared[buttonNo].isFavorite = "False"
            favoriteCountries = DataCarrier.shared.filter({$0.isFavorite!.contains("T")}) //to refresh tableview lastest statement.
            tableViewFav.reloadData()
        }
        
        
    }
}

extension SavedViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableViewFav.dequeueReusableCell(withIdentifier: "cellFav", for: indexPath) as! SavedTableViewCell
        cell.cellFavView.layer.cornerRadius = cell.cellFavView.frame.height / 6
        cell.cellFavLabel.text = favoriteCountries[indexPath.row].countryName
        countryNo.append(favoriteCountries[indexPath.row].countryNo!)
        cell.cellFavButton.tag = favoriteCountries[indexPath.row].countryNo!
        
        helperTools.arragmentTableViewFav(button: cell.cellFavButton, starState: "star.fill", indexPath: indexPath)
        return cell
    }
    //toDetailVcFromSaved
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVcFromSaved" {
            if let destinationVC = segue.destination as? DetailViewConroller {
                destinationVC.countryCode = DataCarrier.shared[indexNumber!].countryCode!
                destinationVC.countryNo = indexNumber
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexNumber = countryNo[indexPath.row]
        performSegue(withIdentifier: "toDetailVcFromSaved", sender: nil)
        
    }
 
    
}
