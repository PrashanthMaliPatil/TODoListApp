//
//  ToDoViewModel.swift
//  TODoListApp
//
//  Created by Prashanth Mali Patil on 03/09/24.
//

import Foundation
import Combine

class ToDoViewModel: ObservableObject {
    @Published var items: [ToDoItem] = []
    private var cancellables = Set<AnyCancellable>()
    
    private let itemsKey = "toDoItems"
    
    init() {
        loadItems()
    }
    
    func addItem(title: String) {
        let newItem = ToDoItem(title: title)
        items.append(newItem)
        saveItems()
    }
    
    func toggleComplete(item: ToDoItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isCompleted.toggle()
            saveItems()
        }
    }
    
    func deleteItem(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        saveItems()
    }
    
    private func loadItems() {
        if let data = UserDefaults.standard.data(forKey: itemsKey),
           let savedItems = try? JSONDecoder().decode([ToDoItem].self, from: data) {
            items = savedItems
        }
    }
    
    private func saveItems() {
        if let data = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(data, forKey: itemsKey)
        }
    }
}
