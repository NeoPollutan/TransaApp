//
//  ProfileFilled.swift
//  App Skripsi
//
//  Created by Rizky Adipratama Ruddyar on 16/04/20.
//  Copyright © 2020 Rizky Adipratama Ruddyar. All rights reserved.
//

import SwiftUI
import CoreData

struct ProfileFilled: View {
    
    //edit profil
    //if else profil kosong dan isi
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Profile.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Profile.namaUser, ascending: true), NSSortDescriptor(keyPath: \Profile.penghasilan, ascending: true),
        NSSortDescriptor(keyPath: \Profile.limitHarian, ascending: true),
        NSSortDescriptor(keyPath: \Profile.photo, ascending: true),
        NSSortDescriptor(keyPath: \Profile.switcher, ascending: false)
        ]
    ) var profiles : FetchedResults<Profile>
    
    @State var photoUser : Data = .init(count: 0)
    
    @State var show = false
    
    func setNotification() -> Void
     {
         let manager = LocalNotificationManager()
        manager.requestPermission()
        manager.addNotification(title: "Jangan lupa catat seluruh aktivitas keuanganmu hari ini! 😊")
        manager.schedule()
     }
    
    var body: some View {
            
            NavigationView {
                

                
                ForEach(self.profiles, id: \.self)
                { save in
                    
                    VStack(spacing: 2)
                    {
                        ZStack {
                         
                             Image(uiImage: UIImage(data: save.photo ?? self.photoUser)!).resizable().frame(height: 400).scaledToFit().blur(radius: 5).overlay(Rectangle().foregroundColor(.black).opacity(0.3))
                      
                            VStack
                                {
                                    
                                    Image(uiImage: UIImage(data: save.photo ?? self.photoUser)!).resizable().frame(width: 125, height: 125).scaledToFit().overlay(Circle().stroke(Color.init(#colorLiteral(red: 1, green: 0.888686657, blue: 0.7034975886, alpha: 1)), lineWidth: 5)).clipShape(Ellipse()).shadow(color: Color.init(#colorLiteral(red: 1, green: 0.888686657, blue: 0.7034975886, alpha: 1)), radius: 10).padding()
                                    
                                    Text("\(save.namaUser ?? "")")
                                        .font(.system(size: 19)).fontWeight(.bold).foregroundColor(Color.init(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))}
                        }
                        
                        
                        HStack (spacing: 2)
                        {
                            ZStack {
                                Rectangle().foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))) .frame(height: 100)
                                
                                VStack
                                    {
                                        Text("Penghasilan Bulanan").font(.system(size: 15)).fontWeight(.semibold).foregroundColor(Color.init(#colorLiteral(red: 0.4895541072, green: 0.469949007, blue: 0.4702165127, alpha: 1))).padding(.bottom, 6)
                                        Text(("Rp \(save.penghasilan ?? ""),00."))
                                            .font(.system(size: 20)).fontWeight(.regular) .foregroundColor(.black)
                                }
                            }
                            ZStack {
                                Rectangle().foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))) .frame(height: 100)
                                
                                VStack
                                    {
                                        Text("Limit Harian").font(.system(size: 15)).fontWeight(.semibold).foregroundColor(Color.init(#colorLiteral(red: 0.4895541072, green: 0.469949007, blue: 0.4702165127, alpha: 1))).padding(.bottom, 6)
                                        Text(("Rp \(save.limitHarian ?? ""),00."))
                                            .font(.system(size: 20)).fontWeight(.regular) .foregroundColor(.black)
                                }
                                
                            }
                            
                        }
                        
                        HStack
                        {
                            ZStack {
                                    Rectangle().foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))) .frame(height: 60)
                                
                                    HStack
                                        {
                                        Text("Turn On Notifications").font(.system(size: 18)).fontWeight(.regular) .foregroundColor(.black)
                                            
                                            Spacer()
                                            
                                            Button(action: {
                                                self.setNotification()
                                            save.switcher.toggle()
                                            try? self.moc.save()
                                            }) {
                                                Image(systemName: save.switcher ? "bell.fill": "bell.slash").resizable().frame(width: 22, height: 22)
                                            }
                                }.padding()
                            }
                                
                        }
                        
                        Spacer()
                        
//                        Button (action: {
//                        }, label: {
//                            RoundedRectangle(cornerRadius: 15)
//                                .frame(width: 360, height: 50, alignment: .center)
//                                .foregroundColor(Color(#colorLiteral(red: 0.1489486992, green: 0.390168488, blue: 0.555157125, alpha: 1)))
//                                .opacity(1)
//                                .overlay(
//                                    Text("Edit Profil")
//                                        .foregroundColor(Color.white))
//
//                        })
//
//                        Spacer()
                        
                    }.background(Rectangle().foregroundColor(Color.init(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))).edgesIgnoringSafeArea(.all))
                    
                } .navigationBarTitle(Text("Profi Saya"), displayMode: .inline) .navigationBarHidden(false) .navigationBarItems(trailing: Button(action: {self.show.toggle()}) {
                    Text("Buat")
                })
                
                    .sheet(isPresented: self.$show)
                    {
                        FormProfile() .environment(\.managedObjectContext, self.moc)
                }
                
                
            }
            
    }
}

struct ProfileFilled_Previews: PreviewProvider {
    static var previews: some View {
        ProfileFilled()
    }
}
