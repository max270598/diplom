//
//  VerifyNewEmailAlertViewController.swift
//  VseBankiRu
//
//  Created by Мах Ol on 5/11/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit
import Firebase

enum AlertType {
    case changeEmail
    case changePassword
}

class VerifyNewEmailAlertViewController: UIViewController {

    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var activityController: UIActivityIndicatorView!
    
    var alertType: AlertType?
    
     let user = Auth.auth().currentUser
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.alertView.addShadowCorner(cornerRadius: 10, offset: CGSize(width: 0, height: 0), color: .black, radius: 10, opacity: 0.6)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.activityController.startAnimating()
        let timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { [weak self] (timer) in
                   
            self?.user?.reload(completion: { (error) in
                if let error = error {
                    print(error.localizedDescription)
                 } else {
                         if Auth.auth().currentUser != nil && Auth.auth().currentUser!.isEmailVerified {
                        print("user verified")
                            self?.activityController.stopAnimating()
                            timer.invalidate()
                            self?.dismiss(animated: true, completion: nil)
                            do {
                                                       try Auth.auth().signOut()
                                                        } catch {
                                                            print(error.localizedDescription)
                                                        }
                                                    
                                                    let storyB = UIStoryboard(name: "Main", bundle: nil)
                                                    let vc = storyB.instantiateViewController(identifier: "AuthorisationViewController")
                                                    vc.modalPresentationStyle = .fullScreen
                            self?.present(vc, animated: true, completion: nil)
                         } else {
                            print("user isnt verified")
                            
                    }
                        }
                })
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
