//
//  SurveyNetworking.swift
//  Surveys
//
//  Created by grzesiek on 20/10/2016.
//  Copyright © 2016 testMateusz Mirkowski. All rights reserved.
//

import Foundation
import Alamofire

struct NetworkStatic {
  static let mainApi = "https://www-staging.usay.co/app/surveys.json"
  static let token = "6eebeac3dd1dc9c97a06985b6480471211a777b39aa4d0e03747ce6acc4a3369"
}

class SurveyNetworking {
  static let sharedInstance = SurveyNetworking()
  
  func requestApi() {
    let surveyEndPoint = NetworkStatic.mainApi + "?access_token=" + NetworkStatic.token
    Alamofire.request(.GET, surveyEndPoint) .responseJSON { response in
    
      if let JSON = response.result.value {
        print("JSON: \(JSON)")
      }
    }
  }
}
