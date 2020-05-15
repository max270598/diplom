//
//  VerifyNewEmailAlertViewController.swift
//  VseBankiRu
//
//  Created by Мах Ol on 5/11/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit
import MessageUI

import Firebase

enum AlertType {
    case changeEmail
    case changePassword
    case resetPassword
    case aboutApp
}

class AlertViewController: UIViewController {
     var credential: AuthCredential = EmailAuthProvider.credential(withEmail: UserDefaults.standard.string(forKey: "UserEmail") ?? "", password: UserDefaults.standard.string(forKey: "UserPassword") ?? "" )
        let currentUser = Auth.auth().currentUser
        let userRef: DatabaseReference = Database.database().reference(withPath: "users")
    
    var delegate: dissmissDelegate?
    
    @IBOutlet weak var aboutAppUnderstandButton: UIButton!
    @IBOutlet weak var aboutAppView: UIView!
    @IBOutlet weak var aboutAppTextView: UITextView!
    @IBAction func aboutAppVKButtonTapped(_ sender: Any) {
        let url = URL(string: "vk://vk.com/public195368419")
        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.openURL(url!)
        } else {
          //redirect to safari because the user doesn't have Instagram
             UIApplication.shared.openURL(NSURL(string: "https://vk.com/public195368419")! as URL)
        }
    }
    @IBAction func aboutAppInstButtonTapped(_ sender: Any) {
        let url = URL(string: "https://www.instagram.com/vsebankiru.official/")
        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.openURL(url!)
        } else {
          //redirect to safari because the user doesn't have Instagram
             UIApplication.shared.openURL(NSURL(string: "https://www.instagram.com/")! as URL)
        }
    }
    @IBAction func aboutAppMailButtonTapped(_ sender: Any) {
        let mailComposeViewController = configureMailComposer(recepients: ["vsebankiru@gmail.com"])
              if MFMailComposeViewController.canSendMail(){
                  self.present(mailComposeViewController, animated: true, completion: nil)
              }else{
                  print("Can't send email")
              }
    }
    
    @IBAction func aboutAppUnderstandButtonTapped(_ sender: Any) {
        self.cancelButtonAction()
    }
    
    
    @IBOutlet weak var developerView: UIView!
    @IBOutlet weak var devloperNameLabel: UILabel!
    @IBAction func developerVKButtonTapped(_ sender: Any) {
//        https://vk.com/m.olyushkin
        let url = URL(string: "vk://vk.com/m.olyushkin")
        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.openURL(url!)
        } else {
          //redirect to safari because the user doesn't have Instagram
             UIApplication.shared.openURL(NSURL(string: "https://vk.com/m.olyushkin")! as URL)
        }
        
    }
    @IBAction func developerInstButtonTapped(_ sender: Any) {
        let url = URL(string: "https://www.instagram.com/maximka2705/")
        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.openURL(url!)
        } else {
          //redirect to safari because the user doesn't have Instagram
             UIApplication.shared.openURL(NSURL(string: "https://www.instagram.com/")! as URL)
        }
    }
    @IBAction func developerMailButtonTapped(_ sender: Any) {
        let mailComposeViewController = configureMailComposer(recepients: ["8102892@gmail.com"])
                     if MFMailComposeViewController.canSendMail(){
                         self.present(mailComposeViewController, animated: true, completion: nil)
                     }else{
                         print("Can't send email")
                     }
    }
    
    
    
    
    
    
    
    
    
    
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
    
    
//    @IBOutlet weak var emailChangeCancelButton: UIButton!
    
    @IBOutlet weak var emailChangeAlertView: UIView!
    @IBOutlet weak var activityController: UIActivityIndicatorView!
    var emailToChange: String?
