//
//  LogFormView.swift
//  ExpenseTracker
//
//  Created by Rizky Adipratama Ruddyar on 28/04/20.
//  Copyright © 2020 Rizky Adipratama Ruddyar. All rights reserved.
//

import SwiftUI
import CoreData

struct LogFormView: View {
        
    @State var name: String = ""
    @State var amount: Double = 0
    @State var category: Category = .kebutuhan
    @State var date: Date = Date()
    
    @Environment(\.presentationMode)
    var presentationMode
    
    var logToEdit: ExpenseLog?
    var context: NSManagedObjectContext
    
    var title: String
    {
        logToEdit == nil ? "Tambah Pengeluaran" : "Ubah Pengeluaran "
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: HStack {
                    Image(systemName: "text.justify").resizable().frame(width: 22, height: 20).foregroundColor(Color.init(#colorLiteral(red: 0.1489486992, green: 0.390168488, blue: 0.555157125, alpha: 1)))
                    Text("Judul Pengeluaran").font(.headline).fontWeight(.medium).foregroundColor(.black)
                }.padding(.top,15))
                {
                TextField("Untuk keperluan apa pengeluaran anda", text: $name)
                    .disableAutocorrection(true)
                }
                
                Section(header: HStack {
                    Image(systemName: "dollarsign.square").resizable().frame(width: 22, height: 20).foregroundColor(Color.init(#colorLiteral(red: 0.1489486992, green: 0.390168488, blue: 0.555157125, alpha: 1)))
                    Text("Jumlah Pengeluaran").font(.headline).fontWeight(.medium).foregroundColor(.black)
                })
                {
                TextField("", value: $amount, formatter: Utils.numberFormatter)
                    .keyboardType(.numbersAndPunctuation)
                }
                
                
                Section(header: HStack {
                    Image(systemName: "list.bullet").resizable().frame(width: 22, height: 20).foregroundColor(Color.init(#colorLiteral(red: 0.1489486992, green: 0.390168488, blue: 0.555157125, alpha: 1)))
                    Text("Kategori Pengeluaran").font(.headline).fontWeight(.medium).foregroundColor(.black)
                }){
                Picker(selection: $category, label: Text("Kategori")) {
                    ForEach(Category.allCases) { category in
                        Text(category.rawValue.capitalized).tag(category)
                    }
                }
                }
                
                Section(header: HStack {
                    Image(systemName: "calendar").resizable().frame(width: 22, height: 20).foregroundColor(Color.init(#colorLiteral(red: 0.1489486992, green: 0.390168488, blue: 0.555157125, alpha: 1)))
                    Text("Tanggal Pengeluaran").font(.headline).fontWeight(.medium).foregroundColor(.black)
                }){
                DatePicker(selection: $date, displayedComponents: .date) {
                    Text("Tanggal")
                }
                    
                }
            }

            .navigationBarItems(
                leading: Button(action: self.onCancelTapped) { Text("Batal")},
                trailing: Button(action: self.onSaveTapped) { Text("Simpan")}
            )   .navigationBarTitle(Text(title), displayMode: .inline) .navigationBarHidden(false)
            
        }
        
    }
    
    private func onCancelTapped() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    private func onSaveTapped() {
        let log: ExpenseLog
        if let logToEdit = self.logToEdit
        {
            log = logToEdit
        } else
        {
            log = ExpenseLog(context: self.context)
            log.id = UUID()
        }
        
        log.name = self.name
        log.category = self.category.rawValue
        log.amount = NSDecimalNumber(value: self.amount)
        log.date = self.date
        
        do{
            try context.save()
        } catch let error as NSError
        {
            print(error.localizedDescription)
        }
        
        self.presentationMode.wrappedValue.dismiss()
    }
    
}

//struct LogFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        return LogFormView()
//    }
//}

struct LogFormView_Previews: PreviewProvider {
    static var previews: some View {
        let stack = CoreDataStack(containerName: "ExpenseTracker")
        return LogFormView(context: stack.viewContext)
    }
}

