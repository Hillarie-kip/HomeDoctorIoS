//
//  ApiManager.swift
//  HomeDoctor
//
//  Created by Hillarie  on 09/07/2020.
//  Copyright © 2020 Hillarie. All rights reserved.
//

import Foundation
import Alamofire
class APIManager {

static let sharedInstance = APIManager()

func callingRegisterAPI(register:UsersModel){
    let headers: HTTPHeaders = [
        .contentType ("application/json")
    ]
    
 
    AF.request(RegisterLogin,method:.post,parameters:register,encoder:
        JSONParameterEncoder.default,headers:headers).response{
            response in
            debugPrint(response)
    }
}
}

           
           
