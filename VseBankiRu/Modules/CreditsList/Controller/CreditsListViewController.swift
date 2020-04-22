//
//  CreditsListViewController.swift
//  VseBankiRu
//
//  Created by Мах Ol on 3/30/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit
import Foundation
import InfiniteScrolling
import Kingfisher




class CreditsListViewController: UIViewController {
    
    
    
    @IBOutlet weak var bestLabel: UILabel!
    @IBOutlet weak var sliderView: UIView!
   
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var mainCollectionViewTopConstr: NSLayoutConstraint!
    
    
    
    
//    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var tableViewTopConstrToSliderView: NSLayoutConstraint!
//
    
    
    
    private var infiniteScrollingBehaviour: InfiniteScrollingBehaviour!
    
    var Credits = Array<CreditModel>()
    
    private var currentPage: Int = 0 {
          didSet {
              if self.currentPage >= 0 && self.currentPage <= self.bannersArray.count-1 {
                  self.pageControl.currentPage = self.currentPage
              }
          }
      }

    
    var defaultTopConstr: CGFloat = 0.0
    
    var bannersArray: [BannersSubModuleBanner] = [
        BannersSubModuleBanner(id: 1, title: "title", subTitle: "subTitle", image: "https://yandex.ru/images/search?from=tabbar&text=superMan&pos=9&img_url=https%3A%2F%2Fwww.tokkoro.com%2Fpicsup%2F5538061-action-comics-wallpapers.jpg&rpt=simage", backgroundImage: "https://i.playground.ru/p/iFOaIK9he88T1McR70KmJQ.jpeg", productId: 1),
        BannersSubModuleBanner(id: 2, title: "title", subTitle: "subtitle", image: "asd", backgroundImage: "https://kartinkinaden.ru/uploads/posts/2019-08/thumbs/1565934550_art-venom-72.jpg", productId: 2)
        ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupBestLabel()
        setupBannerCollection()
        setupMainCollection()
        setupPageControl()
        
        downloadCredits()
        
        
        self.addTableViewCorners()


        self.defaultTopConstr = mainCollectionViewTopConstr.constant
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        
        
    }
    
    


}

//Datasourse Delegate

extension CreditsListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.bannerCollectionView {
            return 2

        }
        return self.Credits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.bannerCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CreditsPromoCollectionViewCell", for: indexPath) as! CreditsPromoCollectionViewCell
        return cell
        } else {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CreditCollectionViewCell", for: indexPath) as! CreditCollectionViewCell
        guard !self.Credits.isEmpty else {
         
            return cell
        }
            cell.configure(with: Credits[indexPath.row])
            cell.delegate = self
        
        return cell
        }
    }
    
    
}


//extension CreditsListViewController:

//Infinite Scrolling

extension CreditsListViewController: InfiniteScrollingBehaviourDelegate {

    func configuredCell(forItemAtIndexPath indexPath: IndexPath, originalIndex: Int, andData data: InfiniteScollingData, forInfiniteScrollingBehaviour behaviour: InfiniteScrollingBehaviour) -> UICollectionViewCell {


        let cell = bannerCollectionView.dequeueReusableCell(withReuseIdentifier: "CreditsPromoCollectionViewCell", for: indexPath) as! CreditsPromoCollectionViewCell

        if let model = data as? BannersSubModuleBannerProtocol {
            cell.backImageView.kf.setImage(with: URL(string: model.backgroundImage))
        }

        return cell
    }
    
    func didEndScrolling(inInfiniteScrollingBehaviour behaviour: InfiniteScrollingBehaviour) {
        guard let currentPage = self.bannerCollectionView.visibleIndexPath?.row else { return }
        if (self.currentPage != (currentPage - 1)) { self.currentPage = (currentPage - 1) }
    }
    //Mark: FIX когда будут готовы другие слайды
    
//    func didSelectItem(atIndexPath indexPath: IndexPath, originalIndex: Int, andData data: InfiniteScollingData, inInfiniteScrollingBehaviour behaviour: InfiniteScrollingBehaviour) {
//        guard let bannerModel = self.banners[originalIndex] as? BannersSubModuleInputBannerProtocol else { return }
//        self.output?.show(banner: bannerModel)
//        //        self.newPresenter?.routeBannerScreen(with: bannerModel)
//        //        self.output?.showMarketplace()
//    }
}





