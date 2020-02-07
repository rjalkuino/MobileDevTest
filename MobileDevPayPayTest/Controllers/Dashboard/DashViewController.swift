//
//  DashViewController.swift
//  MobileDevPayPayTest
//
//  Created by QuantumCrowd on 2/7/20.
//  Copyright © 2020 Robert John Alkuino. All rights reserved.
//

import UIKit

class DashViewController: UIViewController {
    
    let viewModel = DashViewModel()
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(cell: DashCollectionViewCell.self)

        viewModel.getAllCurrentConvertion(completion: { [weak self ] isSuccess in
            guard let weakSelf = self else { return }
            DispatchQueue.main.async {
                weakSelf.collectionView.reloadData()
            }
        })
        
    }
    @IBAction func currencyChangerBtnPressed(_ sender: Any) {
        let controller = UnitListViewController.loadFromNib()
        controller.items = viewModel.currenciesList
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension DashViewController: UICollectionViewDelegate ,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.currenciesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:DashCollectionViewCell.reuseIdentifier , for: indexPath) as! DashCollectionViewCell
        let key = viewModel.currenciesList[indexPath.row]
        cell.currencyUnit.text = viewModel.getCurrencyUnit(unit: key)
        cell.currencyValue.text = viewModel.getConvertedValue(key: key)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
    }
}

extension DashViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellSize = (collectionView.frame.width-20)/3
       
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       return 10
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
       return 10
    }
}

extension DashViewController:UnitListViewControllerDelegate{
    func didSelectUnit(str: String) {
        viewModel.selectedUnit = str
    }
}
