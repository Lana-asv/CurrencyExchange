//
//  SecondScreenCollectionViewCell.swift
//  ExchangeRateApp
//
//  Created by Sveta on 10.12.2021.
//

import UIKit

protocol SecondScreenTableViewCellDelegate: AnyObject {
    func currencyItemCellShouldBeginEditing(_ cell: SecondScreenTableViewCell) -> Bool
    func currencyItemCell(_ cell: SecondScreenTableViewCell, didChange amount: Decimal)
}

final class SecondScreenTableViewCell: UITableViewCell {
    static let identifier = "SecondScreenCollectionViewCell"
    
    private let flagLabel = UILabel()
    private let currencyStack = UIStackView()
    private let currencyShortName = UILabel()
    private let currencyName = UILabel()
    private let currencyTextField = UITextField()
    
    weak var delegate: SecondScreenTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.contentView.addSubview(currencyStack)
        self.contentView.addSubview(currencyTextField)
        self.contentView.addSubview(flagLabel)
        
        self.currencyTextField.delegate = self
        self.currencyTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        
        self.allSetup()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.currencyName.text = nil
        self.currencyShortName.text = nil
        self.currencyTextField.text = nil
        self.flagLabel.text = nil
    }
    
    @objc private func editingChanged() {
        guard let text = currencyTextField.text, let value = Decimal(string: text) else {
            return
        }
        delegate?.currencyItemCell(self, didChange: value)
    }
}

extension SecondScreenTableViewCell: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return delegate?.currencyItemCellShouldBeginEditing(self) ?? false
    }
}

extension SecondScreenTableViewCell {
    private func allSetup() {
        self.allAppearence()
        self.currencyStackAppearence()
        self.currencyStackSetupLayout()
        self.textFieldSetup()
        self.textFieldSetupLayout()
        self.flagLabelAppearence()
        self.flagLabelSetupLayout()
    }
    
    private func allAppearence() {
        self.layer.cornerRadius = 8
    }
    
    private func textFieldSetup() {
        self.currencyTextField.keyboardType = UIKeyboardType.numberPad
        self.currencyTextField.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        self.currencyTextField.backgroundColor = .clear
        self.currencyTextField.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.currencyTextField.textAlignment = .right
        self.currencyTextField.layer.cornerRadius = 5        
    }
    
    private func currencyStackAppearence() {
        self.currencyShortName.textColor =  #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.currencyShortName.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        self.currencyName.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.currencyName.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        
        self.currencyStack.axis = .vertical
        self.currencyStack.spacing = 4
        self.currencyStack.alignment = .leading
        
        self.currencyStack.addArrangedSubview(currencyShortName)
        self.currencyStack.addArrangedSubview(currencyName)
    }
    
    private func flagLabelAppearence() {
        self.flagLabel.font = UIFont.systemFont(ofSize: 30)
    }
    
    private func flagLabelSetupLayout() {
        self.flagLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.flagLabel.heightAnchor.constraint(equalToConstant: 25),
            self.flagLabel.widthAnchor.constraint(equalToConstant: 40),
            self.flagLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.flagLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
        ])
    }
    
    private func currencyStackSetupLayout() {
        self.currencyStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.currencyStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.currencyStack.leadingAnchor.constraint(equalTo: self.flagLabel.trailingAnchor, constant: 10),
            self.currencyStack.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func textFieldSetupLayout() {
        self.currencyTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.currencyTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.currencyTextField.leadingAnchor.constraint(equalTo: self.currencyStack.trailingAnchor, constant: 10),
            self.currencyTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.currencyTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension SecondScreenTableViewCell {
    func update(_ valute: ConverterCellModel) {
        let formatter = NumberFormatter()

        formatter.numberStyle = .decimal
        
        self.currencyShortName.text = valute.currency.charCode
        self.currencyName.text = valute.currency.name
        
        let rateValue = valute.amount as NSNumber
        self.currencyTextField.text = formatter.string(from: rateValue)
        let countryCode = valute.currency.charCode.prefix(2)
        
        self.flagLabel.text = self.countryFlag(countryCode: String(countryCode))
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
