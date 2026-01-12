import SwiftUI

struct ContentView: View {

    @State private var selectedTab = 0
    @State private var currentZoom = 1.0
    @State private var totalZoom = 0.0
    @State private var offset = CGSize.zero
    @State private var lastOffset = CGSize.zero

    var body: some View {
        ZStack {
            NavigationView {
                List {
                    Section("Overview") {
                        NavigationLink {
                            OverviewView()
                        } label: {
                            Label("Overview", systemImage: "book")
                        }

                        NavigationLink {
                            SFSymbolFinderView()
                        } label: {
                            Label("SF Symbols Finder", systemImage: "pencil.and.scribble")
                        }
                    }

                    Section("Practice") {
                        NavigationLink {
                            PencilKitWorkshopView()
                        } label: {
                            Label("Doodle with PencilKit", systemImage: "pencil.tip")
                        }

                        NavigationLink {
                            CoreMLVisionWorkshopView()
                        } label: {
                            Label("Think with CoreML", systemImage: "brain.head.profile")
                        }

                        NavigationLink {
                            WorkshopCompleteView()
                        } label: {
                            Label("Workshop", systemImage: "sum")
                        }
                    }

                    Section("Appendix") {
                        NavigationLink {
                            CreateMLGuideView()
                        } label: {
                            Label("CreateML", systemImage: "cpu")
                        }
                    }
                }
                .listStyle(SidebarListStyle())
                .allowsHitTesting(totalZoom <= 10)
            }
            .scaleEffect(max(1.0, currentZoom + totalZoom))
            .offset(x: offset.width, y: offset.height)

            if totalZoom > 0 {
                Color.clear
                    .contentShape(Rectangle())
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                offset = CGSize(
                                    width: lastOffset.width + value.translation.width,
                                    height: lastOffset.height + value.translation.height
                                )
                            }
                            .onEnded { value in
                                lastOffset = offset
                            }
                    )
            }
        }
        .gesture(
            MagnificationGesture()
                .onChanged { value in
                    currentZoom = value - 1
                }
                .onEnded { value in
                    totalZoom += currentZoom
                    totalZoom = max(0, totalZoom)
                    currentZoom = 0
                    
                    print(totalZoom)
                    if totalZoom <= 0.5 {
                        withAnimation(.spring()) {
                            offset = .zero
                            lastOffset = .zero
                            totalZoom = 0
                        }
                    }
                }
        )
    }
}
