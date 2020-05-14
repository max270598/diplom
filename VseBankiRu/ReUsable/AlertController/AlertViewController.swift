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
    case resetPassword
}

class AlertViewController: UIViewController {

    let user = Auth.auth().currentUser

     let credential: AuthCredential = EmailAuthProvider.credential(withEmail: UserDefaults.standard.string(forKey: "UserEmail") ?? "", password: UserDefaults.standard.string(forKey: "UserPassword") ?? "" )
    
    @IBOutlet weak var passwordResetView: UIView!
    @IBOutlet weak var resetDoneButton: UIButton!
    @IBOutlet weak var resetCancelButton: UIButton!
    @IBOutlet weak var resetEmailTextField: UITextField!
    @IBOutlet weak var resetErrorLabel: UILabel!
    @IBAction func resetDoneButtonTapped(_ sender: Any) {
        self.resetPassword()
    }
    @IBAction func resetCancelButtonTapped(_ sender: Any) {
        self.cancelButtonAction()

    }
    
    
    @IBOutlet weak var emailChangeAlertView: UIView!
    @IBOutlet weak var activityController: UIActivityIndicatorView!
    
    
    @IBOutlet weak var passwordChangeView: UIView!
    @IBOutlet weak var changeOldPasswordTextField: UITextField!
    @IBOutlet weak var changeNewPasswordTextField: UITextField!
    @IBOutlet weak var changeConfirmPasswordTextField: UITextField!
    @IBOutlet weak var changeDoneButton: UIButton!
    @IBOutlet weak var changeCancelButton: UIButton!

    @IBOutlet weak var changeErrorLabel: UILabel!
    @IBAction func changeDoneButtonTapped(_ sender: Any) {
        self.changePassword()
    }
    @IBAction func changeCancelButtonTapped(_ sender: Any) {
        self.cancelButtonAction()
    }
    
    var alertType: AlertType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setupUILoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUIAppear()

    }
    

    

}

extension AlertViewController {
    
    func setupUILoad() {
        
        let butArr: [UIButton] = [self.resetCancelButton, self.changeCancelButton, self.resetDoneButton, self.changeDoneButton]
        
        butArr.forEach { (button) in
            button.clipsToBounds = true
            button.layer.cornerRadius = 6
        }
        
         self.emailChangeAlertView.addShadowCorner(cornerRadius: 10, offset: CGSize(width: 0, height: 0), color: .black, radius: 10, opacity: 0.6)
                self.passwordChangeView.addShadowCorner(cornerRadius: 10, offset: CGSize(width: 0, height: 0), color: .black, radius: 10, opacity: 0.6)
                self.passwordResetView.addShadowCorner(cornerRadius: 10, offset: CGSize(width: 0, height: 0), color: .black, radius: 10, opacity: 0.6)

                let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
                let blurEffectView = UIVisualEffectView(effect: blurEffect)
                blurEffectView.frame = view.bounds
                blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //        view.addSubview(blurEffectView)
                view.insertSubview(blurEffectView, at: 0)
    }
    
    func setupUIAppear() {
        
      
        
        switch self.alertType {
        case .changeEmail:
            self.emailChangeAlertView.isHidden = false
            self.passwordResetView.isHidden = true
            self.passwordChangeView.isHidden = true
            self.changeEmail()
        case .changePassword:
            self.passwordChangeView.isHidden = false
            self.emailChangeAlertView.isHidden = true
            self.passwordResetView.isHidden = true
            self.changePassword()
        case .resetPassword:
            self.passwordResetView.isHidden = false
            self.emailChangeAlertView.isHidden = true
            self.passwordChangeView.isHidden = true
            self.resetPassword()
        default:
            print("")
        }
        self.changeErrorLabel.alpha = 0
              self.resetErrorLabel.alpha = 0
    }
    
    
    
