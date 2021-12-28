//
//  AllCurrencyView.swift
//  ExchangeRateApp
//
//  Created by Sveta on 10.12.2021.
//

import UIKit

protocol AllCurrencyViewDelegate: AnyObject {
    func allCurrencyViewNumberOfItems(_ allCurrencyView: AllCurrencyView) -> Int
    func allCurrencyView(_ allCurrencyView: AllCurrencyView, itemAtIndex index: Int) -> Valute?
}

final class AllCurrencyView: UIView {
    weak var delegate: AllCurrencyViewDelegate?
    
    private lazy var firstCollectionView: UICollectionView = {
        let flowLayout = AllCurrencyCVFlowLayout()

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout.createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.delaysContentTouches = false
        collectionView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        collectionView.register(AllCurrencyCollectionViewCell.self, forCellWithReuseIdentifier: AllCurrencyCollectionViewCell.identifier)
    
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(firstCollectionView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData() {
        self.firstCollectionView.reloadData()
    }
}

extension AllCurrencyView {
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .sidebarPlain)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
}

extension AllCurrencyView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.delegate?.allCurrencyViewNumberOfItems(self) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.firstCollectionView.dequeueReusableCell(withReuseIdentifier: AllCurrencyCollectionViewCell.identifier, for: indexPath) as! AllCurrencyCollectionViewCell
        let item = self.delegate?.allCurrencyView(self, itemAtIndex: indexPath.item)
        cell.update(item)
        return cell
    }
}
