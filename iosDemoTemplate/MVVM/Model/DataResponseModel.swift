//
//  DataResponseModel.swift
//  iosDemoTemplate
//
//  Created by Surinder kumar on 24/07/22.
//

import Foundation


struct DataResponse<T:Codable>:Codable{
    var data : T?
    var status_code : Int = 0
    var message : String = ""
}
