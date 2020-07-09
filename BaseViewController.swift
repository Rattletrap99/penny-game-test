//
//  BaseViewController.swift
//  Coin Portfolio
//
//  Created by Developer on 3/18/20.
//  Copyright © 2020 com.TDJDeveloper. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class BaseViewController : UIViewController, NSFetchedResultsControllerDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    var currentIssuer : Issuer?
    var currentColor : UIColor? = UIColor.white
    var now = Calendar.current.component(.year, from: Date())
    
    
    
    @objc func changeIssuer(issuerName : String) -> Issuer {
        
//        let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        let context = appDelegate.persistentContainer.viewContext

        
        let issuerSort = NSSortDescriptor(key: "name", ascending: false)
        let issuerFetchRequest = NSFetchRequest<Issuer>(entityName: "Issuer")
        issuerFetchRequest.sortDescriptors = [issuerSort]
        
        let mainIssuerFRC = NSFetchedResultsController(fetchRequest: issuerFetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try mainIssuerFRC.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
        
        if ((mainIssuerFRC.fetchedObjects!.count)) > 0 {
            
            if let fObjects = mainIssuerFRC.fetchedObjects{
                for issuerEntity in fObjects{
                    if issuerEntity.name == issuerName{
                        currentIssuer = issuerEntity
                    }
                    appDelegate.saveContext()
                }
//                currentColor = UIColor.retrieveFromData(data: (currentIssuer?.colorD!)!)
            }
        }
        return currentIssuer!
    }
}

