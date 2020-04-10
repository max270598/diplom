//
//  VerificationCodeViewController.swift
//  VseBankiRu
//
//  Created by Мах Ol on 4/9/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit
import FirebaseAuth

class VerificationCodeViewController: UIViewController {

    @IBOutlet weak var phoneNumberTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendCode(_ sender: Any) {
        
        let alert = UIAlertController(title: "Phone number", message: "Is this your phone Number?\n \(self.phoneNumberTextField.text!)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Yes", style: .default) { (UIAlertAction) in
                        self.performSegue(withIdentifier: "code", sender: Any.self)

        }
        
        let cancel = UIAlertAction(title: "No", style: .cancel, handler: nil)
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumberTextField.text!, uiDelegate: nil) { (verificationID, error) in
            
            guard error == nil else {
                print(error?.localizedDescription)
                return
            }
            
            let defaults = UserDefaults.standard
            defaults.setValue(verificationID, forKey: "authVID")
            
        }
        
        alert.addAction(action)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
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
