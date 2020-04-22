//
//  SendCodeViewController.swift
//  VseBankiRu
//
//  Created by Мах Ol on 4/9/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit
import FirebaseAuth

class SendCodeViewController: UIViewController {

    @IBOutlet weak var codeTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logIn(_ sender: Any) {
        let defaults = UserDefaults.standard
        
        let credential: PhoneAuthCredential = PhoneAuthProvider.provider().credential(withVerificationID: defaults.string(forKey: "authVID")!, verificationCode: codeTextField.text!)
        Auth.auth().signIn(with: credential) { (user, error) in
            guard error == nil else {
                print(error?.localizedDescription)
                print(error.debugDescription)
                return
            }
            
            print(user?.user.phoneNumber)
            let userInfo = user?.user.providerData[0]
            print("Provider ID \(userInfo?.providerID)")
            self.performSegue(withIdentifier: "logged", sender: Any?.self)
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
