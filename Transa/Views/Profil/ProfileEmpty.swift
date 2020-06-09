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
            
                VStack
                    {
                        ZStack {
                            Rectangle().foregroundColor(Color(#colorLiteral(red: 0.1489486992, green: 0.390168488, blue: 0.555157125, alpha: 1))) .frame(height: 400)

                            VStack
                                {

                                    Image("noprofile").resizable().frame(width: 125, height: 125).scaledToFit().overlay(Circle().stroke(Color.init(#colorLiteral(red: 1, green: 0.888686657, blue: 0.7034975886, alpha: 1)), lineWidth: 5)).clipShape(Ellipse()).shadow(color: Color.init(#colorLiteral(red: 1, green: 0.888686657, blue: 0.7034975886, alpha: 1)), radius: 10).padding()                                    
                                    Text("Belum Ada Profil")
                                        .font(.system(size: 17)).fontWeight(.bold).foregroundColor(Color.init(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))}
                        }
                        

                        
                }.background(Rectangle().foregroundColor(Color.init(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))).edgesIgnoringSafeArea(.all))
            
            Spacer()
            
            
        }
    }
}

struct ProfileEmpty_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEmpty()
    }
}
