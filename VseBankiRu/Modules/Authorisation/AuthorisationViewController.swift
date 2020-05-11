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
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false

        
        Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in // если пользователь зарегистрирован то переходит на сразу на другой экран
            if user != nil && user!.isEmailVerified {
                self?.performSegue(withIdentifier: "logged", sender: nil)
            }
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.errorLabel.alpha = 0
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 100
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        IQKeyboardManager.shared.enable = false
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        guard let email = self.emailTextField.text, let password = passwordTextField.text, email != "", password != "" else {
            showErrorLabel(with: "Введены неверные данные пользователя")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self](user, error) in
            
           
            guard user != nil else {
                self?.showErrorLabel(with: "Не правильно набрал email или пароль")
                return
                
            }
            
            if error != nil {
                self?.showErrorLabel(with: "Ошибка")
                return
            }
            
            guard (user?.user.isEmailVerified)! else {
                self?.showErrorLabel(with: "Пользователь не верифицирован")
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
        self.errorLabel.text = text
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in
                       self?.errorLabel.alpha = 1
                   }, completion: nil)
    }
}
