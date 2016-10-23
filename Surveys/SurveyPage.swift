//
//  SurveyPage.swift
//  Surveys
//
//  Created by grzesiek on 22/10/2016.
//  Copyright © 2016 testMateusz Mirkowski. All rights reserved.
//

import UIKit

class SurveyPage: UIViewController {
  @IBOutlet weak var surveyTitle: UILabel!
  @IBOutlet weak var surveySubtitle: UILabel!
  @IBOutlet weak var takeSurvey: UIButton!
  
  var pageIndex: Int = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    self.setupViews()
  }
  
  func setupViews() {
    self.takeSurvey.layer.cornerRadius = 15
  }
  
  @IBAction func startSurvey(sender: AnyObject) {
    let mapViewControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("SurveyDetails")
    self.navigationController?.pushViewController(mapViewControllerObj!, animated: true)
  }
  
}
