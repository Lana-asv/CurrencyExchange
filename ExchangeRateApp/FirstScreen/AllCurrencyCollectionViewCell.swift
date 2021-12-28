//
//  AllCurrencyCollectionViewCell.swift
//  ExchangeRateApp
//
//  Created by Sveta on 10.12.2021.
//

import UIKit

final class AllCurrencyCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "AllCurrencyCell"
    
    private let currencyStack = UIStackView()
    private let currencyShortName = UILabel()
    private let currencyName = UILabel()
    private let rateStack = UIStackView()
    private let rateLabel = UILabel()
    private let rateChangesLabel = UILabel()
    private let flagLabel = UILabel()
    
    private enum Metrics {
        static let cellcornerRadius: CGFloat = 8.0
        static let currencyShortNameFontSize: CGFloat = 16.0
        static let currencyNameFontSize: CGFloat = 13.0
        static let currencyStackSpasing: CGFloat = 4.0
        static let rateLabelFontSize: CGFloat = 16.0
        static let rateChangesLabelFontSize: CGFloat = 13.0
        static let rateStackSpasing: CGFloat = 5.0
        static let flagLabelTopConstr: CGFloat = 25.0
        static let flagLabelWidthConstr: CGFloat = 40.0
        static let leadingConstr: CGFloat = 10
        static let trailingConstr: CGFloat = -10
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.currencyShortName.text = nil
        self.currencyName.text = nil
        self.rateLabel.text = nil
        self.rateChangesLabel.text = nil
        self.flagLabel.text = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(flagLabel)
        self.addSubview(currencyStack)
        self.addSubview(rateStack)
        
        self.allSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AllCurrencyCollectionViewCell {
    private func allSetup() {
        self.allAppearence()
        self.currencyStackAppearence()
        self.currencyStackSetupLayout()
        self.rateStackSetupLayout()
        self.rateStackAppearence()
        self.flagLabelSetupLayout()
    }
    
    private func allAppearence() {
        self.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.layer.cornerRadius = Metrics.cellcornerRadius
        self.contentView.clipsToBounds = true
    }
    
    private func currencyStackAppearence() {
        self.flagLabel.font = UIFont.systemFont(ofSize: 30)
        self.currencyShortName.textColor =  #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.currencyShortName.font = UIFont.systemFont(ofSize: Metrics.currencyShortNameFontSize, weight: .semibold)
        self.currencyName.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.currencyName.font = UIFont.systemFont(ofSize: Metrics.currencyNameFontSize, weight: .medium)
        
        self.currencyStack.axis = .vertical
        self.currencyStack.spacing = Metrics.currencyStackSpasing
        self.currencyStack.alignment = .leading
        
        self.currencyStack.addArrangedSubview(currencyShortName)
        self.currencyStack.addArrangedSubview(currencyName)
    }
    
    private func rateStackAppearence() {
        self.rateLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.rateLabel.font = UIFont.systemFont(ofSize: Metrics.rateLabelFontSize, weight: .semibold)
        self.rateChangesLabel.font = UIFont.systemFont(ofSize: Metrics.rateChangesLabelFontSize, weight: .medium)
        self.rateChangesLabel.textColor = .red
        
        self.rateStack.axis = .vertical
        self.rateStack.spacing = Metrics.rateStackSpasing
        self.rateStack.alignment = .trailing
        
        self.rateStack.addArrangedSubview(rateLabel)
        self.rateStack.addArrangedSubview(rateChangesLabel)
    }
        
    private func flagLabelSetupLayout() {
        self.flagLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.flagLabel.heightAnchor.constraint(equalToConstant: Metrics.flagLabelTopConstr),
            self.flagLabel.widthAnchor.constraint(equalToConstant: Metrics.flagLabelWidthConstr),
            self.flagLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.flagLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.leadingConstr),
        ])
    }
    
    private func currencyStackSetupLayout() {
        self.currencyStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.currencyStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.currencyStack.leadingAnchor.constraint(equalTo: self.flagLabel.trailingAnchor, constant: Metrics.leadingConstr),
        ])
    }
    
    private func rateStackSetupLayout() {
        self.rateStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.rateStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.rateStack.leadingAnchor.constraint(equalTo: self.currencyStack.trailingAnchor, constant: Metrics.leadingConstr),
            self.rateStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Metrics.trailingConstr),
            self.rateStack.widthAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    func update(_ item: Valute?) {
        guard let valute = item else { return }
        let formatter = NumberFormatter()

        formatter.numberStyle = .decimal
        
        self.currencyShortName.text = valute.charCode
        let countryCode = valute.charCode.prefix(2)
        
        self.flagLabel.text = self.countryFlag(countryCode: String(countryCode))
        
        if valute.nominal > 1 {
            self.currencyName.text = String(valute.nominal) + " " + valute.name
        } else {
            self.currencyName.text = valute.name
        }
        
        let rateValue = valute.value as NSNumber
        self.rateLabel.text = formatter.string(from: rateValue)
        let sum = (valute.previous - valute.value)
        self.rateChangesLabel.text = String(sum)
        if sum >= 0 {

            self.rateChangesLabel.textColor = .green
            self.rateChangesLabel.text = "▲" + formatter.string(from: NSNumber(value: sum))!
        } else {
            self.rateChangesLabel.text = "▼" + formatter.string(from: NSNumber(value: sum))!
            self.rateChangesLabel.textColor = .red
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
