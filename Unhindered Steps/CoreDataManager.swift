//
//  CoreDataManager.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 19.05.2023.
//

import CoreData
import Foundation
import UIKit

// swiftlint:disable all
class CoreDataManager {
    static let shared = CoreDataManager()
    func saveCoreData(withModel: UserModel) {
        DispatchQueue.main.async {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                let context = appDelegate.persistentContainer.viewContext
                let entityDescription = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
                entityDescription.setValue(withModel.id, forKey: "id")
                entityDescription.setValue(withModel.mail, forKey: "mail")
                entityDescription.setValue(withModel.username, forKey: "username")
                entityDescription.setValue(withModel.helperMail, forKey: "helperMail")
                entityDescription.setValue(withModel.helperName, forKey: "helperName")
                entityDescription.setValue(withModel.helperPhone, forKey: "helperPhone")
                do {
                    try context.save()
                    print("Saved")
                } catch {
                    print("Saving Error")
                }
            }
        }
    }

    func deleteCoreData(with dataId: String) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            fetchRequest.returnsObjectsAsFaults = false
            fetchRequest.predicate = NSPredicate(format: "id = %@", "\(dataId)")
            do {
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        context.delete(result)
                        print("Delete?")
                        do {
                            try context.save()
                            print("Deleted")
                        } catch {
                            print("error deleting")
                        }
                    }
                }
            } catch {
                print("error deleting")
            }
        }
    }

    func getDataForFavs(completion: @escaping ((Result<[UserModel], Error>) -> Void)) {
        var anArray = [UserModel]()
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            fetchRequest.returnsObjectsAsFaults = false
            do {
                let results = try context.fetch(fetchRequest)
                for result in results as! [NSManagedObject] {
                    anArray.append(UserModel(id: result.value(forKey: "id") as? String,
                                             username: result.value(forKey: "username") as? String,
                                             mail: result.value(forKey: "mail") as? String,
                                             helperName: result.value(forKey: "helperName") as? String,
                                             helperMail: result.value(forKey: "helperMail") as? String,
                                             helperPhone: result.value(forKey: "helperPhone") as? String))
                }
                completion(.success(anArray))
            } catch {
                // TODO: check:
            }
        }
    }
}

// swiftlint:enable all
