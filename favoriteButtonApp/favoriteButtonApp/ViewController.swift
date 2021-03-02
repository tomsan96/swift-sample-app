//
//  ViewController.swift
//  favoriteButtonApp
//
//  Created by 山崎定知 on 2021/02/24.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UITableViewDataSource, UITextDragDelegate {

    var products: [Product] = []
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let productA = Product(name:"製品A", like:false)
        let productB = Product(name:"製品B", like:false)
        let productC = Product(name:"製品C", like:true)
        
        products = [productA, productB, productC]

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "product", for: indexPath)
        cell.textLabel!.text = products[indexPath.row].name
        
        let favoriteButton = UIButton()
        favoriteButton.setTitle("★", for: .normal)
        if(products[indexPath.row].like) {
            favoriteButton.setTitleColor(UIColor.yellow, for: .normal)
        } else {
            favoriteButton.setTitleColor(UIColor.gray, for: .normal)
        }

        bindFavoriteButtonToTap(button: favoriteButton, count: indexPath.row)
        
        cell.contentView.addSubview(favoriteButton)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.rightAnchor.constraint(equalTo: favoriteButton.rightAnchor, constant: 10).isActive = true
        
        return cell
    }
    
    private func bindFavoriteButtonToTap(button: UIButton, count: Int) {
        button.rx.tap.subscribe ({ [weak self] _ in
            if(self?.products[count].like ?? false) {
                button.setTitleColor(UIColor.gray, for: .normal)
                self?.products[count].like = false
            }else {
                button.setTitleColor(UIColor.yellow, for: .normal)
                self?.products[count].like = true
            }
        }).disposed(by: disposeBag)
    }

}

