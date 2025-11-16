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
            VStack(spacing: 24) {
                HeroSection()
                    .padding(.top, 6)
                
                CategoriesSection(
                    categories: categories,
                    selectedCategory: $selectedCategory
                )
                                
                MenuItemsSection(
                    predicate: buildPredicate(),
                    sort: buildSortDescriptors()
                )
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Logo()
                }
            }
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
