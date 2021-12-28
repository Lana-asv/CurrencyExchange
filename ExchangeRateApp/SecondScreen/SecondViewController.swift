//
//  SecondViewController.swift
//  ExchangeRateApp
//
//  Created by Sveta on 09.12.2021.
//

import UIKit

final class SecondViewController: UIViewController {
    
    private let presenter: SecondScreenPresenter
    
    init(presenter: SecondScreenPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.rowHeight = 75
        tableView.backgroundColor = .black
        tableView.layer.cornerRadius = 8
        tableView.register(SecondScreenTableViewCell.self, forCellReuseIdentifier: SecondScreenTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func loadView() {
        self.view = self.tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Конвертер"
        self.presenter.viewDidLoad(viewController: self)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addValute))
    }
}

extension SecondViewController {
    func reloadData() {
        self.tableView.reloadData()
    }
    
    func updateVisibleItems() {
        guard let indices = self.tableView.indexPathsForVisibleRows else { return }
        for indexPath in indices {
            if indexPath == IndexPath(item: 0, section: 0) {
                continue
            }

            let cell = tableView.cellForRow(at: indexPath) as! SecondScreenTableViewCell
            update(cell, at: indexPath)
        }
    }
    
    private func update(_ cell: SecondScreenTableViewCell, at indexPath: IndexPath) {
        let item = self.presenter.item(at: indexPath.row)
        cell.update(item)
    }

    @objc private func addValute() {
        self.presenter.addNewValute()
    }
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.presenter.itemsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SecondScreenTableViewCell.identifier, for: indexPath) as! SecondScreenTableViewCell
        cell.delegate = self
        cell.layer.borderWidth = 1
        cell.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.update(cell, at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.updateValute(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.row > 1  {
            return UITableViewCell.EditingStyle.delete
        } else {
            return .none
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.presenter.removeValute(at: indexPath.row)
    }
}

extension SecondViewController: SecondScreenTableViewCellDelegate {
    func currencyItemCellShouldBeginEditing(_ cell: SecondScreenTableViewCell) -> Bool {
        guard let indexPath = self.tableView.indexPath(for: cell),
              indexPath == IndexPath(row: 0, section: 0) else {
            return false
        }

        return true
    }

    func currencyItemCell(_ cell: SecondScreenTableViewCell, didChange amount: Decimal) {
        guard let indexPath = self.tableView.indexPath(for: cell),
              indexPath == IndexPath(row: 0, section: 0) else {
            return
        }
        
        self.presenter.updateAmount(amount)
    }
}

