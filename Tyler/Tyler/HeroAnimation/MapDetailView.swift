//
//  MapDetailView.swift
//  Tyler
//
//  Created by Hyunjun Kim on 10/6/23.
//

import SwiftUI

struct MapDetailView: View {
    
    var namespace: Namespace.ID
    @Binding var isShow: Bool
    @State var appear = [false, false, false]
    @State var viewState: CGSize = .zero
    @State var isDraggable = true
    
    var body: some View {
        ScrollView {
            MapImage
                .overlay {
                    CloseButton
                        .opacity(appear[0] ? 1 : 0)
                }
                .overlay {
                    CardContent
                }
            MapDetail
                .opacity(appear[2] ? 1 : 0)
        }
        .onAppear {
            fadeIn()
        }
        .onChange(of: isShow) { newValue in
            fadeOut()
        }
        .mask(RoundedRectangle(cornerRadius: viewState.width / 3, style: .continuous))
        .shadow(color: .black.opacity(0.3), radius: 30, x: 0, y: 10)
        .scaleEffect(viewState.width / -600 + 1)
        .background(.black.opacity(viewState.width / 500))
        .background(.ultraThinMaterial)
        .gesture(isDraggable ? drag : nil)
        .ignoresSafeArea(edges: .top)
        .statusBarHidden()
    }
    
    var CardContent: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 10) {
                Text("오리런")
                    .font(.title)
                    .bold()
                    .matchedGeometryEffect(id: "title", in: namespace)
                HStack {
                    Image(systemName: "map.fill")
                    Text("건국대학교")
                }
                .matchedGeometryEffect(id: "subtitle", in: namespace)
            }
            .padding(.top, 20)
            Spacer()
            Button {
                //action
            } label: {
                Text("시작하기")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .foregroundStyle(.ultraThinMaterial)
                    }
            }
            .opacity(appear[1] ? 1 : 0)
            .padding(-10)
        }
        .foregroundStyle(.white)
        .padding(40)
    }
    
    var MapImage: some View {
        Image("MapExample")
            .resizable()
            .scaledToFit()
            .overlay {
                Color.black.opacity(0.7)
            }
            .roundedCorner(radius: 40, corners: [.bottomLeft, .bottomRight])
            .matchedGeometryEffect(id: "background", in: namespace)
    }
    
    var CloseButton: some View {
        Button {
            withAnimation(.closeCard) {
                isShow.toggle()
            }
        } label: {
            Image(systemName: "xmark.circle.fill")
                .font(.title)
                .foregroundStyle(.ultraThinMaterial)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .padding(30)
    }
    
    var MapDetail: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("난이도 상, 골목길 가파름")
                .font(.title3)
                .bold()
            Text("안녕하세요 어쩌구 하이 고래 귀엽\n마리오 슈퍼마리오 스파게티")
            Text("안녕하세요 어쩌구 하이 고래 귀엽\n마리오 슈퍼마리오 스파게티")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top)
        .padding(.horizontal, 40)
    }
    
    var drag: some Gesture {
        DragGesture(minimumDistance: 30, coordinateSpace: .local)
            .onChanged { value in
                guard value.translation.width > 0 else { return }
                if value.startLocation.x < 100 {
                    withAnimation {
                        viewState = value.translation
                    }
                }
                
                if viewState.width > 100 {
                    close()
                }
            }
            .onEnded { value in
                if viewState.width > 80 {
                    close()
                } else {
                    withAnimation {
                        viewState = .zero
                    }
                }
            }
    }
    
    func fadeIn() {
        withAnimation(.easeOut.delay(0.3)) {
            appear[0] = true
        }
        withAnimation(.easeOut.delay(0.4)) {
            appear[1] = true
        }
        withAnimation(.easeOut.delay(0.5)) {
            appear[2] = true
        }
    }
    
    func fadeOut() {
        appear[0] = false
        appear[1] = false
        appear[2] = false
    }
    
    func close() {
        withAnimation(.closeCard) {
            viewState = .zero
            isShow.toggle()
        }
        
        isDraggable = false
    }
}

#Preview {
    HeroAnimationView()
}
