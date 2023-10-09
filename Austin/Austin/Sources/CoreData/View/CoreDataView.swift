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
        VStack {
            Spacer()
                .frame(height: 50)
            VStack {
                ForEach(people, id: \.self) { p in
                    HStack {
                        Text("\(p.name ?? "defaultName")")
                        Spacer()
                        Text("\(p.age)")
                    }
                    .font(.title)
                    .padding(.bottom, 20)
                }
            }
            Spacer()
            Button {
                addPerson(name: "person\(people.count)", age: Int32(people.count + 20))
            } label: {
                Text("add person")
                    .frame(width: 300, height: 50)
                    .background(.yellow)
            }
            Button {
                deletePerson(at: IndexSet([people.count - 1]))
            } label: {
                Text("delete")
                    .frame(width: 300, height: 50)
                    .background(.orange)
            }
            Spacer()
                .frame(height: 30)
        }
        .padding()
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
