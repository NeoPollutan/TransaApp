//
//  imagePicker.swift
//  Transa
//
//  Created by Rizky Adipratama Ruddyar on 10/05/20.
//  Copyright © 2020 Rizky Adipratama Ruddyar. All rights reserved.
//

import Foundation
import SwiftUI
import  Combine

struct ImagePicker : UIViewControllerRepresentable
{
    @Binding var show : Bool
    @Binding var photoUser : Data
    
    func makeCoordinator() -> ImagePicker.Coordinator {
        return ImagePicker.Coordinator(child1: self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var child : ImagePicker
        init(child1: ImagePicker)
        {
            child = child1
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let photoUser = info[.originalImage]as! UIImage
            let data = photoUser.jpegData(compressionQuality: 0.45)
            
            self.child.photoUser = data!
            self.child.show.toggle()
        }
    }
}
