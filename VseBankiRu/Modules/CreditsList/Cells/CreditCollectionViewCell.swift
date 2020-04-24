//
//  CreditCollectionViewCell.swift
//  VseBankiRu
//
//  Created by Мах Ol on 4/13/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit

class CreditCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bankLogoImageView: UIImageView!
    
    @IBOutlet weak var creditTypeLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton! {
                    didSet {
                        self.favouriteButton.setImage(UIImage(named: "icon_like_added"), for: .selected)
                        }
                    }
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var arrangeButton: UIButton! {
        didSet{
            self.arrangeButton.clipsToBounds = true
            self.arrangeButton.cornerRadius = 10
        }
    }
    
    // Item ID for Save in Favourite
    private var itemId: String?
    
    // Share Link
    private var itemLinkUrl: String?
    weak var delegate: CreditsListCellDelegate?
    private var deleteClosure: (()->Void)?
    
    
    private var shadowLayer: CAShapeLayer!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setShadow()
//        self.setCorner()
        // Initialization code
    }
   
    
    override var isHighlighted: Bool {
        didSet {
            self.transformCell(self.isHighlighted)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            self.transformCell(self.isSelected)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

            if shadowLayer == nil {
                shadowLayer = CAShapeLayer()
                shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 8).cgPath
                shadowLayer.fillColor = UIColor.white.cgColor

                shadowLayer.shadowColor = UIColor.darkGray.cgColor
                shadowLayer.shadowPath = shadowLayer.path
                shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
                shadowLayer.shadowOpacity = 0.8
                shadowLayer.shadowRadius = 2

                layer.insertSublayer(shadowLayer, at: 0)
                //layer.insertSublayer(shadowLayer, below: nil) // also works
            }
        }
    }

    


private extension CreditCollectionViewCell {

    @IBAction func favouriteButtonTapped(_ sender: UIButton) {
                if sender.isSelected { self.deleteClosure?() }
                guard let itemId = self.itemId else { return }
                sender.favourite(itemId)
       }

       @IBAction func shareButtonTapped(_ sender: UIButton) {
        guard let urlString = self.itemLinkUrl else { return }
        self.delegate?.shareLink(url: urlString, sender: sender)
       }

       @IBAction func arrangeButtonTapped(_ sender: Any) {

       }
}


extension UIButton {

    func inFavourite(_ itemId: String) {
        let inFavourite = CreditListFavouriteService.inFavorite(itemId)
        self.isSelected = inFavourite
    }

    func favourite(_ itemId: String) {
        self.isSelected.toggle()
        CreditListFavouriteService.inFavorite(itemId) ? CreditListFavouriteService.removeFavorite(itemId) : CreditListFavouriteService.addFavorite(itemId)
    }
}

extension CreditCollectionViewCell {

    override func prepareForReuse() {
          super.prepareForReuse()
          self.bankLogoImageView.kf.cancelDownloadTask()
          self.favouriteButton.isSelected = false
          self.creditTypeLabel.text = nil
          self.rateLabel.text = nil
          self.bankLogoImageView.image = nil
          self.bankLogoImageView.backgroundColor = .clear
          self.sumLabel.text = nil
          self.itemLinkUrl = nil
      }

    func addDelete(_ closure: (()->Void)?) {
        self.deleteClosure = closure
    }

    func configure(with model: CreditModel) {

        self.creditTypeLabel.text            = model.type
        self.rateLabel.text = model.min_rate
        self.sumLabel.text = model.short_sum
        self.itemId        = model.id
        self.favouriteButton.isSelected = model.inFavorite()
        self.itemLinkUrl                = model.credit_url

        if let photoUrl = URL(string: model.bank_logo_url) {
            self.bankLogoImageView.kf.indicatorType = .activity
            self.bankLogoImageView.kf.setImage(with: photoUrl)

        }
    }

//    func setCorner() {
//        self.cornerRadius = 8
//        self.borderWidth = 1
//        self.borderColor = UIColor.systemIndigo
//    }
}

