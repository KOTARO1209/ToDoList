//
//  NewCategoryViewController.swift
//  RealmKakeibo
//
//  Created by まちだこうたろう on 2023/02/10.
//

import UIKit
import RealmSwift

class NewCategoryViewController: UIViewController {

    @IBOutlet var categoryTextField: UITextField!
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func save() {
        let category = Category()
        category.title = categoryTextField.text ?? ""
        createCategory(category: category)
        
        self.dismiss(animated: true)
    }
    
    func createCategory(category: Category) {
        try! realm.write {
            realm.add(category)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
