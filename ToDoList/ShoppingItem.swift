//
//  ShoppingItem.swift
//  RealmKakeibo
//
//  Created by まちだこうたろう on 2023/02/07.
//

import Foundation
import RealmSwift

class ShoppingItem: Object{
    @Persisted var title: String = ""
    @Persisted var price: Int = 0
    @Persisted var isMarked: Bool = false
    //@Persisted var category: Category?
}