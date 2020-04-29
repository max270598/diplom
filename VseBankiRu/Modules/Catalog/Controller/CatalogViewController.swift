//
//  BanksCatalogViewController.swift
//  VseBankiRu
//
//  Created by Мах Ol on 2/7/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit
import Firebase

class CatalogViewController: UIViewController {

    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var eurLabel: UILabel!
    @IBOutlet weak var funtLabel: UILabel!
    
    var catalogArr: [ServiceTypeModel] = [
        ServiceTypeModel(name: "Кредиты", image: UIImage(named: "Credits_backView")!),
        ServiceTypeModel(name: "Вклады", image: UIImage(named: "Credits_backView")!),
        ServiceTypeModel(name: "Карты", image: UIImage(named: "Credits_backView")!),
        ServiceTypeModel(name: "Ипотека", image: UIImage(named: "Credits_backView")!),
        ServiceTypeModel(name: "Страхование", image: UIImage(named: "Credits_backView")!),
    ]
    
    
    
    @IBOutlet weak var serviceTypeCollectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupCollectionView()
        self.downloadQuotation()
   
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.serviceTypeCollectionView!.collectionViewLayout = self.getLayout()
    }

 
     @IBAction func signOutButtonTapped(_ sender: Any) {
        do {
           try Auth.auth().signOut()
            } catch {
                print(error.localizedDescription)
            }
            dismiss(animated: true, completion: nil)
        }
     
     

}

extension CatalogViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.catalogArr.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceTypeCollectionViewCell", for: indexPath) as! ServiceTypeCollectionViewCell
        cell.nameLabel.text = catalogArr[indexPath.row].name

        cell.backgroundColor = UIColor.white
        cell.layer.cornerRadius = 10
//        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowRadius = 5
        cell.layer.shadowOpacity = 0.1
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let secondVC = CreditsListViewController(coder: <#NSCoder#>)
        let secondVC = CreditsListViewController(nibName: "CreditsListViewController", bundle: nil)
         let cell = collectionView.cellForItem(at: indexPath) as? ServiceTypeCollectionViewCell
        if cell?.nameLabel.text == "Кредиты" {
            print("кредиты")
        } else {
            print("Другое")
        }
        secondVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
  
    
    
}

extension CatalogViewController: UICollectionViewDelegateFlowLayout {
    
    
    
    func getLayout() -> UICollectionViewLayout
    {
        let layout:UICollectionViewFlowLayout =  UICollectionViewFlowLayout()

        layout.itemSize = CGSize(width: self.serviceTypeCollectionView.frame.width - 40, height: 88)
        layout.minimumLineSpacing = 50
//        layout.sectionInset = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)

        return layout as UICollectionViewLayout

    }
}

extension CatalogViewController {
    func downloadQuotation() {
        
        let service = QuotationNetworkService.shared
           service.getData(urlString: "https://quotes.instaforex.com/api/quotesTick?q=usdrur,eurrur") { result in
               DispatchQueue.main.async {
                   self.usdLabel.text = String(result[0].ask)
                   self.eurLabel.text = String(result[1].ask)
                   
               }
           }
    }
    
    
    func setupCollectionView () {
        serviceTypeCollectionView.delegate = self
        serviceTypeCollectionView.dataSource = self
        self.serviceTypeCollectionView.register(UINib(nibName: "ServiceTypeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ServiceTypeCollectionViewCell")
    }
}
