//
//  ViewController.swift
//  MainScreenDeliveryApp
//
//  Created by Артем Манасян on 03.04.2023.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    let presenter = Presenter()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 24
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(BannersCell.self, forCellWithReuseIdentifier: "bannerCell")
        collectionView.register(CategoriesCell.self, forCellWithReuseIdentifier: "categoryCell")
        collectionView.register(ProductListCell.self, forCellWithReuseIdentifier: "productCell")
        return collectionView
    }()
    let cityLabel = UILabel()
    let listCitiesButton = UIButton()
    var cellTypes = [Presenter.CellTypes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9380843959, green: 0.9380843959, blue: 0.9380843959, alpha: 1)
        view.addSubviews([cityLabel, listCitiesButton, collectionView])
        listCitiesButton.setImage(UIImage(named: "arrowDown"), for: .normal)
        cityLabel.text = "Москва"
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        presenter.mainVC = self
        presenter.viewDidLoad()
        collectionView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cityLabel.pin.top(55).left(16).sizeToFit()
        listCitiesButton.pin.after(of: cityLabel, aligned: .center).marginLeft(10).sizeToFit()
        collectionView.pin.below(of: cityLabel).marginTop(25).horizontally().bottom()
    }
    
    func configCells(_ cellTypes: [Presenter.CellTypes]) {
        self.cellTypes = cellTypes
        collectionView.reloadData()
    }
    
    func makeCells(indexPath: IndexPath) -> UICollectionViewCell {
        switch cellTypes[indexPath.row] {
        case .banner(let model):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as! BannersCell;
            cell.setupCell(model: model)
            return cell
        case .categories(let model):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoriesCell;
            cell.setupCell(model: model)
            return cell
        case .product(let models):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductListCell;
            cell.setupCell(models: models)
            return cell
        }
    }
}

extension MainMenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cellTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        makeCells(indexPath: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.bounds.width ,
              height: cellTypes[indexPath.row].height(for: collectionView.bounds.width))
    }
}
