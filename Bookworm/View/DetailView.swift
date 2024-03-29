//
//  DetailView.swift
//  Bookworm
//
//  Created by dominator on 22/12/19.
//  Copyright © 2019 dominator. All rights reserved.
//

import SwiftUI
import CoreData

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isShowingDeleteAlert = false
    
    let book: Book
    var body: some View {
        GeometryReader{ geometry in
            VStack{
                ZStack(alignment: .bottomTrailing) {
                    Image(self.book.genre ?? "Fantasy")
                        .frame(maxWidth: geometry.size.width)
                    Text(self.book.genre?.uppercased() ?? "FANTASY")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }
                
                Text(self.book.author ?? "Unkown author")
                    .font(.title)
                    .foregroundColor(.secondary)
                Text(self.book.review ?? "No Review")
                    .padding()
                RatingView(rating: .constant(Int(self.book.rating)))
                    .font(.largeTitle)
                
                Spacer()
            }
            
        }
        .navigationBarTitle(self.book.title ?? "Unknown book")
        .alert(isPresented: $isShowingDeleteAlert) {
            Alert(title: Text("Delete book"), message: Text("Are you sure ?"), primaryButton: .destructive(Text("Confirm"), action: deleteBook), secondaryButton: .cancel())
        }
        .navigationBarItems(trailing: Button(action: {
            self.isShowingDeleteAlert = true
        }){
            Image(systemName: "trash")
        })
    }
    
    func deleteBook(){
        moc.delete(book)
        
        try? moc.save()
        
        presentationMode.wrappedValue.dismiss()
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Test book"
        book.author = "Test author"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "This was a great book; I really enjoyed it."
        
        return NavigationView{
            DetailView(book: book)
        }
    }
}
