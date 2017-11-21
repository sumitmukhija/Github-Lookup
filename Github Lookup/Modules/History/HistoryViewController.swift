//
//  HistoryViewController.swift
//  Github Lookup
//
//  Created by Sumit on 11/20/17.
//  Copyright © 2017 Sumit Mukhija. All rights reserved.
//

import UIKit

class HistoryViewController: BaseTabViewController, UITableViewDelegate, UITableViewDataSource {
    
    var historyRows: Array<AnyObject>?
    
    @IBOutlet weak var historyTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = TITLES.HISTORY
        historyRows = CoreDataHelper.getHistoryRows()
        initializeTableView()
    }
    
    func initializeTableView()
    {
        let nib = UINib(nibName: FILE_NAMES.HISTORY_TABLE_CELL, bundle: nil)
        historyTableView.register(nib, forCellReuseIdentifier: IDENTIFIERS.HISTORY_CELL_ID)
        historyTableView.delegate = self
        historyTableView.separatorStyle = .none
        historyTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IDENTIFIERS.HISTORY_CELL_ID, for: indexPath) as! HistoryTableViewCell
        let historyItem = historyRows?[indexPath.row]
        cell.lblName.text = historyItem?.value(forKey: IDENTIFIERS.CD_HISTORY_ATTRIB_QUERY) as? String
        cell.lblDate.text = historyItem?.value(forKey: IDENTIFIERS.CD_HISTORY_ATTRIB_WHEN) as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = historyRows
        {
            return historyRows!.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.tabBarController?.selectedIndex = 0
    }
    
}
