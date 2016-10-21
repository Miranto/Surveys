//
//  Survey.swift
//  Surveys
//
//  Created by grzesiek on 21/10/2016.
//  Copyright © 2016 testMateusz Mirkowski. All rights reserved.
//

import Foundation
import ObjectMapper

class Survey: Mappable {
  var surveyTitle : String?
  var surveySubTitle : String?
  var surveyBackgroundImage : String?
  
  required init?(_ map: Map){
  
  }
  
  func mapping(map: Map) {
    surveyTitle <- map["title"]
    surveySubTitle <- map["type"]
    surveyBackgroundImage <- map["cover_image_url"]
  }
}