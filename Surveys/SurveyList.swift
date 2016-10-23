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
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    setupNavigationBar()
  }
  
  // MARK: Setup Views
  
  func setupNavigationBar() {
    let refreshBar: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem:.Refresh, target: self, action: #selector(SurveyList.getSurveys))
    
    let menuBar: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem:.Action, target: self, action: nil)
    
    self.navigationItem.leftBarButtonItem = refreshBar
    self.navigationItem.rightBarButtonItem = menuBar
    
    navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    
    self.navigationItem.title = "Survey"
  }
  
  func configurePageControl() {
    let width = self.view.frame.size.width
    self.pageControl = UIPageControl(frame: CGRectMake(width-120, 300, 200, 20))
    self.pageControl.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
    self.pageControl.numberOfPages = (self.surveys?.count)!
    self.pageControl.currentPage = 0
    self.pageControl.tintColor = UIColor.whiteColor()
    self.pageControl.currentPageIndicatorTintColor = UIColor.whiteColor()
    self.view.addSubview(pageControl)
  }
  
  // MARK: Networking
  
  func getSurveys() {
    SwiftSpinner.show("Loading data...")
    
    SurveyNetworking.sharedInstance.requestSurveyApi({ surveys in
      self.surveys = surveys
      
      self.setViewControllers([self.getViewControllerAtIndex(0)] as [UIViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
      
      SwiftSpinner.hide()
      self.configurePageControl()
      
    }){ failure in
      SwiftSpinner.hide()
      self.showErrorAlert()
    }
  }
  
  // MARK: Helpers Methods
  
  func showErrorAlert() {
    let alertController = UIAlertController(title: "Error", message: "Cannot download data. Please try again later.", preferredStyle: .Alert)
    
    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
    alertController.addAction(defaultAction)
    
    self.presentViewController(alertController, animated: true, completion: nil)
  }
  
}

// MARK: UIPageViewControllerDataSource

extension SurveyList: UIPageViewControllerDataSource {
  
  func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {

    let pageContent: SurveyPage = viewController as! SurveyPage
    var index = pageContent.pageIndex
    
    if ((index == 0) || (index == NSNotFound))
    {
      return nil
    }

    index -= 1;
    
    return getViewControllerAtIndex(index)
  }
  
  func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
    
    let pageContent: SurveyPage = viewController as! SurveyPage
    var index = pageContent.pageIndex
    if (index == NSNotFound)
    {
      return nil;
    }
    
    index += 1;
    
    if (index == self.surveys!.count)
    {
      return nil;
    }
    
    return getViewControllerAtIndex(index)
  }
  
  func getViewControllerAtIndex(index: NSInteger) -> SurveyPage {
    let surveyPage = self.storyboard?.instantiateViewControllerWithIdentifier("SurveyPage") as! SurveyPage
    surveyPage.surveyTitle.text = self.surveys![index].surveyTitle
    surveyPage.surveySubtitle.text = self.surveys![index].surveySubTitle
    
    let surveyImageURL = self.surveys![index].surveyBackgroundImage
    Alamofire.request(.GET, surveyImageURL!).response { (request, response, data, error) in
      if error == nil {
        surveyPage.view.backgroundColor = UIColor.blackColor()
      }
      else {
        surveyPage.view.backgroundColor = UIColor.init(patternImage:  UIImage(data: data!, scale:1)!)
      }
    }

    surveyPage.pageIndex = index
    
    return surveyPage
  }

}

// MARK: UIPageViewControllerDelegate

extension SurveyList: UIPageViewControllerDelegate {
  
  func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    let pageContentViewController = pageViewController.viewControllers![0] as! SurveyPage
    let index = pageContentViewController.pageIndex
    
    self.pageControl.currentPage = index
    self.pageIndex = index
  }
  
}
