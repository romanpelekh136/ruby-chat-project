import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="messages"
export default class extends Controller {
  connect() {
    this.element.scrollTop = this.element.scrollHeight
  }
}
