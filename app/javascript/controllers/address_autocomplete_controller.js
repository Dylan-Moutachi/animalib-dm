import { Controller } from "@hotwired/stimulus";
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder";

// Connects to data-controller="address-autocomplete"
export default class extends Controller {
  static values = { apiKey: String, country: String };
  static targets = ["address"];

  connect() {
    this.geocoder = new MapboxGeocoder({
      accessToken: this.apiKeyValue,
      types: "country,region,place,postcode,locality,neighborhood,address",
      placeholder: "Where ?",
      countries: this.countryValue,
    });

    this.geocoder.addTo(this.element);

    const savedAddress = localStorage.getItem("savedAddress");
    if (savedAddress) {
      this.addressTarget.value = savedAddress;

      setTimeout(() => {
        const inputField = this.element.querySelector(".mapboxgl-ctrl-geocoder input");
        if (inputField) inputField.value = savedAddress;
      }, 500);
    }

    this.geocoder.on("result", (event) => this.#setInputValue(event));
    this.geocoder.on("clear", () => this.#clearInputValue());
  }

  disconnect() {
    this.geocoder.onRemove();
  }

  #setInputValue(event) {
    const address = event.result["place_name"];
    this.addressTarget.value = address;
    localStorage.setItem("savedAddress", address);
  }

  #clearInputValue() {
    this.addressTarget.value = "";
    localStorage.removeItem("savedAddress");
  }
}
