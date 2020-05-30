//
//  LogsTabView.swift
//  ExpenseTracker
//
//  Created by Rizky Adipratama Ruddyar on 28/04/20.
//  Copyright © 2020 Rizky Adipratama Ruddyar. All rights reserved.
//

import SwiftUI
import CoreData

struct LogsTabView: View {
    
    @Environment(\.managedObjectContext)
    var context: NSManagedObjectContext
    
    @State private var searchText : String = ""
    @State private var searchBarHeight: CGFloat = 0
    @State private var sortType = SortType.date
    @State private var sortOrder = SortOrder.descending
    
    @State var selectedCategories: Set<Category> = Set()
    @State var isAddFormPresented: Bool = false
    
    @State var selectedView = 0
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                
                HStack
                    {
                        Picker(selection: $selectedView, label: Text("")) {
                            Text("Detail") .tag(0)
                            Text("Chart") .tag(1)
                        }
                }.pickerStyle(SegmentedPickerStyle()) .padding()
                
                if selectedView == 0
                {
                    SearchBar(text: $searchText, keyboardHeight: $searchBarHeight, placeholder: "Cari Pengeluaran")
                                 FilterCategoriesView(selectedCategories: $selectedCategories)
                                 Divider()
                                 SelectSortOrderView(sortType: $sortType, sortOrder: $sortOrder)
                                 Divider()
                                 LogListView(predicate: ExpenseLog.predicate(with: Array(selectedCategories), searchText: searchText), sortDescriptor: ExpenseLogSort(sortType: sortType, sortOrder: sortOrder).sortDescriptor)
                }
                else if selectedView == 1
                {
                    DashboardTabView()
                }
                
             
            }
            .padding(.bottom, searchBarHeight)
            .sheet(isPresented: $isAddFormPresented) {
                LogFormView(context: self.context)
            }
            .navigationBarItems(trailing: Button(action: addTapped) { Text("Tambah") })
            .navigationBarTitle("Log Pengeluaran", displayMode: .inline)
        }
    }
    
    
    struct pickerBar: View
    {
        @State var selectedPicker = 0
        var body: some View
        {
            HStack
                {
                    Picker(selection: $selectedPicker, label: Text("")) {
                        Text("Detail") .tag(0)
                        Text("Chart") .tag(1)
                    }
            }.pickerStyle(SegmentedPickerStyle()) .padding()
        }
        
    }
    
    func addTapped() {
        isAddFormPresented = true
    }
    
    
    
}

struct LogsTabView_Previews: PreviewProvider {
    static var previews: some View {
        LogsTabView()
    }
}
