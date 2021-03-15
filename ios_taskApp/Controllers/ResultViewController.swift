//
//  ResultViewController.swift
//  iOS Quiz
//
//  Created by Jitender Kumar Yadav on 27/10/20.
//  Copyright © 2020 Jitender Kumar Yadav. All rights reserved.
//

import UIKit
import CoreData

class ResultViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var resultsTableView: UITableView!
    
    var results = [FinalScore]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        resultsTableView.tableFooterView = UIView()
        getData()
        
    }
    
    func getData() {

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FinalScore")
        let sort = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sort]

        do {
            let results = try PersistenceServce.context.fetch(request) as! [FinalScore]

            self.results = results
            self.resultsTableView.reloadData()

        } catch {
            print("Fetching Failed")
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsTableViewCell", for: indexPath) as! ResultsTableViewCell
        cell.scoreLbl.text = String(results[indexPath.row].marks)
        cell.dateLbl.text = results[indexPath.row].date
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
