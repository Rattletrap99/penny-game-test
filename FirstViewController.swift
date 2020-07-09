//
//  ViewController.swift
//  Coin Portfolio
//
//  Created by Developer on 10/1/19.
//  Copyright © 2019 com.TDJDeveloper. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

class FirstViewController: BaseViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
//    var changeIssuerDelegate = ChangeIssuerProtocol.self
    var usIssuer = Issuer()
    var canadaIssuer = Issuer()
    var selectedIssuer = Issuer()

    
    let addBtnColor = UIColor(red: 0.995, green: 0.029, blue: 0.524, alpha: 1.00)
    let viewCollBtnColor = UIColor(red: 0.687, green: 0.954, blue: 0.000, alpha: 1.00)
    
    var flagArray : [UIImage] = [] //-> Will need attention
    
    var issuerFRC : NSFetchedResultsController<Issuer>?
    
    var sourceArray : [String] = []
    
    var thisCoin = Coin()
    var thisIssuer = Issuer()
    var fetchedData : [Coin] = []
    var index : Int = 0
    
    var leftPickerArray : [String] = []
    var rightPickerArray : [String] = []
    
    //    var pickerString = ""
    //    var issuerString = ""
    
    var permButtonTitle = "View collection of "
    var transText = ""
    var issuers: [Issuer] = []

    var coins: [Coin] = []
    var owners: [Issuer] = []

    
    
