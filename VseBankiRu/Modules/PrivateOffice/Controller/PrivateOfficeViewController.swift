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

    @IBOutlet weak var changeUserNameButton: UIButton!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var infoCollectionView: UICollectionView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var infoSegmentControl: UISegmentedControl!
   
    //Setting
    let settingsButton = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
    let dropDown = DropDown()
    //Avatar
    var avatarsArray: [UIImage] = [UIImage(named: "avatar1")!, UIImage(named: "avatar2")!, UIImage(named: "avatar3")!, UIImage(named: "avatar4")!]
    var avatarIndex = 1
    //Auth
//    let credential: AuthCredential = EmailAuthProvider.credential(withEmail: UserDefaults.standard.string(forKey: "UserEmail") ?? "", password: UserDefaults.standard.string(forKey: "UserPassword") ?? "" )
//    let user = Auth.auth().currentUser
//    let userRef: DatabaseReference = Database.database().reference(withPath: "users")
    //Segment
    var segmentChangedByButton: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.setupUI()
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
        self.segmentChangedByButton = true
        self.infoCollectionView.scrollToItem(at: [0,sender.selectedSegmentIndex], at: .centeredHorizontally, animated: true)
    }
   
    @IBAction func changeUserNameButtonTapped(_ sender: Any) {
        
        if self.changeUserNameButton.isSelected == true {
               self.changeUserNameButton.isSelected = false
                self.userNameTextField.isEnabled = false
                self.userNameTextField.resignFirstResponder()
                
                guard let name = self.userNameTextField.text else {return}
                           self.changeUserName(name: name)
             }else {
                
                
               self.changeUserNameButton.isSelected = true
                self.userNameTextField.isEnabled = true
                self.userNameTextField.becomeFirstResponder()
             }
        
    }
    

}

extension PrivateOfficeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let profileCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as! ProfileCollectionViewCell
        let infoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoCollectionViewCell", for: indexPath) as! InfoCollectionViewCell
        print("indexPath", indexPath)
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

extension PrivateOfficeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.segmentChangedByButton == false {
        self.infoSegmentControl.selectedSegmentIndex = infoCollectionView.visibleIndexPath?.row ?? 0
        
        }
    }
    
   
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.segmentChangedByButton = false

    }
}

extension PrivateOfficeViewController {
    
    func setupUI() {
        self.avatarImage.image = self.avatarsArray[0]
        self.avatarImage.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(avatarToched))
        tapGesture.numberOfTouchesRequired = 1
        tapGesture.numberOfTapsRequired = 1
        self.avatarImage.addGestureRecognizer(tapGesture)
        
        self.userNameTextField.text = UserDefaults.standard.string(forKey: "UserName") ?? "Пользователь"
        self.userNameTextField.isEnabled = false
        self.changeUserNameButton.setImage(UIImage(named: "icon_checkMark"), for: .selected)
        self.changeUserNameButton.setImage(UIImage(named: "icon_edit"), for: .normal)
               self.title = "Кабинет"
               let titleTextAttributes1 = [NSAttributedString.Key.foregroundColor: UIColor.systemIndigo]
               self.infoSegmentControl.setTitleTextAttributes(titleTextAttributes1, for:.selected)
    }
    
    @objc func avatarToched() {
        print("TOUCH")
        self.avatarImage.image = self.avatarsArray[avatarIndex]
        self.avatarIndex += 1
        if self.avatarIndex == 4 { self.avatarIndex = 0 }
    }
    
    func setupCollectionView() {
        self.infoCollectionView.register(UINib(nibName: "InfoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "InfoCollectionViewCell")
         self.infoCollectionView.register(UINib(nibName: "ProfileCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProfileCollectionViewCell")
        
        self.infoCollectionView.delegate = self
        self.infoCollectionView.dataSource = self
        
        self.infoCollectionView.isPagingEnabled = true
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: self.infoCollectionView.bounds.width, height: self.infoCollectionView.bounds.height)
        self.infoCollectionView.showsVerticalScrollIndicator = false
        self.infoCollectionView.showsHorizontalScrollIndicator = false
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
                
                let alertVC = AlertViewController(nibName: "AlertViewController", bundle: nil)
                alertVC.alertType = .changePassword
                alertVC.delegate = self
                self.tabBarController?.tabBar.isHidden = true
                alertVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                alertVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.present(alertVC, animated: true, completion: nil)
                

                    
            
            //Выход
                     default:
                         do {
                            try Auth.auth().signOut()
                             } catch {
                                 print(error.localizedDescription)
                             }
                         
                                                     self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)

                     }
    }
    
    
    @objc func rotateAction(_ sender: UIButton?) {
//
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

extension PrivateOfficeViewController: reloadCellDelagate {
    func reloadCell(at index: Int) {
        self.infoCollectionView.reloadItems(at: [[0, index]])
    }
    
    
}


extension PrivateOfficeViewController: emailPhoneChangedDelegate {
    
    func changeUserName(name: String) {
        guard name != UserDefaults.standard.string(forKey: "UserName") else {return}
        UserDefaults.standard.set(name, forKey: "UserName")
        
        let changesReques = Auth.auth().currentUser?.createProfileChangeRequest()
                   changesReques?.displayName = name
                   changesReques?.commitChanges(completion: { [weak self] (error) in
                       guard error == nil else {
                           print(error?.localizedDescription)
                           return
                       }
        })
        
    let userRef: DatabaseReference = Database.database().reference(withPath: "users")
           userRef.child(Auth.auth().currentUser?.uid ?? "").child("name").setValue(name)
        //Change UserName
    }
    
    func changeEmail(email: String) {
        guard email != UserDefaults.standard.string(forKey: "UserEmail") else {return}
        
        //Change Email
        
            let alertVC = AlertViewController(nibName: "AlertViewController", bundle: nil)
        alertVC.emailToChange = email
        alertVC.alertType = .changeEmail
        alertVC.delegate = self
        self.tabBarController?.tabBar.isHidden = true
        alertVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        alertVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(alertVC, animated: true, completion: nil)
        
     
//
        
        
       
        
    }
    
    func changePhone(phoneNumber: String) {
        guard UserDefaults.standard.string(forKey: "UserPhone") != phoneNumber else {return}
        UserDefaults.standard.set(phoneNumber, forKey: "UserPhone")
        let userRef: DatabaseReference = Database.database().reference(withPath: "users")
        userRef.child(Auth.auth().currentUser?.uid ?? "").child("phone").setValue(phoneNumber)
    }
    
    
}

extension PrivateOfficeViewController: aboutHelpDelegate {
    func showAboutApp() {
        let alertVC = AlertViewController(nibName: "AlertViewController", bundle: nil)
        alertVC.alertType = .aboutApp
        alertVC.delegate = self
        self.tabBarController?.tabBar.isHidden = true
        alertVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        alertVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(alertVC, animated: true, completion: nil)
        
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
        mailComposeVC.setMessageBody("Добрый день! \n\n", isHTML: true)
        return mailComposeVC
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}


extension PrivateOfficeViewController: dissmissDelegate {
    func showTabBar() {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
}
