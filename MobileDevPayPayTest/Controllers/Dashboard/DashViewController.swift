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
    @IBOutlet weak var unitSelectionButton: UIButton!
    @IBOutlet weak var valueTfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(cell: DashCollectionViewCell.self)
        
        viewModel.fetchCallback = { [weak self] in
            self?.viewModel.getAllCurrentConvertion(completion: { [weak self ] isSuccess in
                guard let weakSelf = self else { return }
                DispatchQueue.main.async {
                    weakSelf.collectionView.reloadData()
                }
            })
        }
        
        viewModel.fetch()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                         action: #selector(finishEditing)))
    }
    
    @objc private func finishEditing() {
        view.endEditing(true)
    }
    
    @IBAction func currencyChangerBtnPressed(_ sender: Any) {
        let controller = UnitListViewController.loadFromNib()
        controller.items = viewModel.currenciesList
        controller.delegate = self
        controller.selectedItem = viewModel.selectedUnit
        navigationController?.pushViewController(controller, animated: true)
    }
    @IBAction func convertButtonPressed(_ sender: Any) {
        if let text = valueTfield.text,let value = Double(text) {
            viewModel.amountValue = value
            collectionView.reloadData()
        }
    }
    
}

extension DashViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        guard let oldText = textField.text, let r = Range(range, in: oldText) else {
            return true
        }

        let newText = oldText.replacingCharacters(in: r, with: string)
        
        let numberOfDecimalDigits: Int
        if let dotIndex = newText.firstIndex(of: ".") {
            numberOfDecimalDigits = newText.distance(from: dotIndex, to: newText.endIndex) - 1
        } else {
            numberOfDecimalDigits = 0
        }

        return numberOfDecimalDigits <= 2
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text,let dValue = Double(text) {
            textField.resignFirstResponder()
            viewModel.amountValue = dValue
            return true
        }
        
        return false
    }
}

extension DashViewController: UICollectionViewDelegate ,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.currenciesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:DashCollectionViewCell.reuseIdentifier ,
                                                      for: indexPath) as! DashCollectionViewCell
        
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
        unitSelectionButton.setTitle(viewModel.getCurrencyUnit(unit: str), for: .normal)
    }
}
