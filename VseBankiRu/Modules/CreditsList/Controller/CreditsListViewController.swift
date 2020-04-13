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
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewTopConstrToSliderView: NSLayoutConstraint!
    
    
    
    
    private var infiniteScrollingBehaviour: InfiniteScrollingBehaviour!
    
    var Credits = Array<Credit>()
    
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
        print("load")
        setupCollection()
        setupPageControl()
        setupTableView()
        
        self.addTableViewCorners()


        self.defaultTopConstr = tableViewTopConstrToSliderView.constant
       
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        CreditsListNetwork.shared.getCredits { (credits) in
            print("Кредиты", credits)
        }
        
    }
    
    
    
    
//    func commonInit() {
//        Bundle(for: self.classForCoder).loadNibNamed("CreditsListViewController", owner: self, options: nil)
//
//        self.view.addSubview(contentView)
//        contentView.frame = self.view.bounds
//        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//    }
    
    


}

//Datasourse Delegate

extension CreditsListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CreditsPromoCollectionViewCell", for: indexPath) as! CreditsPromoCollectionViewCell
        return cell
    }
    
    
}

extension CreditsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CreditTableViewCell", for: indexPath) as! CreditTableViewCell
        return cell
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





//Functions

extension CreditsListViewController {
    func setupCollection() {
      
        self.bannerCollectionView.register(UINib(nibName: "CreditsPromoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CreditsPromoCollectionViewCell")
        
        self.bannerCollectionView.isPagingEnabled = true
        
        let configuration = CollectionViewConfiguration(layoutType: .numberOfCellOnScreen(1), scrollingDirection: .horizontal)
        infiniteScrollingBehaviour = InfiniteScrollingBehaviour(withCollectionView: bannerCollectionView, andData: bannersArray, delegate: self, configuration: configuration)
    }

    func setupPageControl() {
                self.pageControl.numberOfPages = bannersArray.count
                self.pageControl.isUserInteractionEnabled = false
                self.pageControl.hidesForSinglePage = true
                self.pageControl.currentPage = 0
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "CreditTableViewCell", bundle: nil), forCellReuseIdentifier: "CreditTableViewCell")
        tableView.separatorInset = UIEdgeInsets(top: 300, left: 100, bottom: 300, right: 100)
        self.tableView.rowHeight = 138
        self.tableView.backgroundColor = UIColor.clear
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //tableView
        if self.tableView.contentOffset.y <= -50 {
            self.showSlider()
        } else if self.tableView.contentOffset.y >= 50 {
            self.hideSlider()
        }

    }
    
    func hideSlider() {
          self.tableViewTopConstrToSliderView.constant = (self.sliderView.frame.height) * -1
          UIView.animate(withDuration: 0.4) {

            self.tableView.layer.cornerRadius = 0.0
            self.tableView.transform = .identity

              self.view.layoutIfNeeded()
          }
      }
      
      func showSlider() {
        self.addTableViewCorners()
        
        
        UIView.animate(withDuration: 0.4) {
            self.tableView.transform = CGAffineTransform(translationX: 0, y: self.sliderView.frame.height + self.defaultTopConstr )
//                self.view.layoutIfNeeded()
//            self.view.updateConstraints()
          }
//        self.tableViewTopConstrToSliderView.constant =  self.defaultTopConstr

      }
    
    func addTableViewCorners() {
        self.tableView.clipsToBounds = true
        self.tableView.layer.cornerRadius = 20
        self.tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
 
    
}
