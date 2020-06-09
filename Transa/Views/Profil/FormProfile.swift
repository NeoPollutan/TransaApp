//
//  FormProfile.swift
//  App Skripsi
//
//  Created by Rizky Adipratama Ruddyar on 16/04/20.
//  Copyright © 2020 Rizky Adipratama Ruddyar. All rights reserved.
//

import SwiftUI
import CoreData

struct FormProfile: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @State var nameUser = ""
    @State var penghasilanUser = ""
    @State var limitUser = ""
    @State var photoUser : Data = .init(count: 0)
    @State var show = false
    
    @Environment(\.presentationMode)
    var presentationMode

    
    var body: some View {
        
        NavigationView {
            
            
            Form {
                
                Section(header: HStack {
                    Image(systemName: "person.crop.rectangle.fill").resizable().frame(width: 22, height: 20).foregroundColor(Color.init(#colorLiteral(red: 0.1489486992, green: 0.390168488, blue: 0.555157125, alpha: 1)))
                    Text("Foto Profil").font(.headline).fontWeight(.medium).foregroundColor(.black)
                }.padding(.top,15))
                {
                    
                    if self.photoUser.count != 0
                    {
                        Button(action: {
                            self.show.toggle()
                        })
                        {
                            Image(uiImage: UIImage(data: self.photoUser)!)
                                .renderingMode(.original) .resizable() .frame(width: 50, height: 50, alignment: .center) .cornerRadius(6)
                        }
                    } else {
                        Button(action: {
                            self.show.toggle()
                        })
                        {
                            Image(systemName: "person.crop.rectangle.fill").font(.system(size: 55)) .foregroundColor(.gray) .frame(alignment: .center)
                            } .padding()
                    }

                }
                
                Section(header: HStack {
                    Image(systemName: "person.fill").resizable().frame(width: 22, height: 20) .foregroundColor(Color.init(#colorLiteral(red: 0.1489486992, green: 0.390168488, blue: 0.555157125, alpha: 1)))
                    Text("Nama Pengguna").font(.headline).fontWeight(.medium).foregroundColor(.black)
                }.padding(.top,15))
                {
                    TextField("Masukan nama anda", text: $nameUser)
                        .disableAutocorrection(true)
                }
                
                Section(header: HStack {
                    Image("wallet").resizable().frame(width: 22, height: 20)
                    Text("Penghasilan Bulanan").font(.headline).fontWeight(.medium).foregroundColor(.black)
                    })
                    {
                    TextField("Masukan penghasilan bulanan anda", value: $penghasilanUser, formatter: Utils.numberFormatter)
                        .keyboardType(.numbersAndPunctuation)
                    }
                
                
                Section(header: HStack {
                    Image("safebox").resizable().frame(width: 22, height: 20)
                    Text("Limit Pengeluaran Harian").font(.headline).fontWeight(.medium).foregroundColor(.black)
                }){
                TextField("Masukan limit pengeluaran harian anda", value: $limitUser, formatter: Utils.numberFormatter)
                    .keyboardType(.numbersAndPunctuation)
                }
                
            }
                
            .sheet(isPresented: self.$show, content: {
                ImagePicker(show: self.$show, photoUser: self.$photoUser)
            })
                
                .navigationBarTitle(Text("Profil Saya"), displayMode: .inline) .navigationBarItems(leading: Button(action: self.onCancel) { Text("Batal")}, trailing: Button(action: self.onSaving) { Text("Simpan")}) .navigationBarHidden(false)
            
        }
        
    }
    
    private func onCancel() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    private func onSaving()
    {
        let send = Profile(context: self.moc)
        send.namaUser = self.nameUser
        send.limitHarian = self.limitUser
        send.penghasilan = self.penghasilanUser
        send.photo = self.photoUser
        
//        do{
//            try send
//          } catch let error as NSError
//          {
//              print(error.localizedDescription)
//          }
          
          self.presentationMode.wrappedValue.dismiss()
        
    }
    
}

struct FormProfile_Previews: PreviewProvider {
    static var previews: some View {
        FormProfile()
    }
}