//    var issuerArray: [String] = ["US", "Canada"] //-> Will need attention
//
//    var denomArray: [String] = ["Select Criterion", "Need Upgrades", "Coins For Sale", "1/2 ¢", "1¢", "2¢", "3¢", "Half dime", "Nickel", "10¢", "20¢", "25¢", "50¢", "$1", "$2"]
    
    //-> Will need attention
    
    var i = Int(0)
    var n = Int(0)
    
    
    
    
    //    @IBOutlet weak var denomLabel: UILabel!
    
    
    @IBOutlet weak var newCoinLabel: UILabel!
    
    @IBOutlet weak var flagImageView: UIImageView!
    
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    @IBOutlet weak var newCoinAddedLabel: UILabel!
    
    
    @IBOutlet weak var pickerStack: UIStackView!
    
    
    @IBOutlet weak var leftPicker: UIPickerView!
    
    @IBOutlet weak var rightPicker: UIPickerView!
    
    
    @IBOutlet weak var addButton: CoolButtonLeftFront!
    
    @IBOutlet weak var viewCollectionButton: CustomButtonBlue!
    
    @IBOutlet weak var newCoinStackView: UIStackView!
    
    
    
    @IBOutlet weak var bottomStackView: UIStackView!
    
    //    @IBOutlet weak var lowerConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var obvImageView: UIImageView!
    @IBOutlet weak var revImageView: UIImageView!
    //    @IBOutlet weak var denomLabelView: UIView!
    
    
    
    
    @IBOutlet weak var issuerLabel: UILabel!
    
    
    
    
    //MARK: - Button Actions
    //MARK: -
    
    @IBAction func deleteIssuers(_ sender: Any) {
//        deleteAllIssuers()
    }
    
    
    
    @IBAction func specsButton(_ sender: Any) {
        performSegue(withIdentifier: "newIssuerSpecSegue", sender:(Any).self)
    }
    
    
    @IBAction func aboutButtonAction(_ sender: Any) {
        //        AudioServicesPlayAlertSound(SystemSoundID(1306))
        
        performSegue(withIdentifier: "privacySegue", sender: (Any).self)
        
    }
    
    
    
    
    
    
    
    
    func deleteAllIssuers() {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Issuer>(entityName: "Issuer")
        if let result = try? context.fetch(fetchRequest) {
            for object in result {
                context.delete(object)
            }
        }
        appDelegate.saveContext()
    }
    
    @IBAction func fixEverythingButton(_ sender: Any) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Coin>(entityName: "Coin")
        if let result = try? context.fetch(fetchRequest) {
            for object in result {
                
                if (object.grade) == nil{
                    object.grade = ""
                }
                if (object.mintMark) == nil{
                    object.mintMark = ""
                }
                if (object.denomination) == nil{
                    object.denomination = ""
                }
                if (object.itemIdentifier) == nil{
                    object.itemIdentifier = ""
                }
                appDelegate.saveContext()
            }
        }
    }
    
    @IBAction func shoppingListBtnAction(_ sender: Any) {
        
        AudioServicesPlayAlertSound(SystemSoundID(1306))
        performSegue(withIdentifier: "shoppingListSegue", sender: sender)
        
    }
    
    @IBAction func addCoinButtonAction(_ sender: UIButton) {
        
        let context = appDelegate.persistentContainer.viewContext
        
        let newCoin = NSEntityDescription.insertNewObject(forEntityName: "Coin", into: context) as! Coin
        
        // Init attributes
        
        newCoin.denomination = "1¢"
        newCoin.grade = "EF"
        newCoin.itemIdentifier = ""
        newCoin.mintMark = "P"
        newCoin.owner = assignToOwner(ownerName: "US", thisCoin: newCoin)
        
        appDelegate.saveContext()
        
        let fetchRequest = NSFetchRequest<Coin>(entityName: "Coin")
        if let result = try? context.fetch(fetchRequest) {
            _ = result.count
//            print("After newCoin Created and saved, there are \(result.count) coins in Core Data")
            issuerLabel.text = String(result.count)
        }
    }

    func assignToOwner(ownerName : String, thisCoin : Coin) -> Issuer{
            
            print("This coin's owner.name should be is \(ownerName)")
    //        print("DoneButtonText == \(doneButtonText)")

            let context = appDelegate.persistentContainer.viewContext
            let ownerfetchRequest = NSFetchRequest<Issuer>(entityName: "Issuer")
            
            if let owners = try? context.fetch(ownerfetchRequest) {
                for owner in owners{
                    if owner.name == ownerName{
                        print("Owner.name == \(String(describing: owner.name))")

                        owner.addToCoins(thisCoin)
                        thisCoin.owner = owner
                        thisIssuer = owner
                        print("NewCoin VC, assign to owner, there are \(String(describing: thisCoin.owner!.coins?.count)) in this issuer")
                        changeIssuer(issuerName : owner.name!)
                        print("This coin's owner is \(String(describing: thisCoin.owner!.name))")
                        saveIt()
                    }
                }
            }
            return thisIssuer
        }
    
    
    func displayFetchResult(){
        
    }
    
    
    
    
    
    
    
    @IBAction func viewCollection(_ sender: UIButton) {
        AudioServicesPlayAlertSound(SystemSoundID(1306))
        
        self.performSegue(withIdentifier: "collectionSegue", sender: sender)
    }
    
    
    //MARK: - Prepare for Segue
    //MARK: -
    
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.identifier == "collectionSegue" {
//            let destVC = segue.destination as! SeriesViewController
//
//            destVC.currentIssuer = currentIssuer
//            if (transText.count) >= 1 {
//                destVC.fetchDenomCriteria = transText
//            }else{
//                // Pop alert
//                print ("Nothing to send!")
//            }
//
//        }else if segue.identifier == "addButtonSegue"{
//
//            let destVC = segue.destination as! SecondNavController
//            let newCoinVC = destVC.topViewController as! NewCoinViewController
////            addCoin.currentIssuer = self.currentIssuer
//
//        }else if segue.identifier == "newIssuerSpecSegue"{
//            let destVC = segue.destination as! NewIssuerSpecViewController
//        }
//    }
    
    
    //MARK: - ViewDidLoad, etc
    //MARK: -
    

    override func viewDidLoad() { //-> Will need attention
        super.viewDidLoad()
        
                self.leftPicker?.delegate = self
                self.leftPicker?.dataSource = self
                
                self.rightPicker?.delegate = self
                self.rightPicker?.dataSource = self

                
                checkAndCreateIssuers()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        title = "Test"
        
        //        leftPicker.selectRow(0, inComponent: 0, animated: true)
        //        myPickerView.selectRow(0, inComponent: 1, animated: true)
        leftPicker.isUserInteractionEnabled = true
//        rightPicker.isUserInteractionEnabled = false
        
        addButton.titleLabel!.numberOfLines = 2 // Dynamic number of lines
        addButton.titleLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping
        addButton.titleLabel!.textAlignment = .center
        
        let spacing: CGFloat = 8.0
        addButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        
//        viewCollectionButton.setTitle ("Select Criterion", for: .normal)
//        viewCollectionButton.isUserInteractionEnabled = false
//
//        viewCollectionButton.titleLabel!.numberOfLines = 2 // Dynamic number of lines
//        viewCollectionButton.titleLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping
//        viewCollectionButton.titleLabel!.textAlignment = .center
        
//        let viewButtonSpacing: CGFloat = 8.0
//        viewCollectionButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: viewButtonSpacing, bottom: 0, right: viewButtonSpacing)
        
//        for case let picker as UIPickerView in pickerStack.arrangedSubviews {
//            picker.layer.borderWidth = 2.0
//            picker.layer.borderColor = UIColor.white.cgColor
//            picker.layer.cornerRadius = 12.0
//        }
        
//        checkAndCreateIssuers()
//        syncIssuersAcrossVersions()
        
        let context = appDelegate.persistentContainer.viewContext
        let coinFetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Coin")

        
        do {
            
            let coins = try context.fetch(coinFetchRequest) as! [Coin]
            
            issuerLabel.text = String(coins.count)
            print(" ####***   FirstVC, there are \(coins.count) Coins in CD")

        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

        
//        normalizeIssuersAndCoins()
    }
    
    
    
    func normalizeIssuersAndCoins(){
        
        // Are there any issuers present?
        // No -- create Issuers (US and Canada)
        
        checkAndCreateIssuers()
        
        // Yes ->
        
        // Are there any coins present?
        
        // Yes -- match .issuedBy with .owner
        
        syncIssuersAcrossVersions()
        
        // No -- Create coins (popCoinAlert)
        
        
        
        
    }
    
    
    
    
    
    func syncIssuersAcrossVersions() { // Should fix issuer problem with existing US, Canada coins in database
        
        let context = appDelegate.persistentContainer.viewContext
        let coinFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Coin")
        let ownerFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Issuer")
        
        do {
            coins = try context.fetch(coinFetchRequest) as! [Coin]
            if coins.count == 0{
                print("1st VC, syncIssuers, there are now \(coins.count) coins")
                //                noCoinAlert()
            }else{
                owners = try context.fetch(ownerFetchRequest) as! [Issuer]
                for coin in coins {
                    if coin.issuedBy == "US" || coin.issuedBy == "Canada" {
                        do {
                            if coin.owner == nil{
                                for owner in owners{
                                    if owner.name == "US" && coin.issuedBy == "US"{
                                        coin.owner = owner
                                        owner.addToCoins(coin)
                                        print("US owner created")
                                        
                                    }else if owner.name == "Canada" && coin.issuedBy == "Canada"{
                                        coin.owner = owner
                                        owner.addToCoins(coin)
                                        print("Canada owner created")
                                        
                                    }else{
                                        print("No changes in ownership")
                                    }
                                }
                                saveIt()
                            }else{
                                
                            }
                        }
                    }
                }
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        saveIt()
    }
    
    //MARK: - Check And Create Issuers
    //MARK: -

    
    func checkAndCreateIssuers(){
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Issuer")
        
        do {
            issuers = try context.fetch(fetchRequest) as! [Issuer]
            print(" *   Now there are \(issuers.count) Issuers in CD")


            
            if issuers.count == 0 {
                
                //MARK: - Create US issuer
                //MARK: -
                
                usIssuer = NSEntityDescription.insertNewObject(forEntityName: "Issuer", into: context) as! Issuer
                
                // Init String attributes
                
                usIssuer.name = "US"
                usIssuer.denominationArray = ["Need Upgrades", "Coins For Sale", "1/2 ¢", "1¢", "2¢", "3¢", "Half dime", "Nickel", "10¢", "20¢", "25¢", "50¢", "$1", "$2"]
                usIssuer.mintMarkArray = ["P","D","S","S-VDB","P-VDB","O","CC","W"]
                usIssuer.firstYear = 1693
                usIssuer.lastYear = Int32(now)
//                usIssuer.colorD = UIColor(red: 0.988, green: 0.620, blue: 0.020, alpha: 1.00).encodeToData()
//                saveIt()
                do {
                    saveIt()
                    issuers = try context.fetch(fetchRequest) as! [Issuer]
                    print(" **   Now there are \(issuers.count) Issuers in CD")
                    leftPickerArray.append(usIssuer.name!)
                } catch {
                    // Error occured while deleting objects
                }
                
                //MARK: - Create Canada issuer
                //MARK: -

                
                canadaIssuer = NSEntityDescription.insertNewObject(forEntityName: "Issuer", into: context) as! Issuer
                
                // Init String attributes
                
                canadaIssuer.name = "Canada"
                canadaIssuer.denominationArray = ["Need Upgrades", "Coins For Sale", "1/2 ¢", "1¢", "2¢", "3¢", "Half dime", "Nickel", "10¢", "20¢", "25¢", "50¢", "$1", "$2"]
                canadaIssuer.mintMarkArray = ["P","D","S","S-VDB","P-VDB","O","CC","W"]
                canadaIssuer.firstYear = 1700
                canadaIssuer.lastYear = Int32(now)
//                canadaIssuer.colorD = UIColor.green.encodeToData()
//                saveIt()
                do {
                    saveIt()
                    issuers = try context.fetch(fetchRequest) as! [Issuer]
                    print(" ***   Now there are \(issuers.count) Issuers in CD")
                    leftPickerArray.append(canadaIssuer.name!)
                } catch {
                    // Error occured while deleting objects
                }
//
                let issuerSort = NSSortDescriptor(key: "name", ascending: false)
                let issuerFetchRequest = NSFetchRequest<Issuer>(entityName: "Issuer")
                issuerFetchRequest.sortDescriptors = [issuerSort]

                issuerFRC = NSFetchedResultsController(fetchRequest: issuerFetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
                do {
                    try issuerFRC?.performFetch()
                } catch {
                    fatalError("Failed to initialize FetchedResultsController: \(error)")
                }

//                if let issuers = issuerFRC?.fetchedObjects{
//                    if issuers.count >= 1{
//                        print("There are now \(issuers.count) issuers") // Now there should be 0
//
//                        for object in issuers {
//                            leftPickerArray.append(object.name!)
//                            print("There are now \(leftPickerArray.count) items in leftPickerArray")
//                        }
////                        currentIssuer = issuers [0]
////                        print("Current issuer is named \(String(describing: currentIssuer?.name))") // Now there should be 2
//
//                    }else{
//                        print("In else, there are now \(issuers.count) issuers") // Now there should be 2
//
//                        popAlert()
//                    }
//                }
            }else{
                print("*************** There are now \(issuers.count) issuers") // Now there should be 2
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func noCoinAlert(){
        
        let alert = UIAlertController(title: "No coins to display", message: "Please begin by entering coins", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {(alert: UIAlertAction!) in self.performSegue(withIdentifier: "addButtonSegue", sender: self)}))
        
        self.present(alert, animated: true)
    }
    
    
    func reloadImageViews(coin: Coin) {
        thisCoin = coin
        loadImageViews()
    }
    
    
    func loadImageViews(){
        
        if let imageData = thisCoin.obversePicMedium{
            
            let image = UIImage(data: imageData as Data)
            obvImageView?.image = image
        }
        if let imageData = thisCoin.reversePicMedium{
            
            let image = UIImage(data: imageData as Data)
            revImageView?.image = image
        }
        
        obvImageView?.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.obvImageView?.alpha = 1
            
        }
        revImageView?.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.revImageView?.alpha = 1
        }
    }
    
    
    //    override func didReceiveMemoryWarning() {
    //        super.didReceiveMemoryWarning()
    //        // Dispose of any resources that can be recreated.
    //    }
    
    
    
    
    //    @IBAction func indexChanged(_ sender: Any) { //-> Will need attention
    //        AudioServicesPlayAlertSound(SystemSoundID(1306))
    //
    //        myPickerView.selectRow(0, inComponent: 0, animated: true)
    //
    //
    //        pickerString = denomArray[myPickerView.selectedRow(inComponent: 0)]
    //
    //        flagArray = [UIImage(named: "US-flag")!, UIImage(named: "Canada-flag")!]
    //
    //        let usCollectionString = ("US " + "\(pickerString)")
    //        let canadaCollectionString = ("Canadian " + "\(pickerString)")
    //
    //
    //        switch segmentedControl.selectedSegmentIndex{ //-> Will need attention
    //
    //        case 0:
    //            changeIssuerDelegate?.changeFlag(flag: .us)
    //
    //            if #available(iOS 13.0, *) {
    //                segmentedControl.selectedSegmentTintColor = currentIssuer?.currentColor
    //            } else {
    //                // Fallback on earlier versions
    //            }
    //
    //            UIView.transition(with: self.flagImageView,
    //                              duration: 0.75,
    //                              options: .transitionCrossDissolve,
    //                              animations: {
    //                                self.flagImageView.image = self.flagArray[0]},
    //                              completion: nil)
    //            viewCollectionButton.setTitleColor(currentIssuer?.currentColor, for: .normal)
    //            viewCollectionButton.setTitle(usCollectionString, for: .normal)
    //
    //            addButton.setTitleColor(currentIssuer?.currentColor, for: .normal)
    //            addButton.setTitle("Add New US Coin", for: .normal)
    //
    //            self.myPickerView.setValue(currentIssuer?.currentColor, forKeyPath: "textColor")
    //
    //            print ("case .us")
    //            print(currentIssuer as Any)
    //
    //        case 1:
    //            changeFlagDelegate?.changeFlag(flag: .canada)
    //
    //            if #available(iOS 13.0, *) {
    //                segmentedControl.selectedSegmentTintColor = currentIssuer?.currentColor
    //            } else {
    //                // Fallback on earlier versions
    //            }
    //
    //            UIView.transition(with: self.flagImageView,
    //                              duration: 0.75,
    //                              options: .transitionCrossDissolve,
    //                              animations: {
    //                                self.flagImageView.image = self.flagArray[1]},
    //                              completion: nil)
    //
    //            viewCollectionButton.setTitleColor(currentIssuer?.currentColor, for: .normal)
    //            viewCollectionButton.layer.borderColor = currentIssuer?.currentColor.cgColor
    //            addButton.layer.borderColor = currentIssuer?.currentColor.cgColor
    //            self.myPickerView.setValue(currentIssuer?.currentColor, forKeyPath: "textColor")
    //            viewCollectionButton.setTitle(canadaCollectionString, for: .normal)
    //
    //            addButton.setTitleColor(currentIssuer?.currentColor, for: .normal)
    //            addButton.setTitle("Add New Canadian Coin", for: .normal)
    //        default:
    //            break
    //        }
    //    }
    
    //    func deleteRow(){
    //        let medArray = denomArray.filter({ $0 != "Check Empty Issuers" })
    //        denomArray = medArray
    //        myPickerView.reloadComponent(1)
    //    }
    
    
    
    //MARK: - pickerView functions
    //MARK: -
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {

        return 1

        }

//    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
//
//        switch pickerView{
//        case leftPicker:
//            return CGFloat(self.view.bounds.width * 0.2)
//
//        case rightPicker:
//            return CGFloat(self.view.bounds.width * 0.8)
//
//        default:
//            return 200.0
//        }
//
//    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch pickerView {
        case leftPicker:
            if ((issuerFRC?.fetchedObjects?.count)!) > 0 {
//                print("FetchedObjects.count == \(issuerFRC?.fetchedObjects!.count as Any)")
//                print("In number of rows, fetchedObjects.count == \(issuerFRC!.fetchedObjects!.count as Any)")
                return (issuerFRC!.fetchedObjects!.count)
            }else{
                return 0
            }
            
        case rightPicker: // Crashing here I believe because thisIssuer hasn't been defined yet
            
            if currentIssuer != nil {
                return (currentIssuer!.denominationArray?.count)!
            }else{
                return 0
            }
            
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
//        if (row) <= 1 {
//
//            print("This row is number \(row)")
//            print(issuerFRC!.fetchedObjects!.count as Any)
//            thisIssuer = (issuerFRC?.fetchedObjects![row])!
//            changeIssuer(issuerName: thisIssuer.name!)
//            print(" ***** \(String(describing: currentIssuer!.name)) as Any")
//
//            rightPickerArray = currentIssuer!.denominationArray!
//
////            print("currentIssuer.name == \(String(describing: currentIssuer!.name))")
////            print("currentIssuer.colorD == \(String(describing: currentIssuer!.colorD))")

            switch pickerView {
                
            case leftPicker:
                return NSAttributedString(string: leftPickerArray [row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
                
                
            case rightPicker:
                if rightPickerArray.count < 2 {
                    return NSAttributedString(string: ("Choose Issuer"), attributes: [NSAttributedString.Key.foregroundColor: currentColor, .strokeWidth : -5 ]) //nil optional here!!!!
                }else{
//                    rightPicker.reloadComponent(0)

                    return NSAttributedString(string: (rightPickerArray [row]), attributes: [NSAttributedString.Key.foregroundColor: currentColor, .strokeWidth : -5 ]) //nil optional here!!!!
                }
//                print("Index out of range here")
                
            default:
//                return NSAttributedString(string: denomArray[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
                print("Not finding an appropriate array")
            }
//                    }else{
//                        popAlert()
//                    }
            
            //        print("(rightPickerArray == \(rightPickerArray) as Any)")
            
            return NSAttributedString(string: rightPickerArray[row], attributes: [NSAttributedString.Key.foregroundColor: currentColor])
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        AudioServicesPlayAlertSound(SystemSoundID(1306))
        
        
        
        switch pickerView {
        case leftPicker:
            
            changeIssuer(issuerName: leftPickerArray [row] )
            
            issuerLabel.text = currentIssuer?.name
            issuerLabel.textColor = currentColor
            
            print("currentIssuer.denomArray == \(String(describing: currentIssuer?.denominationArray))")
            rightPickerArray = currentIssuer?.denominationArray! as! [String]
            rightPicker.reloadComponent(0)
            rightPicker.isUserInteractionEnabled = true
            print("currentIssuer.name == \(String(describing: currentIssuer!.name))")
            leftPicker.layer.borderColor = currentColor?.cgColor
            viewCollectionButton.layer.borderColor = currentColor?.cgColor
            rightPicker.layer.borderColor = currentColor?.cgColor
            rightPicker.selectRow(0, inComponent: 0, animated: true)

            saveIt()
            
        case rightPicker:
//            if title == rightPickerArray [row]{
                viewCollectionButton.isUserInteractionEnabled = true
                viewCollectionButton.setTitle(rightPickerArray [row], for: .normal)
                
//            }else if title == rightPickerArray [row]{
//                viewCollectionButton.isUserInteractionEnabled = true
//                viewCollectionButton.setTitle(rightPickerArray [row], for: .normal)
//
//            }else{
//                viewCollectionButton.setTitle(rightPickerArray [row], for: .normal)
//            }
            
            
            
        default:
            break
        }
        
        viewCollectionButton.isUserInteractionEnabled = true
        transText = rightPickerArray[row]
        print("In Did select row")
//        print("currentIssuer == \(String(describing: currentIssuer?.name))")
//        print(transText as Any)
    }
    
    
    func saveIt(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.saveContext()
    }

    
    func popAlert(){
        
        let alert = UIAlertController(title: "No Issuers present!", message: "Please create Issuers", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    
    //-> Will need attention Replace flag with image from user input for country
    
    func createImageWith(issuer: String?) -> UIImage? {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let nameLabel = UILabel(frame: frame)
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = .lightGray
        nameLabel.textColor = .white
        nameLabel.font = UIFont.boldSystemFont(ofSize: 40)
        nameLabel.text = issuer
        UIGraphicsBeginImageContext(frame.size)
        defer { UIGraphicsEndImageContext() } // ?
        if let currentContext = UIGraphicsGetCurrentContext() {
            nameLabel.layer.render(in: currentContext)
            let nameImage = UIGraphicsGetImageFromCurrentImageContext()
            return nameImage
        }
        return nil
    }
}



