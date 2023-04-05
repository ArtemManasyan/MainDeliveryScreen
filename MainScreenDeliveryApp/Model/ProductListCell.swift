//
//  ProductListCell.swift
//  MainScreenDeliveryApp
//
//  Created by Артем Манасян on 03.04.2023.
//

import UIKit
import Kingfisher

class ProductListCell: UICollectionViewCell {
    var models: [ProductLisCellModel]?
    let tableView: UITableView = {
        let table = UITableView()
        table.register(ProductTableViewCell.self, forCellReuseIdentifier: "product")
        table.backgroundColor = .white
        return table
    }()
    static var cellHeight: CGFloat = 720

    func setupCell(models: [ProductLisCellModel]) {
        self.models = models
        addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 10
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.pin.all()
    }
}

extension ProductListCell: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "product", for: indexPath) as! ProductTableViewCell
        guard let model = models?[indexPath.row] else { return UITableViewCell() }
        cell.setupCell(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        180
    }
}

struct ProductLisCellModel {
    let name: String
    let description: String
    let image: String
    let price: String
    
    init(model: Product) {
        name = model.name
        description = model.description
        image = model.image
        price = "от \(model.price)р"
    }
}


class ProductTableViewCell: UITableViewCell {
    let productImage = UIImageView()
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    let priceLabel = PriceLabelView()

    
    func setupCell(model: ProductLisCellModel) {
        addSubviews([productImage, nameLabel, descriptionLabel, priceLabel])
        productImage.kf.setImage(with: URL(string: model.image))
        productImage.frame = CGRect(x: 0, y: 0, width: 132, height: 132)
        productImage.clipsToBounds = true
        productImage.contentMode = .scaleAspectFit
        productImage.layer.cornerRadius = productImage.frame.height / 2
        nameLabel.text = model.name
        nameLabel.font = .boldSystemFont(ofSize: 15)
        descriptionLabel.text = model.description
        descriptionLabel.font = .systemFont(ofSize: 13)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = UIColor(hex: "#AAAAAD")
        priceLabel.priceLabel.text = model.price
        priceLabel.set()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        productImage.pin.vCenter().left(16)
        nameLabel.pin.after(of: productImage, aligned: .top).marginLeft(32).sizeToFit()
        descriptionLabel.pin.below(of: nameLabel, aligned: .left).marginTop(8).width(171).sizeToFit(.width)
        priceLabel.pin.right(24).bottom(16).width(90).height(33)
    }
}

class PriceLabelView: UIView {
    let priceLabel = UILabel()
    let paddingView = UIView()
    
    func set() {
        addSubviews([paddingView,priceLabel])
        paddingView.frame = CGRect(x: 0, y: 0, width: 87, height: 32)
        paddingView.layer.borderWidth = 1
        paddingView.layer.borderColor = UIColor(hex: "#FD3A69").cgColor
        paddingView.layer.cornerRadius = 6
        priceLabel.textColor = UIColor(hex: "#FD3A69")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        paddingView.pin.all()
        priceLabel.pin.hCenter().vCenter().sizeToFit()
    }
}

