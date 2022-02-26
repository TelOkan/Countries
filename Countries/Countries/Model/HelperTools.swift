//
//  HelperTools.swift
//  Countries
//
//  Created by Okan on 27.02.2022.
//

import Foundation
import UIKit

class HelperTools {
    
    func arrangmentTableview(tableView : UITableView){
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.reloadData()
    }
    
    func checkFavState(button : UIButton , starState : String){
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .large)
        let largeBoldDoc = UIImage(systemName: starState, withConfiguration: largeConfig)
        button.setImage(largeBoldDoc, for: .normal)
        button.tintColor = .systemYellow
    }
    
    
    func arragmentTableViewFav(button : UIButton, starState : String,indexPath: IndexPath){
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .large)
        let largeBoldDoc = UIImage(systemName: starState, withConfiguration: largeConfig)
        button.setImage(largeBoldDoc, for: .normal)
        button.tintColor = .systemYellow
    }
    
    
   
}
