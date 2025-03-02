import SwiftUI

struct Todo: Identifiable {
    var id = UUID()
    var item: String
    var isDone: Bool
}

struct ContentView: View {
    @State private var todos: [Todo] = []
    @State private var themeColor: Color = .yellow
    @State private var showInfo = false
    @State private var appTitle: String = "Todoey"
    
    var body: some View {
        ZStack {
            VStack (alignment: .leading) {
                HStack {
                    Text(appTitle)
                        .foregroundStyle(themeColor)
                        .font(.system(size: 40, weight: .bold))
                    
                    Spacer()
                    
                    Button {
                        showInfo.toggle()
                    } label: {
                        Image(systemName: "info.circle")
                            .foregroundColor(themeColor)
                            .font(.title2)
                    }
                }
                .padding(.horizontal, 30)
                
                List {
                    ForEach($todos) { $todo in
                        TodoRowView(todo: $todo, themeColor: themeColor)
                    }
                    .onDelete(perform: removeRows)
                }
                .listStyle(PlainListStyle())
                    
                Button {
                    todos.append(Todo(item: "", isDone: false)) }
                label: {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(themeColor)
                        Text("New Reminder")
                            .foregroundColor(themeColor)
                            .font(.title2)
                            .bold()
                    }
                }
                .offset(x: 30)
            }
        }
        .sheet(isPresented: $showInfo) {
            InfoView(selectedColor: $themeColor, title: $appTitle)
        }
    }
func removeRows(at offsets: IndexSet) {
    todos.remove(atOffsets: offsets)
    }
}

struct TodoRowView: View {
    @Binding var todo: Todo
    var themeColor: Color
    
    var body: some View{
        HStack {
            Button {
                todo.isDone.toggle()
            } label: {
                Image(systemName: todo.isDone ? "circle.fill" : "circle")
                    .padding(.horizontal, 10)
                    .foregroundStyle(themeColor)
                    .font(.title2)
            }
            TextField("", text: $todo.item)
                .foregroundColor(.white)
                .font(.title2)
                .opacity(todo.isDone ? 0.5 : 1)
        }
    }
}

struct InfoView: View {
    @Binding var selectedColor: Color
    @Binding var title: String
    let colors: [Color] = [.yellow, .blue, .green, .red, .purple, .orange, .pink, .white, .brown, .cyan]
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "list.bullet.circle.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(selectedColor)
            
            .padding(.bottom, 30)
            
            TextField("", text: $title)
                .padding()
                .font(.title)
                .bold()
                .frame(maxWidth: 350)
                .multilineTextAlignment(.center)
                .background(Color.gray.cornerRadius(10))
            
            .padding(.bottom, 30)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))], spacing: 15) {
                ForEach(colors, id: \.self) { color in
                    Button {
                        selectedColor = color
                    } label: {
                        Circle()
                            .fill(color)
                            .frame(width: 50, height: 50)
                            .overlay(selectedColor == color ? Image(systemName: "checkmark.circle.fill").foregroundColor(.white) : nil)
                    }
                }
            }
            .padding(.bottom, 30)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}

#Preview {
    @State var previewColor: Color = .yellow
    @State var previewTitle: String = "Todoey"
    
    return InfoView(selectedColor: $previewColor, title: $previewTitle)
}
