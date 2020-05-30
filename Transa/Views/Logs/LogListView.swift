//
//  LogListView.swift
//  ExpenseTracker
//
//  Created by Rizky Adipratama Ruddyar on 28/04/20.
//  Copyright © 2020 Rizky Adipratama Ruddyar. All rights reserved.
//

import SwiftUI
import CoreData

struct LogListView: View {
    
   @Environment(\.managedObjectContext)
   var context: NSManagedObjectContext
   
    
   @FetchRequest(
       entity: ExpenseLog.entity(),
       sortDescriptors: [
           NSSortDescriptor(keyPath: \ExpenseLog.date, ascending: false)
       ]
   )
   private var result: FetchedResults<ExpenseLog>
   
   
   init(predicate: NSPredicate?, sortDescriptor: NSSortDescriptor) {
       let fetchRequest = NSFetchRequest<ExpenseLog>(entityName: ExpenseLog.entity().name ?? "ExpenseLog")
       fetchRequest.sortDescriptors = [sortDescriptor]
       
       if let predicate = predicate {
           fetchRequest.predicate = predicate
       }
       _result = FetchRequest(fetchRequest: fetchRequest)
   }
    
    @State var logToEdit: ExpenseLog?

    // TODO: - Implement Fetch of Expense Log to display in a List
      var body: some View {
            List {
                ForEach(result) { (log: ExpenseLog) in
                    Button(action: {
                        self.logToEdit = log
                    }) {
                        HStack(spacing: 16) {
                            CategoryImageView(category: log.categoryEnum)
                            VStack(alignment: .leading, spacing: 8) {
                                Text(log.nameText).font(.headline)
                                Text(log.dateText).font(.subheadline)
                            }
                            Spacer()
                            Text(log.amountText).font(.headline)
                        }
                        .padding(.vertical, 4)
                    }
                }
                .onDelete(perform: onDelete)
                .sheet(item: $logToEdit, onDismiss: {self.logToEdit = nil})
                {
                    (log: ExpenseLog) in LogFormView (name: log.name ?? "", amount: log.amount?.doubleValue ?? 0, category: Category(rawValue: log.category ?? "") ?? .makanan, date: log.date ?? Date(), logToEdit: log, context: self.context)
                }
            }
        }
        
        private func onDelete(with indexSet: IndexSet) {
            // TODO: Implement Delete
            indexSet.forEach { index in
                let log = result[index]
                context.delete(log)
            }
            try? context.saveContext()
        }
    }


//struct LogListView_Previews: PreviewProvider {
//    static var previews: some View {
//        LogListView()
//    }
//}

struct LogListView_Previews: PreviewProvider {
    static var previews: some View {
        let stack = CoreDataStack(containerName: "ExpenseTracker")
        let sortDescriptor = ExpenseLogSort(sortType: .date, sortOrder: .descending).sortDescriptor
        return LogListView(predicate: nil, sortDescriptor: sortDescriptor)
            .environment(\.managedObjectContext, stack.viewContext)
    }
}

