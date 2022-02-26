//
//  HomeViewController.swift
//  deneme2
//
//  Created by Okan on 24.02.2022.
//

import UIKit

/*protocol ProcessorDelegate {
 func getProcessorData(_ favoriteState : [FavoriteState])
 }*/
class HomeViewController: UIViewController,CountryManagerDelegate{
    
    var apiManager = ApiManager()
    var savedViewController = SavedViewController()
    var helperTools = HelperTools()
    var indexNo : Int?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        apiManager.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        apiManager.getCountriesData() //i am getting here country data's with api call.
        helperTools.arrangmentTableview(tableView: tableView)
    }
    
    @IBAction func favButtonPressed(_ sender: UIButton) {
        
        
        let buttonNo = sender.tag
        
        // if one country added  as favorite , i am separating with this statement.
        if (DataCarrier.shared[buttonNo].isFavorite == "False" ){
            
            DataCarrier.shared[buttonNo].isFavorite = "True"
            helperTools.checkFavState(button: sender, starState: "star.fill")
            
        }else if (DataCarrier.shared[buttonNo].isFavorite == "True"){
            
            DataCarrier.shared[buttonNo].isFavorite = "False"
            helperTools.checkFavState(button: sender, starState: "star")
        }
    }
    
    func getCountriesData(_ modelManager: ApiManager, _ countryModel: [CountryModel]) {
                
        if DataCarrier.shared.count != 10 { //i have to check DataCarrier whather empty or not. if i don't do this statement , every clicked on main button  which is tabBar control , main screen will be loaded a lot of same countries. like this country names will appear as it's supposed to be.
            
            for (i,item) in countryModel.enumerated(){
                //i have added data into Data carrier.
                let values = DataCarrier(countryNo : i ,countryCode: item.code , countryName: item.name, isFavorite: "False")
                DataCarrier.shared.append(values)
            }
        }
        
        DispatchQueue.main.async { //when async situation finish. reload tableView otherwise every time we see white screen :) this mean never tableView will be load.
            
            self.tableView.reloadData()
            
        }
        
        
    }
    
}
extension HomeViewController : UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return DataCarrier.shared.count //tableView row quantity.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        cell.cellLabel.text = DataCarrier.shared[indexPath.row].countryName
        cell.cellFavButton.tag = DataCarrier.shared[indexPath.row].countryNo! //i have embeeded contryNo in to button tag. like this, i have give relative button with row.
        cell.cellView.layer.cornerRadius = cell.cellView.frame.height / 6
  
        if DataCarrier.shared[indexPath.row].isFavorite == "True"{ // if one country added  as favorite , i am separating with this statement.
            
            helperTools.arragmentTableViewFav(button: cell.cellFavButton, starState: "star.fill", indexPath: indexPath)
        }else {
            helperTools.arragmentTableViewFav(button: cell.cellFavButton, starState: "star", indexPath: indexPath)
        }
     
        return cell
    }
    
    
    
    
    //below code lines related with segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            if let destinationVC = segue.destination as? DetailViewConroller {
                destinationVC.countryCode = DataCarrier.shared[indexNo!].countryCode! //i am giving country code because i am calling with country code to api request.
                destinationVC.countryNo = indexNo // we need index number to fallow right cauntry is added favorite.
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        indexNo =  indexPath.row //i have catched index number here.
        performSegue(withIdentifier: "toDetailVC", sender: nil)
        
    }
    
    
    
}


