//
//  PrivateOfficeViewController.swift
//  VseBankiRu
//
//  Created by Мах Ol on 5/9/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit
import Firebase
import MessageUI
import DropDown

class PrivateOfficeViewController: UIViewController {

    @IBOutlet weak var infoCollectionView: UICollectionView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var infoSegmentControl: UISegmentedControl!
    
    let settingsButton = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
    let dropDown = DropDown()
    
    
    let user = Auth.auth().currentUser
    let credential: AuthCredential = EmailAuthProvider.credential(withEmail: UserDefaults.standard.string(forKey: "UserEmail") ?? "", password: UserDefaults.standard.string(forKey: "UserPassword") ?? "" )

    override func viewDidLoad() {
        super.viewDidLoad()
        self.userNameLabel.text = UserDefaults.standard.string(forKey: "UserName") ?? "Пользователь"
        
        self.title = "Кабинет"
        self.setupCollectionView()

        self.setupNavigation()
        self.setupDropDown()
        
        
        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    @IBAction func infoSegmentControlChanged(_ sender: UISegmentedControl) {
    }
   
    

}

extension PrivateOfficeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let profileCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as! ProfileCollectionViewCell
        let infoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoCollectionViewCell", for: indexPath) as! InfoCollectionViewCell
        
        profileCell.delegate = self
        infoCell.delegate = self
        
        switch indexPath.row {
        case 0:
            let phone = UserDefaults.standard.string(forKey: "UserPhone")
            let email = UserDefaults.standard.string(forKey: "UserEmail")
            profileCell.configure(phoneNumber: phone ?? "", email: email ?? "")
            return profileCell
        default:
            return infoCell
        }
        
    }
    
    
}

extension PrivateOfficeViewController {
    func setupCollectionView() {
        self.infoCollectionView.register(UINib(nibName: "InfoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "InfoCollectionViewCell")
         self.infoCollectionView.register(UINib(nibName: "ProfileCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProfileCollectionViewCell")
        
        self.infoCollectionView.delegate = self
        self.infoCollectionView.dataSource = self
        
        self.infoCollectionView.isPagingEnabled = true
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: self.infoCollectionView.bounds.width, height: self.infoCollectionView.bounds.height)
        
        self.infoCollectionView.collectionViewLayout = layout
    }
    
    func setupDropDown() {
        self.dropDown.anchorView = self.navigationItem.rightBarButtonItem
        dropDown.direction = .bottom
        dropDown.width = 150
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.dataSource = ["Сменить пароль", "Выйти"]
        dropDown.textFont = UIFont(name: "SFProText-Light", size: 16)!
        dropDown.backgroundColor = .white
        
        
        dropDown.cancelAction = { [unowned self] in
            self.settingsButton.isSelected.toggle()
            self.rotateAction(nil)
        }

            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                self.dropDownCellTapped(index: index, item: item)
          print("Selected item: \(item) at index: \(index)")
        }
    }
    

    
    func setupNavigation() {
        self.settingsButton.backgroundColor = .clear
        self.settingsButton.setImage(UIImage(named: "icon_settings_colored"), for: .normal)
        self.settingsButton.addTarget(self, action: #selector(rotateAction(_:)), for: .touchUpInside)
        let item1: UIBarButtonItem = UIBarButtonItem(customView: self.settingsButton)
        
        self.navigationItem.setRightBarButton(item1, animated: true)
        
    }
    
    func dropDownCellTapped(index: Int, item: String) {
        
        switch index {
            case 0:
                        //Смена пароля
            user?.reauthenticate(with: credential, completion: { (result, error) in
                guard  error == nil else { print(error?.localizedDescription); return }
                
                self.user?.updatePassword(to: "321321", completion: { (error) in
                    guard  error == nil else { print(error?.localizedDescription); return }
                    print("USEREMAIL", self.user?.email)
                    Auth.auth().sendPasswordReset(withEmail: self.user?.email ?? "") { (error) in
                        guard error == nil else { return }
                                    
                                    print("SUccess")
                                    }
                        })
                        
            })
                        
                        
    
                        
                         
                    
            
            
            
            //Выход
                     default:
                         do {
                            try Auth.auth().signOut()
                             } catch {
                                 print(error.localizedDescription)
                             }
                         
                         let storyB = UIStoryboard(name: "Main", bundle: nil)
                         let vc = storyB.instantiateViewController(identifier: "AuthorisationViewController")
                         vc.modalPresentationStyle = .fullScreen
                         self.present(vc, animated: true, completion: nil)
                     }
    }
    
    
    @objc func rotateAction(_ sender: UIButton?) {
//
        print("Selected", self.settingsButton.isSelected)
        let transform: CGAffineTransform =  self.settingsButton.isSelected ? .identity : CGAffineTransform(rotationAngle: 179 * .pi / 180)
        
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseOut, animations: {
                self.navigationItem.rightBarButtonItem?.customView?.transform = transform
            }) { _ in
//                self.settingsButton.isSelected.toggle()
            }
        }
        
        self.dropDown.show()

       
    }
}

extension PrivateOfficeViewController: emailPhoneChanged {
    func changeEmail(email: String) {
        print("chengeEmail")
        guard email != UserDefaults.standard.string(forKey: "UserEmail") else {return}
        
        //Change Email
        user?.reauthenticate(with: credential, completion: { [weak self] (result, error) in
            if let error = error {
                print("Error", error.localizedDescription)
            } else {
                self?.user?.updateEmail(to: email) { (error) in
                    guard error != nil else {
                        print("Error", error?.localizedDescription)
                        return
                    }
                    
                }
            }
        })
//
        
        
        
    }
    
    func changePhone(phoneNumber: String) {
        UserDefaults.standard.set(phoneNumber, forKey: "UserPhone")
    }
    
    
}

extension PrivateOfficeViewController: aboutHelpDelegate {
    func showAboutApp() {
        let aboutVC = AboutAppViewController(nibName: "AboutAppViewController", bundle: nil)
        aboutVC.hidesBottomBarWhenPushed = true

        self.navigationController?.pushViewController(aboutVC, animated: true)
        
    }
    
    func showHelp() {
        let mailComposeViewController = configureMailComposer()
        if MFMailComposeViewController.canSendMail(){
            self.present(mailComposeViewController, animated: true, completion: nil)
        }else{
            print("Can't send email")
        }
    }
    
}

extension PrivateOfficeViewController: MFMailComposeViewControllerDelegate {
    func configureMailComposer() -> MFMailComposeViewController{
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(["vsebankiru@gmail.com"])
        mailComposeVC.setSubject("Тех. Поддержка")
        mailComposeVC.setMessageBody("Добрый день! \n\n", isHTML: false)
        return mailComposeVC
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
