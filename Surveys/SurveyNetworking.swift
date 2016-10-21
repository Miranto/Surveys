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
  
  func requestApi(completion: ([Survey]) -> Void) {
    let surveyEndPoint = NetworkStatic.mainApi + "?access_token=" + NetworkStatic.token
    Alamofire.request(.GET, surveyEndPoint).responseArray { (response: Response<[Survey], NSError>) in
    
      let surveyResponse = response.result.value
      
      if let surveysArray = surveyResponse {
        for survey in surveysArray {
          print(survey.surveyTitle)
          print(survey.surveySubTitle)
          print(survey.surveyBackgroundImage)
        }
      }
      completion(surveyResponse!)
      print(surveyResponse?.count)
    }

  }
}
