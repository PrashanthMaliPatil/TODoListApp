//
//  ToDoListView.swift
//  TODoListApp
//
//  Created by Prashanth Mali Patil on 03/09/24.
//

import SwiftUI

struct ToDoListView: View {
    @StateObject private var viewModel = ToDoViewModel()
    @State private var newTaskTitle = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter new task", text: $newTaskTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button(action: {
                        guard !newTaskTitle.isEmpty else { return }
                        viewModel.addItem(title: newTaskTitle)
                        newTaskTitle = ""
                    }) {
                        Image(systemName: "plus")
                            .padding()
                    }
                }
                
                List {
                    ForEach(viewModel.items) { item in
                        HStack {
                            Text(item.title)
                                .strikethrough(item.isCompleted)
                                .foregroundColor(item.isCompleted ? .gray : .black)
                            Spacer()
                            Button(action: {
                                viewModel.toggleComplete(item: item)
                            }) {
                                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(item.isCompleted ? .green : .blue)
                            }
                        }
                    }
                    .onDelete(perform: viewModel.deleteItem)
                }
            }
            .navigationTitle("To-Do List")
            .toolbar {
                EditButton()
            }
        }
    }
}

#Preview {
    ToDoListView()
}
