//
//  TaskTableViewController.swift
//  TasksCoreData
//
//  Created by Austin Beydler on 12/1/17.
//  Copyright © 2017 Austin Beydler. All rights reserved.
//

import UIKit
import CoreData


class TaskTableViewController: UITableViewController {
    
    @IBOutlet var taskTableView: UITableView!
    
    
    var tasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let manageContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        do{
            tasks = try manageContext.fetch(fetchRequest)
            
            taskTableView.reloadData()
            
        }catch{
            print("Fetch cannot be preformed")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addNewTask(_ sender: Any) {

        
        performSegue(withIdentifier: "showTask", sender: self)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? TasksDetailViewController,
            let selectedRow = self.taskTableView.indexPathForSelectedRow?.row else{
                return
        }
        
        destination.existingTask = tasks[selectedRow]
        
    }
    
    func deleteTask( at indexPath: IndexPath){
        let task = tasks[indexPath.row]
        
        if let managedContext = task.managedObjectContext {
            
            managedContext.delete(task)
            
            do{
                try managedContext.save()
                
                self.tasks.remove(at: indexPath.row)
                taskTableView.deleteRows(at: [indexPath], with: .automatic)
                
            }catch{
                print("delete failed")
                
                taskTableView.reloadRows(at: [indexPath], with: .automatic)
            }
            
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
      
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
 
        return tasks.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = taskTableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        
        let task = tasks[indexPath.row]
        
        cell.textLabel?.text = task.name
        cell.textLabel?.textColor = UIColor.blue
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            deleteTask(at: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showTask", sender: self)
    }

    

    

}
