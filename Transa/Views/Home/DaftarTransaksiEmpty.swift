//
//  DaftarTransaksiEmpty.swift
//  App Skripsi
//
//  Created by Rizky Adipratama Ruddyar on 12/04/20.
//  Copyright © 2020 Rizky Adipratama Ruddyar. All rights reserved.
//

import SwiftUI

struct DaftarTransaksiEmpty: View {
    var body: some View {
                ZStack {
                    Rectangle().foregroundColor(.white) .frame(height: 360)
                    VStack {
                        Image("listkosong").resizable().frame(width: 168, height: 157).padding(.top)
                        Text("Daftar transaksi kosong").foregroundColor(Color.init(#colorLiteral(red: 0.1489486992, green: 0.390168488, blue: 0.555157125, alpha: 1))).bold().padding([.top, .bottom],10)
                        Text("Kamu belum mencatat transaksi pengeluaran apapun hari ini.").font(.subheadline).foregroundColor(.gray).multilineTextAlignment(.center).padding(.horizontal,60)
                    }.padding()
                }.background(Rectangle().foregroundColor(Color.init(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).edgesIgnoringSafeArea(.all))
    }
}

struct DaftarTransaksiEmpty_Previews: PreviewProvider {
    static var previews: some View {
        DaftarTransaksiEmpty()
    }
}
