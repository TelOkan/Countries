//
//  ViewController.swift
//  deneme2
//
//  Created by Okan on 23.02.2022.
//

import UIKit
import Foundation
import Kingfisher
import SVGKit
class DetailViewConroller: UIViewController,CountryManagerFlagDelegate {
    
    var modelFlagManeger = ApiManager()
    var helperTools = HelperTools()
    @IBOutlet weak var detailFavButton: UIButton!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var countryCodeLabel: UILabel!
    var countryCode : String = ""
    var countryNo : Int?
    var wikiDataBaseURL = "https://www.wikidata.org/wiki/" //i need this link to open wikidata page.
    var wikiData : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        modelFlagManeger.delegateFlag = self
        countryCodeLabel.text = countryCode
        modelFlagManeger.getCountriesDataFlag(countryCode: countryCode) //i am getting here country data's with api call with countryCode to get flan url.
        
    
        if DataCarrier.shared[countryNo!].isFavorite == "True"{
            helperTools.checkFavState(button: detailFavButton, starState: "star.fill")
            
        }else {
            helperTools.checkFavState(button: detailFavButton, starState: "star")
            
        }
    }
    
    @IBAction func detailFavButtonPressed(_ sender: Any) {
    
        if let buttonNo = countryNo {
                if (DataCarrier.shared[buttonNo].isFavorite == "False" ){ //in the detail screen to change statement of the country favorite.
                DataCarrier.shared[buttonNo].isFavorite = "True"
                helperTools.checkFavState(button: detailFavButton, starState: "star.fill")
                
            }else if (DataCarrier.shared[buttonNo].isFavorite == "True"){
                DataCarrier.shared[buttonNo].isFavorite = "False"
                helperTools.checkFavState(button: detailFavButton, starState: "star")
            }
        }
    }
   
    //when clicked on the for more information.
    @IBAction func informationPressed(_ sender: Any) {
        if let url = URL(string: wikiDataBaseURL+wikiData){
            UIApplication.shared.openURL(url)
        }
    }
    
    //i have used here kingfished third party library to download image and upload this image into imageView
    func getCountriesFlagData(_ modelManager: ApiManager, _ countryFlagModel: CountryFlagModel) {
        let url = URL(string: countryFlagModel.flagImageUri)
        flagImageView.kf.setImage(with: url, options: [.processor(SVGImgProcessor())])
        wikiData = countryFlagModel.wikiDataId
    }
}

//our picture format is Svg so we need to process this image to relevant format
public struct SVGImgProcessor:ImageProcessor {
    public var identifier: String = "com.appidentifier.webpprocessor"
    public func process(item: ImageProcessItem, options: KingfisherParsedOptionsInfo) -> KFCrossPlatformImage? {
        switch item {
        case .image(let image):
            print("already an image")
            return image
        case .data(let data):
            let imsvg = SVGKImage(data: data)
            return imsvg?.uiImage
        }
    }
}


