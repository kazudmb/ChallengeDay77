//
//  ContentView.swift
//  ChallengeDay77
//
//  Created by KazukiNakano on 2020/07/27.
//  Copyright © 2020 dmb. All rights reserved.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var showingAlert = false
    @State private var showingAlertInput = false
    @State private var alertInput = ""
        
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    self.showingImagePicker = true
                }
                .padding(.vertical)
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$selectedImage)
        }
    }
    
    func loadImage() {
        guard let inputImage = selectedImage else { return }
        image = Image(uiImage: inputImage)
        
        setImageName()
    }
    
    func setImageName() {
        
        // input image name
        saveImage()
    }
    
    func saveImage() {
        guard let processedImage = self.selectedImage
            else {
                self.showingAlert = true
                return
        }
        
        let imageSaver = ImageSaver()
        
        imageSaver.successHandler = {
            print("Success!")
        }
        
        imageSaver.errorHandler = {
            print("Oops: \($0.localizedDescription)")
        }
        
        imageSaver.writeToPhotoAlbum(image: processedImage)
        
        addImageAndName()
    }
    
    func addImageAndName() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
