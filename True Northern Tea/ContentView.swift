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
            VStack {
                Color.clear.frame(height: 50)
                HStack {
                    Spacer()
                    HStack(spacing: 20) {
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
                    .background(Color.white.shadow(radius: 10))
                    .transition(.move(edge: .top))
                }

                // BANNER
                VStack(spacing: 15) {
                    Text("True Northern Tea")
                        .font(.custom("Baskerville-Bold", size: 60))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .shadow(radius: 10)

                    Text("Here at True Northern Tea, we invite you to explore our handcrafted, natural selection of tea, where we've dedicated our passion to your enjoyment and well-being. We have anything from calm fall blends, to soothing holiday infusions. Enjoy!")
                        .font(.custom("Georgia", size: 20))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white.opacity(0.9))
                        .padding(.horizontal)

                    Button(action: {
                        print("Order Now button clicked")
                    }) {
                        Text("Order Now")
                            .font(.custom("HelveticaNeue", size: 18))
                            .padding(.horizontal, 30)
                            .padding(.vertical, 10)
                            .background(LinearGradient(gradient: Gradient(colors: [.white, .gray]), startPoint: .top, endPoint: .bottom))
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    }
                }
                .padding(.bottom, 40)
                .padding(.top, 20)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .id("section1")
            }
            .background {
                Image("banner")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .overlay(Color.black.opacity(0.3))
            }

            // ALLERGEN ALERT SECTION
            SectionView(title: "Allergen Alert", backgroundColor: .white, textColor: .black) {
                Text("Despite our best efforts, We cannot guarantee that the tea has not come into contact with peanuts, nuts & other allergens.")
                    .font(.custom("Georgia", size: 16))
                    .multilineTextAlignment(.center)
                    .padding()
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
                .frame(height: 300)
                .tabViewStyle(.page)
            }
            .id("section3")

            // DELIVERY & PICKUP SECTION
            SectionView(title: "Delivery & Pickup", backgroundColor: .white, textColor: .black) {
                Text("FREE DELIVERY AND PICKUP TO OAKBANK RESIDENTS ONLY. Orders will be delivered within 3 days. Please contact us at truenortherntea@gmail.com to schedule pickup.")
                    .font(.custom("Georgia", size: 16))
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .id("section4")

            // ABOUT US SECTION
            SectionView(title: "About Us", backgroundColor: .gray, textColor: .black) {
                Text("I’m Levi, a 15-year-old with a passion to make natural and healthy tea blends. At True Northern Tea, we use only the finest natural ingredients to create delicious yet nourishing and beneficial teas. Our mission is to make tea that tastes amazing but contains pure and simple natural ingredients while being convenient and at an affordable cost. Thank you for joining me on this journey!")
                    .font(.custom("Georgia", size: 16))
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .id("section5")

            // CONTACT US SECTION
            SectionView(title: "Contact Us", backgroundColor: .white, textColor: .black) {
                VStack {
                    Link("Manitoba, Canada", destination: URL(string: "https://www.google.ca/maps/place/Manitoba/")!)
                    Link("truenortherntea@gmail.com", destination: URL(string: "mailto:truenortherntea@gmail.com")!)
                }
                .font(.custom("Georgia", size: 16))
            }
            .id("section6")

            // FOOTER
            footerView
        }
        .edgesIgnoringSafeArea(.top)
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
                .font(.custom("HelveticaNeue", size: 18))
                .foregroundColor(.black)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
    }

    func productView(title: String, imageName: String, message: String) -> some View {
        VStack(spacing: 10) {
            Text(title)
                .font(.custom("HelveticaNeue", size: 16))
            Image(imageName)
                .resizable()
                .frame(width: 120, height: 120)
                .cornerRadius(10)
                .shadow(radius: 5)

            Button(action: {
                let sms = "sms:2044038767&body=\(message)"
                if let url = URL(string: sms) {
                    UIApplication.shared.open(url)
                }
            }) {
                Text("Buy Now")
                    .font(.custom("HelveticaNeue-Bold", size: 16))
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(8)
                    .shadow(radius: 5)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(15)
    }

    var footerView: some View {
        VStack {
            Text("© 2024 True Northern Tea. All rights reserved.")
                .foregroundColor(Color(UIColor.lightGray))
                .font(.custom("HelveticaNeue", size: 14))
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
                .font(.custom("HelveticaNeue-Bold", size: 24))
                .foregroundColor(textColor)
                .padding(.bottom, 10)
            content()
                .foregroundColor(textColor)
        }
        .padding()
        .background(backgroundColor)
        .cornerRadius(12)
        .shadow(radius: 10)
        .frame(maxWidth: .infinity)
    }
}

// Preview for the SwiftUI ContentView
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
