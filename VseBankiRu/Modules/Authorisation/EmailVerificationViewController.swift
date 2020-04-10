//
//  EmailVerificationViewController.swift
//  VseBankiRu
//
//  Created by Мах Ol on 4/10/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit
import Firebase

class EmailVerificationViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let user = Auth.auth().currentUser
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.startAnimating()
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { [weak self] (timer) in
                   
            self?.user?.reload(completion: { (error) in
                if let error = error {
                    print(error.localizedDescription)
                 } else {
                         if Auth.auth().currentUser != nil && Auth.auth().currentUser!.isEmailVerified {
                        print("user verified")
                            self?.activityIndicator.stopAnimating()
                            timer.invalidate()
                            self?.performSegue(withIdentifier: "emailVerified", sender: nil)
                            
                         } else {
                            print("user isnt verified")
                            
                    }
                        }
                })
        }
    }
//                       print("user", self?.user)
                       
                       
//                       switch self?.user!.isEmailVerified {
//                       case true:
//                           print("user verified")
//                           timer.invalidate()
//                           self?.activityIndicator.stopAnimating()
//                           self?.performSegue(withIdentifier: "emailVerified", sender: nil)
//
//                       case false:
//                           print("user in not verified")
//                           print("timer", timer.timeInterval)
//
//                       default:
//                           print("Some error")
//                       }
//                   }
//               )}
//           }
//
//    }
//
//
                    
                
                
                
                
            
        // Do any additional setup after loading the view.
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
