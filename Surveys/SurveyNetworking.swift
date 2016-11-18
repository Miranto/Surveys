//
//  SurveyNetworking.swift
//  Surveys
//
//  Created by grzesiek on 20/10/2016.
//  Copyright © 2016 testMateusz Mirkowski. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

struct NetworkStatic {
  static let mainApi = "https://www-staging.usay.co/app/surveys.json"
  static let token = "6eebeac3dd1dc9c97a06985b6480471211a777b39aa4d0e03747ce6acc4a3369"
}

class SurveyNetworking {
  static let sharedInstance = SurveyNetworking()
  
  func requestSurveyApi(_ completion: @escaping ([Survey]) -> Void, failure: @escaping (NSError) -> Void) {
    let surveyEndPoint = NetworkStatic.mainApi + "?access_token=" + NetworkStatic.token
    Alamofire.request(surveyEndPoint).responseArray { (response: DataResponse<[Survey]>) in
    
      switch response.result {
      case .success:
        let surveyResponse = response.result.value
        
        print("success")
        
        completion(surveyResponse!)
        
      case .failure(let error):
        print("failure")
        
        failure(error as NSError)
      }
    }
  }
  
}
