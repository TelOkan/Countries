//
//  favoriteState.swift
//  deneme2
//
//  Created by Okan on 26.02.2022.
//

import Foundation
//i need create one class which carry datas to every screen. This techniqe name is singleton design pattern
class DataCarrier {
   
    static var shared = [DataCarrier]().self
    var countryNo   : Int?
    var countryCode : String?
    var countryName : String?
    var isFavorite  : String?
    
    init(countryNo : Int,countryCode : String , countryName : String, isFavorite : String) {
        self.countryNo   = countryNo
        self.countryCode = countryCode
        self.countryName = countryName
        self.isFavorite  = isFavorite
    }
}

