//
//  UserViewModel.swift
//  iosDemoTemplate
//
//  Created by Surinder kumar on 24/07/22.
//

import UIKit

class UserViewModel: NSObject {

    public static let shared : UserViewModel? = UserViewModel()
    
    func userLogin(email:String,password:String,completion:@escaping completionHandler){
        
        let param = ["email":email,"pass":password]
        
        server(url: "BaseUrl", apiMethod: .post, param: param, header: nil, isLoaderShow: true) { [weak self] (response,responseData,success) in
            
            let usersData = try? JSONDecoder().decode(DataResponse<CommonModel>.self, from: responseData ?? Data())
            if usersData?.status_code == 200{
                completion(true,usersData?.message ?? "")
            }else{
                completion(false,usersData?.message ?? "")
            }
        }
        
    }
    
}
