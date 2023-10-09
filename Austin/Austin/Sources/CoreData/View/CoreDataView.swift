//
//  CoreDataView.swift
//  Austin
//
//  Created by Seungui Moon on 10/9/23.
//

import SwiftUI

struct CoreDataView: View {
    @Environment(\.managedObjectContext) private var managedObjectContext
    @FetchRequest(
        entity: Person.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Person.age, ascending: true)
        ]
    ) private var people: FetchedResults<Person>
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    // MARK: 이후 ViewModel로 분리 필요
    func saveContext() {
        do {
          try managedObjectContext.save()
        } catch {
          print("Error saving managed object context: \(error)")
        }
    }
    
    func addPerson(name: String, age: Int32) {
        let newPerson = Person(context: managedObjectContext)

        newPerson.name = name
        newPerson.age = age

        saveContext()
    }

    func deletePerson(at offsets: IndexSet) {
      offsets.forEach { index in
        let person = self.people[index]
        self.managedObjectContext.delete(person)
      }
      saveContext()
    }
}

#Preview {
    CoreDataView()
}
