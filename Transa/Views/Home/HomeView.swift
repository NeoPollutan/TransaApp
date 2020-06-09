//
//  HomeView.swift
//  App Skripsi
//
//  Created by Rizky Adipratama Ruddyar on 12/04/20.
//  Copyright © 2020 Rizky Adipratama Ruddyar. All rights reserved.
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    
    @Environment(\.managedObjectContext) var moc
    
    
    @FetchRequest(entity: Profile.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Profile.namaUser, ascending: true),
                                                              NSSortDescriptor(keyPath: \Profile.limitHarian, ascending: true),
                                                              NSSortDescriptor(keyPath: \Profile.photo, ascending: true)
        ]
    ) var profiles : FetchedResults<Profile>
    
    @State var photoUser : Data = .init(count: 0)
    
    
    @Environment(\.managedObjectContext)
    var context: NSManagedObjectContext
    
    
    class DateHelper{
        internal class func startOfDay(day: NSDate) -> NSDate {
            let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
            let unitFlags: NSCalendar.Unit = [.minute, .hour, .day, .month, .year]
            var todayComponents = gregorian!.components(unitFlags, from: day as Date)
            todayComponents.hour = 0
            todayComponents.minute = 0
            return (gregorian?.date(from: todayComponents))! as NSDate
        }
        
        internal class func endOfDay(day: NSDate) -> NSDate {
            let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
            let unitFlags: NSCalendar.Unit = [.minute, .hour, .day, .month, .year]
            var todayComponents = gregorian!.components(unitFlags, from: day as Date)
            todayComponents.hour = 23
            todayComponents.minute = 59
            return (gregorian?.date(from: todayComponents))! as NSDate
        }
    }
    
    
    @FetchRequest(
        entity: ExpenseLog.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \ExpenseLog.date, ascending: false)
        ]
        ,predicate: NSPredicate(format: "(date => %@) AND (date <= %@)", DateHelper.startOfDay(day: NSDate()), DateHelper.endOfDay(day: NSDate()))
    )
    private var result: FetchedResults<ExpenseLog>
    
    

    
    @FetchRequest(
        entity: ExpenseLog.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \ExpenseLog.amount, ascending: false)
        ]
        ,predicate: NSPredicate(format: "(date => %@) AND (date <= %@)", DateHelper.startOfDay(day: NSDate()), DateHelper.endOfDay(day: NSDate()))
    )
    var fetchSumDaily: FetchedResults<ExpenseLog>
    
    
    
    var sum: Decimal {
        fetchSumDaily.reduce(0) { $0 + $1.amount!.decimalValue }
    }
    
    var sumText: String
    {
        NSDecimalNumber(decimal: self.sum).stringValue
    }
        
   
    
    
    

    
    
