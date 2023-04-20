import SwiftUI

struct CityForm: View {
  @Binding var data: City.FormData

  var body: some View {
    Form {
        TextFieldWithLabel(label: "Name", text: $data.name, prompt: "Name")
        TextFieldWithLabel(label: "Latitude", text: $data.latitude, prompt: "Latitude")
        TextFieldWithLabel(label: "Longitude", text: $data.longitude, prompt: "Longitude")

    }
  }
}

struct TextFieldWithLabel: View {
  let label: String
  @Binding var text: String
  var prompt: String? = nil

  var body: some View {
    VStack(alignment: .leading) {
      Text(label)
        .bold()
        .font(.caption)
      TextField(label, text: $text, prompt: prompt != nil ? Text(prompt!) : nil)
        .padding(.bottom, 20)
    }
  }
}

struct NewCityForm: View {
    @EnvironmentObject var dataStore: DataStore
    @Binding var isPresentingCityForm: Bool
    @Binding var newCityFormData: City.FormData

    var body: some View {
        NavigationStack {
            CityForm(data: $newCityFormData)
            .toolbar {
              ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") { isPresentingCityForm = false }
              }
              ToolbarItem(placement: .navigationBarTrailing) {
                  Button("Save") {
                      let newCity = City.create(from: newCityFormData)
                      dataStore.createCity(newCity)
                      isPresentingCityForm = false
                      newCityFormData = City.FormData()
                  }
              }
            }
        }
        .padding()
    }
}

struct BookForm_Previews: PreviewProvider {
    static var previews: some View {
      CityForm(data: Binding.constant(City.previewData[0].dataForForm))
    }
}
