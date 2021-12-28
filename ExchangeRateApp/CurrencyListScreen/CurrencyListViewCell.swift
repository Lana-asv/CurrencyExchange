//
//  CurrencyListViewCell.swift
//  ExchangeRateApp
//
//  Created by Sveta on 21.12.2021.
//

import UIKit

protocol ICurrencyListViewCell {
    func updated(_ item: Valute?)
}

final class CurrencyListViewCell: UICollectionViewCell {

    static let identifier = "CurrencyListViewCell"
    
    private let currencyShortName = UILabel()
    private let currencyName = UILabel()
    private let flagLabel = UILabel()
    
    private enum Metrics {
        static let flagLabelFontSize: CGFloat = 30.0
        static let currencyShortNameFontSize: CGFloat = 16.0
        static let currencyNameFontSize: CGFloat = 14.0
        static let flagLabelHeight: CGFloat = 35.0
        static let flagLabelWidth: CGFloat = 40.0
        static let flagLabelLeading: CGFloat = 20.0
        static let currencyNameLeading: CGFloat = 20.0
        static let currencyShortNameLeading: CGFloat = 10.0
        static let currencyShortNameWidth: CGFloat = 80.0
        static let currencyShortNameTrailing: CGFloat = -10.0

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.currencyShortName.text = nil
        self.currencyName.text = nil
        self.flagLabel.text = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(flagLabel)
        self.addSubview(currencyName)
        self.addSubview(currencyShortName)
        
        self.allSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CurrencyListViewCell {
    private func allSetup() {
        self.allAppearence()
        self.currencyAppearence()
        self.flagLabelSetupLayout()
        self.currencyNameSetupLayout()
        self.currencyShortNameSetupLayout()
    }
    
    private func allAppearence() {
        self.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.contentView.clipsToBounds = true
    }
    
    private func currencyAppearence() {
        self.flagLabel.font = UIFont.systemFont(ofSize: Metrics.flagLabelFontSize)
        self.currencyShortName.textColor =  #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.currencyShortName.font = UIFont.systemFont(ofSize: Metrics.currencyShortNameFontSize, weight: .semibold)
        self.currencyShortName.textAlignment = .center
        self.currencyName.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.currencyName.font = UIFont.systemFont(ofSize: Metrics.currencyNameFontSize, weight: .medium)
        
        
    }
    private func flagLabelSetupLayout() {
        self.flagLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.flagLabel.heightAnchor.constraint(equalToConstant: Metrics.flagLabelHeight),
            self.flagLabel.widthAnchor.constraint(equalToConstant: Metrics.flagLabelWidth),
            self.flagLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.flagLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.flagLabelLeading),
        ])
    }
    
    private func currencyNameSetupLayout() {
        self.currencyName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.currencyName.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.currencyName.leadingAnchor.constraint(equalTo: self.flagLabel.trailingAnchor, constant: Metrics.currencyNameLeading),
        ])
    }
    
    private func currencyShortNameSetupLayout() {
        self.currencyShortName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.currencyShortName.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.currencyShortName.leadingAnchor.constraint(equalTo: self.currencyName.trailingAnchor, constant: Metrics.currencyShortNameLeading),
            self.currencyShortName.widthAnchor.constraint(equalToConstant: Metrics.currencyShortNameWidth),
            self.currencyShortName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Metrics.currencyShortNameTrailing)
        ])
    }
}
 
extension CurrencyListViewCell: ICurrencyListViewCell {
    func updated(_ item: Valute?) {
        guard let valute = item else { return }
        
        self.currencyShortName.text = valute.charCode
        let countryCode = valute.charCode.prefix(2)
        
        self.flagLabel.text = self.countryFlag(countryCode: String(countryCode))
        
        if valute.nominal > 1 {
            self.currencyName.text = String(valute.nominal) + " " + valute.name
        } else {
            self.currencyName.text = valute.name
        }
    }
    
    private func countryFlag(countryCode: String) -> String {
        let base = 127397
        var tempScalarView = String.UnicodeScalarView()
        for i in countryCode.utf16 {
          if let scalar = UnicodeScalar(base + Int(i)) {
            tempScalarView.append(scalar)
          }
        }
        return String(tempScalarView)
      }
}
