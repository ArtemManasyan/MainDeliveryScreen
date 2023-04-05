//
//  Service.swift
//  MainScreenDeliveryApp
//
//  Created by Артем Манасян on 04.04.2023.
//

import Foundation
import Alamofire

class Service {
    
    private let productUrl = "https://run.mocky.io/v3/dfc6b98d-43ac-4d02-b572-728467107bea"
    
    func getData(completion: ((ProductParseModel) -> Void)?) {
        AF.request(productUrl, method: .get).responseDecodable(of: ProductParseModel.self) { response in
            switch response.result {
            case let .success (productModel):
                print(productModel)
                completion?(productModel)
            case let .failure(error):
                print(error)
            }
        }
    }
}
