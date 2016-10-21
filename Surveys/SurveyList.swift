//
//  SurveyList.swift
//  Surveys
//
//  Created by grzesiek on 20/10/2016.
//  Copyright © 2016 testMateusz Mirkowski. All rights reserved.
//

import UIKit

class SurveyList: UIPageViewController {
  @IBOutlet weak var surveyTitle: UILabel!
  @IBOutlet weak var surveySubtitle: UILabel!
  @IBOutlet weak var takeSurvey: UIButton!
  
  var surveys: [Survey]?

  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    SurveyNetworking.sharedInstance.requestApi() { survey in
      self.surveys = survey
    }
  }
}
