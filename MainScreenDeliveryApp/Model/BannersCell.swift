//
//  BannersCell.swift
//  MainScreenDeliveryApp
//
//  Created by Артем Манасян on 03.04.2023.
//

import UIKit

class BannersCell: UICollectionViewCell {
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: "banner")
        collection.backgroundColor = .clear
        return collection
    }()
    static var cellHeight: CGFloat = 113
    var model: BannerCellModel?
    var banners: [BannerCollectionViewCell]?
    
    func setupCell(model: BannerCellModel) {
        banners = model.bannerTypes.map {
            let banner = BannerCollectionViewCell()
            banner.set(type: $0)
            return banner
        }
        self.model = model
        addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.pin.all()
    }
}

extension BannersCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        banners?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "banner", for: indexPath) as! BannerCollectionViewCell
        guard let banner = banners?[indexPath.row] else { return UICollectionViewCell() }
        cell.set(type: banner.type)
        cell.setNeedsLayout()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 300, height: 112)
    }
}

struct BannerCellModel {
    let bannerTypes: [BannerCollectionViewCell.BannerType]
}


class BannerCollectionViewCell: UICollectionViewCell {
    
    let bannerImage = UIImageView()
    var type: BannerType!
    
    enum BannerType: String, CaseIterable {
        case banner1
        case banner2
        
        var image: UIImage {
            switch self {
            case .banner1:
                return UIImage(named: "banner3")!
            case .banner2:
                return UIImage(named: "banner2")!
            }
        }
    }
    
    func set(type: BannerType) {
        self.type = type
        addSubview(bannerImage)
        bannerImage.layer.cornerRadius = 10
        bannerImage.image = type.image
        bannerImage.contentMode = .scaleAspectFill
        bannerImage.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bannerImage.pin.left(16).vertically().right()
    }
}
