//
//  BanksCatalogViewController.swift
//  VseBankiRu
//
//  Created by Мах Ol on 2/7/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit

class BanksCatalogViewController: UIViewController {

    struct BanksCatalogModelCell {
        var name: String
        var image: UIImage
        
        init(name: String, image: UIImage) {
            self.image = image
            self.name = name
        }    }
    var catalogArr: [BanksCatalogModelCell] = [
        BanksCatalogModelCell(name: "asdasd", image: UIImage(named: "Credits_backView")!),
        BanksCatalogModelCell(name: "asdasd", image: UIImage(named: "Credits_backView")!),
        BanksCatalogModelCell(name: "asdasd", image: UIImage(named: "Credits_backView")!),
        BanksCatalogModelCell(name: "asdasd", image: UIImage(named: "Credits_backView")!)



    ]
    
    @IBOutlet weak var banksCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        banksCollectionView.delegate = self
        banksCollectionView.dataSource = self
        self.banksCollectionView.register(UINib(nibName: "BanksCatalogCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BanksCatalogCollectionViewCell")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.banksCollectionView!.collectionViewLayout = self.getLayout()
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

extension BanksCatalogViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.catalogArr.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BanksCatalogCollectionViewCell", for: indexPath) as! BanksCatalogCollectionViewCell
        cell.backImageView.image = catalogArr[indexPath.row].image
        cell.nameLabel.text = catalogArr[indexPath.row].name

        cell.backImageView.layer.cornerRadius = 15
        cell.backImageView.clipsToBounds = true
        
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowRadius = 5
        cell.layer.shadowOpacity = 0.1
        
        return cell
    }
    
    
}

extension BanksCatalogViewController: UICollectionViewDelegateFlowLayout {
    
    
    
    func getLayout() -> UICollectionViewLayout
    {
        let layout:UICollectionViewFlowLayout =  UICollectionViewFlowLayout()

        layout.itemSize = CGSize(width: self.banksCollectionView.frame.width - 40, height: 88)
        layout.minimumLineSpacing = 50
//        layout.sectionInset = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)

        return layout as UICollectionViewLayout

    }
}