//    @IBAction func emailChangeCancelButtonTapped(_ sender: Any) {
//        print("Credentioal", self.credential, "\n\n\n\n\n\n")
//        Auth.auth().signIn(with: self.credential) { (result, error) in
//            guard error == nil else {print("Error", error?.localizedDescription); return}
//            self.currentUser?.reauthenticate(with: self.credential, completion: { [weak self] (result, error) in
//                    guard error == nil else { print("Error", error?.localizedDescription); return }
//                       print("RESULT", result, "\n\n\n\n\n\n\n")
//                       print("curentUser", self?.currentUser, "\n\n\n\n\n\n\n")
//                   self?.currentUser?.updateEmail(to: UserDefaults.standard.string(forKey: "UserEmail") ?? "") { (error) in
//                            guard error == nil else { print("Error", error?.localizedDescription) ; return }
//
//                       }
//                       })
//                   self.delegate?.reloadCell(at: 0)
//                   self.cancelButtonAction()
//        }
//
//    }
    
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
        let viewsArr: [UIView] = [self.emailChangeAlertView, self.passwordResetView, self.passwordChangeView, self.aboutAppView, self.developerView]
        
        butArr.forEach { (button) in
            button.clipsToBounds = true
            button.layer.cornerRadius = 6
        }
        
        viewsArr.forEach { (view) in
            view.addShadowCorner(cornerRadius: 10, offset: CGSize(width: 0, height: 0), color: .black, radius: 10, opacity: 0.6)
        }
        
        self.aboutAppUnderstandButton.clipsToBounds = true
        self.aboutAppUnderstandButton.cornerRadius = self.aboutAppUnderstandButton.frame.height / 2
        

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
            self.aboutAppView.isHidden = true
            self.developerView.isHidden = true
            self.aboutAppUnderstandButton.isHidden = true
            self.changeEmail()
        case .changePassword:
            self.passwordChangeView.isHidden = false
            self.emailChangeAlertView.isHidden = true
            self.passwordResetView.isHidden = true
            self.aboutAppView.isHidden = true
            self.developerView.isHidden = true
            self.aboutAppUnderstandButton.isHidden = true

            self.changePassword()
        case .resetPassword:
            self.passwordResetView.isHidden = false
            self.emailChangeAlertView.isHidden = true
            self.passwordChangeView.isHidden = true
            self.aboutAppView.isHidden = true
            self.developerView.isHidden = true
            self.aboutAppUnderstandButton.isHidden = true

            self.resetPassword()
            
        case .aboutApp:
            self.aboutAppUnderstandButton.isHidden = false
            self.aboutAppView.isHidden = false
            self.developerView.isHidden = false
            self.passwordResetView.isHidden = true
            self.emailChangeAlertView.isHidden = true
            self.passwordChangeView.isHidden = true
        default:
            print("")
        }
        self.changeErrorLabel.alpha = 0
              self.resetErrorLabel.alpha = 0
    }
    
    
    
    func changeEmail(){
        self.activityController.startAnimating()
        
        self.currentUser?.reauthenticate(with: self.credential, completion: { [weak self] (result, error) in
             guard error == nil else { print("Error", error?.localizedDescription); return }
            self?.currentUser?.updateEmail(to: self?.emailToChange ?? "") { (error) in
                     guard error == nil else { print("Error", error?.localizedDescription) ; return }

                     self?.currentUser?.sendEmailVerification(completion: { (error) in
                         guard error == nil else { print("ERROR", error?.localizedDescription); return }
                        
                                let timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] (timer) in
                                           
                                    self?.currentUser?.reload(completion: { (error) in
                                        guard error == nil else {print("Error", error?.localizedDescription); return}
                                        
                                        guard self?.currentUser != nil && (self?.currentUser!.isEmailVerified)! else {return}
                        //                    if self?.user != nil && (self?.user!.isEmailVerified)! {
                                                print("user verified")
                                        UserDefaults.standard.set(self?.emailToChange, forKey: "UserEmail")
                                        self?.userRef.child((self?.currentUser?.uid)!).child("email").setValue(self?.emailToChange)
                                                    self?.activityController.stopAnimating()
                                                    timer.invalidate()
                                                    do {
                                                                               try Auth.auth().signOut()
                                                                                } catch {
                                                                                    print(error.localizedDescription)
                                                                                }
                                                                            
                                        self?.view.window?.rootViewController?.dismiss(animated: true, completion: nil)

                        //                         } else {
                        //                            print("user isnt verified")
                        //
                        //                    }
                                                
                                        })
                                }

                        
                        
                        
                     })
             }
         })
        
    }
    
    
    
    
    func changePassword() {
        let oldPassword = UserDefaults.standard.string(forKey: "UserPassword")
        guard let oldPasswordText = self.changeOldPasswordTextField.text, oldPassword != "", let newPasswordText = self.changeNewPasswordTextField.text, newPasswordText != "", let confirmPasswordText = changeConfirmPasswordTextField.text, confirmPasswordText != "" else { showError(errorText: "Заполните все поля"); return }
        guard oldPassword == oldPasswordText else { self.showError(errorText: "Неверно указан старый пароль"); return }
        
        guard newPasswordText == confirmPasswordText else { showError(errorText: "Пароли не совпадают"); return}
        
                                //Смена пароля
                    currentUser?.reauthenticate(with: credential, completion: { [weak self] (result, error) in
                        guard  error == nil else { print(error?.localizedDescription); return }
                        
                        self?.currentUser?.updatePassword(to: newPasswordText, completion: {[weak self] (error) in
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
            
            self?.showSuccessAndDissmiss()
            
        }
        
    }
    
    func aboutApp() {
        
    }
    
    
    func cancelButtonAction() {
        self.delegate?.showTabBar()
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
        self.changeErrorLabel.textColor = .systemGreen
        self.changeErrorLabel.text = "Успешно"
        
        switch self.alertType {
        case .changeEmail:

            UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in
                self?.changeErrorLabel.alpha = 1
                }, completion: { _ in
                    do {
                                               try Auth.auth().signOut()
                                                } catch {
                                                    print(error.localizedDescription)
                                                }
                                                self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)

                        
            })
            
        case .changePassword:
            UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in
                         self?.changeErrorLabel.alpha = 1
                         }, completion: { _ in
                             do {
                                                        try Auth.auth().signOut()
                                                         } catch {
                                                             print(error.localizedDescription)
                                                         }
                            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)

                     })
        case .resetPassword:
            
            UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in
                self?.changeErrorLabel.alpha = 1
                }, completion: { _ in
                
                        self.dismiss(animated: true, completion: nil)
            })
            
        default:
            print("")
        }
    }
    
}


extension AlertViewController: MFMailComposeViewControllerDelegate {
    func configureMailComposer(recepients: [String]) -> MFMailComposeViewController{
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(recepients)
        mailComposeVC.setSubject("")
        mailComposeVC.setMessageBody("Добрый день! \n\n", isHTML: false)
        return mailComposeVC
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

