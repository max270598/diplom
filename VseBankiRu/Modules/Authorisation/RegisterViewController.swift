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

    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    @IBOutlet weak var createAccountButton: LoadingButton!
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
        self.createAccountButton.showLoading()
        
        guard let name = self.firstNameTextField.text, let phone = self.phoneTextField.text, let email = self.emailTextField.text, let password = passwordTextField.text, name != "", phone != "", email != "", password != "", let confirmPassword = confirmPasswordTextField.text, confirmPassword != "" else {
                showErrorLabel(with: "Заполните все поля")
            self.createAccountButton.hideLoading()
                return
            }
        
        guard password.count > 5 else {
            showErrorLabel(with: "Пароль должен содержать не менее 6 символов")
            self.createAccountButton.hideLoading()

            return
        }
        
        guard confirmPassword == password else {
            showErrorLabel(with: "Пароли не совпадают")
            self.createAccountButton.hideLoading()

            return
        }
         

        self.createUser(name: name, email: email, phone: phone, password: password)
        

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
    
    
    func createUser( name:String, email: String, phone: String,  password: String) {
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self](user, error) in
            
            
            guard user != nil, error == nil else {
                print(error?.localizedDescription)
                if (error?.localizedDescription)! == "The email address is already in use by another account." {
                    self?.showErrorLabel(with: "Пользователь с таким Email уже существует")
                }
                self?.createAccountButton.hideLoading()

                return
            }
         
            let changesReques = Auth.auth().currentUser?.createProfileChangeRequest()
            changesReques?.displayName = name
            changesReques?.commitChanges(completion: { [weak self] (error) in
                guard error == nil else {
                    print(error?.localizedDescription)
                    return
                }
                
                
                
                
                            let userRef = self?.ref.child((user?.user.uid)!)
                let id = user?.user.uid
                let userData = ["id": user?.user.uid,
                            "email": user?.user.email,
                            "phone": phone,
                            "name": user?.user.displayName]
                userRef?.setValue(userData)
//                            userRef?.setValue(["email": user?.user.email])
//                            userRef?.setValue(["name": user?.user.displayName])
//                            userRef?.setValue(["phone": phone])
                
                //            userRef?.setValue(["name": user?.user.displayName])
                            
                            UserDefaults.standard.set(user?.user.email, forKey: "UserEmail")
                            UserDefaults.standard.set(user?.user.displayName, forKey: "UserName")
                            UserDefaults.standard.set(phone, forKey: "UserPhone")
                            UserDefaults.standard.set(password, forKey: "UserPassword")

                                                    
                
                            self?.sendEmailVerification()
                            
                            self?.disableCreateButton()
                            
                            self?.performSegue(withIdentifier: "emailVerification", sender: nil)
            })
            

            
            
            
            
            
            
            
            
            

        }
    }
    
    func showErrorLabel(with text: String) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in
            self?.errorLabel.text = text
                       self?.errorLabel.alpha = 1
                   }, completion: nil)
    }
    
    func sendEmailVerification(_ callback: ((Error?) -> ())? = nil){
        Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
            callback?(error)
            print("ERROR", error?.localizedDescription)
        })
        print("ОТПРАВИЛИ")
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
