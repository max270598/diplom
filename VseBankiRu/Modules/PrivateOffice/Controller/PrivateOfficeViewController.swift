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

class PrivateOfficeViewController: UIViewController {

    @IBOutlet weak var settingsBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var infoCollectionView: UICollectionView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var infoSegmentControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Кабинет"

        self.setupCollectionView()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewWillDisappear(_ animated: Bool) {
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
}

extension PrivateOfficeViewController: emailPhoneChanged {
    func changeEmail(email: String) {
        
    }
    
    func changePhone(phoneNumber: String) {
        
    }
    
    
}

extension PrivateOfficeViewController: aboutHelpDelegate {
    func showAboutApp() {
        
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
        mailComposeVC.setMessageBody("Добрый день! \n\n Мне нужна помощь по впросам:\n\n", isHTML: false)
        return mailComposeVC
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
