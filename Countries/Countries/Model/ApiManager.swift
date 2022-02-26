//
//  ModelManager.swift
//  deneme2
//
//  Created by Okan on 23.02.2022.
//

import Foundation
protocol CountryManagerDelegate { //I used protokols and Delegates to Carrier data between of the screens.
    func getCountriesData(_ modelManager : ApiManager , _ countryModel : [CountryModel])
}
protocol CountryManagerFlagDelegate {
    func getCountriesFlagData(_ modelManager : ApiManager , _ countryFlagModel : CountryFlagModel)
}
struct ApiManager {
    
    var delegate : CountryManagerDelegate?
    var delegateFlag : CountryManagerFlagDelegate?
    
    //below code lines for api request
    let baseURL = "https://wft-geo-db.p.rapidapi.com/v1/geo/countries"
    let apiKey = "/?rapidapi-key=09ce5a4ddfmshbabe6a0cd52da12p11dfa8jsn01dc1c42728f"
    let countryQuantity = "&limit=10"
    
    
    //Here have two options why i am api requesting. home screen or detail screen. I need flag url so i have to arrange it.
    mutating func getCountriesData(){
        let urlString = "\(baseURL)\(apiKey)\(countryQuantity)"
        performRequest(with: urlString , flagIsValid: false)
    }
    
    mutating func getCountriesDataFlag(countryCode : String){
        let urlString = "\(baseURL)/\(countryCode)\(apiKey)\(countryQuantity)"
        performRequest(with: urlString, flagIsValid: true)
    }
    
    
    //perform request does api request for me.
    func performRequest(with UrlString : String , flagIsValid : Bool) {
        
        
        
        if let url = URL(string: UrlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if  error != nil  {
                    print(error!)
                }
                if let safeData = data {
                    if flagIsValid == false {
                        
                        if let  arrayCountry = self.parseJson(safeData){
                            self.delegate?.getCountriesData(self, arrayCountry)
                        }
                        
                    }else {
                        if let  arrayCountryFlag = self.parseJsonForFlag(safeData){
                            self.delegateFlag?.getCountriesFlagData(self, arrayCountryFlag)
                        }
                    }
                }
            }
            task.resume()
        }
        
    }
    
    
    
    
    
    //i need to convert api respond because it is coming as Json.
    func parseJson(_ countryData : Data) -> [CountryModel]? {
        let decoder = JSONDecoder()
        var countryModel = [CountryModel]()
        do{
            let decodedData = try decoder.decode(CountriesData.self, from: countryData)
            for (i,_) in decodedData.data.enumerated(){
                
                let code = decodedData.data[i].code
                let name = decodedData.data[i].name

                countryModel.append(CountryModel(code: code, name: name))
            }
            return countryModel
        }
        catch{
            print(error)
            return nil
        }
        
    }
    
    //i need to convert api respond because it is coming as Json.
    func parseJsonForFlag(_ countryData : Data) -> CountryFlagModel? {
        let decoder = JSONDecoder()
        
        do{
            let decodedData = try decoder.decode(CountriesFlagData.self, from: countryData)
            let wikiDataId = decodedData.data.wikiDataId
            let flagImageUri = decodedData.data.flagImageUri
            let countryFlagModel =  CountryFlagModel(wikiDataId: wikiDataId, flagImageUri: flagImageUri)
            
            return countryFlagModel
        }
        catch{
            print(error)
            return nil
        }
        
    }
    
    
}

