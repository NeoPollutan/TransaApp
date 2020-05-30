//
//  ProfileEmpty.swift
//  App Skripsi
//
//  Created by Rizky Adipratama Ruddyar on 13/04/20.
//  Copyright © 2020 Rizky Adipratama Ruddyar. All rights reserved.
//

import SwiftUI
import CoreData

struct ProfileEmpty: View {
    
    @State var isSheetProfile : Bool = false
     @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        GeometryReader { geometry in
            
            NavigationView {
                VStack
                    {
                        ZStack {
                            Rectangle().foregroundColor(Color(#colorLiteral(red: 0.1489486992, green: 0.390168488, blue: 0.555157125, alpha: 1))) .frame(height: 300)
                            VStack
                                {

                                    Image("noprofile").resizable().frame(width: 85, height: 85).scaledToFit().overlay(Circle().stroke(Color.init(#colorLiteral(red: 1, green: 0.888686657, blue: 0.7034975886, alpha: 1)), lineWidth: 5)).clipShape(Ellipse()).shadow(color: Color.init(#colorLiteral(red: 1, green: 0.888686657, blue: 0.7034975886, alpha: 1)), radius: 10).onTapGesture {
                                        //func
                                    }.padding()
                                    
                                    Text("Belum Ada Nama")
                                        .font(.system(size: 17)).fontWeight(.bold).foregroundColor(Color.init(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))}
                        }
                        
                        Spacer()
                        
                        Button (action: {
                            self.isSheetProfile = true
                        }, label: {
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: 360, height: 50, alignment: .center)
                                .foregroundColor(Color(#colorLiteral(red: 0.1489486992, green: 0.390168488, blue: 0.555157125, alpha: 1)))
                                .opacity(1)
                                .overlay(
                                    Text("Buat Profil Baru")
                                        .foregroundColor(Color.white))
                            
                        })
                        
                        Spacer()
                        
                }.background(Rectangle().foregroundColor(Color.init(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))).edgesIgnoringSafeArea(.all))
                .navigationBarTitle(Text("Profil Saya"), displayMode: .inline) .navigationBarHidden(false)
                
                    .sheet(isPresented: self.$isSheetProfile) {
                        FormProfile().environment(\.managedObjectContext, self.moc)
                }
            }
            
        }
    }
}

struct ProfileEmpty_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEmpty()
    }
}
