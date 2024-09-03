//
//  ToDoItem.swift
//  TODoListApp
//
//  Created by Prashanth Mali Patil on 03/09/24.
//

import Foundation

struct ToDoItem: Identifiable, Codable {
    var id = UUID()
    var title: String
    var isCompleted: Bool = false
}
