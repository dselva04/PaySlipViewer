//
//  ViewController.swift
//  PaySlipViewer
//
//  Created by karthik on 23/11/21.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var newPayBtn: UIButton!
    @IBOutlet weak var viewPayBtn: UIButton!
    @IBOutlet weak var bonusBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        // Do any additional setup after loading the view.
    }

    @IBAction func newPayBtnPressed(_ sender: Any) {
        guard let navViewController = AddPaySlipVC.getStoryboardInstanceForNC(),
        let viewController = navViewController.topViewController as? AddPaySlipVC
        else { return }
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func viewPayBtnPressed(_ sender: Any) {
        guard let navViewController = ViewPaySlipVC.getStoryboardInstanceForNC(),
              let viewController = navViewController.topViewController as? ViewPaySlipVC
        else { return }
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func bonusBtnPressed(_ sender: Any) {
    }
    
}

