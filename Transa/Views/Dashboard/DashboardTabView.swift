//
//  DashboardTabView.swift
//  ExpenseTracker
//
//  Created by Rizky Adipratama Ruddyar on 28/04/20.
//  Copyright © 2020 Rizky Adipratama Ruddyar. All rights reserved.
//

import SwiftUI
import CoreData

struct DashboardTabView: View {
    
    @Environment(\.managedObjectContext)
    var context: NSManagedObjectContext
    
    @State var totalExpenses: Double?
    @State var categoriesSum: [CategorySum]?
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 4) {
                if totalExpenses != nil {
                    Text("Total Pengeluaran")
                        .font(.headline)
                    if totalExpenses != nil {
                        Text(totalExpenses!.formattedCurrencyText)
                            .font(.largeTitle) .padding(.bottom, 40)
                    }
                }
            }
            
            if categoriesSum != nil {
                if totalExpenses != nil && totalExpenses! > 0 {
                    PieChartView(
                        data: categoriesSum!.map { ($0.sum, $0.category.color) },
                        style: Styles.pieChartStyleOne,
                        form: CGSize(width: 300, height: 240),
                        dropShadow: false
                    ) .padding(.bottom,40)
                }
                
                Divider()

                List {
                    Text("Kategori Pengeluaran").font(.headline)
                    ForEach(self.categoriesSum!) {
                        CategoryRowView(category: $0.category, sum: $0.sum)
                    }
                }
            }
            
            if totalExpenses == nil && categoriesSum == nil {
                Spacer()
                ZStack {
                    Rectangle().foregroundColor(.white) .frame(height: 360)
                    VStack {
                        Image("listkosong").resizable().frame(width: 168, height: 157).padding(.top)
                        Text("Chart pengeluaran kosong").foregroundColor(Color.init(#colorLiteral(red: 0.1489486992, green: 0.390168488, blue: 0.555157125, alpha: 1))).bold().padding([.top, .bottom],10)
                        Text("Silahkan tambahkan catatan pengeluaran keuangan.").font(.subheadline).foregroundColor(.gray).multilineTextAlignment(.center).padding(.horizontal,60)
                    }.padding()
                }
                Spacer()
                
            }
        }
        .padding(.top)
        .onAppear(perform: fetchTotalSums)
    }
    
    
    // TODO: - Impelement fetch total expenses sum
    func fetchTotalSums() {
           ExpenseLog.fetchAllCategoriesTotalAmountSum(context: self.context) { (results) in
               guard !results.isEmpty else { return }
               
               let totalSum = results.map { $0.sum }.reduce(0, +)
               self.totalExpenses = totalSum
               self.categoriesSum = results.map({ (result) -> CategorySum in
                   return CategorySum(sum: result.sum, category: result.category)
               })
           }
       }
    
}


struct CategorySum: Identifiable, Equatable {
    let sum: Double
    let category: Category
    
    var id: String { "\(category)\(sum)" }
}


struct DashboardTabView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardTabView()
    }
}
