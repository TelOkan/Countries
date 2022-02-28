//
//  Model.swift
//  deneme2
//
//  Created by Okan on 23.02.2022.
//

import Foundation

struct CountriesData : Codable{
    let data : [Datas]
}

struct Datas: Codable {
    let code : String
    let name : String
   
}
