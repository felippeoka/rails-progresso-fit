import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="weight-image"
export default class extends Controller {
  connect() {
    console.log("ola")
  }
}
