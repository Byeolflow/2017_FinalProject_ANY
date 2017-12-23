//
//  DetailLocalListTableViewController.swift
//  FinalProject_2014111535_ANY
//
//  Created by SWUCOMPUTER on 2017. 12. 22..
//  Copyright © 2017년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class DetailLocalListTableViewController: UITableViewController {
    
   // @IBOutlet var detailTitle: UITableViewCell!
    
    var detailList: NSManagedObject?
    //var bigLocalList: [NSManagedObject] = []
    var detailLocalList: [NSManagedObject] = []
    

    
    func getContext()->NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
        //return appDelegate.persistentContainer.viewContext
    }
    
    //View가 보여질 때 자료를 DB에서 가져오도록 한다.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let context = getContext()
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LocalDetails")

    //   let fetchRequest2 = NSFetchRequest<NSManagedObject>(entityName: "Locals")
        
        //정렬
        let sortDescriptor = NSSortDescriptor (key: "saveDate", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do{
            
            self.detailLocalList = try context.fetch(fetchRequest)
            
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        
        self.tableView.reloadData()
        
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = detailList?.value(forKey: "localName") as? String

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return detailLocalList.count
        
        
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailLocal Cell", for: indexPath)

        // Configure the cell...
        
        let detailLocal = detailLocalList[indexPath.row]
        
        
        if let detailName = detailLocal.value(forKey: "detailName") as? String {
            
            cell.textLabel?.text = detailName
        }
        
        
        
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        
        if let unwrapDate = detailLocal.value(forKey: "saveDate") {
            let displayDate = formatter.string(from: unwrapDate as! Date)
            cell.detailTextLabel?.text = displayDate
        }
        /*
        if let dateTime = detailLocal.value(forKey: "saveDate") as? String {
            cell.detailTextLabel?.text = dateTime
        }
        */
        
        /*
        detailName
        latitude
        longitude
        memo
        saveDate
        */
        
        return cell
        
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            //Core Data 내의 해당 자료 삭제
            let context = getContext()
            context.delete(detailLocalList[indexPath.row])
            do{
                try context.save()
                print("deleted!")
            } catch let error as NSError {
                print("Could not delete \(error), \(error.userInfo)")
            }
            
            //배열에서 해당 자료 삭제
            detailLocalList.remove(at: indexPath.row)
        
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toConfrimContents" {
            if let destination = segue.destination as? ConfrimViewController {
                if let selectedIndex = self.tableView.indexPathsForSelectedRows?.first?.row {
                    destination.detailAddress = detailLocalList[selectedIndex]
                }
            }
        }
        
    }
    

}
