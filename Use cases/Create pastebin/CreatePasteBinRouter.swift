//
//  CreatePasteBinRouter.swift
//  POD browser
//
//  Created by Warwick McNaughton on 12/01/19.
//  Copyright (c) 2019 Warwick McNaughton. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol CreatePasteBinRoutingLogic {
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol CreatePasteBinDataPassing {
    var dataStore: CreatePasteBinDataStore? { get }
}

class CreatePasteBinRouter: NSObject, CreatePasteBinRoutingLogic, CreatePasteBinDataPassing {
    weak var viewController: CreatePasteBinViewController?
    var dataStore: CreatePasteBinDataStore?
  
  // MARK: Routing
  
  //func routeToSomewhere(segue: UIStoryboardSegue?)
  //{
  //  if let segue = segue {
  //    let destinationVC = segue.destination as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //  } else {
  //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
  //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //    navigateToSomewhere(source: viewController!, destination: destinationVC)
  //  }
  //}

  // MARK: Navigation
  
  //func navigateToSomewhere(source: CreatePasteBinViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: CreatePasteBinDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
