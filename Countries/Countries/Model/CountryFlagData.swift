//
//  CountryFlagApiModel.swift
//  deneme2
//
//  Created by Okan on 25.02.2022.
//

import Foundation


struct CountriesFlagData : Codable{
    let data : DatasWFlag
}

struct DatasWFlag : Codable{
    let wikiDataId : String
    let flagImageUri : String
   
}
