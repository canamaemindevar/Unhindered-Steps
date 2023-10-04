//
//  CoreDataManager.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 19.05.2023.
//

import CoreData
import Foundation
import UIKit

protocol CoreDataManagerInterface {
    func saveCoreData(withModel: UserModel)
    func deleteCoreData(with dataId: String)
    func getDataForFavs(completion: @escaping ((Result<[UserModel], Error>) -> Void))
    var logger: Loggable { get }
}

// swiftlint:disable all
final class CoreDataManager: CoreDataManagerInterface {
    static let shared = CoreDataManager()
    var logger: Loggable

    init(logger: Loggable = Logger()) {
        self.logger = logger
    }

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
                    self.logger.log("Saved")
                } catch {
                    self.logger.log("Saving Error")
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
                        logger.log("Delete?")
                        do {
                            try context.save()
                            logger.log("Deleted")
                        } catch {
                            logger.log("error deleting")
                        }
                    }
                }
            } catch {
                logger.log("error deleting")
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
                logger.log(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
}

// swiftlint:enable all
