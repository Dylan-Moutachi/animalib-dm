import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="booking-modal"
export default class extends Controller {
  static targets = ["button", "modal", "modalContent", "submitButton"]

  connect() {
    this.modal = new bootstrap.Modal(this.modalTarget, {})
  }

  show(event) {
    const slotBtn = event.currentTarget;
    fetch(slotBtn.dataset.path + `?date=${slotBtn.dataset.datetime}`, {
      method: 'GET',
      headers: { "Accept": "Application/json" }
    })
    .then(response => response.json())
    .then(data => {
      this.modalContentTarget.innerHTML = data.html

      // Une fois le contenu inséré, on attache les écouteurs d'événements
      this.attachAnimalSelectionListener()
    })

    this.modal.show()
  }

  attachAnimalSelectionListener() {
    const animalRadios = this.modalContentTarget.querySelectorAll('input[name="booking[animal_id]"]')
    this.submitButtonTarget.disabled = true;

    animalRadios.forEach(radio => {
      radio.addEventListener('change', () => {
        this.submitButtonTarget.disabled = !this.isAnimalSelected();
      })
    })
  }

  isAnimalSelected() {
    return this.modalContentTarget.querySelector('input[name="booking[animal_id]"]:checked') !== null;
  }
}