//        @State var totalDaily: Decimal?
//
//    func sumDaily(){
//        let sumDailys = fetchSumDaily.reduce(Decimal(0.0)) {
//            if let amount = $1.amount as Decimal? {
//                return $0 + amount
//            }
//
//            return $0
//        }
//        totalDaily = sumDailys
//
//    }
    
 
    
    
    
    let hour = Calendar.current.component(.hour, from: Date()) 
    
    @State var pengeluaranhariini = "250.000"
    
    
    
    enum HomeSheet{
        case Profile
        case Add
    }
    
    @State var isSheet : Bool = false
    @State var homeSheet : HomeSheet = .Profile
    
    
    
    var body: some View {
        
        
        GeometryReader { geometry in
            VStack
                {
                    
                    HStack{
                        ZStack
                            {
                                Image("kotakcardgreeting") .resizable()
                                    
                                    .frame(width: geometry.frame(in: .global).width, height: geometry.frame(in: .global).height/4)
                                    .offset(y: -50)
                                
                                HStack{
                                    
                                    
                                    VStack(alignment: .leading){
                                        
                                        
                                        Text("\(getGreeting()),")
                                            .font(.system(size: 22))
                                            .fontWeight(.semibold).foregroundColor(Color.init(#colorLiteral(red: 1, green: 0.888686657, blue: 0.7034975886, alpha: 1))) .padding(.top, 40)
                                        
                                        ForEach(self.profiles, id: \.self)
                                        { profilNama in
                                            Text("\(profilNama.namaUser ?? "")")
                                                .font(.system(size: 22))
                                                .fontWeight(.semibold).foregroundColor(Color.init(#colorLiteral(red: 1, green: 0.888686657, blue: 0.7034975886, alpha: 1))) .padding(.top, 1)
                                        }
                                        
                                        
                                        Text("Jangan lupa catat pengeluaranmu hari ini")
                                            .font(.system(size: 17)).fontWeight(.semibold).foregroundColor(.white)
                                            .padding(.top, 10)
                                        
                                        
                                        
                                    }.padding()
                                    
                                    
                                    
                                    
                                    Spacer()
                                    
                                    ForEach(self.profiles, id: \.self)
                                    { profilPhoto in
                                        VStack{
                                            Image(uiImage: UIImage(data: profilPhoto.photo ?? self.photoUser)!).resizable().frame(width: 55, height: 55).scaledToFit().overlay(Circle().stroke(Color.init(#colorLiteral(red: 1, green: 0.888686657, blue: 0.7034975886, alpha: 1)), lineWidth: 5)).clipShape(Ellipse()).shadow(color: Color.init(#colorLiteral(red: 1, green: 0.888686657, blue: 0.7034975886, alpha: 1)), radius: 5).onTapGesture {
                                                
                                            }.padding()
                                            
                                            
                                        }
                                        
                                    }
                                }.offset(y: -60)
                                
                                
                                Image("bigaddbutton") .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.frame(in: .global).width/4, height: geometry.frame(in: .global).height/8) .onTapGesture {
                                        self.isSheet = true
                                        self.homeSheet = HomeSheet.Add
                                        
                                }
                                .padding(.top, 100)
                                
                        }
                    }
                    
                    Spacer()
                    
                    
                    
                    HStack {
                        ZStack {
                            Image("cardstatus") .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.frame(in: .global).width, height: geometry.frame(in: .global).height/4)
                            HStack
                                {
                                    Spacer()
                                    if self.result.count == 0
                                    {
                                        Text("") .padding(.trailing, 180)
                                    }
                                    else
                                    {
                                        Text("IDR \(self.sumText),00.")
                                            .font(.system(size: 20))
                                            .fontWeight(.bold).foregroundColor(.white) .multilineTextAlignment(.trailing) .padding(.top, 40)
                                    }
                                    
                                    
                                    Spacer()
                                    
                                    if self.profiles.count == 0
                                    {
                                        Text("") .padding(.leading, 180)
                                        
                                    }
                                    else
                                    {
                                        ForEach(self.profiles, id: \.self)
                                        { profilLimit in
                                            Text(("IDR \(profilLimit.limitHarian ?? ""),00."))
                                                .font(.system(size: 20)).fontWeight(.bold) .foregroundColor(.white) .multilineTextAlignment(.trailing)
                                                .padding(.top, 40)
                                        }
                                        
                                    }
                                    
                                    Spacer()
                            }
                            
                        }
                    }
                    
                    
                    Spacer()
                    
                    HStack
                        {
                            
                            Text("Daftar Pengeluaran Hari Ini")
                                .font(.system(size: 17)).fontWeight(.bold).foregroundColor(Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))) .multilineTextAlignment(.leading)
                            
                            Spacer()
                            
                            Button(action: {
                                self.isSheet = true
                                self.homeSheet = HomeSheet.Add

                            }) {
                                Text("Tambah")
                                    .font(.system(size: 17)).fontWeight(.bold).foregroundColor(Color.init(#colorLiteral(red: 0.1489486992, green: 0.390168488, blue: 0.555157125, alpha: 1))) .multilineTextAlignment(.leading)
                            }
                            
                    }.padding(.horizontal)
                    
                    ScrollView
                        {
                            
                            if self.result.count == 0
                            {
                                DaftarTransaksiEmpty()
                            }
                            else
                            {
                                VStack
                                    {
                                        // i want to put list of the only today inputted data here
                                        ForEach(self.result)
                                        {
                                            (log: ExpenseLog) in
                                            
                                            
                                            
                                            ZStack{
                                                HStack(spacing: 16) {
                                                    CategoryImageView(category: log.categoryEnum) .padding(.leading , 8)
                                                    VStack(alignment: .leading, spacing: 8) {
                                                        Text(log.nameText).font(.headline)
                                                        Text(log.dateText).font(.subheadline)
                                                    }
                                                    Spacer()
                                                    Text(log.amountText).font(.headline).padding(.trailing , 8)
                                                    
                                                } .padding(.vertical, 8) .padding(.horizontal,4)
                                            }
                                            
                                        }
                                }.background(Rectangle().foregroundColor(Color.init(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).edgesIgnoringSafeArea(.all))
                            }
                            
                            
                            
                            
                            
                            
                            
                            
                    }
                    
                    
            }.background(Rectangle().foregroundColor(Color.init(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))).edgesIgnoringSafeArea(.all))
                
                .sheet(isPresented: self.$isSheet) {
                    
                    if self.homeSheet == HomeSheet.Profile{
                        ProfileFilled().environment(\.managedObjectContext, self.moc)
                        
                    }
                    else if self.homeSheet == HomeSheet.Add{
                        LogFormView(context: self.context)
                        
                    }
                    
            }
            
            
            
        }
    }
}

private func getGreeting() -> String {
    let hour = Calendar.current.component(.hour, from: Date())
    
    switch hour {
    case 0..<10:
        return "Selamat Pagi"
    case 10..<15:
        return "Selamat Siang"
    case 15..<18:
        return "Selamat Sore"
    case 18..<24:
        return "Selamat Malam"
    default:
        break
    }
    return "Hello"
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

