//
//  ContentView.swift
//  swift-uppgift4
//
//  Created by Dennis on 2024-11-12.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var allTodos: [TodoItem]
    @State var addTodoText = ""
    
    var body: some View {
        NavigationSplitView {
            VStack{
                TextField("type things to do", text: $addTodoText).padding(.leading, 30)
                Button(action: addItem){
                    Text("add")
                }
            }
            List {
                ForEach(allTodos.sorted(by: { !$0.done && $1.done })) { item in
                    HStack {
                        Toggle(isOn: Binding(
                            get: { item.done },
                            set: { newValue in
                                withAnimation {
                                    let mutableItem = item
                                    mutableItem.done = newValue
                                    modelContext.insert(mutableItem)
                                }
                            }
                        )) {
                            Text(item.text)
                                .strikethrough(item.done, color: .gray)
                                .foregroundColor(item.done ? .gray : .primary)
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        } detail: {
            Text("Select an item")
        }
    }
    
    private func addItem() {
        withAnimation {
            if(addTodoText == ""){
                return
            }
            let newTodo = TodoItem(text: addTodoText, done: false)
            modelContext.insert(newTodo)
            addTodoText = ""
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(allTodos[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: TodoItem.self, inMemory: true)
}
