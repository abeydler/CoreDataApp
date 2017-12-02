//
//  TasksDetailViewController.swift
//  TasksCoreData
//
//  Created by Austin Beydler on 11/30/17.
//  Copyright © 2017 Austin Beydler. All rights reserved.
//

import UIKit

class TasksDetailViewController: UIViewController {
    @IBOutlet weak var taskTitleTextField: UITextField!
    @IBOutlet weak var taskDetailTextView: UITextView!
    
    var existingTask: Task?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        
        taskTitleTextField.delegate = self
        //taskDetailTextView.delegate = self
        
        taskTitleTextField.text = existingTask?.name
        taskDetailTextView.text = existingTask?.detail
        
        self.title = existingTask?.name
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveTask(_ sender: Any) {
        
        let name = taskTitleTextField.text
        let detail = taskDetailTextView.text ?? ""
        
        var task:Task?
        
        if let existingTask = existingTask{
            existingTask.name = name
            existingTask.detail = detail
            
            task = existingTask
        }else{
            task = Task(name: name, detail: detail)
        }
        
        if let task = task{
            
            do  {
               
                let managedContext = task.managedObjectContext
                
                try managedContext?.save()
                
                self.navigationController?.popViewController(animated: true)
                
            }catch{
                 print("Task cannot be saved")
                
            }
            
        }else{
            print("TASK NOT CREATED")
        }
        
        
    }
    
    
   
}

extension TasksDetailViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
