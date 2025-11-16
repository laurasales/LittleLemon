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
    
    var categories = ["Starters", "Desserts", "Drinks", "Specials"]
    
    var body: some View {
        VStack {
            Text("Little Lemon")
            Text("Barcelona")
            Text("iOS App Capstone")
            
            ScrollView (.horizontal) {
                HStack {
                    ForEach(categories, id: \.self) { category in
                        Text(category)
                            .fixedSize()
                    }
                }
            }
            FetchedObjects() { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        NavigationLink(destination: FoodDetail(dish: dish)) {
                            FoodItem(dish: dish)
                         }
                    }
                }
            }
        }
        .onAppear {
            getMenuData()
        }
    }
    
    private func getMenuData() {
        PersistenceController.shared.clear()
        
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let data {
                let menuList = try? JSONDecoder().decode(MenuList.self, from: data)
                createDishesFrom(menuItems: menuList?.menu ?? [], viewContext)
            }
        }
        dataTask.resume()
    }
    
    private func createDishesFrom(menuItems:[MenuItem], _ context:NSManagedObjectContext) {
        for menuItem in menuItems {
            /*guard let _ = exists(name: menuItem.title, context) else {
                continue
            }*/
            let oneDish = Dish(context: context)
            oneDish.title = menuItem.title
            oneDish.price = menuItem.price
            oneDish.image = menuItem.image
            oneDish.descript = menuItem.description
            oneDish.category = menuItem.category
        }
        try? context.save()
    }
}

#Preview {
    Menu()
}
