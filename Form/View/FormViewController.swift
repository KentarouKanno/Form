//
//  ViewController.swift
//  Form
//
//  Created by Kentarou on 2017/03/17.
//  Copyright © 2017年 Kentarou. All rights reserved.
//

import UIKit

protocol FormViewControllerType {
    /**
     @IBOutletのTableViewを取得する為のプロトコル
    */
    var table: UITableView { get }
}


class FormViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FormViewControllerType {
    
    var formViewModel: FormViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputBaseViewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Notification
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(self.willChangeKeyboard(_:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(self.willHideKeyboard(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        notificationCenter.addObserver(self, selector: #selector(self.willChangeKeyboard(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        formViewModel = FormViewModel(viewController: self)
        tableView.reloadData()
    }
    
    var table: UITableView {
        return self.tableView
    }
    
    // MARK: - TableView Delegate & DataSource
    
    // Section Count
    func numberOfSections(in tableView: UITableView) -> Int {
        if let formViewModel = formViewModel {
            return formViewModel.dataArray.count
        }
        return 0
    }
    
    // Row Count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formViewModel.dataArray[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    // Generate Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return formViewModel.dataArray[indexPath.section][indexPath.row].createCell(indexPath: indexPath)
    }
    
    @IBAction func errorLog(_ sender: UIButton) {
        
        formViewModel.errorLog()
        // tableView.reloadSections([1], with: .fade)
        
        tableView.reloadData()
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // WillChange Keyboad
    func willChangeKeyboard(_ notification: Notification) {
        
        if let userInfo = (notification as NSNotification).userInfo {
            if let keyboard = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
                let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval {
                
                let keyBoardHeight = keyboard.cgRectValue.height
                self.inputBaseViewBottomConstraint.constant = keyBoardHeight
                
                UIView.animate(withDuration:duration, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    // WillHide Keyboard
    func willHideKeyboard(_ notification: Notification) {
        
        if let userInfo = (notification as NSNotification).userInfo {
            if let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval {
                
                self.inputBaseViewBottomConstraint.constant = 74
                UIView.animate(withDuration:duration, animations: {
                    self.view.layoutIfNeeded()
                }, completion: { finish in
                    
                })
            }
        }
    }
}

