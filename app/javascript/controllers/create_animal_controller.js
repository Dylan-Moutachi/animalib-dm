import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["name", "specie", "submitButton"];

  connect() {
    this.toggleButton();
  }

  validate() {
    const nameFilled = this.nameTarget.value.trim() !== "";
    const specieFilled = this.specieTarget.value.trim() !== "";

    this.submitButtonTarget.disabled = !nameFilled || !specieFilled;
  }

  toggleButton() {
    this.validate();
  }
}