extension CreditsListViewController: CreditsListCellDelegate {
    func shareLink(url urlString: String, sender: UIView) {
           var sourceView: UIView = self.mainCollectionView
           if UIDevice.current.userInterfaceIdiom == .pad {
               sourceView = sender
           }
           guard let activityController = self.shareLinkController(urlString: urlString, sourceView: sourceView) else { return }
        print("toucheddddd")
           self.present(activityController, animated: true, completion: nil)
       }
}

//Functions

 extension CreditsListViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //tableView
        
        if self.mainCollectionView.contentOffset.y <= -50 {
            self.showSlider()
        } else if self.mainCollectionView.contentOffset.y >= 50 {
            self.hideSlider()

        }

    }
    
    func hideSlider() {
          self.mainCollectionViewTopConstr.constant = (self.sliderView.frame.height) * -1
          UIView.animate(withDuration: 0.4) {

            self.mainCollectionView.layer.cornerRadius = 0.0
            self.mainCollectionView.transform = .identity

              self.view.layoutIfNeeded()
          }
      }
      
      func showSlider() {
        self.addTableViewCorners()
        
        
        UIView.animate(withDuration: 0.4) {
            self.mainCollectionView.transform = CGAffineTransform(translationX: 0, y: self.sliderView.frame.height + self.defaultTopConstr )

          }
      }
    
 
    
    func downloadCredits() {
        DispatchQueue.main.async {
            CreditsListNetwork.shared.getCredits { (credits) in
//                print("Кредиты", credits)
                
                self.Credits = credits
                print("download Ended")
                self.mainCollectionView.reloadData()
                print("reload")
            }
        }
        

    }
    
    
    
}

 private extension CreditsListViewController {
    
    func setupBestLabel() {
    //        self.bestLabel.borderWidth = 1
            self.bestLabel.borderColor = UIColor.black
            
            self.bestLabel.clipsToBounds = true
            self.bestLabel.layer.cornerRadius = 20
            self.bestLabel.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            
        }
        
        func setupBannerCollection() {
          
            self.bannerCollectionView.register(UINib(nibName: "CreditsPromoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CreditsPromoCollectionViewCell")
            
            self.bannerCollectionView.isPagingEnabled = true
            
            let configuration = CollectionViewConfiguration(layoutType: .numberOfCellOnScreen(1), scrollingDirection: .horizontal)
            infiniteScrollingBehaviour = InfiniteScrollingBehaviour(withCollectionView: bannerCollectionView, andData: bannersArray, delegate: self, configuration: configuration)
        }
        
        func setupMainCollection() {
            self.mainCollectionView.dataSource = self
            self.mainCollectionView.delegate = self
            self.mainCollectionView.register(UINib(nibName: "CreditCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CreditCollectionViewCell")
            
            
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: 355, height: 138)
            layout.minimumLineSpacing = 20
            layout.minimumInteritemSpacing = 20
            self.mainCollectionView.collectionViewLayout = layout
        }

        func setupPageControl() {
                    self.pageControl.numberOfPages = bannersArray.count
                    self.pageControl.isUserInteractionEnabled = false
                    self.pageControl.hidesForSinglePage = true
                    self.pageControl.currentPage = 0
        }
    func addTableViewCorners() {
         self.mainCollectionView.clipsToBounds = true
         self.mainCollectionView.layer.cornerRadius = 20
         self.mainCollectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
     }
    
    func setupNavigationBar() {
        let favouriteButton = UIButton(type: .custom)
        favouriteButton.setImage(UIImage(named: "favourite_icon_nav"), for: .normal)
        favouriteButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        favouriteButton.addTarget(self, action: #selector(self.favouriteButtonTapped), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: favouriteButton)

        let sortingButton = UIButton(type: .custom)
        sortingButton.setImage(UIImage(named: "sort_icon"), for: .normal)
        sortingButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        sortingButton.addTarget(self, action: #selector(self.sortingButtonTapped), for: .touchUpInside)
        let item2 = UIBarButtonItem(customView: sortingButton)

        self.navigationItem.setRightBarButtonItems([item1,item2], animated: true)
        
    }
    
    @objc func favouriteButtonTapped() {
        let secondVC = CreditListFavouriteViewController(nibName: "CreditListFavouriteViewController", bundle: nil)
        self.navigationController?.pushViewController(secondVC, animated: true)
        print("tapped")
    }
    
    @objc func sortingButtonTapped() {
           print("tapped")
       }
}
