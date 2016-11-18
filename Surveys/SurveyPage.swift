//
//  SurveyPage.swift
//  Surveys
//
//  Created by grzesiek on 22/10/2016.
//  Copyright © 2016 testMateusz Mirkowski. All rights reserved.
//

import UIKit

class SurveyPage: UIViewController {
  
  // MARK: Properties
  
  @IBOutlet weak var surveyTitle: UILabel!
  @IBOutlet weak var surveySubtitle: UILabel!
  @IBOutlet weak var takeSurvey: UIButton!
  
  var pageIndex: Int = 0
  
  // MARK: Lifecycles Methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.setupViews()
  }
  
  // MARK: Setup Views
  
  func setupViews() {
    self.takeSurvey.layer.cornerRadius = 15
  }
  
  // MARK: IBActions
  
  @IBAction func startSurvey(_ sender: AnyObject) {
    let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "SurveyDetails")
    self.navigationController?.pushViewController(mapViewControllerObj!, animated: true)
  }
  
}
