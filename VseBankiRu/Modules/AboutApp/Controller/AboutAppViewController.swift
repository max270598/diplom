//
//  AboutAppViewController.swift
//  VseBankiRu
//
//  Created by Мах Ol on 5/10/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit

class AboutAppViewController: UIViewController {

    @IBOutlet weak var aboutTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "О Приложении"
        self.aboutTextView.backgroundColor = .clear
        self.aboutTextView.sizeToFit()
        self.aboutTextView.font = UIFont(name: "SFProText-Medium", size: 17)
        self.aboutTextView.text = "ТЕКС О ПРИЛОЖЕНИИ sakdjlskajaflsdjnaflkjnsdlvjcndsflvnldsfnvlsdjfnlvdsnfljvndsjlfnvsjdfnvkjsdnfkjvnsdfkjnvksdjfnvkjsdfnvkjsdnfjvnsdkjfnvksdjfnvksdjnfvksdnfvksdnfkn"
        // Do any additional setup after loading the view.
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
