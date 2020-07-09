//
//  AppDelegate.swift
//  Coin Portfolio
//
//  Created by Developer on 10/1/19.
//  Copyright © 2019 com.TDJDeveloper. All rights reserved.
//

import UIKit
import CoreData





@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var savedFlag = 0


    var window: UIWindow?
//    let managedObjectContext : Managed

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 0.707, green: 0.699, blue: 0.852, alpha: 1.00)
        UINavigationBar.appearance().tintColor = .black

        let myColor = UIColor(red: 0.707, green: 0.699, blue: 0.852, alpha: 1.00)
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        let context = appDelegate.persistentContainer.viewContext
        let issuerFetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Issuer")
        let coinFetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Coin")

        
        do {
            let issuers = try context.fetch(issuerFetchRequest) as! [Issuer]
            print(" ###   Upon startup, there are \(issuers.count) Issuers in CD")
            
            let coins = try context.fetch(coinFetchRequest) as! [Coin]
            print(" ####   Upon startup, there are \(coins.count) Coins in CD")

        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }


        
        
        if #available(iOS 13.0, *) {

            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = myColor
            appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]

            UINavigationBar.appearance().tintColor = .black
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().tintColor = .black
            UINavigationBar.appearance().barTintColor = myColor
            UINavigationBar.appearance().isTranslucent = false
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        self.saveContext()
        
        let issuerFetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Issuer")
        let coinFetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Coin")

        do {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

            let issuers = try context.fetch(issuerFetchRequest) as! [Issuer]
            let coins = try context.fetch(coinFetchRequest) as! [Coin]

            print("\\\\ Upon quit, there are \(issuers.count) Issuers in CD")
            print("\\\\ Upon quit, there are \(coins.count) Coins in CD")

        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

        
        
        
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Coin_Portfolio")
        let description = NSPersistentStoreDescription()

        description.shouldInferMappingModelAutomatically = true
        description.shouldMigrateStoreAutomatically = true
        container.persistentStoreDescriptions = [description]

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = self.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                savedFlag += 1
                
                let coinFetchRequest =
                    NSFetchRequest<NSManagedObject>(entityName: "Coin")

                let savedCoins = try context.fetch(coinFetchRequest) as! [Coin]
                
                print("In appDelegate, saveContext, after context.save, there are \(savedCoins.count) coins.")
                print("Successfully saved in appDelegate \(String(describing: savedFlag)) times")
                
                
                
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

