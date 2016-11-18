//
//  SurveyList.swift
//  Surveys
//
//  Created by grzesiek on 20/10/2016.
//  Copyright © 2016 testMateusz Mirkowski. All rights reserved.
//

import UIKit
import Alamofire
import SwiftSpinner

class SurveyList: UIPageViewController {
  
  // MARK: Properties
  
  var surveys: [Survey]?
  var pageControl: UIPageControl!
  var pageIndex: Int!
  
  // MARK: Lifecycles Methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.dataSource = self
    self.delegate = self
    
    getSurveys()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    setupNavigationBar()
  }
  
  
  // MARK: Setup Views
  
  func setupNavigationBar() {
    let refreshBar: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem:.refresh, target: self, action: #selector(SurveyList.getSurveys))
    
    let menuBar: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem:.action, target: self, action: nil)
    
    self.navigationItem.leftBarButtonItem = refreshBar
    self.navigationItem.rightBarButtonItem = menuBar
    
    navigationController?.navigationBar.tintColor = UIColor.white
    
    self.navigationItem.title = "Survey"
  }
  
  func configurePageControl() {
    let width = self.view.frame.size.width
    self.pageControl = UIPageControl(frame: CGRect(x: width-120, y: 300, width: 200, height: 20))
    self.pageControl.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
    self.pageControl.numberOfPages = (self.surveys?.count)!
    self.pageControl.currentPage = 0
    self.pageControl.tintColor = UIColor.white
    self.pageControl.currentPageIndicatorTintColor = UIColor.white
    self.view.addSubview(pageControl)
  }
  
  // MARK: Networking
  
  func getSurveys() {
    SwiftSpinner.show("Loading data...")
    
    SurveyNetworking.sharedInstance.requestSurveyApi({ [unowned self] surveys in
      self.surveys = surveys
      
      self.setViewControllers([self.getViewControllerAtIndex(0)] as [UIViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
      
      SwiftSpinner.hide()
      self.configurePageControl()
      
    }){ failure in
      SwiftSpinner.hide()
      self.showErrorAlert()
    }
  }
  
  // MARK: Helpers Methods
  
  func showErrorAlert() {
    let alertController = UIAlertController(title: "Error", message: "Cannot download data. Please try again later.", preferredStyle: .alert)
    
    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(defaultAction)
    
    self.present(alertController, animated: true, completion: nil)
  }
  
}

// MARK: UIPageViewControllerDataSource

extension SurveyList: UIPageViewControllerDataSource {
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

    let pageContent: SurveyPage = viewController as! SurveyPage
    var index = pageContent.pageIndex
    
    if ((index == 0) || (index == NSNotFound)) {
      return nil
    }

    index -= 1;
    
    return getViewControllerAtIndex(index)
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    
    let pageContent: SurveyPage = viewController as! SurveyPage
    var index = pageContent.pageIndex
    if (index == NSNotFound) {
      return nil;
    }
    
    index += 1;
    
    if (index == self.surveys!.count) {
      return nil;
    }
    
    return getViewControllerAtIndex(index)
  }
  
  func getViewControllerAtIndex(_ index: NSInteger) -> SurveyPage {
    let surveyPage = self.storyboard?.instantiateViewController(withIdentifier: "SurveyPage") as! SurveyPage
    surveyPage.surveyTitle.text = self.surveys![index].surveyTitle
    surveyPage.surveySubtitle.text = self.surveys![index].surveySubTitle
    
    let surveyImageURL = self.surveys![index].surveyBackgroundImage
    
//    Alamofire.request(surveyImageURL!).responseData { response in
//      if let data = response.result.value {
//        surveyPage.view.backgroundColor = UIColor.init(patternImage:  UIImage(data: data)!)
//      }
//      else {
//        surveyPage.view.backgroundColor = UIColor.black
//      }
//    }

    surveyPage.pageIndex = index
    
    return surveyPage
  }

}

// MARK: UIPageViewControllerDelegate

extension SurveyList: UIPageViewControllerDelegate {
  
  func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    let pageContentViewController = pageViewController.viewControllers![0] as! SurveyPage
    let index = pageContentViewController.pageIndex
    
    self.pageControl.currentPage = index
    self.pageIndex = index
  }
  
}
