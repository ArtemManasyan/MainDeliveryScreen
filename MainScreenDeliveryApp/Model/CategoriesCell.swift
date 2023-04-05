//
//  CategoriesCell.swift
//  MainScreenDeliveryApp
//
//  Created by Артем Манасян on 03.04.2023.
//

import UIKit

class CategoriesCell: UICollectionViewCell {
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "category")
        collection.backgroundColor = .clear
        return collection
    }()
    var isOn: Bool = false
    static var cellHeight: CGFloat = 34
    private var model: CategoriesCellModel?
    private var buttons =  [CategoryCollectionViewCell]()
    
    func setupCell(model: CategoriesCellModel) {
        self.model = model
        addSubview(collectionView)
        buttons = model.buttonTypes.map {
            let button = CategoryCollectionViewCell()
            button.set(type: $0)
            return button
        }
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.pin.left(16).vertically().right()
    }
}

extension CategoriesCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model?.buttonTypes.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "category", for: indexPath) as! CategoryCollectionViewCell
        let button = buttons[indexPath.row]
        cell.set(type: button.type)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 90, height: 34)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = buttons[indexPath.row]
        cell.setHighLighted()
//        collectionView.reloadData()
    }
}

struct CategoriesCellModel {
    let buttonTypes: [CategoryCollectionViewCell.CategoryType]
    let selectedType: CategoryCollectionViewCell.CategoryType
}

class CategoryCollectionViewCell: UICollectionViewCell {
    let paddingView = UIView()
    let categoryNameButton = UILabel()
    var type: CategoryType!
    
    enum CategoryType: String, CaseIterable {
        case pizza
        case combo
        case deserts
        case drink
        var name: String {
            switch self {
            case .pizza:
                return "Пицца"
            case .combo:
                return "Комбо"
            case .deserts:
                return "Десерты"
            case .drink:
                return "Напитки"
            }
        }
    }
    
    func set(type: CategoryType) {
        self.type = type
        addSubview(paddingView)
        addSubview(categoryNameButton)
        paddingView.frame = CGRect(x: 0, y: 0, width: 88, height: 32)
        paddingView.layer.borderColor = UIColor(hex: "#FD3A6966").cgColor
        paddingView.layer.borderWidth = 1
        paddingView.layer.cornerRadius = 20
        categoryNameButton.textColor = UIColor(hex: "#FD3A6966")
        categoryNameButton.text = type.name
        categoryNameButton.font = .systemFont(ofSize: 11)
    }
    
    func setHighLighted() {
        paddingView.backgroundColor = UIColor(hex: "#FD3A6933")
        categoryNameButton.textColor = UIColor(hex: "#FD3A69")
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        paddingView.pin.all()
        categoryNameButton.pin.hCenter().vCenter().sizeToFit()
    }
}
