//
//  Menu.swift
//  LittleLemon
//
//  Created by Laura Sales Martínez on 4/11/25.
//

import SwiftUI
import CoreData

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var searchText = ""
    @State private var selectedCategory: String? = nil
    
    var categories = ["Starters", "Mains", "Desserts", "Drinks", "Specials"]
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Little Lemon")
                Text("Barcelona")
                Text("iOS App Capstone")
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(categories, id: \.self) { category in
                            Text(category)
                                .padding(8)
                                .background(selectedCategory == category ? .accentColor : Color.gray.opacity(0.2))
                                .foregroundColor(selectedCategory == category ? .white : .black)
                                .cornerRadius(8)
                                .onTapGesture {
                                    if selectedCategory == category {
                                        selectedCategory = nil
                                    } else {
                                        selectedCategory = category
                                    }
                                }
                        }
                    }
                    .padding(.horizontal)
                }
                
                FetchedObjects(
                    predicate: buildPredicate(),
                    sortDescriptors: buildSortDescriptors()
                ) { (dishes: [Dish]) in
                    List(dishes) { dish in
                        NavigationLink(destination: FoodDetail(dish: dish)) {
                            FoodItem(dish: dish)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Menu")
            .searchable(text: $searchText, prompt: "Search menu")
            .onAppear {
                getMenuData()
            }
        }
    }
    
    private func getMenuData() {
        PersistenceController.shared.clear()
        
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        guard let url = URL(string: urlString) else { return }
        
        let urlRequest = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, _, _ in
            if let data {
                let menuList = try? JSONDecoder().decode(MenuList.self, from: data)
                createDishesFrom(menuItems: menuList?.menu ?? [], viewContext)
            }
        }
        dataTask.resume()
    }
    
    private func createDishesFrom(menuItems:[MenuItem], _ context:NSManagedObjectContext) {
        for menuItem in menuItems {
            let oneDish = Dish(context: context)
            oneDish.title = menuItem.title
            oneDish.price = menuItem.price
            oneDish.image = menuItem.image
            oneDish.descript = menuItem.description
            oneDish.category = menuItem.category
        }
        try? context.save()
    }
    
    private func buildSortDescriptors() -> [NSSortDescriptor] {
        [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))]
    }
    
    private func buildPredicate() -> NSPredicate {
        var predicates: [NSPredicate] = []
        
        if !searchText.isEmpty {
            predicates.append(NSPredicate(format: "title CONTAINS[cd] %@", searchText))
        }
        
        if let category = selectedCategory {
            predicates.append(NSPredicate(format: "category LIKE[cd] %@", category))
        }
        
        if predicates.isEmpty {
            return NSPredicate(value: true)
        } else if predicates.count == 1 {
            return predicates.first!
        } else {
            return NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        }
    }
}

#Preview {
    Menu()
}
