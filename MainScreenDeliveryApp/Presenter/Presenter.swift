//
//  Presenter.swift
//  MainScreenDeliveryApp
//
//  Created by Артем Манасян on 03.04.2023.
//

import UIKit

protocol PresenterDelegate: AnyObject {
    func getProducts(product: ProductLisCellModel)
}

class Presenter {
    
    var selectedButtonType: CategoryCollectionViewCell.CategoryType = .pizza
    var delegate: PresenterDelegate?
    let service = Service()
    weak var mainVC: MainMenuViewController?
    
    func loadData() {
        
        let categoriesModel = CategoriesCellModel(
            buttonTypes: CategoryCollectionViewCell.CategoryType.allCases,
            selectedType: selectedButtonType
        )
        
        let bannersModel = BannerCellModel(bannerTypes: BannerCollectionViewCell.BannerType.allCases)
        
        service.getData(completion: { model in

            let productModel = model.product.map {
                ProductLisCellModel.init(model: $0)
            }
            
            let cellTypes: [CellTypes] = [ .banner(bannersModel),
                                           .categories(categoriesModel),
                                           .product(productModel)       ]
            self.mainVC?.configCells(cellTypes)
        })
    }
    
    func viewDidLoad() {
        loadData()
    }
    
    enum CellTypes {
        case banner(BannerCellModel)
        case categories(CategoriesCellModel)
        case product([ProductLisCellModel])
        
        func height(for width: CGFloat) -> CGFloat {
            switch self {
            case .banner:
                return BannersCell.cellHeight
            case .categories:
                return CategoriesCell.cellHeight
            case .product:
                return ProductListCell.cellHeight
            }
        }
    }
}
