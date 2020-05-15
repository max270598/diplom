//
//  LastViewController.swift
//  VseBankiRu
//
//  Created by Мах Ol on 5/15/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit

class LastViewController: UIViewController {

    @IBAction func goBack(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func recursivePop(controller: UIViewController?){

    if let controller = controller {
        if let nav:UINavigationController = controller.navigationController {
            nav.popToRootViewController(animated: true)
            self.recursivePop(controller: controller)
        }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



class LastViewController2: UIViewController {

    @IBAction func goBack(_ sender: UIButton) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil) 
//      let window = UIApplication.shared.windows[0] as UIWindow;
//        print("WINDOW", window)
////        UIApplication.shared
//        let frame = UIScreen.main.bounds
//        UIApplication.shared.windows.first?.frame = frame
//        UIApplication.shared.windows.first?.rootViewController = AuthorisationViewController()
//        UIApplication.shared.windows.first?.makeKeyAndVisible()
////        window.rootViewController = LastViewController
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func recursivePop(controller: UIViewController?){

    if let controller = controller {
        if let nav:UINavigationController = controller.navigationController {
            nav.popToRootViewController(animated: true)
            self.recursivePop(controller: controller)
        }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
