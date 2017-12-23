//
//  LocalChoiceTableViewController.swift
//  FinalProject_2014111535_ANY
//
//  Created by SWUCOMPUTER on 2017. 12. 22..
//  Copyright © 2017년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class LocalChoiceTableViewController: UITableViewController {
    
    var localNumber: Int = 0
    
    var localList: [NSManagedObject] = []
    var realdetailLocalList: [NSManagedObject] = []
    
    func getContext()->NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    //View가 보여질 때 자료를 DB에서 가져오도록 한다.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let context = self.getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Locals")
        
        let fetchRequest2 = NSFetchRequest<NSManagedObject>(entityName: "LocalDetails")
       
        
        //정렬
       // let sortDescriptor = NSSortDescriptor (key: "localName", ascending: true)
        let sortDescriptor = NSSortDescriptor (key: "sortDate", ascending: true)

        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do{
            localList = try context.fetch(fetchRequest)
            self.realdetailLocalList = try context.fetch(fetchRequest2)
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        //return localList.count
        return localList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Local Cell", for: indexPath)

       // Configure the cell...
       /*
        var localName = Array(localList)
        cell.textLabel?.text = localName[indexPath.row]
        */
        
        let local = localList[indexPath.row]
        
        localNumber = indexPath.row
        
        if let localNameLabel = local.value(forKey: "localName") as? String {
            cell.textLabel?.text = localNameLabel
            
        }
        
        
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

            
            context.delete(localList[indexPath.row])
            for i in 0..<realdetailLocalList.count{
                context.delete(realdetailLocalList[i])
            }
            do{
                try context.save()
                print("deleted!")
            } catch let error as NSError {
                print("Could not delete \(error), \(error.userInfo)")
            }
            
            //배열에서 해당 자료 삭제
            localList.remove(at: indexPath.row)
            
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
        if segue.identifier == "toAddList"{
            if let destVC = segue.destination as? AddLocalViewController{
                destVC.localVC = self
            }
        }
            
        else if segue.identifier == "toDetailView"{
            if let gotoVC = segue.destination as? DetailLocalListTableViewController{
                
                if let selectedIndex = self.tableView.indexPathsForSelectedRows?.first?.row {
                    
                    gotoVC.detailList = localList[selectedIndex]
               
                    
                }
                
            }
            
        }
        
        
    }
    

}
