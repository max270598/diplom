//
//  VerificationViewController.swift
//  VseBankiRu
//
//  Created by Мах Ol on 4/10/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit
import Firebase

class VerificationViewController: UIViewController {

    @IBOutlet weak var codeTextField: UITextField!
    
    var email: String?
    var phone: String?
    var password: String?
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var confirmButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference(withPath: "users")

        // Do any additional setup after loading the view.
    }
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        
        let credential: PhoneAuthCredential = PhoneAuthProvider.provider().credential(withVerificationID: defaults.string(forKey: "verificationID")!, verificationCode: codeTextField.text!)
        Auth.auth().signIn(with: credential) { (user, error) in
            guard error == nil else {
                print(error?.localizedDescription)
                print(error.debugDescription)
                return
            }
            
            Auth.auth().createUser(withEmail: self.email!, password: self.password!) { [weak self](result, error) in
                guard result != nil, error == nil else {
                    print(error?.localizedDescription)
                    return
                }
                
                let userRef = self?.ref.child((result?.user.uid)!)
                userRef?.setValue(["email": result?.user.email])
                userRef?.setValue(["phone": result?.user.phoneNumber])
                
            }
            self.performSegue(withIdentifier: "verifyed", sender: nil)
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
