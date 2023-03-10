//
//  ViewController.swift
//  RealmKakeibo
//
//  Created by まちだこうたろう on 2023/02/07.
//

import UIKit
import RealmSwift

class ItemViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    let realm = try! Realm()
    var items: [ShoppingItem] = []
    let dt = Date()
    let dateformatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
        items = readItems()
    }
    
    //TableViewのリロードを行っている
    override func viewWillAppear(_ animated: Bool) {
        //これを追加すると表示されるたびに更新される
        items = readItems()
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemTableViewCell
        let item: ShoppingItem = items[indexPath.row]
        self.dateformatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yMMMdHms", options: 0, locale: Locale(identifier: "ja_JP"))
        cell.setCell(title: item.title, contents: item.contents, isMarked: item.isMarked, date: item.date ?? self.dateformatter.string(from: dt))
        
        return cell
    }
    
    func readItems() -> [ShoppingItem] {
        return Array(realm.objects(ShoppingItem.self))
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            //Realmから消す
            try! realm.write {
                realm.delete(items[indexPath.row])
            }

            //配列から消す？
            items.remove(at: indexPath.row)
            //表示上消す
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
    
}

