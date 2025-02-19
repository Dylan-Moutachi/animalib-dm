import { Controller } from "@hotwired/stimulus"


// Connects to data-controller="booking-modal"
export default class extends Controller {
  static targets = ["button", "modal", "modalContent"]

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
    })

    this.modal.show()

    // console.log(this.modalTarget);
    // this.modalTarget.classList.toggle("d-none");
  }

  // show(event) {
  //   event.preventDefault();
  //   fetch(this.formTarget.action, {
  //     method: "GET",
  //     headers: { "Accept": "application/json" },
  //   })
  //     .then(response => response.json())
  //     .then((data) => {
  //       if (data.inserted_item) {
  //         this.itemsTarget.insertAdjacentHTML("beforeend", data.inserted_item)
  //       }
  //       this.formTarget.outerHTML = data.form
  //     })
  }
