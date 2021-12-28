//
//  AllCurrencyCVFlowLayout.swift
//  ExchangeRateApp
//
//  Created by Sveta on 10.12.2021.
//

import UIKit

final class AllCurrencyCVFlowLayout: UICollectionViewFlowLayout {
    static let sectionHeaderElementKind = "section-header-element-kind"
        
        func createLayout() -> UICollectionViewLayout {

            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                 heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(50))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitem: item,
                                                           count: 1)
            let spacing = CGFloat(2)
            group.interItemSpacing = .fixed(spacing)

            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = spacing
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

            let layout = UICollectionViewCompositionalLayout(section: section)
            return layout
    }
}
