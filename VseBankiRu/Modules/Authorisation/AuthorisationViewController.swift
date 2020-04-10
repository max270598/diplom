//
//  AuthorisationViewController.swift
//  VseBankiRu
//
//  Created by Мах Ol on 4/10/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit
import FirebaseAuth
import IQKeyboardManagerSwift

class AuthorisationViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        IQKeyboardManager.shared.keyboardDistanceFromTextField = 100

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true

        self.errorLabel.alpha = 0
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        guard let email = self.emailTextField.text, let password = passwordTextField.text, email != "", password != "" else {
            showErrorLabel(with: "Info is incorrect")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self](user, error) in
            if error != nil {
                self?.showErrorLabel(with: "Error occured")
                return
            }
           
            guard user != nil else {
                self?.showErrorLabel(with: "No such user")
                return
                
            }
            
            guard (user?.user.isEmailVerified)! else {
                self?.showErrorLabel(with: "User email is not verified")
                return
            }
            self?.performSegue(withIdentifier: "logged", sender: nil)

            
        }
        
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
       
        self.performSegue(withIdentifier: "register", sender: nil)
       
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

extension AuthorisationViewController {
    func showErrorLabel(with text: String) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in
                       self?.errorLabel.alpha = 1
                   }, completion: nil)
    }
}
