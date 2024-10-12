//
//  ContentView.swift
//  True Northern Tea
//
//  Created by Nolan Law on 2024-10-12.
//

import SwiftUI

struct ContentView: View {
    @State private var showMenu = false

    var body: some View {
        ScrollView(.vertical) {
            // HEADER
            HStack {
                Text("True Northern Tea")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.leading, 20)

                Spacer()

                HStack(spacing: 15) {
                    Image("search-icon")
                        .resizable()
                        .frame(width: 25, height: 25)
                    Image("cart-icon")
                        .resizable()
                        .frame(width: 25, height: 25)
                    Image("menu-icon")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .onTapGesture {
                            withAnimation {
                                showMenu.toggle()
                            }
                        }
                }
                .padding(.trailing, 20)
            }
            .padding(.vertical)
            .background(Color.white)
            .overlay(Divider(), alignment: .bottom)

            if showMenu {
                VStack(alignment: .leading) {
                    menuLink("Home", sectionId: "section1")
                    menuLink("Allergen Alert", sectionId: "section2")
                    menuLink("Featured Products", sectionId: "section3")
                    menuLink("Delivery & Pickup", sectionId: "section4")
                    menuLink("About Us", sectionId: "section5")
                    menuLink("Contact Us", sectionId: "section6")
                }
                .background(Color.white)
                .transition(.move(edge: .top))
            }

            // BANNER
            ZStack {
                Image("banner")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .overlay(Color.black.opacity(0.3))

                VStack {
                    Text("True Northern Tea")
                        .font(.system(size: 60))
                        .foregroundColor(.white)
                    Text("Here at True Northern Tea, we invite you to explore our handcrafted, natural selection of tea...")
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    Button(action: {
                        print("Order Now button clicked")
                    }) {
                        Text("Order Now")
                            .font(.system(size: 16))
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(5)
                    }
                }
                .padding(.bottom, 50)
            }
            .frame(maxHeight: .infinity)
            .background(Color.clear)
            .id("section1")

            // ALLERGEN ALERT SECTION
            SectionView(title: "Allergen Alert", backgroundColor: .white, textColor: .black) {
                Text("Despite our best efforts, We cannot guarantee that the tea has not come into contact with peanuts, nuts & other allergens.")
                    .multilineTextAlignment(.center)
            }
            .id("section2")

            // FEATURED PRODUCTS SECTION
            SectionView(title: "Featured Products", backgroundColor: .teal, textColor: .black) {
                TabView {
                    productView(title: "Festive Fireside Blend, C$5.00", imageName: "festive-fireside", message: "I would like to buy Festive Fireside Blend")
                    productView(title: "Lemon & Ginger, C$5.00", imageName: "lemon-ginger", message: "I would like to buy Lemon & Ginger")
                    productView(title: "Warm Chai, C$5.00", imageName: "warm-chai", message: "I would like to buy Warm Chai")
                    productView(title: "Pumpkin Spice, C$5.00", imageName: "pumpkin-spice", message: "I would like to buy Pumpkin Spice")
                }
                .frame(height: 275)
                .tabViewStyle(.page)
            }
            .id("section3")

            // DELIVERY & PICKUP SECTION
            SectionView(title: "Delivery & Pickup", backgroundColor: .white, textColor: .black) {
                Text("FREE DELIVERY AND PICKUP TO OAKBANK RESIDENTS ONLY. Orders will be delivered within 3 days. Please contact us at truenortherntea@gmail.com to schedule pick up.")
                    .multilineTextAlignment(.center)
            }
            .id("section4")

            // ABOUT US SECTION
            SectionView(title: "About Us", backgroundColor: .gray, textColor: .black) {
                Text("I’m Levi, a 15-year-old with a passion to make natural and healthy tea blends. At True Northern Tea, we use only the finest natural ingredients to create delicious yet nourishing and beneficial teas.Our mission is to make tea that tastes amazing but contains pure and simple natural ingredients while being convenient and at an affordable cost. Thank you for joining me on this journey!")
                    .multilineTextAlignment(.center)
            }
            .id("section5")

            // CONTACT US SECTION
            SectionView(title: "Contact Us", backgroundColor: .white, textColor: .black) {
                VStack {
                    Link("Manitoba, Canada", destination: URL(string: "https://www.google.ca/maps/place/Manitoba/")!)
                    Link("truenortherntea@gmail.com", destination: URL(string: "mailto:truenortherntea@gmail.com")!)
                }
            }
            .id("section6")

            // FOOTER
            footerView
        }
    }

    // Custom views

    func menuLink(_ text: String, sectionId: String) -> some View {
        Button(action: {
            withAnimation {
                scrollToSection(sectionId)
                showMenu.toggle()
            }
        }) {
            Text(text)
                .foregroundColor(.black)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    func productView(title: String, imageName: String, message: String) -> some View {
        VStack {
            Text(title)
            Image(imageName)
                .resizable()
                .frame(width: 100, height: 100)
            Button(action: {
                let sms = "sms:2044038767&body=\(message)"
                if let url = URL(string: sms) {
                    UIApplication.shared.open(url)
                }
            }) {
                Text("Buy Now")
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(5)
            }
        }
        .padding()
    }

    var footerView: some View {
        VStack {
            Text("© 2024 True Northern Tea. All rights reserved.")
                .foregroundColor(Color(UIColor.lightGray))
        }
        .padding()
        .background(Color.black)
    }

    func scrollToSection(_ sectionId: String) {
        withAnimation {
            // Scroll logic for SwiftUI's ScrollView
        }
    }
}

// Custom SectionView to reduce repetitive code
struct SectionView<Content: View>: View {
    var title: String
    var backgroundColor: Color
    var textColor: Color
    let content: () -> Content

    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .foregroundColor(textColor)
            content()
                .foregroundColor(textColor)
        }
        .padding()
        .background(backgroundColor)
        .frame(maxWidth: .infinity)
    }
}

// Preview for the SwiftUI ContentView
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
