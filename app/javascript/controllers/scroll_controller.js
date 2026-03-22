import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="scroll"
export default class extends Controller {
  connect() {
    this.scrollToBottom()

    this.observer = new MutationObserver(() => {
      this.scrollToBottom()
    })

    this.observer.observe(this.element, { childList: true })
  }

  disconnect(){
    this.observer.disconnect()
  }



  scrollToBottom() {
    this.element.scrollTop = this.element.scrollHeight
  }
}
