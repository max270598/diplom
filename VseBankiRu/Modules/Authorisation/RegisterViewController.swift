//
//  RegisterViewController.swift
//  VseBankiRu
//
//  Created by Мах Ol on 4/10/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit
import Firebase


class RegisterViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    @IBOutlet weak var createAccountButton: UIButton!
    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Регистрация"
        self.errorLabel.alpha = 0

        ref = Database.database().reference(withPath: "users")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.enableCreateButton()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "verify" else {return}
        guard let secondVC = segue.destination as? VerificationViewController  else {return}
       
        secondVC.email = self.emailTextField.text
        secondVC.password = self.passwordTextField.text
    }

    @IBAction func createAccountButtonTapped(_ sender: Any) {
        guard let name = self.firstNameTextField.text, let email = self.emailTextField.text, let password = passwordTextField.text, name != "", email != "", password != "", let confirmPassword = confirmPasswordTextField.text, confirmPassword != "" else {
                showErrorLabel(with: "Info is incorrect")
                return
            }
        
        guard confirmPassword == password else {
            showErrorLabel(with: "Passwords don't match")
            return
        }
         

        self.createUser(email: email, password: password)
        

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

extension RegisterViewController {
    func showErrorLabel(with text: String) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in
            self?.errorLabel.text = text
                       self?.errorLabel.alpha = 1
                   }, completion: nil)
    }
    
    func sendEmailVerification(_ callback: ((Error?) -> ())? = nil){
        Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
            callback?(error)
        })
    }
    
    func createUser(email: String, password: String) {
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self](user, error) in
            
            
            guard user != nil, error == nil else {
                print(error?.localizedDescription)
                if (error?.localizedDescription)! == "The email address is already in use by another account." {
                    self?.showErrorLabel(with: "The email address is already exist")
                }
                return
            }
         
            let userRef = self?.ref.child((user?.user.uid)!)
            userRef?.setValue(["email": user?.user.email])
            
            
            self?.sendEmailVerification()
            
            self?.disableCreateButton()
            
            self?.performSegue(withIdentifier: "emailVerification", sender: nil)
        }
    }
    
    func disableCreateButton() {
        self.createAccountButton.alpha = 0.6
        self.createAccountButton.isUserInteractionEnabled = false
    }
    
    func enableCreateButton() {
        self.createAccountButton.alpha = 1
        self.createAccountButton.isUserInteractionEnabled = true
    }
}
