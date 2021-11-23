//
//  UIViewController.swift
//  PaySlipViewer
//
//  Created by karthik on 23/11/21.
//

import UIKit

protocol CommonViewControllerMethods {
    static func getStoryboardInstanceForNC() -> UINavigationController?
    static func getStoryboardInstanceForVC() -> UIViewController?
    static func getStoryboardInstanceForTabVC() -> UITabBarController?
}
extension UIViewController:CommonViewControllerMethods{
    static func getStoryboardInstanceForTabVC() -> UITabBarController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let tabBarViewController = storyboard.instantiateInitialViewController() as? UITabBarController else { return nil }
        return tabBarViewController
    }
    
    static func getStoryboardInstanceForNC() -> UINavigationController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let navController = storyboard.instantiateInitialViewController() as? UINavigationController else { return nil }
        return navController
    }
    
    static func getStoryboardInstanceForVC() -> UIViewController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() else { return nil }
        return viewController
    }
    
}


extension UIViewController {
    func hideKeyboardOnTap(){
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}