    func changeEmail(){
        self.activityController.startAnimating()
        
        let timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { [weak self] (timer) in
                   
            self?.user?.reload(completion: { (error) in
                if let error = error {
                    print(error.localizedDescription)
                 } else {
                    if self?.user != nil && (self?.user!.isEmailVerified)! {
                        print("user verified")
                            self?.activityController.stopAnimating()
                            timer.invalidate()
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
    
    
    
    
    func changePassword() {
        let oldPassword = UserDefaults.standard.string(forKey: "UserPassword")
        guard let oldPasswordText = self.changeOldPasswordTextField.text, oldPassword != "", let newPasswordText = self.changeNewPasswordTextField.text, newPasswordText != "", let confirmPasswordText = changeConfirmPasswordTextField.text, confirmPasswordText != "" else { showError(errorText: "Заполните все поля"); return }
        guard oldPassword == oldPasswordText else { self.showError(errorText: "Неверно указан старый пароль"); return }
        
        guard newPasswordText == confirmPasswordText else { showError(errorText: "Пароли не совпадают"); return}
        
                                //Смена пароля
                    user?.reauthenticate(with: credential, completion: { [weak self] (result, error) in
                        guard  error == nil else { print(error?.localizedDescription); return }
                        
                        self?.user?.updatePassword(to: newPasswordText, completion: {[weak self] (error) in
                            guard  error == nil else { print(error?.localizedDescription); return }
                            
                            self?.showSuccessAndDissmiss()
        //                    Auth.auth().sendPasswordReset(withEmail: self.user?.email ?? "") { (error) in
        //                        guard error == nil else { return }
        //
        //                                    print("SUccess")
        //                                    }
                                })
                                
                    })
        
    }
    
    func resetPassword() {
        guard let emailText = self.resetEmailTextField.text, emailText != "" else {self.showError(errorText: "Заполните все поля"); return}
        Auth.auth().sendPasswordReset(withEmail: emailText) {[weak self] (error) in
            guard error == nil else {print("ErrorRESET", error?.localizedDescription); self?.showError(errorText: "Такого пользователя не существует"); return }
            
            print("Отправлено")
        }
        
    }
    
    
    func cancelButtonAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func showError(errorText: String) {
        self.changeErrorLabel.textColor = .red

        switch self.alertType {
        case .changePassword:
             self.changeErrorLabel.text = errorText
                  UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in
                                 self?.changeErrorLabel.alpha = 1
                             }, completion: nil)
        case .resetPassword:
            self.resetErrorLabel.text = errorText
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in
                           self?.resetErrorLabel.alpha = 1
                       }, completion: nil)
        default:
            print("")
        }
      
    }
    
    func showSuccessAndDissmiss() {
        self.changeErrorLabel.textColor = .green
        self.changeErrorLabel.text = "Успешно"
        
        switch self.alertType {
        case .changeEmail:

            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in
                self?.changeErrorLabel.alpha = 1
                }, completion: { _ in
                    do {
                                               try Auth.auth().signOut()
                                                } catch {
                                                    print(error.localizedDescription)
                                                }
                    let storyB = UIStoryboard(name: "Main", bundle: nil)
                                            let vc = storyB.instantiateViewController(identifier: "AuthorisationViewController")
                                            vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                        
            })
            
        case .changePassword:
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in
                         self?.changeErrorLabel.alpha = 1
                         }, completion: { _ in
                             do {
                                                        try Auth.auth().signOut()
                                                         } catch {
                                                             print(error.localizedDescription)
                                                         }
                            let storyB = UIStoryboard(name: "Main", bundle: nil)
                                                    let vc = storyB.instantiateViewController(identifier: "AuthorisationViewController")
                                                    vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true, completion: nil)

                     })
        case .resetPassword:
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in
                self?.changeErrorLabel.alpha = 1
                }, completion: { _ in
                
                        self.dismiss(animated: true, completion: nil)
            })
            
        default:
            print("")
        }
    }
    
}
