//
//  PersistenceManager.swift
//  ExchangeRateApp
//
//  Created by Sveta on 27.12.2021.
//

import Foundation
import CoreData

protocol IValuteStorage {
    func getValutesCount(filter: String?) -> Int
    func getValute(at index: Int, filter: String?) -> Valute?

    func updateValutes(_ valutes: [Valute])
}

final class PersistenceManager {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ExchangeRateApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension PersistenceManager: IValuteStorage {
    
    func getValutesCount(filter: String?) -> Int {
        let fetchRequest: NSFetchRequest<ValuteEntity> = ValuteEntity.fetchRequest()
        if let filterString = filter, !filterString.isEmpty {
            fetchRequest.predicate = NSPredicate(format: "\(#keyPath(ValuteEntity.name)) CONTAINS[cd] '\(filterString)'")
        }
        fetchRequest.includesSubentities = false
        guard let count = try? context.count(for: fetchRequest) else {
            return 0
        }
        
        return count
    }
    
    func getValute(at index: Int, filter: String?) -> Valute? {
        let fetchRequest: NSFetchRequest<ValuteEntity> = ValuteEntity.fetchRequest()
        if let filterString = filter, !filterString.isEmpty {
            fetchRequest.predicate = NSPredicate(format: "\(#keyPath(ValuteEntity.name)) CONTAINS[cd] '\(filterString)'")
        }
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        fetchRequest.fetchOffset = index
        fetchRequest.fetchLimit = 1

        guard let entity = try? context.fetch(fetchRequest).first else {
            return nil
        }

        return Valute(valuteEntity: entity)
    }

    func updateValutes(_ valutes: [Valute]) {
        for valute in valutes {
            updateValute(valute)
        }
    }

    private func updateValute(_ valute: Valute) {
        let fetchRequest = valuteFetchRequest(valute.id)
        if let valuteToUpdate = try? context.fetch(fetchRequest).first {
            valuteToUpdate.previous = valute.previous
            valuteToUpdate.value = valute.value
            try? context.save()
        } else {
            addValute(valute)
        }
    }
    
    private func valuteFetchRequest(_ identifier: String) -> NSFetchRequest<ValuteEntity> {
        let fetchRequest: NSFetchRequest<ValuteEntity> = ValuteEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "\(#keyPath(ValuteEntity.identifier)) = '\(identifier)'")
        return fetchRequest
    }
    
    private func addValute(_ valute: Valute) {
        let newValute = ValuteEntity(context: context)
        newValute.identifier = valute.id
        newValute.charCode = valute.charCode
        newValute.name = valute.name
        newValute.nominal = valute.nominal
        newValute.previous = valute.previous
        newValute.value = valute.value
        try? context.save()
    }

}
