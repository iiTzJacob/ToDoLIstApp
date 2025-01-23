//
//  ContentView.swift
//  ToDoListApp
//
//  Created by Jacob Colon on 1/22/25.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingForm = false
    @State private var offWhite = Color(red: 0.95, green: 0.95, blue: 0.95)
    
    var body: some View {
        VStack {
            ZStack {
                HStack{
                    Text("ToDo List")
                        .font(.largeTitle)
                        .foregroundStyle(offWhite)
                        .padding(.leading)
                    
                    Spacer()
                    Button {
                        isShowingForm = true
                    }
                    label: {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    .foregroundStyle(offWhite)
                }
                .padding(.top, 100)
                .padding(.trailing)
                .padding(.bottom, 25)
                .background(Color.red)
                .clipShape(RoundedCorners(radius: 10, corners: [.bottomLeft, .bottomRight]))
            }
            .ignoresSafeArea()
            .sheet(isPresented: $isShowingForm){
                FormView()
            }
            Spacer()
        }
    }
    
    func addItem(item: String) {
            
    }
}

struct FormView: View {
    @Environment(\.dismiss) var dismiss
    @State private var itemName: String = ""
    @State private var todoList = []
    let date = Date()
    let todaysDate = "\(currentDate().month)/\(currentDate().days)/\(currentDate().year)"
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Add Item")) {
                    TextField("Item Name", text: $itemName)
                    Text(todaysDate)
                }
                
                Section {
                    Button("Submit") {
                        
                        dismiss()
                    }
                }
            }
        }
    }
    class currentDate {
        let month = String(Calendar.current.component(.month, from: Date()))
        let days = String(Calendar.current.component(.day, from: Date()))
        let year = String(Calendar.current.component(.year, from: Date()))
    }
    
    class todoListItems {
        var newItem: String
        var dateAdded: String
        
        init(newItem: String, dateAdded: String) {
            self.newItem = newItem
            self.dateAdded = dateAdded
        }
    }
    
    func addItem(item: todoListItems) {
        var item = todoListItems(newItem: itemName, dateAdded: todaysDate)
        todoList.append(item)
    }
}

struct RoundedCorners: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))

        return Path(path.cgPath)
    }
}

#Preview {
    ContentView()
}
